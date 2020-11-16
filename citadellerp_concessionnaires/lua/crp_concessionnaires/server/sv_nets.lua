util.AddNetworkString("CRP::Concessionnaire:Player:OpenGui")
util.AddNetworkString("CRP::Concessionnaire:Server:SpawnVehicle")
util.AddNetworkString("CRP::Concessionnaire:Server:ReturnVehicle")



net.Receive("CRP::Concessionnaire:Server:SpawnVehicle", function ( len, ply )

	local id = net.ReadUInt(5)
	local idVehicle = net.ReadUInt(5)

	if not CitadelleRP.Concessionnaires.Config.List[id].Vehicles[idVehicle] then return end

	CitadelleRP.Concessionnaires:SpawnVehicle( ply, id, idVehicle )

end)

net.Receive("CRP::Concessionnaire:Server:ReturnVehicle", function ( len, ply )

	local id = net.ReadUInt(5)

	if not CitadelleRP.Concessionnaires.Config.List[id] then return end

	CitadelleRP.Concessionnaires:ReturnVehicle( ply, id )

end)
