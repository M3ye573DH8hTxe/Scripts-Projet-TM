CitadelleRP = CitadelleRP or {}
CitadelleRP.Shop = CitadelleRP.Shop or {}
CitadelleRP.Shop.Config = CitadelleRP.Shop.Config or {}


CitadelleRP.Shop.Config.List = {
    [1] = {
        Name = "Shop - Armurie",
        Model = "models/smalls_civilians/pack1/hoodie_male_02_pm.mdl",
        Logo = "img_type/gun.png",
        position = Vector(-4513.3315429688, -5153.8002929688, -4507.7607421875),
        angles = Angle(0, 166.2, 0),
        requiredJob = TEAM_VENDEUR_ARMES,
        IsAmmo = false,
        IsEnt = false,
        Content = {
            [1] = { -- Weapon
                Name = "Glock 18",
                Model = "models/weapons/tfa_w_dmg_glock.mdl",
                Price = 6000,
                Class = "tfa_glock",

            },
            [2] = { -- Weapon
                Name = "P229R",
                Model = "models/weapons/tfa_w_sig_229r.mdl",
                Price = 6000,
                Class = "tfa_sig_p229r",

            },
            [3] = { -- Weapon
                Name = "Benelli M3",
                Model = "models/weapons/tfa_w_benelli_m3.mdl",
                Price = 16000,
                Class = "tfa_m3",
            },

            [4] = { -- Weapon

                Name = "Remington 870",
                Model = "models/weapons/tfa_w_remington_870_tact.mdl",
                Price = 16000,
                Class = "tfa_remington870",
            },
            [5] = { -- Weapon
                Name = "MP5SD",
                Model = "models/weapons/tfa_w_hk_mp5sd.mdl",
                Price = 12000,
                Class = "tfa_mp5sd",

            },
             
            [6] = { -- Weapon
                Name = "KRISS Vector",
                Model = "models/weapons/tfa_w_kriss_vector.mdl",
                Price = 10000,
                Class = "tfa_vector",

            },
            [7] = { -- Weapon

                Name = "MP9",
                Model = "models/weapons/tfa_w_brugger_thomet_mp9.mdl",
                Price = 10000,
                Class = "tfa_mp9",
            },
            [8] = { -- Weapon
                Name = "HK416",
                Model = "models/weapons/tfa_w_hk_416.mdl",
                Price = 14000,
                Class = "tfa_m416",

            },
            
            [9] = { -- Weapon
                Name = "M24",
                Model = "models/weapons/tfa_w_snip_m24_6.mdl",
                Price = 20000,
                Class = "tfa_m24",

            },
        },
    },

    [2] = {
        Name = "Shop - Munitions",
        Model = "models/items/ammocrate_ar2.mdl",
        Logo = "img_type/bullet.png",
        position = Vector(-4503.3686523438, -5111.1440429688, -4495.4995117188),
        angles = Angle(0, 180, 0),
        requiredJob = TEAM_VENDEUR_ARMES,
        IsAmmo = true,
        IsEnt = false,
        Content = {
            [1] = { -- Ammo

                Name = "Balles de pistolet",
                Model = "models/items/boxsrounds.mdl",
                Price = 700,
                Class = "Pistol",


            },
            [2] = { -- Ammo
                Name = "Balles de revolver",
                Model = "models/items/357ammobox.mdl",
                Price = 700,
                Class = "357",

            },
            [3] = { -- Ammo
                Name = "Balles de fusil à pompe",
                Model = "models/items/boxbuckshot.mdl",
                Price = 700,
                Class = "Buckshot",

            },
            [4] = { -- Ammo
                Name = "Balles de Winchester",
                Model = "models/items/sniper_round_box.mdl",
                Price = 700,
                Class = "AirboatGun",

            },
            [5] = { -- Ammo
                Name = "Balles de SMG",
                Model = "models/items/boxsrounds.mdl",
                Price = 700,
                Class = "SMG1",

            },
             
            [6] = { -- Ammo
                Name = "Balles de fusils d'assault",
                Model = "models/items/boxmrounds.mdl",
                Price = 700,
                Class = "AR2",

            },
             [7] = { -- Ammo
                Name = "Balles de Sniper",
                Model = "models/items/sniper_round_box.mdl",
                Price = 700,
                Class = "SniperPenetratedRound",

            },
        },
    },
    [3] = {
        Name = "Shop - Pablov",
        Model = "models/player/leet.mdl",
        Logo = "img_type/ak.png",
        position = Vector(-9409.787109375, -2405.107421875, -4263.8647460938),
        angles = Angle(0, 128.2, 0),
        requiredJob = TEAM_VENDEUR_ARMES_NOIRES,
        IsAmmo = false,
        IsEnt = false,
        Content = {
            [1] = { -- Weapon
                Name = "UZI",
                Model = "models/weapons/tfa_w_uzi_imi.mdl",
                Price = 10000,
                Class = "tfa_uzi",

            },
            [2] = { -- Weapon
                Name = "TEC-9",
                Model = "models/weapons/tfa_w_intratec_tec9.mdl",
                Price = 10000,
                Class = "tfa_tec9",

            },
            [3] = { -- Weapon
                Name = "Mossberg 590",
                Model = "models/weapons/tfa_w_mossberg_590.mdl",
                Price = 16000,
                Class = "tfa_mossberg590",

            },
            [4] = { -- Weapon
                Name = "P90",
                Model = "models/weapons/tfa_w_fn_p90.mdl",
                Price = 16000,
                Class = "tfa_smgp90",

            },
            [5] = { -- Weapon
                Name = "SR-3M Vikhr",
                Model = "models/weapons/tfa_w_dmg_vikhr.mdl",
                Price = 16000,
                Class = "tfa_vikhr",

            },
             
            [6] = { -- Weapon
                Name = "AK-47",
                Model = "models/weapons/tfa_w_ak47_tfa.mdl",
                Price = 18000,
                Class = "tfa_ak47",

            },
             [7] = { -- Weapon
                Name = "AN-94",
                Model = "models/weapons/tfa_w_rif_an_94.mdl",
                Price = 18000,
                Class = "tfa_an94",

            },
            [8] = { -- Weapon
                Name = "Dragunov SVU",
                Model = "models/weapons/tfa_w_dragunov_svu.mdl",
                Price = 20000,
                Class = "tfa_svu",

            },
            [10] = { -- Weapon
                Name = "Intervention",
                Model = "models/weapons/tfa_w_snip_int.mdl",
                Price = 20000,
                Class = "tfa_intervention",

            },
            [11] = { -- Weapon
                Name = "Matériel de crochetage",
                Model = "models/weapons/w_crowbar.mdl",
                Price = 5000,
                Class = "lockpick",

            },
            [12] = { -- Weapon
                Name = "Hackeur de Keypad",
                Model = "models/weapons/w_c4.mdl",
                Price = 5000,
                Class = "keypad_cracker",

            },
            [13] = { -- Weapon
                Name = "Menottes",
                Model = "models/tobadforyou/flexcuffs_deployed.mdl",
                Price = 5000,
                Class = "weapon_r_restrains",

            },
        },
    },

    [4] = {
        Name = "Autre",
        Model = "models/props_wasteland/controlroom_filecabinet001a.mdl",
        Logo = "img_type/other.png",
        position =  Vector(-4510.9008789062, -5062.3793945312, -4498.1982421875),
        angles = Angle(0, -157.1, 0),
        IsAmmo = false,
        IsEnt = true,
        Content = {
            [1] = { -- Kevlar
                Name = "Kevlar",
                Model = "models/sal/acc/armor01.mdl",
                Price = 6000,
                Class = "tfa_nmrih_m92fs",
                requiredJob = TEAM_VENDEUR_ARMES,
                IsSpawn = false,

            },
            [2] = { -- Kit
                Name = "Kit de réparation",
                Model = "models/vcmod/vcmod_toolbox.mdl",
                Price = 4000,
                Class = "vc_pickup_healthkit_100",
                IsSpawn = true,

            },
        },
    },
}

