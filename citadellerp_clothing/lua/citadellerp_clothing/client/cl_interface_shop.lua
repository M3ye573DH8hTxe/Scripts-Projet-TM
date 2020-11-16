net.Receive("CRP:Clothing:Player:OpenShop", function ( len )

    local buttonType = {
        [1] = { Name = "T-Shirts", Func = function( p, model, ent, frame )
            p:Clear()
            CitadelleRP.Clothing:ViewList( p, 1, model, ent, frame )
		end},
		[2] = { Name = "Pantalons", Func = function( p, model, ent, frame )
            p:Clear()
            CitadelleRP.Clothing:ViewList( p, 2, model, ent, frame )
		end},
		[3] = { Name = "Chaussures", Func = function( p, model, ent, frame )
            p:Clear()
            CitadelleRP.Clothing:ViewList( p, 3, model, ent, frame )
        end}
    }

	local ShopFrame = vgui.Create("CRPFrame")
	ShopFrame:SetRSize(1000, 750)
    ShopFrame:Center()
	ShopFrame:SetTitre("Magasin")
    ShopFrame:SetDraggable( false )
    ShopFrame:CloseButton( true )	

	local PanelBar = vgui.Create( "DPanel", ShopFrame )
	PanelBar:SetSize(ShopFrame:GetWide() - 20, TitanAPI.RespY(50))
	PanelBar:SetPos(TitanAPI.RespX(10), TitanAPI.RespY(75))
	function PanelBar:Paint(w, h)
		surface.SetDrawColor( Color(0, 0, 0, 50) )
		surface.DrawRect( 0, 0, w, h )
	end


	local PanelPM = vgui.Create( "DPanel", ShopFrame )
	PanelPM:SetSize(TitanAPI.RespX(270), TitanAPI.RespY(570))
	PanelPM:SetPos(ShopFrame:GetWide() - 280, TitanAPI.RespY(150))
	function PanelPM:Paint(w, h)
		surface.SetDrawColor( Color(0, 0, 0, 50) )
		surface.DrawRect( 0, 0, w, h )
	end


	local PMPreview = vgui.Create( "DModelPanel", PanelPM )
	PMPreview:SetPos( 10, 10 )
	PMPreview:SetSize( TitanAPI.RespX(250), TitanAPI.RespY(550) )
    PMPreview:SetLookAt( Vector( 0, 0, 36 ) ) 
	PMPreview:SetFOV( 40 )
		print("Model before : " .. LocalPlayer():GetModel())

	PMPreview:SetModel( LocalPlayer():GetModel() )
	PMPreview.Entity:SetBodygroup(1, PMPreview.Entity:GetBodygroup(1))
	PMPreview.Entity:SetBodygroup(2, PMPreview.Entity:GetBodygroup(2))
	PMPreview.Entity:SetBodygroup(3, PMPreview.Entity:GetBodygroup(3))
	PMPreview.Entity:SetBodygroup(5, PMPreview.Entity:GetBodygroup(5))
    function PMPreview:LayoutEntity( ent )
        if self:IsDown() then
            local curposx, curposy = self:CursorPos()
            if self.prevx == nil or self.prevy == nil then self.prevx, self.prevy = curposx, curposy end
                ent:SetAngles( Angle( 0, -( self.prevx - curposx ), 0 ) )
        else
            self.prevx, self.prevy = nil, nil
        end
    end
    print("Model : " .. PMPreview:GetModel())



	local PanelList = vgui.Create( "DPanel", ShopFrame )
	PanelList:SetSize(ShopFrame:GetWide() - 280 - 10 - 10, TitanAPI.RespY(570))
	PanelList:SetPos(TitanAPI.RespX(10), TitanAPI.RespY(150))
	function PanelList:Paint(w, h)
		surface.SetDrawColor( Color(0, 0, 0, 50) )
		surface.DrawRect( 0, 0, w, h )
	end

    for k,v in pairs(buttonType) do

    	buttonType[k] = PanelBar:Add("CRPButton")
    	buttonType[k]:SetTitre(v.Name)
    	buttonType[k]:SetRSize(150, 40)
		buttonType[k]:SetRPos(((k - 1) * 150) + 15, 5)
		buttonType[k].DoClick = function(self)
			v['Func']( PanelList, PMPreview, LocalPlayer(), ShopFrame )
		end

	end

end)


