function CitadelleRP.Avantage:SaveAvantages(ply)

	local jsonAvantages = util.TableToJSON(self.List[ply:SteamID64()])
    local tblInfos = self.SQL:Query("REPLACE INTO `crp_avantages`(steamid, avantages) VALUES (?, ?)", { ply:SteamID64(), jsonAvantages } )

end

function CitadelleRP.Avantage:LoadAvantages(ply, callback)
	local uid = ply:SteamID64()
	local query = self.SQL:Query("SELECT * FROM crp_avantages WHERE steamid='"..uid.."';")

	if query then
		if query ~= nil and query[1] ~= nil and query[1].avantages ~= nil then
			local inv = util.JSONToTable(query[1].avantages)
			callback(inv)
		else
			callback(false)
		end
	else
		print("[CRP - Avantages] Failed to save AVANTAGES, open a support ticket with the following error. ERROR:"..err)
		callback(false)
	end


end


function CitadelleRP.Avantage:AddAvantage( ply, swep )
	
	if not self.List[ply:SteamID64()] then return end

	local tblAvantages = self.List[ply:SteamID64()]
	table.insert(self.List[ply:SteamID64()], swep)

	self:SaveAvantages(ply)

end


function CitadelleRP.Avantage:RemoveAvantage( ply, swep )

	if not self.List[ply:SteamID64()] then return end

	local tblAvantages = self.List[ply:SteamID64()]
	if table.HasValue(self.List[ply:SteamID64()], swep) then return end
	table.RemoveByValue(tblAvantages, swep)

	self:SaveAvantages(ply)

end