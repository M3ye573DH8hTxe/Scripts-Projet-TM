local meta = FindMetaTable("Player")
function meta:SetStaff()

	CitadelleRP.Admin.InStaff = {}

	if self:GetNWBool("IS_MOD", false) then
		self:SetNWBool("IS_MOD", false)

		ULib.invisible( self, false, 0 )
		self:GodDisable()
		self:SetMoveType( MOVETYPE_WALK )

	    self:SetNoDraw( false )
        self:SetNotSolid( false )
        self:DrawWorldModel( true )

		--table.RemoveByValue(CitadelleRP.Admin.InStaff, self)
		ulx.fancyLogAdmin( self, true, "#A a arrêté d'administrer" )
		DarkRP.notify(self, 0, 3, "Vous êtes désormais plus en STAFF.")
		return
	end

	self:SetNWBool("IS_MOD", true)

	ULib.invisible( self, true, 0 )
	self:GodEnable()
	self:SetMoveType( MOVETYPE_NOCLIP )

    self:SetNoDraw( true )
    self:SetNotSolid( true )
    self:DrawWorldModel( false )
    
	--table.insert(CitadelleRP.Admin.InStaff, self)
	ulx.fancyLogAdmin( self, true, "#A a commencé à administrer" )
	DarkRP.notify(self, 0, 3, "Vous êtes désormais en STAFF.")
end

