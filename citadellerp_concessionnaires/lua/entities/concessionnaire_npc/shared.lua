ENT.Base 			= "base_ai"
ENT.Type 			= "ai"
ENT.PrintName 		= "SHOP"
ENT.Category 		= "CitadelleRP - Concessionnaire"

ENT.Spawnable 		= false


function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "ConcessionnaireID" )
end