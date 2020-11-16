include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	TitanAPI.DrawHudPNJ(self, "Concessionnaire", "Prenez vos véhicules ici", Color(255, 255,255,255))
end 