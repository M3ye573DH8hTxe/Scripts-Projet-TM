AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()	
	
	self:SetModel("models/props_vtmb/safe.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

end

function ENT:SpawnFunction(ply, tr, class)

	if not tr.Hit then return end
	
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180

	local ent = ents.Create(class)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:SetAngles(SpawnAng)
	ent:Spawn()
	ent:Activate()

	return ent

end


function ENT:AcceptInput( Name, Activator, Caller )	

    if Name == "Use" and Caller:IsPlayer() then

		local job = Caller:getDarkRPVar("job")

		if job == "Maire" then
			
			net.Start("MAIRE:VerifOn")
			net.Send(Caller)	
			return

		end

		net.Start("MAIRE:VerifOff")
		net.Send(Caller)	

	end
end

