local icon = Material("citadellerp/icon.png", "smooth")

local intHealth = 0
local intArmor = 0
local intHunger = 0
local intMoney = 0 

local widget = {}

widget[1] = {

    name = "Santé",
    value = function()
        return math.Clamp( LocalPlayer():Health() or 0, 0, LocalPlayer():GetMaxHealth() ).. " %"
    end
}
widget[2] = {

    name = "Armure",
    value = function()
        return math.Clamp( LocalPlayer():Armor() or 0, 0, 100 ).. " %"
    end
}
widget[3] = {

    name = "Faim",
    value = function()
        return math.Round( math.Clamp( LocalPlayer():getDarkRPVar( "Energy" ) or 0, 0, 999 ) ) .. " %"
    end
}
widget[4] = {

    name = "Argent",
    value = function()
        return DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "money" ) or 0 ).. " (".. DarkRP.formatMoney( LocalPlayer():getDarkRPVar( "salary" ) or 0 ).. ")"                                                                                                                                                                                 /* 76561198180318085 */                                                
    end
}

function CitadelleRP.HUD.Fonctions:Draw()

    if !IsValid( LocalPlayer() ) then return end

    local intW, intH = ScrW(), ScrH()
    local intBoxWeight, intBoxHeight = intW *.34, intH *.06
    local intSpacing = 0
    local intMaterialSize = 32

    CitadelleRP.API:DrawLinearGradient( 0, intH - intBoxHeight, intBoxWeight, intBoxHeight, Color( 40, 40, 40, 225 ), Color( 0, 0, 0, 0 ), false )
    CitadelleRP.API:DrawLinearGradient( 0, intH - intBoxHeight, intBoxWeight, intBoxHeight * 0.08, Color( 120, 120, 120, 225 ), Color( 0, 0, 0, 0 ), false )
    CitadelleRP.API:drawMaterial(CitadelleRP.API:RespX(5), intH - intBoxHeight + ((intBoxHeight - intBoxHeight * 0.75) * 0.5) + intBoxHeight * 0.08, intBoxHeight * 0.75, intBoxHeight * 0.75, Color( 250, 250, 250, 250 ), icon)

    for i = 1, 4 do

        surface.SetFont(CitadelleRP.API:GetFont("titleHUD"))
        draw.SimpleText( widget[i].name, CitadelleRP.API:GetFont("titleHUD"), intBoxHeight *.5 -intMaterialSize *.5 +intMaterialSize +20 +intSpacing, intH -intBoxHeight *.5 -select( 2, surface.GetTextSize( widget[i].name ) ) *.4 + intH *.002, Color(240, 240, 240, 220), 0, TEXT_ALIGN_CENTER )
        surface.SetFont(CitadelleRP.API:GetFont("valueHUD"))    
        draw.SimpleText( widget[i].value(), CitadelleRP.API:GetFont("valueHUD"), intBoxHeight *.5 -intMaterialSize *.5 +intMaterialSize +20 +intSpacing, intH -intBoxHeight *.5 +select( 2, surface.GetTextSize( widget[i].value() ) ) *.4 +ScrH() *.002, Color(240, 240, 240, 220), 0, TEXT_ALIGN_CENTER )

        intSpacing = intSpacing + intH *.1

    end
              
end

function CitadelleRP.HUD.Fonctions:DrawAmmo()
    
    if !IsValid( LocalPlayer() ) then return end
    if !IsValid( LocalPlayer():GetActiveWeapon() ) then return end

    local entWeapon, intTotalAmmo, intAmmoClip, strWeaponName
    local intW, intH = ScrW(), ScrH()
    local intBoxWeight, intBoxHeight = intW *.125, intH *.06
    local intMaterialSize = 32

    entWeapon = LocalPlayer():GetActiveWeapon()
    intTotalAmmo = LocalPlayer():GetAmmoCount( entWeapon:GetPrimaryAmmoType() ) or LocalPlayer():GetAmmoCount( entWeapon:GetSecondaryAmmoType() ) or LocalPlayer():GetAmmoCount( entWeapon:Ammo1() )
    intAmmoClip = entWeapon:Clip1()
    if intAmmoClip < 0 or CitadelleRP.HUD.Config.WeaponBlackList[ entWeapon:GetClass() ] then return end


    CitadelleRP.API:DrawLinearGradient( intW - intBoxWeight, intH - intBoxHeight, intBoxWeight, intBoxHeight, Color( 0, 0, 0, 0 ), Color( 40, 40, 40, 225 ), false )
    CitadelleRP.API:DrawLinearGradient( intW - intBoxWeight, intH - intBoxHeight, intBoxWeight, intBoxHeight * 0.08, Color( 0, 0, 0, 0 ), Color( 120, 120, 120, 225 ), false )

    surface.SetFont(CitadelleRP.API:CreateFont(30, "Coolvetica Rg", 500))
    draw.SimpleText( intAmmoClip .. " / " .. intTotalAmmo, CitadelleRP.API:CreateFont(30, "Coolvetica Rg", 500), intW - intBoxWeight * 0.5, intH - intBoxHeight * .5 - select( 2, surface.GetTextSize( intAmmoClip.. " / ".. intTotalAmmo ) ) *.5, Color(240, 240, 240, 220), 0, 0 )

