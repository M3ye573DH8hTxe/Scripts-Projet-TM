ENT.Type 			= "anim"
ENT.PrintName 		= "▌ Caisse de Munitions ▌"
ENT.Author 			= "Titan"
ENT.Category 		= "CitadelleRP - Munitions"


ENT.Spawnable    = true


function ENT:SetupDataTables()

	self:NetworkVar("Entity", 4, "owning_ent")

end
