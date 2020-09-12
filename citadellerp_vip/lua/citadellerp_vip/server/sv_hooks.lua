hook.Add("playerGetSalary", "CRP:Vip:SalaireBoost", function(ply, amount)

	if ply:IsVIP() and ply:getDarkRPVar("job") ~= "Staff" then
		
		if string.find(ply:GetUserGroup(), "+") then

			return false, "Votre salaire a été multipliez par 3 car vous êtes VIP+.", amount*3


		else
			
			return false, "Votre salaire a été multipliez par 2 car vous êtes VIP.", amount*2

		end

	end

	return false, "", amount

end)
