hook.Add("PlayerCanPickupWeapon", "CRP:Utils:BlackListWeapon", function (ply, wep)

	if ply:IsSuperAdmin() then

		return true
		
	end

	if ply:IsBlackListedWeapon(wep:GetClass()) then
		
		return false

	end

	return true

end)