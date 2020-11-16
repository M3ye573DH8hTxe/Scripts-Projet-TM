resource.AddSingleFile('resource/fonts/bebaskai.ttf')


function Maire_Init()

	SetGlobalInt("MAIRE_TAX", 0 )
	SetGlobalInt("MAIRE_MONEY", 0 )


end
hook.Add( "Initialize", "Maire_Init", Maire_Init )



hook.Add("playerGetSalary", "Maire_Salaire", function( ply, salary )

	local newSalaire = 0
	local tax = GetGlobalInt("MAIRE_TAX")

	newSalaire = salary * (1 - (tax / 100))

	local taxMoney = salary * (tax / 100)
	SetGlobalInt( "MAIRE_MONEY", math.Round( GetGlobalInt( "MAIRE_MONEY" ) + taxMoney ))


	DarkRP.notify( ply, 1, 10, "Vous recevez " .. (100 - tax) .."% de votre salaire (Taxe : " .. tax .. "%)" )
    return false, "Tu reçois ".. newSalaire .."$.", newSalaire

end)

function Maire_Kill( mayor, weapon, killer )

	local jobMaire = mayor:getDarkRPVar("job")

	if jobMaire == "Mayor" then 

		mayor:changeTeam( GAMEMODE.DefaultTeam, true )
		DarkRP.notifyAll( 0, 4, "Le maire s'est fait assassiner !" )
		SetGlobalInt( "MAIRE_TAX", 0 )
		SetGlobalInt( "MAIRE_MONEY",0 )
		
	end
end
hook.Add("PlayerDeath", "Maire_Kill", Maire_Kill)


function Maire_Deco( mayor )
	
	local jobMaire = mayor:getDarkRPVar("job")

	if jobMaire == "Mayor" then 

		DarkRP.notifyAll( 0, 4, "Le maire a quitté la ville subitment" )
		SetGlobalInt( "MAIRE_TAX", 0 )
		SetGlobalInt( "MAIRE_MONEY",0 )

	end
end
hook.Add("PlayerDisconnected", "Maire_Deco", Maire_Deco)





hook.Add("canLockpick","CanLockPick_CoffreMaire",function (ply, ent, trace)
	if ent:GetClass() == "mayor" then

		if ply:isCP() then
			
			return false
		end

		return true
	end
end)

hook.Add("lockpickTime","TimerLockPick_CoffreMaire",function (ply, ent)
	if ent:GetClass() == "mayor" then
		return 60
	end
end)

hook.Add("lockpickStarted","StartLockPick_CoffreMaire",function (ply, ent, trace)
	if ent:GetClass() == "mayor" then

		ply:warrant(nil, "Braque coffre du maire")

		for k, v in pairs( player.GetAll() ) do

			if v:isCP() then
				
				DarkRP.notifyAll(v, 0, 4, "Le coffre du maire est en train de se faire crocheter !" )


			end

		end

	end
end)


hook.Add("onLockpickCompleted","FinishLockPick_CoffreMaire",function (ply, success, ent)

	if ent:GetClass() == "mayor" and success == true then

		DarkRP.createMoneyBag(ply:GetPos(), GetGlobalInt("MAIRE_MONEY"))
		SetGlobalInt( "MAIRE_MONEY", 0 )

	end

end)