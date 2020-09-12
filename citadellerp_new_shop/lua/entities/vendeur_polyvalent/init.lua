AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX ) 
	self:SetUseType( SIMPLE_USE ) 
	self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:EnableMotion(true) end
end


function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput( Name, Activator, Caller )	

    if Name == "Use" and Caller:IsPlayer() then

		net.Start("CRP::Shop:Player:OpenMenu")
			net.WriteEntity(self)
		net.Send(Caller)
		
	end
	
end

