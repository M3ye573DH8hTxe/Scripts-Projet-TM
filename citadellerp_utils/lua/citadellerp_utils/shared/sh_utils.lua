CitadelleRP.Utils = CitadelleRP.Utils or {}
CitadelleRP.Presentation = CitadelleRP.Presentation or {}
CitadelleRP.Presentation.Data = CitadelleRP.Presentation.Data or {}





local meta = FindMetaTable("Player")

-- WEAPON

function meta:IsBlackListedWeapon(weapon)
    if table.HasValue(RPExtraTeams[self:Team()].blacklisted_weapons, weapon) then 

    	DarkRP.notify(self, 1, 3, "Vous n'êtes pas autorisé à prendre/acheter cette arme dans ce métier.")
    	return true 
    end

    return false
end



-- Grade

function meta:IsVIP()
    if self:IsUserGroup("founder") then return true end
    if self:IsUserGroup("superadmin") then return true end
    if self:IsUserGroup("admin") then return true end
    if self:IsUserGroup("Modo-VIP+") then return true end
    if self:IsUserGroup("Modo-VIP") then return true end
    if self:IsUserGroup("Modo-Test-VIP+") then return true end
    if self:IsUserGroup("Modo-Test-Vip") then return true end
    if self:IsUserGroup("Donateur") then return true end
    if self:IsUserGroup("VIP+") then return true end
    if self:IsUserGroup("VIP") then return true end
    
    return false
end

function meta:IsVIPPlus()
    if self:IsUserGroup("founder") then return true end
    if self:IsUserGroup("superadmin") then return true end
    if self:IsUserGroup("admin") then return true end
    if self:IsUserGroup("Modo-VIP+") then return true end
    if self:IsUserGroup("Modo-Test-VIP+") then return true end
    if self:IsUserGroup("Donateur") then return true end
    if self:IsUserGroup("VIP+") then return true end
    
    return false
end


function meta:IsStaff()
    if self:IsUserGroup("founder") then return true end
    if self:IsUserGroup("superadmin") then return true end
    if self:IsUserGroup("admin") then return true end
    if self:IsUserGroup("Modérateur") then return true end
    if self:IsUserGroup("Modo-VIP+") then return true end
    if self:IsUserGroup("Modo-VIP") then return true end
    if self:IsUserGroup("Modo-Test-VIP+") then return true end
    if self:IsUserGroup("Modo-Test-Vip") then return true end
    if self:IsUserGroup("Moderateur") then return true end
    if self:IsUserGroup("Modo-Test") then return true end

    return false
end

function meta:IsHautStaff()
    if self:IsUserGroup("superadmin") then return true end
    if self:IsUserGroup("admin") then return true end
    
    return false
end


-- Véhicules & Player


function meta:HasVehicle()

    for u, i in pairs(ents.GetAll()) do
		if i:IsVehicle() then
			if i:CPPIGetOwner() == self then
				return true
			end
		end
    end
    
    return false

end


function meta:GetUVehicle()

    if not self:HasVehicle() then return end

    for u, i in pairs(ents.GetAll()) do
		if i:IsVehicle() then
			if i:CPPIGetOwner() == self then
				return i
			end
		end
    end
    
    return nil

end


function getVehicleList(class)

	local data = list.Get( 'Vehicles' )[ class ]
	if not data then return false end
	
	return data

end

