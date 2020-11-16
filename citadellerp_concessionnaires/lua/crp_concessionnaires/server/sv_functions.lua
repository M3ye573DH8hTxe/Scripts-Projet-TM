-- First functions

function CitadelleRP.Concessionnaires:SpawnVehicle( ply, id, idVehicle )

	--[[
	if not CitadelleRP.Concessionnaires.HasPermission( ply, id, idVehicle ) then

		DarkRP.notify(ply, 1, 3, "Vous n'avez pas la permission de sortir ce véhicule.")
		return 

	end
	 ]]--

	if ply:HasVehicle() then 

		DarkRP.notify(ply, 1, 3, "Vous devez d'abord rendre votre véhicule.")
		return 
	end

	local tblConcess = self.Config.List[id]
	local tblVehicle = tblConcess.Vehicles[idVehicle]


	local list = getVehicleList(tblVehicle.ClassName)
	if not list then return end


	local ent = ents.Create( "prop_vehicle_jeep" )

	if istable( list.KeyValues ) then
		for k, v in pairs( list.KeyValues ) do
			ent:SetKeyValue( k, v )
		end
	end

	ent:SetModel( list.Model )
	ent:SetVehicleClass(tblVehicle.Class)

	if tblVehicle.Skin then

		ent:SetSkin(tblVehicle.Skin)

	end


	ent:SetPos(tblConcess.spawnVehicle.position)
	ent:SetAngles(tblConcess.spawnVehicle.angles)


	ent.VehicleTable = list


	ent:Spawn()
	ent:Activate()
	ent:keysOwn( ply )
	ent:keysLock()


	timer.Simple(0.2, function ( )

		DarkRP.notify(ply, 3, 3, "Votre véhicule est apparu !")
		ply:EnterVehicle( ent )

	end)


end

function CitadelleRP.Concessionnaires:ReturnVehicle( ply, id )

	if not ply:HasVehicle() then return end

	local tblConcess = self.Config.List[id]
	local tblVehicleSphere = {}

	local detect = ents.FindInSphere(tblConcess.spawnPnj.position, 150)
	for u, i in pairs( detect ) do

		if i:IsVehicle() then

			if not i:isKeysOwnedBy(ply) then return end

			if not i:CPPIGetOwner() == ply then return end

			if self.IsVehicleInlist(id, i:GetVehicleClass()) then

				i:Remove()
				DarkRP.notify(ply, 1, 3, "Vous avez rendu votre véhicule.")

			end
		
		end
	end

end


-- Second functions

function CitadelleRP.Concessionnaires:HasPermission( ply, id, idVehicle )

	if self.Config.List[id].Vehicles[idVehicle].job[ply:getDarkRPVar("job")] then
		return true
	end
	return false

end

function CitadelleRP.Concessionnaires:IsVehicleInlist(id, class)

	for k, v in pairs(self.Config.List[id].Vehicles) do
		if v.Class == class then
			return true
		end
	end
	return false

end



