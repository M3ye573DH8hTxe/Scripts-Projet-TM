net.Receive( "CRP::Shop:Player:OpenMenu", function()
    local ent = net.ReadEntity()
    local intID = ent:GetShopID()
    local tbl = CitadelleRP.Shop.Config.List[ intID ]


    local Shop = vgui.Create( "CRPFrame" )
    Shop:SetRSize(600, 500)
    Shop:SetTitle(tbl.Name)
    Shop:Center()
    Shop:SetDraggable( false )
    Shop:CloseButton( true )	


    local pList = vgui.Create( "CRPScrollPanel", Shop )
    pList:SetSize( Shop:GetWide() - 20, Shop:GetTall() - 110 - 10 )
    pList:SetPos( 10, 110 )
    pList.Paint = nil
	local scrollbar = pList:GetVBar()
    scrollbar:SetHideButtons( true )
    function scrollbar:Paint(w, h)
        draw.RoundedBox( 1, 5, 5, w, h, Color( 42, 42, 40, 230 ) )
    end
    function scrollbar.btnGrip:Paint(w, h)
        draw.RoundedBox( 1, 5, 0, w, h, Color( 72, 72, 70 ) )
    end        

	local pListLayout = vgui.Create( "DIconLayout", pList )
    pListLayout:SetSize( pList:GetWide(), pList:GetTall() )
    pListLayout:SetSpaceY( 5 )

    local intM = 0

    if table.Count( tbl.Content ) > 4 then
        intM = 5
    end

    for k,v in SortedPairs( tbl.Content or {}, false ) do
        local Bouton = vgui.Create( "DButton", pListLayout )
        Bouton:SetSize( pListLayout:GetWide(), 100 )
        Bouton:SetText('')
        Bouton:SetAlpha( 100 )
        function Bouton:OnCursorEntered()
            Bouton:AlphaTo( 255, 0.5, 0 )
            self.hover = true
        end
        function Bouton:OnCursorExited()
            Bouton:AlphaTo( 100, 0.5, 0 )
            self.hover = false
        end
        Bouton.Slide = 0

        function Bouton:Paint( w, h )

            surface.SetDrawColor( Color( 130, 130, 130, 150 ) )
            surface.DrawRect( 0, 0, w, h )
            
            surface.SetDrawColor( Color( 60, 60, 60, 200 ) )
            surface.DrawRect( 11, 20, 60, 60 )

            surface.SetFont( "Bebas:18" )
            local intTW, intTH = surface.GetTextSize( v.Name .. " -" )

            local col = Color( 71, 138, 73 )

            if LocalPlayer():getDarkRPVar('money') < v.Price then
                col = Color( 177, 89, 86 )
            end

        if self.hover then 
                self.Slide = Lerp( 0.08, self.Slide, w )

                draw.SimpleText( v.Name .. " -", "Bebas:18", 85, h / 2, color_white, 0, 1 )
                draw.SimpleText( " " .. DarkRP.formatMoney( v.Price ), "Bebas:18", 85 + intTW, h / 2, col, 0, 1 )

                surface.SetDrawColor( col )
                surface.DrawRect( self.Slide - 140, 0, 140, h )

                local intXC = ( w - 140 ) + 140 / 2
                draw.SimpleTextOutlined( "ACHETER", "Bebas:30", self.Slide - 70 - intM, h / 2, color_white, 1, 1, 1, color_black )

            else
                self.Slide = Lerp( 0.05, self.Slide, 0 )

                draw.SimpleText( v.Name .. " -", "Bebas:18", 85, h / 2, color_white, 0, 1 )
                draw.SimpleText( " " .. DarkRP.formatMoney( v.Price ), "Bebas:18", 85 + intTW, h / 2, col, 0, 1 )
            end
        end
        function Bouton:DoClick()
            if v.Price > LocalPlayer():getDarkRPVar("money") then
                surface.PlaySound("UI/buttonrollover.wav")
            else
            surface.PlaySound("UI/buttonclick.wav")

            net.Start( "CRP::Shop:Player:BuyShop" )
                net.WriteEntity( ent )
                net.WriteUInt( k, 32 )
            net.SendToServer()
        end
        end

        local pModel = vgui.Create( "SpawnIcon", Bouton )
        pModel:SetSize( 60, 60 )
        pModel:SetPos( 10, 20 )
        pModel:SetModel( v.Model )
        pModel:SetToolTip()
        function pModel:OnMousePressed() end 
        function pModel:IsHovered() end
    end   
end)

