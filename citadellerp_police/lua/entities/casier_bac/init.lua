AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()

	self:SetModel("models/props_wasteland/controlroom_storagecloset001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	

end


function ENT:Use(activator, obj)

	if(activator:IsPlayer()) then

		local job = activator:getDarkRPVar("job")

		if job == "Agent de la BAC" and activator:GetVar( "CharacterCreatorIdSaveLoad") == 2 then
			net.Start("CRP::Police:Bac:CasierOpen")
			net.Send(activator)

		else

			DarkRP.notify(activator, 1, 3, "Vous ne pouvez pas accéder à ce casier.")

		end
		
	end

end