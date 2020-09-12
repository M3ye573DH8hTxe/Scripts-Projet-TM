local PANEL = {}

AccessorFunc(PANEL,"colBackground","BackgroundColor")
AccessorFunc(PANEL,"colBackgroundHover","BackgroundColorHover")
AccessorFunc(PANEL,"intLerp","Lerp",FORCE_NUMBER)
AccessorFunc(PANEL,"type","ButtonType")


function PANEL:Init()
    self:SetFont(self:getFont("button4"))
    self:SetTextColor(color_white)
    self:SetText("")

    self:SetLerp(0)
    self:SetButtonType("diagonal")
    self:SetBackgroundColor(self:getColor("secondary"))
    self:SetBackgroundColorHover(self:getColor("green"))

    function self:SetText(str) self.strText = str end
    function self:GetText() return self.strText end
end

function PANEL:SetRPos(x, y) self:SetPos(CitadelleRP.API:RespX(x), CitadelleRP.API:RespY(y)) end
function PANEL:SetRSize(w, h) self:SetSize(CitadelleRP.API:RespX(w), CitadelleRP.API:RespY(h)) end


function PANEL:DoClick()
    if IsValid(self) then
        surface.PlaySound("buttons/button14.wav")
    end
end

function PANEL:Paint(w, h)

    self:drawRect(0,0,w,h,self:GetBackgroundColor())

    CitadelleRP.API:switch (self.type,

        CitadelleRP.API:case("diagonal", function()

            self:SetLerp(Lerp(RealFrameTime() * 8,self:GetLerp(),self:IsHovered() && w + 40 || 0))

            surface.SetDrawColor(self:GetBackgroundColorHover())
            draw.NoTexture()
            surface.DrawPoly({
                { x = 0, y = 0 },
                { x = self:GetLerp() - 40, y = 0 },
                { x = self:GetLerp(), y = h },
                { x = 0, y = h }
            })

        end),

        CitadelleRP.API:case("horizontal", function()

            self:SetLerp(Lerp(RealFrameTime() * 8,self:GetLerp(),self:IsHovered() && w + 40 || 0))
            draw.NoTexture()
            self:drawRect(0,0,self:GetLerp(),h,self:GetBackgroundColorHover())
    
        end),


        CitadelleRP.API:case("normal", function()

            if self:IsHovered() then self:drawRect(0,0,w,h,self:GetBackgroundColorHover()) end

        end),

        CitadelleRP.API:default( function() end)
    )

    draw.SimpleText(self:GetText(),self:GetFont(),w/2,h/2,self:GetTextColor(),1,1)
    --self:drawOutline(0,0,w,h,self:getColor("outline"))

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



function PANEL:drawRect(x, y, w, h, color)
    return CitadelleRP.API:drawRect(x, y, w, h, color)
end 
function PANEL:drawOutline(x, y, w, h, color)
    return CitadelleRP.API:drawOutline(x, y, w, h, color)
end 



derma.DefineControl("CRPButton", "Titan DButton", PANEL, "DButton")