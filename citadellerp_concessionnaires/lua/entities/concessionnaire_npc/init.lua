AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid(  SOLID_BBOX ) 
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then  
		phys:Wake()   
		phys:EnableMotion(false)              
	end
end


function ENT:OnTakeDamage()
	return false
end 

function ENT:AcceptInput( Name, Activator, Caller )	

	local tblConcess = CitadelleRP.Concessionnaires.Config.List[self:GetConcessionnaireID()]

    if Name == "Use" and Caller:IsPlayer() then

		if tblConcess.check then 

			if not tblConcess.check(Caller) then

				DarkRP.notify(Caller, 1, 3, "Vous n'avez pas accès à ce genre de véhicules.")
				return

			end

		end

		net.Start("CRP::Concessionnaire:Player:OpenGui")
			net.WriteEntity(self)
		net.Send(Caller)

	end
	
end