end


function CitadelleRP.HUD.Fonctions:DrawAgenda()
    if !IsValid( LocalPlayer() ) then return end
    if !LocalPlayer():getAgendaTable() then return end

    local intSpacing = intW *.02

    local strAgendaTitle = LocalPlayer():getAgendaTable()[ "Title" ]
    local strAgendaText = DarkRP.textWrap( ( LocalPlayer():getDarkRPVar( "agenda" ) or "" ):gsub( "//", "\n" ):gsub( "\\n", "\n" ), CitadelleRP.API:GetFont("valueHUD"), math.Round( intW *.2 ) )
    if !strAgendaText or strAgendaText == "" then return end
    draw.SimpleText( strAgendaTitle, CitadelleRP.API:GetFont("titleHUD"), intW -intSpacing, intSpacing *.8,  Color(240, 240, 240, 220), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
    draw.DrawNonParsedText( strAgendaText, CitadelleRP.API:GetFont("valueHUD"), intW -intSpacing, intSpacing *.8 +select( 2, surface.GetTextSize( CitadelleRP.API:GetFont("valueHUD") ) ),  Color(240, 240, 240, 220), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

end

local PlayerVoicePanels = {}

function CitadelleRP.HUD.Fonctions:RotateLogo( x, y, w, h )

    if !IsValid( LocalPlayer() ) then return end

    local Rotating = math.sin(CurTime() * 3)
    local backwards = 0

    if Rotating < 0 then
        Rotating = 1 - (1 + Rotating)
        backwards = 1
    end
        
    surface.SetMaterial(icon)
    surface.SetDrawColor(color_white )
    surface.DrawTexturedRectRotated( x, y, Rotating * 64, 64,  backwards )

end


function CitadelleRP.HUD.Fonctions:HUDPaint()

    if !IsValid( LocalPlayer() ) then return end

    self:Draw()
    self:DrawAmmo()
    self:DrawAgenda()

end

function CitadelleRP.HUD.Fonctions:DoorInfo( entDoor )
    local tblDoorTeams = entDoor:getKeysDoorTeams()
    local tblDoorGroup = entDoor:getKeysDoorGroup()
    local strOwner = entDoor:isKeysOwned() or tblDoorTeams or tblDoorGroup or entDoor:getKeysNonOwnable()
    local strTitle = entDoor:getKeysTitle()
    local tblDoorInfo = {}
    
    if strOwner == entDoor:isKeysOwned() then
        tblDoorInfo[ "Owner" ] = entDoor:getDoorOwner():Nick()
        for intPlayer, v in pairs( entDoor:getKeysCoOwners() or {} ) do
            
            local pPlayer = Entity( intPlayer )
            if !IsValid( pPlayer ) or !pPlayer:IsPlayer() then continue end
            tblDoorInfo[ "CoOwners" ] = tblDoorInfo[ "CoOwners" ] or {}
            tblDoorInfo[ "CoOwners" ][ #tblDoorInfo[ "CoOwners" ] +1 ] = pPlayer:Nick()
        end
    elseif tblDoorTeams then
        for intTeam, _ in pairs( tblDoorTeams ) do
            if !intTeam or !RPExtraTeams[ intTeam ] then continue end
            tblDoorInfo[ "Owner" ] = tblDoorInfo[ "Owner" ] or {}
            tblDoorInfo[ "Owner" ][ #tblDoorInfo[ "Owner" ] +1 ] = RPExtraTeams[ intTeam ].name
        end
    elseif tblDoorGroup then
        tblDoorInfo[ "Owner" ] = tblDoorGroup
    elseif entDoor:getKeysNonOwnable() then
        tblDoorInfo[ "Owner" ] = DarkRP.getPhrase("keys_unowned")
    else
        tblDoorInfo[ "Owner" ] = DarkRP.getPhrase("keys_unowned")
    end
    
    
    for strKey, typeValue in pairs( tblDoorInfo ) do
        if strKey == "Owner" and !istable( tblDoorInfo[ "Owner" ] ) then
            surface.SetFont( "SethHUD:Fonts:Title" )
            draw.DrawNonParsedText( typeValue, CitadelleRP.API:GetFont("titleDoor"), 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
        elseif tblDoorInfo[ "Owner" ] and istable( tblDoorInfo[ "Owner" ] ) then
            local intSpacing = 0
            for _, strName in pairs( tblDoorInfo[ "Owner" ] ) do
                draw.DrawNonParsedText( strName, CitadelleRP.API:GetFont("valueDoor"), 0, 30+intSpacing, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                intSpacing = intSpacing +25
            end
        end
        if strKey == "CoOwners" then
            local intSpacing = 0
            for _, strName in pairs( tblDoorInfo[ "CoOwners" ] ) do
                draw.DrawNonParsedText( strName, CitadelleRP.API:GetFont("valueDoor"), 0, 30+intSpacing, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                intSpacing = intSpacing +25
            end
        end
    end
end

function CitadelleRP.HUD.Fonctions:GetDoorInfos( entDoor )
    local tblDoorInfos = {}
    if entDoor.getKeysTitle then
        tblDoorInfos[ "Title" ] = entDoor:getKeysTitle()
    end
    if entDoor.getDoorOwner then
        local strOwner = entDoor:getDoorOwner()
        if IsValid( strOwner ) then
            tblDoorInfos[ "Owner" ] = strOwner
        end
    end
    if entDoor:getKeysCoOwners() then
        tblDoorInfos[ "CoOwners" ] = entDoor:getKeysCoOwners() or {}
    end
    if entDoor:getKeysDoorGroup() then
        tblDoorInfos[ "GroupAllowed" ] = {}
        table.insert( tblDoorInfos[ "GroupAllowed" ], entDoor:getKeysDoorGroup() )
        
    elseif entDoor:getKeysDoorTeams() then
        tblDoorInfos[ "GroupAllowed" ] = {}
        for intKey, _ in pairs( entDoor:getKeysDoorTeams() or {} ) do
            if !RPExtraTeams[ intKey ] then continue end
            table.insert( tblDoorInfos[ "GroupAllowed" ], RPExtraTeams[ intKey ].name )
        end
    end

    return tblDoorInfos
end

function CitadelleRP.HUD.Fonctions:GetDoorPos( entDoor )
    local vecDimension = entDoor:OBBMaxs() -entDoor:OBBMins()
    local vecCenter = entDoor:OBBCenter()
    local intMinimum, intKey
    local vecNorm, angRotate, vecPos, intDot
    
    for i = 1, 3 do
        if !intMinimum or vecDimension[ i ] <= intMinimum then
            intKey = i
            intMinimum = vecDimension[ i ]
        end
    end

    vecNorm = Vector()
    vecNorm[ intKey ] = 1
    angRotate = Angle( 0, vecNorm:Angle().y +90, 90 )

    if entDoor:GetClass() == "prop_door_rotating" then
        vecPos = Vector( vecCenter.x, vecCenter.y, 15 ) +angRotate:Up() *( intMinimum /6 )
    else
        vecPos = vecCenter + Vector( 0, 0, 20 ) +angRotate:Up() *( ( intMinimum *.5 ) -0.1 )
    end

    local angRotateNew = entDoor:LocalToWorldAngles( angRotate )
    intDot = angRotateNew:Up():Dot( LocalPlayer():GetShootPos() -entDoor:WorldSpaceCenter() )

    if intDot < 0 then
        angRotate:RotateAroundAxis( angRotate:Right(), 180 )

        vecPos = vecPos -( 2 *vecPos *-angRotate:Up() )
        angRotateNew = entDoor:LocalToWorldAngles( angRotate )
    end
    vecPos = entDoor:LocalToWorld( vecPos )

    return vecPos, angRotateNew
end

function CitadelleRP.HUD.Fonctions:DrawDoor()
    local pPlayer = LocalPlayer()
    if !IsValid( pPlayer ) or !pPlayer:IsPlayer() then return end

    local entDoor = pPlayer:GetEyeTrace() and pPlayer:GetEyeTrace().Entity
    if entDoor:IsVehicle() then return end
    if !entDoor or !IsValid( entDoor ) then return end
    if pPlayer:GetPos():DistToSqr( entDoor:GetPos() ) > 100000 then return end
    if !entDoor.isDoor or !entDoor:isKeysOwnable() then return end
    if !entDoor.getKeysNonOwnable then return end
    

    local vecPos, angRotate = self:GetDoorPos( entDoor )
    if !vecPos or !angRotate then return end

    local tblDoorInfos = self:GetDoorInfos( entDoor )
    local strTitle = tblDoorInfos[ "Title" ]
    local entOwner = tblDoorInfos[ "Owner" ]
    local tblCoOwners = tblDoorInfos[ "CoOwners" ]
    local tblGroup = tblDoorInfos[ "GroupAllowed" ]
    local strTitle = entOwner and strTitle or entOwner and "Proriété achetée" or entDoor:getKeysNonOwnable() and "" or "Propriété disponible"
    local intAlphaTo = 255 -( pPlayer:GetPos():DistToSqr( entDoor:GetPos() ) *.001 ) *4.8

    cam.Start3D2D( vecPos, angRotate, .1 )
        if !tblGroup or #tblGroup <= 0 then
            
            draw.SimpleText( strTitle, CitadelleRP.API:GetFont("titleDoor"), 0, 10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

            if entOwner then
                draw.SimpleText( entOwner:Nick(), CitadelleRP.API:GetFont("valueDoor"), 0, 45, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                
                if tblCoOwners and #tblCoOwners >= 1 then
                    local intSpacing = 0
                    for _, pPlayer in pairs( tblCoOwners ) do
                        if IsValid(pPlayer) then
                            draw.SimpleText( pPlayer:Nick(), CitadelleRP.API:GetFont("valueDoor"), 0, 70 +intSpacing, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                        end

                        intSpacing = intSpacing +25
                    end
                end
                if entDoor:isKeysAllowedToOwn( LocalPlayer() ) and !entDoor:isKeysOwnedBy( LocalPlayer() ) then
                    draw.SimpleText( "Appuyez sur F2 pour être copropriétaire", CitadelleRP.API:GetFont("valueDoor"), 0, -10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                end
            elseif !entOwner and !entDoor:getKeysNonOwnable() then
                draw.SimpleText( "Appuyez sur F2 pour acheter", CitadelleRP.API:GetFont("valueDoor"), 0, -10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
            end
        else
            draw.SimpleText( "Proriété achetée", CitadelleRP.API:GetFont("titleDoor"), 0, 10, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
            local intSpacing = 0
            for _, strGroup in pairs( tblGroup ) do
                draw.SimpleText( strGroup, CitadelleRP.API:GetFont("valueDoor"), 0, 50 +intSpacing, Color( 255, 255, 255, intAlphaTo ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
                intSpacing = intSpacing +25
            end
        end
    cam.End3D2D()
end
local iconSpeaker = Material("/hud/mat_speaker.png", "smooth")
local iconUser = Material("/hud/mat_user.png", "smooth")

function CitadelleRP.HUD.Fonctions:DrawHeadHUD( pPlayer )
    if LocalPlayer() == pPlayer then return end
    if !IsValid( LocalPlayer() ) or !LocalPlayer():Alive() or !IsValid( pPlayer ) or !pPlayer:Alive() then return end
    if pPlayer:GetColor().a == "0" then return end
    if LocalPlayer():GetPos():DistToSqr( pPlayer:GetPos() ) > 100000 then return end

    local vecPos = pPlayer:GetPos() +Vector( 0, 0, pPlayer:OBBMaxs().z *1.15 ) 
    local angRotate = Angle( 0, LocalPlayer():EyeAngles().y - 90, 90 )
    local matPlayer = CitadelleRP.HUD.tblPlayerSpeaking[ pPlayer ] and iconSpeaker or iconUser
    --local strWantedReason = pPlayer:getDarkRPVar( "wantedReason" )
    
    local intPlayerNameY, intPlayerJobY, intPlayerValueY

    intPlayerNameY, intPlayerJobY = 10, 43
    


    cam.Start3D2D( vecPos, angRotate, .1 )
        CitadelleRP.API:drawMaterial( -64 -15, -5, 64, 64,  Color(240, 240, 240, 220), matPlayer )
        
        if IsFriend(pPlayer) or (pPlayer:isCP() and LocalPlayer():isCP()) then
            
            draw.SimpleText( pPlayer:Nick(), CitadelleRP.API:CreateFont(45, "Coolvetica Rg", 1000), 0, intPlayerNameY, Color(240, 240, 240, 220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )


        else

            draw.SimpleText( "Inconnu", CitadelleRP.API:CreateFont(45, "Coolvetica Rg", 1000), 0, intPlayerNameY, Color(240, 240, 240, 220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

        end

        draw.SimpleText( pPlayer:GetNWString("ID_META", 0), CitadelleRP.API:CreateFont(35, "Coolvetica Rg", 600), 0, intPlayerJobY, Color(240, 240, 240, 220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        --[[
        if pPlayer:isWanted() and SethHUD.CustomerConfig.ShowWantedHeadHUD then
            draw.SimpleTextOutlined( self:GetLanguage( "WantedName" ), "SethHUD:Fonts:HeadWanted", 0, -80, Color( 200, 100, 100 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 150, 25, 25 ) )
            draw.SimpleTextOutlined( strWantedReason, "SethHUD:Fonts:HeadValue", 0, -50, Color( 200, 100, 100 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color( 150, 25, 25 ) )
        end
        ]]--
    cam.End3D2D()
end
