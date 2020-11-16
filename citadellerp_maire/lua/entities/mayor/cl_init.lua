include( "shared.lua" )

function ENT:DrawTranslucent()
	self:DrawModel()
end

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

net.Receive("MAIRE:VerifOn", function ( len )

--[[-------------------------------------------------------------------------
    Frame
---------------------------------------------------------------------------]]

	local Frame = vgui.Create( "DFrame" )

    Frame:SetSize( 400, 400 )
    Frame:Center()
    Frame:SetTitle('')
    Frame:SetDraggable( false )
    Frame:ShowCloseButton( false )
    Frame:MakePopup()
    function Frame:Paint( w, h )

        DrawBlur( self, 5 )

        -- Bordure
        surface.SetDrawColor( 255, 255, 255, 100 )
        surface.DrawRect( 0, 0, w - 4, 4 )
        surface.DrawRect( 0, 0 + 4, 4, h - 8 )
    	surface.DrawRect( w - 4, 0, 4, h - 4 )
        surface.DrawRect( 0, h - 4, w , 4 )

        -- Frame
        surface.SetDrawColor( 36, 36, 33, 250 )
        surface.DrawRect( 4, 4, w - 8, h - 8 )

    end

    -- Bouton Close
    local BoutonClose = vgui.Create( "DButton", Frame )
    BoutonClose:SetSize( 16, 16 )
    BoutonClose:SetPos( Frame:GetWide() - BoutonClose:GetWide() - 10, 10 )
    BoutonClose:SetText('')
    function BoutonClose:Paint( w, h )
        draw.SimpleText( "✖", "Bebas:30", w / 2, h / 2, Color( 255, 121, 121 ), 1, 1 )
    end
    function BoutonClose:DoClick()
        Frame:Remove()
    end

--[[-------------------------------------------------------------------------
    Taxe
 ---------------------------------------------------------------------------]] 

    -- Texte Taxe
    local Maire_Text_Tax = vgui.Create("DLabel", Frame)
    local Maire_Text_Tax_Text = "Taxe : " .. GetGlobalInt("MAIRE_TAX") .. "%"

    surface.SetFont("Bebas:30")

    local Maire_Text_TaxW, Maire_Text_TaxH = surface.GetTextSize(Maire_Text_Tax_Text)
    local Maire_Text_TaxX = (Frame:GetWide() - Maire_Text_TaxW) / 2 
    Maire_Text_Tax:SetPos(Maire_Text_TaxX, 60)

    Maire_Text_Tax:SetFont("Bebas:30")
    Maire_Text_Tax:SetColor( Color( 255, 255, 255, 255) )
    Maire_Text_Tax:SetText(Maire_Text_Tax_Text)
    Maire_Text_Tax:SizeToContents()
 

    -- Slider Taxe
    local Maire_Slider_Tax = vgui.Create("DNumSlider", Frame)
    Maire_Slider_Tax:SetWide( 480 )
    Maire_Slider_Tax:SetPos( -120, 100 )
    Maire_Slider_Tax:SetText( "" )
    Maire_Slider_Tax:SetMin( 0 )
    Maire_Slider_Tax:SetMax( 25 )
    Maire_Slider_Tax:SetValue( GetGlobalInt("MAIRE_TAX") )
    Maire_Slider_Tax:SetDecimals( 0 )
 
    -- Bouton Taxe
    local Maire_Button_Tax = vgui.Create( "DButton", Frame )
    Maire_Button_Tax:SetText( "Définir la taxe" )
    Maire_Button_Tax:SetFont("Bebas:15")
    Maire_Button_Tax:SetTextColor( Color( 255, 255, 255 ) )
    Maire_Button_Tax:SetPos( 150, 150 )
    Maire_Button_Tax:SetSize( 100, 30 )
    Maire_Button_Tax.Paint = function( self, w, h )

        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) ) 

        if self:IsHovered() then
        	
        	draw.RoundedBox( 0, 0, 0, w, h, Color( 64, 64, 64, 250 ) ) 

        end
    end
    Maire_Button_Tax.DoClick = function()
 
        net.Start( "MAIRE:UpdateTax" )
        net.WriteDouble( math.Clamp( math.Round( tonumber(Maire_Slider_Tax:GetValue()) ), 0, 25 ) )
        net.SendToServer()
        Frame:Close()
 
    end
 
--[[-------------------------------------------------------------------------
    Money
---------------------------------------------------------------------------]]

     -- Texte Money
    local Maire_Text_Money = vgui.Create("DLabel", Frame)
    local Maire_Text_Money_Text = "Il y a " .. DarkRP.formatMoney( GetGlobalInt( "MAIRE_MONEY" ) ) .. " dans le coffre."

    surface.SetFont("Bebas:30")

    local Maire_Text_MoneyW, Maire_Text_MoneyH = surface.GetTextSize(Maire_Text_Money_Text)
    local Maire_Text_MoneyX = (Frame:GetWide() - Maire_Text_MoneyW) / 2 
    Maire_Text_Money:SetPos(Maire_Text_MoneyX, 250)

    Maire_Text_Money:SetFont("Bebas:30")
    Maire_Text_Money:SetColor( Color( 255, 255, 255, 255) )
    Maire_Text_Money:SetText(Maire_Text_Money_Text)
    Maire_Text_Money:SizeToContents()
 
    -- Bouton Money
    local Maire_Button_Money = vgui.Create( "DButton", Frame )
    Maire_Button_Money:SetText( "Retirer les fonds" )
    Maire_Button_Money:SetFont("Bebas:15")
    Maire_Button_Money:SetTextColor( Color( 255, 255, 255 ) )
    Maire_Button_Money:SetPos( 150, 300 )
    Maire_Button_Money:SetSize( 100, 30 )
    Maire_Button_Money.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 250 ) )
        if self:IsHovered() then
        	draw.RoundedBox( 0, 0, 0, w, h, Color( 64, 64, 64, 250 ) ) 
        end
    end
    Maire_Button_Money.DoClick = function()

        notification.AddLegacy("Vous avez prix l'argent contenu dans le coffre (" .. GetGlobalInt("MAIRE_MONEY") .. "$).", 3, 5)
        net.Start( "MAIRE:TakeMoney" )
        net.SendToServer()
        Frame:Close()

    end

end)



net.Receive("MAIRE:VerifOff", function( len )

    notification.AddLegacy("Désolé, tu n'es pas maire de la ville !", 1, 5)

end)

