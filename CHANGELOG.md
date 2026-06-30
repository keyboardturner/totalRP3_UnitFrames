[Full Changelog & Previous Releases](https://github.com/keyboardturner/totalRP3_UnitFrames/releases)

# 1.1.0

Added Backplate texture feature with 2 options reminiscent of alpha/beta Wrath Death Knight player portraits:
 - A "Sword Runes" option, with premade box for Runes
 - A "Plain Sword" option
   - These options may not align with many player portrait frame UIs, many things changed in 20 years
   - Options/customization for secondary resource bars like Combo Points may come in a future update to help resize/move them (Blizz was supposed to add it in edit mode but it seems to still be unavailable)

Settings UI got reworked slightly to now allow allow displaying a parent option's header, as well as displaying all of a header's children when searching the header

Possibly fixed an error upon login where the trp3 profile for placing the buttons was not available fast enough

renamed core.lua to Core.lua hopefully

# 1.0.9

12.0.7 toc update

# 1.0.8

Fix a minor catastrophic issue with the player name not being updated properly

# 1.0.7

Potential fix to "attempt to compare local 'name'" error

# 1.0.6

12.0.5 toc update

Potentially fixed issue where `realm` was nil regarding the playerframe, causing an error

# 1.0.5

Fix funni buttons lingering when targeting a player with a profile and then targeting an NPC

# 1.0.4

Fixes to button positioning & settings UI

# 1.0.3

Even more secret value error checks for PvP

# 1.0.2

Added lock icon / greyed text to options which are unavailable and require another option to function.

Fixed secret value error on status check

# 1.0.1

Fixed the minor catastrophic issue that happened where the toc was missing every single new file in the packaged versions. You can imagine this probably lead to some errors

# 1.0.0

Reworked much of the code to be more portioned out and organized across separate files. Still more work to do but it's in a functional state

Reworked the settings panel, now with more standardized widgets and searchable settings (organization / order is a WIP)

Added a new Narcissus Portrait option to the player portraits.

Added options to colorize the Open Profile button ring

Added options to colorize the target/player frames

Added option for TRP3 Profile-specific portraits

Added options to view AFK/DND/Disconnect status of a unit target (DC probably won't be visible)

Added tooltips to potentially incompatible options, such as with BetterBlizzFrames which functionally overlaps / overwrites many features.

Fixed up the "resting glow" hide method

# 0.3.5

Temporarily removed the secondary resource options which were causing a protected function error (might be re-implemented in a future update)

# 0.3.4

12.0.1 toc update

# 0.3.3

Minor adjustment to portrait texture prep for Midnight API changes

# 0.3.2

11.2.7 toc update

# 0.3.1

11.2.5 toc update

# 0.3.0

11.2.0 toc update

# 0.2.9

11.1.7 toc update

# 0.2.8

11.1.5 toc update & addon category

# 0.2.7

11.1.0 toc update

# 0.2.6

11.0.7 toc update

# 0.2.5

it is a mystery (idk what happened to skip this number)

# 0.2.4

11.0.5 toc update

# 0.2.3

Fix error that occurs when a texture is not 64x64 (texture will remain blank)

# 0.2.2

color pickers really exploded and haven't actually been effectively usable, so this just cleans up that area. it's also now a Feature™️ that text gets alpha values.

# 0.2.1

TOC updates for TWW, added additional Emerald Dream Narcissus border, fix to "Dragonflight" (now Neltharion) option, complete rewrite of dropdown menus, eliminated extraneous code

# 0.2.0

toc bump to 10.2.7

# 0.1.9

toc bump to 10.2.6

# 0.1.8

combat lockdown for secondary power frames, colormixin calls and cleanup, color picker update

# 0.1.7

Added ability to move the secondary power frame, such as Combo Points, Monk Chi, Paladin Holy Power, Death Knight Runes.

# 0.1.6

Packager Testing

10.2 toc bump