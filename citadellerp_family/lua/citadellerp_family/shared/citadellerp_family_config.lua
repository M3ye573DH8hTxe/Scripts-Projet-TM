CitadelleRP = CitadelleRP or {}
CitadelleRP.Family = CitadelleRP.Family or {}
CitadelleRP.Family.Config = CitadelleRP.Family.Config or {}


local meta = FindMetaTable("Player")
--table.Empty(CitadelleRP.Family.Families)
--PrintTable(CitadelleRP.Family.Families)

function meta:HasFamily()

	for k,v in pairs(CitadelleRP.Family.Families) do
		
		return v.members["64=" .. self:SteamID64()] or false

	end
end

function meta:GetFamilyName()

	if not self:HasFamily() then return end

	for k,v in pairs(CitadelleRP.Family.Families) do

		if v.members["64=" .. self:SteamID64()] then
			
			return v.name

		end

	end

	return ""


end


function meta:IsLeader()

	if not self:HasFamily() then return end


	if CitadelleRP.Family.Families[self:GetFamilyName()].leader == self:SteamID64() then
		return true

	end

	return false

end


function meta:GetFamiliesModels()

	if not self:HasFamily() then return end

	local tbl = CitadelleRP.Family.Families[self:GetFamilyName()]

	if tbl.leader == tostring(self:SteamID64()) then

		return tbl.skin_leader

	elseif tbl.members["64=" .. self:SteamID64()] and not tbl.leader == tostring(self:SteamID64()) then
			
		return tbl.skins

	end

	return {}

end
--PrintTable(CitadelleRP.Family.Families["Lupin"].members)
function IsFamilyName(name)

	for k,v in pairs(CitadelleRP.Family.Families) do

		if k == name then
			
			return true
		end

	end

	return false

end

function meta:GetFamilyJob()

	if not self:HasFamily() then return end
	local job_id = 0

	for k,v in pairs(RPExtraTeams) do

		if self:IsLeader() and CitadelleRP.Family.Families[self:GetFamilyName()].team_chief == team.GetName(k) then 

			job_id = k

		elseif not self:IsLeader() and CitadelleRP.Family.Families[self:GetFamilyName()].team_member == team.GetName(k) then 

			job_id = k

		end
	end

	return job_id

end

