function CitadelleRP.Identity:ChangeRPName( ply, new_name )

	if not ply:canAfford(CitadelleRP.Identity.Config.PriceChangeName) then
		
		DarkRP.notify(ply, 1, 5, "Vous n'avez pas assez d'argent pour changer de nom.")
		return

	end


	ply:addMoney(-CitadelleRP.Identity.Config.PriceChangeName)
	ply:setRPName(new_name, false)

end


function CitadelleRP.Identity:GiveFakePaper( ply, new_name )


end

