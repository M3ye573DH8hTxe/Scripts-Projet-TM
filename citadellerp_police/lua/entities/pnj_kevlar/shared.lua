ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Vendeur de kevlar"
ENT.Category = "CitadelleRP - Police"
ENT.Spawnable = true

ENT.AdminOnly    = true


if CLIENT then
	
	function ENT:Draw()
		self:DrawModel()
		CitadelleRP.API:DrawHudPNJ(self, "Police", "Gilets par balles", Color(255, 255,255,255))
	end 


	function ENT:DrawTranslucent()
		self:Draw()
	end

end	