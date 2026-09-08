# True Target Lock for The Blood of Dawnwalker

![True Target Lock cover](cover.png)

A UE4SS Lua mod that keeps the enemy you hard-lock selected, regardless of
whether you play with a mouse, keyboard, or controller.

## What it changes

The game handles input-device target changes through `SwitchLockTarget`. This
mod prevents user-requested target switching only while hard lock is already
active:

- Mouse: prevents ordinary mouse movement from moving the hard lock.
- Keyboard and controller: prevents target cycling while the hard lock is on.

To select another enemy, release hard lock, select the enemy, then hard-lock
again. Initial target selection, attacks, blocking, combat exit, and automatic
retargeting when a target dies are unchanged.

## Tested build

- Tested store: GOG
- Game build: `dw1-pc-gog-257186-shipping-patch2-all-CL-257186`
- UE4SS: `v3.0.1-1111-g97b7e501`
- Community report: works on Steam.

## Installation

1. Install UE4SS for The Blood of Dawnwalker.
2. Copy the `TrueTargetLock` folder to `ue4ss/Mods/`.
3. Add this line to `ue4ss/Mods/mods.txt`:

```text
TrueTargetLock : 1
```

Restart the game. If UE4SS hot reload is enabled, `Ctrl+R` can reload the mod
without restarting.

## Uninstallation

Remove `TrueTargetLock : 1` from `ue4ss/Mods/mods.txt`, then delete the
`ue4ss/Mods/TrueTargetLock` folder.

## Version 1.0.0

- Added controller and keyboard support.
- Confirmed in combat with multiple enemies on the GOG Patch 2 build.
- Steam compatibility is community-confirmed.

## Community

Join the community on [Discord](https://discord.gg/7S7CfzbXkh).

## Support

If you want to support future work, visit [Second Player on Patreon](https://www.patreon.com/cw/Second_Player).
