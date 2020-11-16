CitadelleRP.Concessionnaires.RollMenu = 1

net.Receive("CRP::Concessionnaire:Player:OpenGui", function ( len )

	local ent = net.ReadEntity()
    local intID = ent:GetConcessionnaireID()
    local tbl = CitadelleRP.Concessionnaires.Config.List[ intID ]
	CitadelleRP.Concessionnaires.RollMenu = 1


	local ConcessGui = vgui.Create( "DFrame" )
	TitanAPI.PaintFrame(ConcessGui, tbl.Name, 600, 550, true, Color(45, 45, 45, 200), Color(0, 0, 0, 200))


	local BoutonSwitchNext = vgui.Create( "CRPButton", ConcessGui )
	BoutonSwitchNext:SetRSize( 50, 50 )
	BoutonSwitchNext:SetRPos(425, 440 )
	BoutonSwitchNext:SetTitre("►")
	function BoutonSwitchNext:DoClick()
    	CitadelleRP.Concessionnaires.RollMenu = (CitadelleRP.Concessionnaires.RollMenu || 1)
		if TitanAPI.GetNumberOfEntries(tbl.Vehicles) < (CitadelleRP.Concessionnaires.RollMenu + 1) then
			CitadelleRP.Concessionnaires.RollMenu = 1
		else
			CitadelleRP.Concessionnaires.RollMenu = CitadelleRP.Concessionnaires.RollMenu + 1
		end	
		CreateGuiModel(intID, CitadelleRP.Concessionnaires.RollMenu, ConcessGui.PanelConcessModel)

	end


	local BoutonSwitchLast = vgui.Create( "CRPButton", ConcessGui )
	BoutonSwitchLast:SetRSize( 50, 50 )
	BoutonSwitchLast:SetRPos(125, 440 )
	BoutonSwitchLast:SetTitre("◄")
	function BoutonSwitchLast:DoClick()
    	CitadelleRP.Concessionnaires.RollMenu = (CitadelleRP.Concessionnaires.RollMenu || 1)
		if 1 > (CitadelleRP.Concessionnaires.RollMenu - 1) then
			CitadelleRP.Concessionnaires.RollMenu = 1
		else
			CitadelleRP.Concessionnaires.RollMenu = CitadelleRP.Concessionnaires.RollMenu - 1
		end	
		CreateGuiModel(intID, CitadelleRP.Concessionnaires.RollMenu, ConcessGui.PanelConcessModel)
	end


    if (!ConcessGui || !IsValid(ConcessGui)) then return end
    if IsValid(ConcessGui.PanelConcessModel) then return end
	ConcessGui.PanelConcessModel = vgui.Create( "DPanel", ConcessGui )
	ConcessGui.PanelConcessModel:SetSize( 350, 350 )
	ConcessGui.PanelConcessModel:SetPos(125, 75 )
	ConcessGui.PanelConcessModel.Paint = function( self, w, h )
		surface.SetDrawColor(Color(255,255,255,50))
		surface.DrawOutlinedRect(0,0,w,h)
	end


	CreateGuiModel(intID, CitadelleRP.Concessionnaires.RollMenu, ConcessGui.PanelConcessModel)
	

	local BoutonApparaitre = vgui.Create( "CRPButton", ConcessGui )
	BoutonApparaitre:SetRSize( 230, 50 )
	BoutonApparaitre:SetRPos(185, 440 )
	BoutonRendre:SetTitre("Apparaître")
	function BoutonApparaitre:DoClick()
		net.Start("CRP::Concessionnaire:Server:SpawnVehicle")
			net.WriteUInt(intID, 5)
			net.WriteUInt(CitadelleRP.Concessionnaires.RollMenu, 5)
		net.SendToServer()

		ConcessGui:Remove()
	end


	local BoutonRendre = vgui.Create( "CRPButton", ConcessGui )
	BoutonRendre:SetRSize( 100, 30 )
	BoutonRendre:SetRPos(250, 500 )
	BoutonRendre:SetTitre("Rendre")
	function BoutonRendre:DoClick()
		net.Start("CRP::Concessionnaire:Server:ReturnVehicle")
			net.WriteUInt(intID, 5)
		net.SendToServer()

		ConcessGui:Remove()
	end


end)




function CreateGuiModel(pnjID, number, base)


   	if (!base || !IsValid(base)) then return end

   	if !IsValid(base.Name) then

		base.Name = vgui.Create( "DLabel", base )
		base.Name:SetSize( 350, 50 )
		base.Name:SetPos(0, 0)

	end
	base.Name:SetText("")
	base.Name.Paint = function( self, w, h )
		draw.SimpleText(CitadelleRP.Concessionnaires.Config.List[pnjID].Vehicles[number].Name, TitanAPI.GetFont(22,"Righteous",550),  175,  20 , Color( 255, 255, 255 ), 1, 1 )

	end
   	if !IsValid(base.Voiture) then

		base.Voiture = vgui.Create( "DModelPanel", base )
		base.Voiture:SetSize( 350, 350 )
		base.Voiture:SetPos(0, 10)

	end

	base.Voiture:SetModel( getVehicleList(CitadelleRP.Concessionnaires.Config.List[pnjID].Vehicles[number].ClassName ).Model ) 

	if CitadelleRP.Concessionnaires.Config.List[pnjID].Vehicles[number].Skin then 
		base.Voiture.Entity:SetSkin( CitadelleRP.Concessionnaires.Config.List[pnjID].Vehicles[number].Skin )
	end


	base.Voiture:SetCursor("arrow")
	local mn, mx = base.Voiture.Entity:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

	base.Voiture:SetFOV( 45 )
	base.Voiture:SetCamPos( Vector( size, size, size ) )
	base.Voiture:SetLookAt( ( mn + mx ) * 0.5 )

	function base.Voiture:LayoutEntity( ent )
		base.Voiture:RunAnimation()
   	end	
end
