param([Parameter(Mandatory=$true)][string]$ModFolder)
$ErrorActionPreference='Stop'
$root=(Resolve-Path -LiteralPath $ModFolder).ProviderPath
$patches=ConvertFrom-Json '[{"name":"45EAC7636FFC32C7B7C12312707817AB97713317000000000000000000000000.ips","original":"D2CE767F7539C6C696BC00387861F75F845C0063F7673827CAFCE3632E4CA964","translated":"3656AA276A919E71C75EC330821C8F5C62EEF8BDFBCB8B46AB0B16BF901F2A9D","edits":[[829,"5361766520536c6f74"],[839,"3a20456d7074792f556e7265616461626c65"],[858,"3a2050742e20"],[865,"2043682e200000"],[875,"4f726967696e616c2053617665202f204175746f73617665"],[900,"200000"],[910,"556e69742047726f77746800000000000000"],[929,"436c61737320547261696e696e6700000000"],[948,"47616d65706c617920547765616b73000000"],[967,"53686f727463757473000000"],[1122,"5374617274204e65772047616d6500"]]},{"name":"DB93B0125F4850601D61C3EDDE012F8EB2ECFE77000000000000000000000000.ips","original":"FF06D2F65279A187447611DC8A7811DA66508EA12FC19A156BB044B4621D4A28","translated":"6C016DD4B9B3DE9DFFC3E8DC4DEDD2AEF4DC2E73847873CED4BE6325BA5D5539","edits":[[4925,"47726f777468204d6f64653a000000"],[4941,"47726f77746820426f6e75733a0000"],[4957,"537570706f727420506f696e747320526174653a00"],[4979,"4d6f756e7420426f6e64204d756c7469706c6965723a0000"],[5004,"576561706f6e202f204d61676963205850204d756c7469706c6965723a00"],[5035,"436c617373204d617374657279204d756c7469706c6965723a0000"],[5063,"4b61726d6120467261676d656e74204d756c7469706c6965723a00"],[5091,"476f6c64204d756c7469706c6965723a0000000000"],[5113,"4e6f6e2d576561706f6e20526577617264204d756c7469706c6965723a00"],[5144,"436c617373204578616d20537563636573733a0000000000"],[5169,"436c6173732043686170746572204c6f636b3a0000"],[5191,"5370656369616c20436c61737320556e6974204c696d69743a0000"],[5219,"436c617373204368616e6765204c6576656c3a0000"],[5241,"526563727569746d656e743a000000000000"],[5260,"576f726c64204d6170204d6f7665205475726e20436f73743a0000000000"],[5291,"52656e6f776e3a0000"],[5301,"52656e6f776e20537465703a000000"],[5317,"426972642053686f72746375743a00"],[5333,"4d65616c2053686f72746375743a00"],[5349,"536b696c6c20547261696e696e673a000000000000"],[5371,"4361746368204d6f756e743a000000000000"],[5390,"4465766f74696f6e2053686f72746375743a000000"],[5644,"52616e646f6d"],[5651,"707000000000000000"],[5661,"4f6666000000"],[5668,"4c7620"],[5672,"556e6c6f636b"],[5679,"4c762e2031204261736520436c617373"],[5696,"466978656400"],[5703,"780000"],[5707,"28557365204c6566742f5269676874290000"],[5726,"4f6e20284265737429000000000000000000"],[5745,"53746f636b00"],[5754,"707020284850200000000000000000"],[5780,"4c756e61746963000000000000000000000000"],[5800,"4275696c742d696e20746869726420646966666963756c747920666f722074657374732e2053686172657320736f6d6520486172642072756c65732e"]]}]'
$pending=@()
foreach($patch in $patches){
    $path=Join-Path $root ('exefs\'+$patch.name)
    $hash=(Get-FileHash -LiteralPath $path).Hash
    if($hash -eq $patch.translated){continue}
    if($hash -ne $patch.original){throw "Unsupported patch file: $($patch.name)"}
    $bytes=[IO.File]::ReadAllBytes($path)
    foreach($edit in $patch.edits){
        $offset=[int]$edit[0]
        $hex=[string]$edit[1]
        for($i=0;$i -lt $hex.Length;$i+=2){
            $bytes[$offset+($i -shr 1)]=[Convert]::ToByte($hex.Substring($i,2),16)
        }
    }
    $sha=[Security.Cryptography.SHA256]::Create()
    try{$actual=[BitConverter]::ToString($sha.ComputeHash($bytes)).Replace('-','')}
    finally{$sha.Dispose()}
    if($actual -ne $patch.translated){throw "Translation verification failed: $($patch.name)"}
    $pending += [pscustomobject]@{Path=$path;Name=$patch.name;Bytes=$bytes;Hash=$hash}
}
if(!$pending.Count){'English translation already applied.';return}
$backup=Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) ('FEFW Translation Backups\'+[guid]::NewGuid().ToString('N'))
New-Item -Path $backup -ItemType Directory -Force | Out-Null
foreach($item in $pending){
    $saved=Join-Path $backup $item.Name
    Copy-Item -LiteralPath $item.Path -Destination $saved
    if((Get-FileHash -LiteralPath $saved).Hash -ne $item.Hash){throw 'Backup verification failed'}
}
try {
    foreach($item in $pending){[IO.File]::WriteAllBytes($item.Path,$item.Bytes)}
    foreach($patch in $patches){
        if((Get-FileHash -LiteralPath (Join-Path $root ('exefs\'+$patch.name))).Hash -ne $patch.translated){throw 'Final verification failed'}
    }
} catch {
    foreach($item in $pending){Copy-Item -LiteralPath (Join-Path $backup $item.Name) -Destination $item.Path -Force}
    throw
}
"English translation applied. Backup: $backup"
