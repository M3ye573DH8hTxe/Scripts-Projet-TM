if CLIENT then

    CitadelleRP.HUD = CitadelleRP.HUD or {}
    CitadelleRP.HUD.Fonctions = CitadelleRP.HUD.Fonctions or {}
    CitadelleRP.HUD.Config = CitadelleRP.HUD.Config or {}

    CitadelleRP.HUD.Config.MaxArmor = 100


    CitadelleRP.HUD.Config.DisabledDarkRPBaseHUD = {
        [ "CHudHealth" ] = true,
    	[ "CHudBattery" ] = true,
    	[ "DarkRP_Hungermod" ] = true,
    	[ "DarkRP_HUD" ] = true,
        [ "DarkRP_LocalPlayerHUD" ] = true,
        [ "CHudSecondaryAmmo" ] = true,
        [ "CHudAmmo" ] = true,
        [ "CHudVoiceStatus" ] = true,
        [ "DarkRP_ZombieInfo" ] = true,
        [ "DarkRP_EntityDisplay" ] = true,
    }

    CitadelleRP.HUD.Config.WeaponBlackList = {
        [ "weapon_physcannon" ] = true,
        ["weapon_empty_hands"] = true,
    }
end