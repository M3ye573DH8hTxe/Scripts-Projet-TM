local PANEL = {}

function PANEL:Init()
    self:SetTextColor(color_white)
    self:SetCursorColor(color_white)
    self.lerpValid = 0
    self.intBorderRadius = 0

    self:SetDrawLanguageID(false)

    self.colLabel = CitadelleRP.API:GetColor("secondary")
    self.colLabelText = color_white
    self.colValid = CitadelleRP.API:GetColor("valid")
    self.colBackground = CitadelleRP.API:GetColor("primary")
end

function PANEL:SetRPos(x, y) self:SetPos(CitadelleRP.API:RespX(x), CitadelleRP.API:RespY(y)) end
function PANEL:SetRSize(w, h) self:SetSize(CitadelleRP.API:RespX(w), CitadelleRP.API:RespY(h)) end

function PANEL:SetLabel(strText,tblIcon)
    surface.SetFont(self:GetFont())
    local intW, intH = surface.GetTextSize(strText)
    intW = intW + 30

    if tblIcon then
        self.tblIcon = {
            infos = tblIcon,
            icon = CitadelleRP.API:GetIcon(tblIcon.type,tblIcon.size or 18,tblIcon.unicode)
        }

        intW = intW + ( self.tblIcon.infos.size + 10 )
    end

    self.strLabel = strText

    local pLabel = vgui.Create("DPanel",self:GetParent())
    pLabel:SetPos(self:GetPos())
    pLabel:SetSize(intW,self:GetTall())
    pLabel.Paint = function(p,w,h)
        draw.RoundedBox(0,0,0,w,h,self.colLabel)

        if self.tblIcon then 
            draw.SimpleText(self.tblIcon.icon.text,self.tblIcon.icon.font,self.tblIcon.infos.size + 5,h/2,self.colLabelText,1,1)
            draw.SimpleText(self.strLabel,self:GetFont(),tblIcon.size+25,h/2,self.colLabelText,0,1)
        else
            draw.SimpleText(self.strLabel,self:GetFont(),w/2,h/2,self.colLabelText,1,1)
        end
    end

    local oldPosX,oldPosY = self:GetPos()

    self:SetPos(oldPosX+pLabel:GetWide(),oldPosY)
    self:SetSize(self:GetWide()-pLabel:GetWide(),self:GetTall())

    return self 
end 

function PANEL:SetLabelColor(col)
    self.colLabel = col

    return self
end

function PANEL:SetLabelTextColor(col)
    self.colLabelText = col

    return self
end

function PANEL:SetBackgroundColor(col)
    self.colBackground = col

    return self
end

function PANEL:Paint(w,h)
    draw.RoundedBox(self.intBorderRadius,0,0,w,h,self.colBackground)

    local intLerpTime = 5

    if string.len(self:GetText()) > 0 then
        self.lerpValid = Lerp(FrameTime()*intLerpTime,self.lerpValid,w)
    else
        self.lerpValid = Lerp(FrameTime()*intLerpTime,self.lerpValid,0)
    end

    surface.SetDrawColor(self.colValid)
    surface.DrawRect(w/2 - self.lerpValid / 2,h-1,self.lerpValid,1)

	if ( self.GetPlaceholderText && self.GetPlaceholderColor && self:GetPlaceholderText() && self:GetPlaceholderText():Trim() != "" && self:GetPlaceholderColor() && ( !self:GetText() || self:GetText() == "" ) ) then
		local oldText = self:GetText()

		local str = self:GetPlaceholderText()
		if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
		str = language.GetPhrase( str )

	    self:SetText( str )
		self:DrawTextEntryText( self:GetPlaceholderColor(), self:GetHighlightColor(), self:GetCursorColor() )
		self:SetText( oldText )

        return
    end

    self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
end

function PANEL:SetBorderRadius(intAmount)
    self.intBorderRadius = intAmount

    return self
end


vgui.Register("CRPTextEntry",PANEL,"DTextEntry")
