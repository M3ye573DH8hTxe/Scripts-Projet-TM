AddCSLuaFile("shared.lua")
include("shared.lua")
 
function ENT:Initialize()
   	self:SetModel("models/ckevlar_vest/vest.mdl")
    self:SetAngles(Angle(270,0,0))
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON )
   
 
    self.ArmorInt = 100
    local phys = self:GetPhysicsObject()
    if(phys:IsValid()) then
        phys:Wake()
        phys:EnableMotion(true)
    end
end
 
function ENT:RunSound(ply, sound)
    ply:EmitSound( sound )
end
 
function ENT:Use( activator, caller )

    caller:SetArmor(caller:Armor() + self.ArmorInt)
    self:RunSound(caller, "armoron")
    if(caller:Armor() > 100) then
        caller:SetArmor(100)
    end
    self:Remove()

end