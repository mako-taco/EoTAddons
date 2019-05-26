local auras = EOT_Auras

EOT_ClassRoleAuras = {
    ["WARRIOR"] = {
        ["TANK"] = {
            trash = {
                auras.pots.fortitude,
                auras.pots.superiorDefense,
                auras.pots.mongoose,
                auras.jujus.power,
            },
            boss = {
                auras.jujus.might,
                auras.jujus.ember,
                auras.food.squid,
                auras.misc.crystalWard,
                auras.misc.blackLabel,
                auras.scrolls.protection,
            },
            flasked = {}
        },
        ["DPS"] = {
            trash = {
                auras.pots.mongoose,
                auras.jujus.power,
            },
            boss = {
                auras.jujus.might,
                auras.food.squid,
            },
            flasked = {}
        }
    },
    ["MAGE"] = {
        ["CDPS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.greaterFirepower,
                auras.pots.frostPower,
                auras.pots.arcane,
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        }
    },
    ["HUNTER"] = {
        ["DPS"] = {
            trash = {
                auras.pots.mongoose,
                auras.pots.sages
            },
            boss = {
                auras.food.squid,
                auras.misc.blackLabel,
                auras.jujus.might,
            },
            flasked = {}
        }
    },
    ["WARLOCK"] = {
        ["CDPS"] = {
            trash ={
                auras.pots.sages,
                auras.pots.arcane,
                auras.pots.greaterFirepower,
                auras.pots.shadowPower
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        }
    },
    ["ROGUE"] = {
        ["DPS"] = {
            trash = {
                auras.pots.mongoose,
                auras.jujus.power,
            },
            boss = {
                auras.jujus.might,
                auras.food.squid,
                auras.misc.blackLabel,
            },
            flasked = {}
        },
    },
    ["DRUID"] = {
        ["TANK"] = {
            trash = {
                auras.pots.fortitude,
                auras.pots.superiorDefense,
                auras.pots.mongoose,
                auras.jujus.power
            },
            boss = {
                auras.jujus.might,
                auras.food.squid,
                auras.misc.blackLabel,
                auras.misc.crystalWard,
                auras.scrolls.protection,
            },
            flasked = {}
        },
        ["DPS"] = {
            trash = {
                auras.pots.mongoose,
                auras.jujus.power,
            },
            boss = {
                auras.jujus.might,
                auras.food.squid,
                auras.misc.blackLabel,
            },
            flasked = {}
        },
        ["CDPS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.arcane
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        },
        ["HEALS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.arcane
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        }
    },
    ["SHAMAN"] = {
        ["DPS"] = {
            trash = {
                auras.pots.mongoose,
                auras.jujus.power
            },
            boss = {
                auras.jujus.might,
                auras.food.squid,
                auras.misc.blackLabel,
            },
            flasked = {}
        },
        ["CDPS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.arcane,
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        },
        ["HEALS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.arcane
            },
            boss = {},
            flasked = {}
        }
    },
    ["PRIEST"] = {
        ["CDPS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.arcane,
                auras.pots.shadowPower
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        },
        ["HEALS"] = {
            trash = {
                auras.pots.sages,
                auras.pots.arcane
            },
            boss = {
                auras.food.nightfin,
                auras.misc.blackLabel,
            },
            flasked = {}
        }
    }
}
