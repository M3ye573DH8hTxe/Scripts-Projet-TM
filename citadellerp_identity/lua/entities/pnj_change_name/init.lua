AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
		
	self:SetModel("models/Humans/Group01/Female_02.mdl")
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE || CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
end

function ENT:AcceptInput( name, activator, caller )
	 if ( name == "Use" && activator:IsPlayer() ) then

	 	if activator:GetVar( "CharacterCreatorIdSaveLoad") == 2 or activator:GetVar( "CharacterCreatorIdSaveLoad") == 3 then
	 		
	 		DarkRP.notify(activator, 0, 4, "Vous ne pouvez pas changer de nom avec l'identité POLICE ou FAMILLE.")
	 		return
	 		
	 	end
		timer.Simple(0.5, function()

			net.Start("CRP::Identity:Client:OpenInterfaceChangeName")
			net.Send(activator)
		end)
	end
end