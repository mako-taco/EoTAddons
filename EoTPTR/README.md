# EoTPTR
## A collection of commands to assist in PTR practice

`/ptr`
displays command help

`/ptr buff <level>` 
buff your target based on their class with different levels of consumes, where level is 0, 1, 2, or 3.
also repairs the target's armor. Hold `ctrl` to buff for offspec instead.

specs are as follows (main, off):
```
warrior  - dps, tank
druid - healer, tank
shaman - healer, caster dps
priest - healer, caster dps
```

`/ptr res`
resurrects + fully heals the group

`/ptr gather`
ports all group members to you (don't need leader)

## forked client ony
The following commands only work on EoT's forked vmangos core

`/ptr repair`
repairs group members gear

`/ptr raidbuff <level>`
smart buffs applied to the entire group, see `/ptr buff` for details

`/ptr wipe`
wipes the group instantly

`/ptr cooldown`
cools down the entire group

`/ptr aura <spellid>`
apply the auras for a spell to the entire group

`/ptr god <on,off>`
toggles godmode for the entire group