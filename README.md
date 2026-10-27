# RollFor for Classic Era 1.14.2

Automated raid rolling for World of Warcraft Classic Era **1.14.2** (interface `11402`). Master loot, soft-res imports from [raidres.fly.dev](https://raidres.fly.dev), and the Murder Mittens item notes are included. Version **4.6.103**.

Copy the `RollFor` folder into `_classic_era_/Interface/AddOns`. If the client build is not exactly `11402`, enable out-of-date addons at character select.

## Credit

This upload is a Classic Era port of the [Murder Mittens fork](https://github.com/Fedilious/roll-for-vanilla) by Fedilious. That fork is based on [RollFor](https://github.com/obszczymucha/roll-for-vanilla) by Obszczymucha. Guild-specific behavior in the fork (item notes, SR+ rolls, transmog trade calls, priority loot, and the longer roll timer) comes from that project, including class announcements and loot-frame positioning from [sica42](https://github.com/sica42).

## What this upload changes

The Fedilious tree targets WoW 1.12. Classic Era 1.14.2 is the modern client with vanilla data, so this copy loads the repo's existing Classic compatibility layer and leaves the 1.12 shims out.

- `RollFor.toc` is set to interface `11402` and loads LibStub, CallbackHandler, AceTimer, and LibDeflate directly. On 1.14.2, XML includes are resolved from the addon root, so the old `Libs.xml` paths never found `LibDeflate`.
- Item notes use the full item link returned by `GetItemInfo` instead of rebuilding a 1.12 link.
- Raid master-looter checks use `GetLootMethod`'s raid index.

Saved variables are `RollForDb` and `RollForCharDb`.
