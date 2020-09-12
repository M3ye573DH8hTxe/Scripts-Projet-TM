AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self:SetModel("models/player/portal/f_police7_armor.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self:SetMaxYawSpeed(90)
end


function ENT:OnTakeDamage()
	return false
end 

local kevlar = {
    ["RAID"] = { power = 200, price = 3500 },
    ["Agent de la BAC"] = { power = 100, price = 2000 },
    ["Agent de police"] = { power = 100, price = 2000 },
}


function ENT:AcceptInput( Name, Activator, Caller )	

    if Name == "Use" and Caller:IsPlayer() then
		 
		if kevlar[Caller:getDarkRPVar("job")] then
	        local power = kevlar[Caller:getDarkRPVar("job")].power
	        local price = kevlar[Caller:getDarkRPVar("job")].price


	        if power == Caller:Armor() then

	        	DarkRP.notify(Caller, 0, 3, "Votre armure est tout neuve.")

	            return
	        end

	        Caller:SetArmor(power)
	        Caller:addMoney(-price)

	        DarkRP.notify(Caller, 0, 3, "VOus avez reçu un nouveau gilet par balles.")

	        return
	    end

	    DarkRP.notify(Caller, 1, 3, "Vous n'êtes pas autorisé à avoir un gilet par balles.")

	end
	
end



