util.AddNetworkString("MAIRE:TakeMoney")
util.AddNetworkString("MAIRE:VerifOff")
util.AddNetworkString("MAIRE:VerifOn")
util.AddNetworkString("MAIRE:Verif")
util.AddNetworkString("MAIRE:UpdateTax")

net.Receive("MAIRE:UpdateTax", function ( len, ply )

	local job = ply:getDarkRPVar("job")

	if job == "Maire" then
		
		local tax = net.ReadDouble()
		SetGlobalInt("MAIRE_TAX", tax)

	end


end)


net.Receive("MAIRE:TakeMoney", function ( len, ply )

	local job = ply:getDarkRPVar("job")

	if job == "Maire" then
		
		local money = GetGlobalInt("MAIRE_MONEY")

		ply:addMoney(money)
		SetGlobalInt("MAIRE_MONEY", 0)

	end


end)

