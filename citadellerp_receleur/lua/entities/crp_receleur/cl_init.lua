include("shared.lua")

function ENT:Draw()
	self:DrawModel()

	CitadelleRP.API:DrawHudPNJ(self, CitadelleRP.Receleur.Config.Name, CitadelleRP.Receleur.Config.Description, Color(255, 255,255,255))
end 