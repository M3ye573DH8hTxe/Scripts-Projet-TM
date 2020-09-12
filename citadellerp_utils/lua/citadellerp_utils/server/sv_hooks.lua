hook.Add( "CanPlayerSuicide", "CRP:Utils:Commands:Suicide", function (ply)
	if not ply:IsSuperAdmin() then
		ply:ChatPrint("Désolé, tu ne peux pas te suicider...")
		return false
	end
end)


hook.Add("canDropWeapon", "CRP:Utils:Hooks:DropWeapon", function(ply, wep)

	local job = ply:getDarkRPVar("job")

	if CitadelleRP.Utils.Config.JobCanNotDropWeapon[job] and CitadelleRP.Utils.Config.JobCanNotDropWeapon[job][wep:GetClass()] then
		
		return false

	end

	return true
	
end)