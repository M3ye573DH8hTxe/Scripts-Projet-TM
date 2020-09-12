util.AddNetworkString("CRP::Shop:Player:OpenMenu")
util.AddNetworkString("CRP::Shop:Player:BuyShop")

net.Receive("CRP::Shop:Player:BuyShop", function ( len, ply )

	local entity = net.ReadEntity()
	local num = net.ReadUInt(32)

	CitadelleRP.Shop:Buy(ply, entity, num)

end)


