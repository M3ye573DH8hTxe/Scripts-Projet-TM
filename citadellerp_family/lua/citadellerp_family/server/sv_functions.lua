function CitadelleRP.Family:Initialize()

	CitadelleRP.Family.Families = {}

    local tblInfos = self.SQL:Query("SELECT * FROM crp_family")

	for k,v in pairs(tblInfos or {}) do
	    CitadelleRP.Family.Families[v.name] = {
		    name = v.name,
		    leader = v.leader,
		    members = self:GetTableMembers(util.JSONToTable(v.members or "{}")),
		    skins = self:GetTableMembers(util.JSONToTable(v.skins or "{}")),
		    skin_leader = self:GetTableMembers(util.JSONToTable(v.skin_leader or "{}")),
		    team_chief = v.team_chief,
		    team_member = v.team_member
		}
		--PrintTable(util.JSONToTable(v.members))
	end

	--PrintTable(CitadelleRP.Family.Families)

end

--CitadelleRP.Family:Initialize()

function CitadelleRP.Family:GetTableMembers(tbl)
    local tblNew = {}

    for k,v in pairs(tbl or {}) do
        tblNew[tostring(k)] = v
    end

    return tblNew
end


function CitadelleRP.Family:Save(family_name)

	local tblGroup = self.Families[family_name]

	if ( not tblGroup ) then return end

	local tblMembers = util.TableToJSON(tblGroup.members or {})

	self.SQL:Query("UPDATE crp_family SET members = ? WHERE name = ?", {
	    tblMembers,
	    family_name
	})

	self:SyncAll(family_name)

end

--CitadelleRP.Family:SyncAll()
function CitadelleRP.Family:SyncAll(family_name)

	if family_name and not table.IsEmpty(CitadelleRP.Family.Families) then
		
		net.Start("CRP::Family:Client:Sync")
			net.WriteBool(true)
			net.WriteTable(CitadelleRP.Family.Families)
			net.WriteString(family_name)
		net.Broadcast()
		return
	end

	net.Start("CRP::Family:Client:Sync")
		net.WriteBool(false)
		net.WriteTable(CitadelleRP.Family.Families)
	net.Broadcast()

end

function CitadelleRP.Family:SyncPlayer(player, family_name)

	if family_name then
		
		net.Start("CRP::Family:Client:Sync")
			net.WriteBool(true)
			net.WriteTable(CitadelleRP.Family.Families)
			net.WriteString(family_name)
		net.Send(player)
		return
	end

	net.Start("CRP::Family:Client:Sync")
		net.WriteBool(false)
		net.WriteTable(CitadelleRP.Family.Families)
	net.Send(player)

end
--[[-------------------------------------------------------------------------
							Create - Disband
---------------------------------------------------------------------------]]

function CitadelleRP.Family:Create(ply, name, leader, skin_leader, skins, team_chief, team_member )

	if not ply:IsSuperAdmin() then return end

	if leader:HasFamily() then return end 

	local steamidLeader = leader:SteamID64()


	self.SQL:Query("INSERT INTO crp_family(name, leader, skins, skin_leader, members, team_chief, team_member) VALUES (?, ?, ?, ?, ?, ?, ?)", {
		name,
		steamidLeader,
		util.TableToJSON(skins),
		util.TableToJSON(skin_leader),
		"",
		team_chief,
		team_member
	})

	self:Initialize()
	self:Add( leader, name ) 

	DarkRP.notify(ply, 1, 4, "La famille " .. name .. " a été crée avec succès !")

end

--CitadelleRP.Family:Create("test", "sss", "test", {"test", "test2"} )


function CitadelleRP.Family:Disband( family_name, leader )

	if not leader:HasFamily() then return end 
	if not leader:IsLeader() then return end

	self.SQL:Query("DELETE FROM crp_family WHERE name = ?", {family_name})
	self:Initialize()
	self:SyncAll(family_name)

	DarkRP.notify(leader, 1, 4, "Vous avez dissous votre famille.")

	if leader:GetVar("CharacterCreatorIdSaveLoad") == 3 then
		net.Start("CharacterCreator:OpenMenu")
		net.Send(leader)
	end

end



--[[-------------------------------------------------------------------------
							Invit - Accept - Deny - kick
---------------------------------------------------------------------------]]	

