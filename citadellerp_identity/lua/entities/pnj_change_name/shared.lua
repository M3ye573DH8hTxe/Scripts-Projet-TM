ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Secrétaire de la mairie"
ENT.Category = "CitadelleRP - Identity"
ENT.Author = "Titan"
ENT.Spawnable = true
ENT.AdminSpawnable = true

if CLIENT then
	
	function ENT:Draw()
		self:DrawModel()
		CitadelleRP.API:DrawHudPNJ(self, "Administration", "Changer de nom ici !", Color(255, 255,255,255))
	end 


	function ENT:DrawTranslucent()
		self:Draw()
	end

end	