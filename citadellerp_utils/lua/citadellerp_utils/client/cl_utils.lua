timer.Simple(5, function()
    function FAdmin.Messages.AddMessage(MsgType, Message) end
end)

timer.Simple(5, function()
	RunConsoleCommand("photon_hud_opacity", "0")
end)

hook.Add( "PreGamemodeLoaded", "CRP:Utils:disable_playervoicechat_base", function()
    hook.Remove( "InitPostEntity", "CreateVoiceVGUI" )
end )

local function NoSound()
    return true
end
hook.Add("PlayerDeathSound", "CRP:Utils:NoSound", NoSound)