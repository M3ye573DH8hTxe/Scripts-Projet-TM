--[[-------------------------------------------------------------------------
                Variables
---------------------------------------------------------------------------]] 

CitadelleRP.HUD.tblPlayerSpeaking = CitadelleRP.HUD.tblPlayerSpeaking or {}
CitadelleRP.HUD.VoiceIsActived = false
--[[-------------------------------------------------------------------------
                Disable HUD
---------------------------------------------------------------------------]] 
hook.Add( "HUDShouldDraw", "CRP:HUD:HUDShouldDraw", function( strName )
    if CitadelleRP.HUD.Config.DisabledDarkRPBaseHUD[ strName ] then return false end
end)

--[[-------------------------------------------------------------------------
                HUDPaint
---------------------------------------------------------------------------]] 

hook.Add("HUDPaint", "CRP:HUD:DrawHUD", function()

    CitadelleRP.HUD.Fonctions:HUDPaint()
    if CitadelleRP.HUD.VoiceIsActived then
        CitadelleRP.HUD.Fonctions:RotateLogo( ScrW()-55, ScrH()/2-32, 64, 64)
    end  
    
end)


hook.Add( "PostDrawOpaqueRenderables", "CRP:HUD:PostDrawOpaqueRenderables", function()
    CitadelleRP.HUD.Fonctions:DrawDoor()
end)

hook.Add( "PostPlayerDraw", "CRP:HUD:PostPlayerDraw", function( pPlayer )
    CitadelleRP.HUD.Fonctions:DrawHeadHUD( pPlayer )
end)



--[[-------------------------------------------------------------------------
                Voice
---------------------------------------------------------------------------]]   
hook.Add("PlayerStartVoice", "CRP:HUD:IconEnableVoice", function(ply)
    Material("voice/icntlk_pl"):SetFloat("$alpha", 0)
    if ply == LocalPlayer() then
        CitadelleRP.HUD.VoiceIsActived = true
        CitadelleRP.HUD.tblPlayerSpeaking[ ply ] = nil
    end

end)

hook.Add("PlayerEndVoice", "CRP:HUD:IconDisableVoice", function(ply)
    if ply == LocalPlayer() then
        CitadelleRP.HUD.VoiceIsActived = false
        CitadelleRP.HUD.tblPlayerSpeaking[ ply ] = nil
    end

end)

hook.Remove("StartChat", "DarkRP_StartFindChatReceivers")
hook.Remove("PlayerStartVoice", "DarkRP_VoiceChatReceiverFinder")

--[[-------------------------------------------------------------------------
                Notify patch
---------------------------------------------------------------------------]]   
local function DisplayNotify( tblMsg )
    local strText = tblMsg:ReadString()
    GAMEMODE:AddNotify( strText, tblMsg:ReadShort(), tblMsg:ReadLong())
    surface.PlaySound("buttons/lightswitch2.wav")
    MsgC( Color( 255, 20, 20, 255 ), "[DarkRP] ", Color(200, 200, 200, 255), strText, "\n" )
end
usermessage.Hook( "_Notify", DisplayNotify )

