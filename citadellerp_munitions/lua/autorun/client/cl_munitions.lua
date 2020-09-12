
local matBlur = Material( "pp/blurscreen" )
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen( 0, 0 )
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor( 255, 255, 255 )
    surface.SetMaterial( matBlur )
    for i = 1, 3 do
        matBlur:SetFloat( "$blur", ( i / 3 ) * ( amount or 6 ) )
        matBlur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( x * -1, y * -1, scrW, scrH )
    end
end

net.Receive("Munitions:OpenCaisse", function(len)

    local vendeur = net.ReadEntity()

    local MunitionShop = vgui.Create( "CRPFrame" )
    MunitionShop:SetRSize(600, 600)
    MunitionShop:Center()
    if vendeur:Nick() ~= nil then 
    	MunitionShop:SetTitle("Munitions - " .. vendeur:Nick())
    else
    	MunitionShop:SetTitle("Munitions - Libre")
    end
    MunitionShop:SetDraggable( false )
    MunitionShop:CloseButton( true )    


    local MunitionShopScroll = vgui.Create( "CRPScrollPanel", MunitionShop )
    MunitionShopScroll:SetRSize( MunitionShop:GetWide() - 20, MunitionShop:GetTall() - 110 - 10 )
    MunitionShopScroll:SetRPos( 10, 110 )
    MunitionShopScroll.Paint = nil
    local MunitionScrollbar = MunitionShopScroll:GetVBar()
    MunitionScrollbar:SetHideButtons( true )
    function MunitionScrollbar:Paint(w, h)
        draw.RoundedBox( 3, 6, 5, w, h, Color( 42, 42, 40, 230 ) )
    end
    function MunitionScrollbar.btnGrip:Paint(w, h)
        draw.RoundedBox( 3, 6, 0, w, h, Color( 72, 72, 70 ) )
    end    



    for k,v in pairs(DarkRP.getCategories().ammo) do

        for ki, ammo in pairs(v.members) do

		    local weaponType = vgui.Create("CRPPanel", MunitionShopScroll)
		    weaponType:SetRSize(0, 80)
		    weaponType:DockMargin(0, 0, 0, 5)
		    weaponType:Dock(TOP)
		    weaponType:SetText("")

		    local weaponModel= vgui.Create("SpawnIcon", weaponType)
		    weaponModel:SetPos(20, 17.5)
		    weaponModel:SetSize(55, 55)
		    weaponModel:SetModel(ammo.model)
		    function weaponModel:OnMousePressed() end 
		    function weaponModel:IsHovered() end
		        
		    local weaponBTN = vgui.Create("DButton", weaponType)
		    weaponBTN:SetSize(90, 45)
		    weaponBTN:SetPos(440, 17.5)
		    weaponBTN:SetText("")

		    function weaponBTN:OnCursorEntered()
		        surface.PlaySound("UI/buttonrollover.wav")
		    end

		    function weaponBTN:OnCursorExited()
		        hovering = false
		    end

		    function weaponType:Paint(w, h)

		        draw.RoundedBox(15, 5, 0, w, h, Color(36, 39, 44, 150))

		        draw.RoundedBox(0, 100, (h / 2) - 23, 1, 50, Color(255, 255, 255, 150))
		        draw.SimpleText(ammo.name, CitadelleRP.API:CreateFont(20, "Righteous", 300),  175,  h /2, Color( 255, 255, 255 ), 1, 1 )

		        draw.RoundedBox(0, 250, (h / 2) - 23, 1, 50, Color(255, 255, 255, 150))
		        draw.SimpleText( "PRIX : " .. ammo.price / 2 .. "$", CitadelleRP.API:CreateFont(20, "Righteous", 300),  325,  h /2, Color( 255, 255, 255 ), 1, 1 )

		        draw.RoundedBox(0, 400, (h / 2) - 23, 1, 50, Color(255, 255, 255, 150))

		    end

		    weaponBTN.Paint = function (self, w, h)

		        local money = LocalPlayer():getDarkRPVar("money")

		        draw.RoundedBox(3, 0, 0, w, h, Color(104, 104, 104, 255))

		        if self:IsHovered() == false then
		            draw.SimpleText( "Acheter", CitadelleRP.API:CreateFont(20, "Righteous", 300), w / 2 , h / 2 , Color( 255, 255, 255 ), 1, 1 )
		        end

		        if self:IsHovered() then 

		            if money < ammo.price then

		                draw.SimpleText( "✖", CitadelleRP.API:CreateFont(20, "Righteous", 300), w / 2 , h / 2 , Color( 255, 255, 255 ), 1, 1 )

		            end 

		            if money > ammo.price then

		                draw.SimpleText( "✔", CitadelleRP.API:CreateFont(20, "Righteous", 300), w / 2 , h / 2 , Color( 255, 255, 255 ), 1, 1 )

		            end
		                

		        end

		        weaponBTN.DoClick = function ()

		            local moneyYY = LocalPlayer():getDarkRPVar("money")

		            if moneyYY < (ammo.price / 2) then
		                    
		                notification.AddLegacy("Désolé, vous n'avez pas assez d'argent pour acheter cette arme.", 1, 5)
		                return
		                    
		            end
		     

		            net.Start("Munitions:Acheter")
		            net.WriteString(ammo.ammoType)
		            net.WriteInt(ammo.price / 2, 32)
		            net.WriteEntity(vendeur)
		            net.SendToServer()

		        end

		    end

    	end

	end

end)