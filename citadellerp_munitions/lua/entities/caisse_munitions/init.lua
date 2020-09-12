AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()	
	
	self:SetModel("models/Items/ammocrate_smg1.mdl")
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
	ent:Setowning_ent(ply)
	ent:SetAngles(SpawnAng)
	ent:Spawn()
	ent:Activate()


	return ent

end


function ENT:AcceptInput( Name, Activator, Caller )	

    if Name == "Use" and Caller:IsPlayer() then

		net.Start("Munitions:OpenCaisse")
		net.WriteEntity(self:Getowning_ent())
		net.Send(Caller)	

	end
end

