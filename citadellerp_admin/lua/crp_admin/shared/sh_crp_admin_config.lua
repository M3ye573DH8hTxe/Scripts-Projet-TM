CitadelleRP = CitadelleRP or {}
CitadelleRP.Admin = CitadelleRP.Admin or {}

CitadelleRP.Admin.Config = CitadelleRP.Admin.Config or {}


local meta = FindMetaTable("Player")


function meta:IsInStaff()

	if self:GetNWBool("IS_MOD", false) && (self:getDarkRPVar("job") == "Staff" or self:IsSuperAdmin()) then
		
		return true

	end

	return false

end