function CitadelleRP.Clothing:ViewList( p, type, model, ent, frame )

	local pScroll = vgui.Create( "DScrollPanel", p )
    pScroll:Dock( FILL )
    local sbar = pScroll:GetVBar()
	sbar:SetHideButtons( true )
	function sbar:Paint(w, h)
		draw.RoundedBox( 1, 5, 0, w, h, Color( 42, 42, 40, 230 ) )
	end
	function sbar.btnGrip:Paint(w, h)
	   	draw.RoundedBox( 1, 5, 0, w, h, Color( 72, 72, 70 ) )
	end 

  
	local pList = vgui.Create( "DIconLayout", pScroll )
    pList:Dock( FILL )
    pList:SetSpaceY( 10 )
    pList:SetSpaceX( 20 )
     


	for k,v in SortedPairs( CitadelleRP.Clothing.Config.List or {} ) do

        local panel = pList:Add( 'SpawnIcon' )
        panel:SetSize( TitanAPI.RespX(124), TitanAPI.RespY(200) )
        panel:SetPos(TitanAPI.RespX(5), TitanAPI.RespY(7))
        panel:SetText("")
		panel.Paint = function(p, w, h)
			surface.SetDrawColor( Color(0, 0, 0, 50) )
			surface.DrawRect( 0, 0, w, h )
		end


		local modelL = vgui.Create( "DModelPanel", panel )
	    modelL:SetSize( TitanAPI.RespX(110), TitanAPI.RespY(178) )
	    modelL:SetPos( 7, 11 )
	    modelL:SetModel( LocalPlayer():GetModel() )
		modelL.Entity:SetBodygroup(1, modelL.Entity:GetBodygroup(1))
		modelL.Entity:SetBodygroup(2, modelL.Entity:GetBodygroup(2))
		modelL.Entity:SetBodygroup(3, modelL.Entity:GetBodygroup(3))
		modelL.Entity:SetBodygroup(5, modelL.Entity:GetBodygroup(5))
	    modelL.LayoutEntity = function() 
	    	return 
	    end
		modelL.DoClick = function()

			panel.Paint = function(self,w,h)
				surface.SetDrawColor( Color(0, 0, 0, 50) )
				surface.DrawRect( 0, 0, w, h )
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawOutlinedRect( 0, 0, w, h )

			end 
			--model:SetModel(ent:GetModel())

			model.Entity:SetBodygroup(3,modelL.Entity:GetBodygroup(3) )


	    end


	    TitanAPI.switch (type,

			TitanAPI.case(1, function()

				local startpos = modelL.Entity:GetBonePosition( modelL.Entity:LookupBone( "ValveBiped.Bip01_Spine2" ) or 0)
				modelL:SetLookAt( startpos )
				modelL:SetCamPos( startpos - Vector( -17,0,0) )
				modelL.Entity:SetEyeTarget( startpos - Vector( -25,0,0) )

			end),

			TitanAPI.case(2, function()

				local startpos = modelL.Entity:GetBonePosition( modelL.Entity:LookupBone( "ValveBiped.Bip01_R_Calf" ) or 0) + Vector( 0,5,0 )
				modelL:SetLookAt( startpos )
				modelL:SetCamPos( startpos - Vector( -30,-0,0) )
				modelL.Entity:SetEyeTarget( startpos - Vector( -30,-0,0) )
	
			end),

			TitanAPI.case(3, function()

				local startpos = modelL.Entity:GetBonePosition( modelL.Entity:LookupBone( "ValveBiped.Bip01_R_Foot" ) or 0) + Vector( 0,5,0 )
				modelL:SetLookAt( startpos )
				modelL:SetCamPos( startpos - Vector( -30,-0,0) )
				modelL.Entity:SetEyeTarget( startpos - Vector( -10,-0,0) )

			end),

			TitanAPI.default( function() print("[CLOTHING] Aucune valeur : Contactez un administrateur") end)
		)

    end


	function CitadelleRP.Clothing.hoverInformations(bool, panel, v)


     	local panel2 = vgui.Create("DPanel", panel)
        panel2:SetSize( panel:GetWide(), panel:GetTall() )
        panel2:SetPos(0, 0)
        function panel2:Paint( w, h )

        	if self:IsHovered() then
        					draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, °0 ) )

        		return
        	end
			draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 200, 200, 200 ) )

        end



	end


    

end