function CitadelleRP.Family:Invite( inviter, family_name, player )

	if player:HasFamily() or not inviter:HasFamily() then return end
	if not inviter:IsLeader() then return end

	CitadelleRP.Family.FamiliesInvite = {}

	self.FamiliesInvite[family_name][tostring(player:SteamID64())] = {}

	net.Start("CRP::Family:Client:Invite")
		net.WriteString(family_name)
	net.Send(player)
	DarkRP.notify(inviter, 1, 4, "Vous avez invité " .. player:Nick() .. " dans votre famille.")

end


function CitadelleRP.Family:Accept( player, family_name )

	if self.FamiliesInvite[family_name][tostring(player:SteamID64())] then

		self.FamiliesInvite[family_name][tostring(player:SteamID64())] = nil
		self:Add( player, family_name )
		DarkRP.notification(player, 0, 3, "Vous avez accepté l'invitation !")

	end
	


end

--CitadelleRP.Family:Add(Entity(2), "Zebix")
function CitadelleRP.Family:Deny( player, family_name )

	if self.FamiliesInvite[family_name][tostring(player:SteamID64())] then
		
		self.FamiliesInvite[family_name][tostring(player:SteamID64())] = nil
		DarkRP.notification(player, 1, 3, "Vous avez refusé l'invitation !")

	end
	


end

function CitadelleRP.Family:Kick( player, target, family_name )

	if target:IsLeader() then return end
	if not target:HasFamily() then return end
	
	self:Remove( target, family_name )

	self:Save(family_name)
	self:SyncAll(family_name)

end

--[[-------------------------------------------------------------------------
							Add - Remove
---------------------------------------------------------------------------]]	





function CitadelleRP.Family:Add( player, family_name )

	if player:HasFamily() then return end 

    local tblGroup = self.Families[family_name]

    if ( not tblGroup ) then return end

	tblGroup.members["64=" .. tostring(player:SteamID64())] = { name = ""}


	self:Save(family_name)

	if player:GetNWString("CharacterCreator1") == "Player1Create" or player:GetNWString("CharacterCreator2") == "Player2Create" or player:GetNWString("CharacterCreator3") == "Player3Create" then 
 		player:CharacterCreatorSave()
 	end 

 	timer.Simple(0.2, function()
	 	if not IsValid( player ) && not player:IsPlayer() then return end 
		net.Start("CharacterCreator:OpenMenu")
		net.Send(player)
	end) 

end

function CitadelleRP.Family:UpdateName( player, family_name, prenom )

    local tblGroup = self.Families[family_name]

    if ( not tblGroup ) then return end

	tblGroup.members["64=" .. player:SteamID64()] = { name = prenom .. " " .. family_name}

	self:Save(family_name)

end
--CitadelleRP.Family:Add( Entity(1), "test" )

function CitadelleRP.Family:Remove( player )

	if not player:HasFamily() or player:IsLeader() then return end 

	local tblGroup = self.Families[family_name]

	if ( not tblGroup ) then return end

	tblGroup.members[tostring(player:SteamID64())] = nil


	self:Save(family_name)

end

--[[-------------------------------------------------------------------------
							List
---------------------------------------------------------------------------]]	

function CitadelleRP.Family:ListMembers( family_name )

	return self.Families[family_name].members

end

function CitadelleRP.Family:GetFamilies()

	return self.Families

end


--[[-------------------------------------------------------------------------
							Info
---------------------------------------------------------------------------]]	


function CitadelleRP.Family:GetFamilyByMember(member)

	for k,v in pairs(self.Families) do

		if table.HasValue(v.members, tostring(member:SteamID64())) then
			
			return v.name
		end

	end

	return "Unknown"


end


concommand.Add("crp_family_admin", function( ply )

	if not ply:IsSuperAdmin() then return end
	
	net.Start("CRP::Family:Client:OpenAdminInterface")
		net.WriteTable(CitadelleRP.Family.Families)
	net.Send(ply)
	
end)


concommand.Add("crp_family", function (ply)

    if not ply:HasFamily() then return end

	net.Start("CRP::Family:Client:OpenMemberInterface")
		net.WriteString(ply:GetFamilyName())
	net.Send(ply)

end)

function CitadelleRP.Family:FamilyArleadyExist( family_name )

	return self.Families[family_name] or false

end