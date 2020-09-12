CitadelleRP.Avantage.List = CitadelleRP.Avantage.List or {}

hook.Add("PlayerInitialSpawn", "CRP:Avantage:PlayerInitialSpawn", function(ply)


  CitadelleRP.Avantage:LoadAvantages(ply, function(inv)

    if inv then
      CitadelleRP.Avantage.List[ply:SteamID64()] = inv
    else
      CitadelleRP.Avantage.List[ply:SteamID64()] = {}
    end

  end)


end)

hook.Add("PlayerSpawn", "CRP:Avantage:PlayerSpawn", function(ply)

    local tbl = CitadelleRP.Avantage.List[ply:SteamID64()]
    
    timer.Simple(1, function()

        if table.HasValue(tbl, "kevlar") then
            ply:SetArmor(100)
        end
          
        DarkRP.notify(ply, 0, 3, "Vous avez reçu vos avantages !")

    end)
end)
