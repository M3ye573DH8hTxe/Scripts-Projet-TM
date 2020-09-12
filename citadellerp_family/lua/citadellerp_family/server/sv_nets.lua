util.AddNetworkString("CRP::Family:Server:Invite")
util.AddNetworkString("CRP::Family:Client:Invite")

net.Receive("CRP::Family:Server:Invite", function( len, ply )

	local typeInvite = net.ReadString()
	if not isstring(typeInvite) then return end
	CitadelleRP.API:switch (typeInvite,

		CitadelleRP.API:case("Invite:Invite", function()
			local family_name = net.ReadString()
			local plyWhoIsInvited = net.ReadEntity()

			-- if not IsValid(plyWhoIsInvited) then return end
			CitadelleRP.Family:Invite( ply, family_name, plyWhoIsInvited )

		end),

		CitadelleRP.API:case("Invite:Response", function()

			local response = net.ReadBool()
			local family_name = net.ReadString()

			if response then

				CitadelleRP.Family:Accept( ply, family_name )

			else

				CitadelleRP.Family:Deny( ply, family_name )

			end
	
		end),

		CitadelleRP.API:default( function() print("[FAMILY-INVITE] Aucune valeur : Contactez un administrateur") end)
	)

end)



util.AddNetworkString("CRP::Family:Client:OpenAdminInterface")
util.AddNetworkString("CRP::Family:Client:OpenMemberInterface")

util.AddNetworkString("CRP::Family:Server:ManageFamily")
util.AddNetworkString("CRP::Family:Client:Sync")


net.Receive("CRP::Family:Server:ManageFamily", function( len, ply )

	local typeManage = net.ReadString()
	if not isstring(typeManage) then return end

	local family_name = net.ReadString() or "Unknown"

	CitadelleRP.API:switch (typeManage,

		CitadelleRP.API:case("Manage:Create", function()
			if CitadelleRP.Family:FamilyArleadyExist( family_name ) then DarkRP.notify(ply, 0, 3, "Ce nom existe déjà !") return end

			local leader = net.ReadEntity()
			if leader:HasFamily() or leader:IsLeader() then DarkRP.notify(ply, 0, 3, "Le chef sélectionné fait déjà parti d'une famille !") return end
			local team_chief = net.ReadString()
			local team_member = net.ReadString()
			local skin_leader = net.ReadTable()
			local skins = net.ReadTable()
			CitadelleRP.Family:Create(ply, family_name, leader, skin_leader, skins, team_chief, team_member )

		end),

		CitadelleRP.API:case("Manage:Disband", function()

			CitadelleRP.Family:Disband( family_name, ply )
	
		end),

		CitadelleRP.API:case("Manage:Kick", function()

			local target = net.ReadEntity()
			CitadelleRP.Family:Kick( ply, target, family_name )
	
		end),


		CitadelleRP.API:case("Manage:Leave", function()

			CitadelleRP.Family:Remove( ply )	

		end),

		CitadelleRP.API:default( function() print("[FAMILY-MANAGE] Aucune valeur : Contactez un administrateur") end)
	)

	
end)


