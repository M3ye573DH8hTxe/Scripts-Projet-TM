local PANEL = {}

AccessorFunc(PANEL,"colBackground","BackgroundColor")
AccessorFunc(PANEL,"ColBorder","BorderColor")

function PANEL:Init()
    self:SetFocusTopLevel( true )
    self:SetPaintBackgroundEnabled( false )
    self:SetPaintBorderEnabled( false )

    self:SetTitle("")

   	self:MakePopup()
	self:ShowCloseButton(false)

    self.AddText = {}

    self:SetBackgroundColor(self:getColor("background"))
    self:SetBorderColor(self:getColor("secondary"))


    function self:SetTitle(str) self.strText = str end
    function self:GetTitle() return self.strText end



end

function PANEL:SetRPos(x, y) self:SetPos(CitadelleRP.API:RespX(x), CitadelleRP.API:RespY(y)) end
function PANEL:SetRSize(w, h) self:SetSize(CitadelleRP.API:RespX(w), CitadelleRP.API:RespY(h)) end

function PANEL:CloseButton(bool)
	if isbool(bool) && bool then
        local btnClose = vgui.Create( "DButton", self )
        btnClose:SetSize( 16, 16 )
        btnClose:SetPos( self:GetWide() - btnClose:GetWide() - CitadelleRP.API:RespX(10), CitadelleRP.API:RespY(10) )
        btnClose:SetText('')
        btnClose.Paint = function( self, w, h )
            draw.SimpleText( "✖", "DermaDefault", w / 2, h / 2, Color( 255, 121, 121 ), 1, 1 )
        end
        btnClose.DoClick = function()
        	if IsValid(self) then
        		self:Remove()
        	end
        end
	end
end

function PANEL:AddSimpleText( text, font, x, y, color, alignX, alignY )

    table.insert(self.AddText, CitadelleRP.API:GetNumberOfEntries(self.AddText), {t = text, f = font, xX = x, yY = y, col = color, alix = alignX, aliy = alignY})

end

function PANEL:Paint(w, h)

    CitadelleRP.API:drawRect(0,0,w,h,self:GetBackgroundColor())
    draw.RoundedBorderEx( 1, 3, 0, 0, w, h, self:GetBorderColor(), true, true, true, true )
    surface.DrawGradient(0, 0, w, h)

    
	draw.SimpleText( self.strText, self:getFont("titre"), w / 2, 0 + 30, Color( 255, 255, 255 ), 1, 1 )

    for k,v in pairs(self.AddText or {}) do
        draw.SimpleText( v.t, v.f, v.xX, v.yY, v.col, v.alix, v.aliy )
    end

end

--[[-------------------------------------------------------------------------
Utils
---------------------------------------------------------------------------]]

function PANEL:getColor(str)
    return CitadelleRP.API:GetColor(str)
end


function PANEL:getFont(str)
    return CitadelleRP.API:GetFont(str)
end



derma.DefineControl("CRPFrame", "Titan DFrame", PANEL, "DFrame")