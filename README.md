# Settings Tweaks English Translation v1.0

English text for 49 labels and menu fragments in the 设置补正 (Settings Tweaks) mod for Fire Emblem: Fortune’s Weave. The translation requires the original Settings Tweaks mod. This repo also includes the separate [Perfect Map Search Yield](#perfect-map-search-yield) add-on.

## Perfect Map Search Yield

This optional add-on gives direct world-map **Search** the reward yield of a **Perfect** result, using the spot’s own loot pool. Items can still vary. **Deploy to Search** for battalions follows the regular rules.

Tested in-game by me on Fortune’s Eden v1.6.8.6 with English Settings Tweaks and adaptive 60 FPS. The patch targets game executable build **DB93B0125F4850601D61C3EDDE012F8EB2ECFE77**.

### Install and turn it on

1. On the [GitHub repo page](https://github.com/limmieo/settings-tweaks-english), choose **Code → Download ZIP**, then extract it.
2. Stop Fire Emblem if it is running. On the Fortune’s Eden home screen, open **Game Settings → Add-Ons**.
3. Choose **Import Mod from Folder** and select the extracted [Perfect Map Search Yield](Perfect%20Map%20Search%20Yield) folder that contains **exefs**.
4. Check **Perfect Map Search Yield** in **Add-Ons**, save the settings, and launch the game. Use **Search** at a spot on the world map.
5. To disable it, stop the game, uncheck **Perfect Map Search Yield** in **Add-Ons**, then launch again.

For a manual install, copy the whole **Perfect Map Search Yield** folder into the game’s mod directory. In the default portable setup, the patch ends up at:

~~~
user/load/04007EF01F8AE000/Perfect Map Search Yield/exefs/Perfect-Map-Search-Yield.pchtxt
~~~

The add-on can be enabled independently of Settings Tweaks. The toggle is in the emulator’s **Add-Ons** tab.


## Credits

- Original mod and gameplay changes belong to the creator of 设置补正. The original creator’s identity could not be verified.
- GitHub user [yanjianzhouzi](https://github.com/yanjianzhouzi) supplied the original files in a [Fortune’s Eden issue #45 attachment](https://github.com/TheSneakyBadger/FEFW-Stable-with-60-FPS-Patch/issues/45#issuecomment-6830102204).
- Tested in-game by me.

## Install on Windows

1. Download the original mod from the issue attachment above and extract its **settings-mod** folder.
2. Close the game. Open PowerShell in the folder containing this README.
3. Run the command below, replacing the example path with the folder that contains the mod’s **exefs** directory.

   ~~~powershell
   .\Apply-English.ps1 -ModFolder "C:\path\to\settings-mod"
   ~~~

4. If you patched a separate copy, install that folder as a game add-on. Enable a single copy of Settings Tweaks and launch the game. Open the in-game Settings menu and use the D-pad left or right to adjust values.

The patcher verifies SHA-256 hashes and prints the backup location under Local AppData. To undo the translation, close the game and copy the backed-up IPS files into the mod’s **exefs** folder.

## Compatibility

Tested with Fortune’s Eden v1.6.8.6, 1080p Balanced, and adaptive 60 FPS. The patcher targets the files from issue #45 for game executable build DB93B0125F4850601D61C3EDDE012F8EB2ECFE77. The English menu and left/right adjustment were tested in-game.

## Settings guide

Highlight a row in the in-game Settings menu and press **left or right on the D-pad** to adjust it. **1×** keeps the normal rate for multipliers, **0 percentage points** leaves a bonus unchanged, and **Stock** uses the original game behavior for that option.

The descriptions below follow the original labels and patch text. The English menu and left/right adjustment were tested in-game. Individual gameplay effects still need testing where noted.

### Growth, training, and rewards

| Setting | What it changes |
| --- | --- |
| **Growth Mode** | **Random** rolls stat gains at level-up. **Fixed** uses a predictable growth method. |
| **Growth Bonus** | Adjusts growth rates in percentage points. A +10 point bonus would take 40% to 50%. |
| **Support Points Rate** | Multiplies the support points units earn toward their relationships. |
| **Mount Bond Multiplier** | Multiplies bond gains with mounts. |
| **Weapon / Magic XP Multiplier** | Adjusts how fast weapon and magic proficiency ranks increase. |
| **Class Mastery Multiplier** | Adjusts how fast you master the equipped class and unlock its mastery rewards. |
| **Karma Fragment Multiplier** | Adjusts how many Karma Fragments you earn. |
| **Gold Multiplier** | Adjusts how much gold you earn. |
| **Non-Weapon Reward Multiplier** | Adjusts how many non-weapon items you receive as rewards. |

### Classes, recruitment, and travel

| Setting | What it changes |
| --- | --- |
| **Class Exam Success** | Adjusts the chance of passing a class certification exam. |
| **Class Chapter Lock** | Lets you lift chapter restrictions on class access. Other requirements may still apply. |
| **Special Class Unit Limit** | Adjusts the limit on how many units can use a special class. |
| **Class Change Level** | Adjusts the level used when changing class. The exact calculation is unverified. |
| **Recruitment** | **Stock** keeps standard recruitment behavior. **Lv. 1 Base Class** is intended to make new recruits start at level 1 in a basic class. The effect on individual recruits and their stats is unverified. |
| **World Map Move Turn Cost** | Adjusts how many turns traveling on the world map consumes. |
| **Renown** | Adjusts the Renown value. |
| **Renown Step** | Sets how much the Renown value changes with each left/right press. |

### Activity shortcuts

The patch includes an **On (Best)** option. Whether each shortcut skips the interaction, awards its best result, or does both is unverified.

| Setting | Activity |
| --- | --- |
| **Bird Shortcut** | Interacting with the bird. |
| **Meal Shortcut** | The shared meal activity. |
| **Skill Training** | The skill-training activity. Weapon and magic proficiency earned in battle has its own multiplier. |
| **Catch Mount** | The mount-catching activity. Bond gains have their own multiplier. |
| **Devotion Shortcut** | The attendant activity, labeled **侍奉** in the original. Its English name and exact reward are unverified. |

### Difficulty and saves

**Lunatic** is described in the patch as a third difficulty for testing that shares some rules with Hard. The exact combat changes are unverified.

The patch also includes labels for **manual save slots** and the **original save / autosave**. How the mod selects and writes those slots is unverified.
