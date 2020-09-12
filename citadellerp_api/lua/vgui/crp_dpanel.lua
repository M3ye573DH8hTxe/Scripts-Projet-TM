local PANEL = {}

function PANEL:Init()

end

function PANEL:SetRPos(x, y) self:SetPos(CitadelleRP.API:RespX(x), CitadelleRP.API:RespY(y)) end
function PANEL:SetRSize(w, h) self:SetSize(CitadelleRP.API:RespX(w), CitadelleRP.API:RespY(h)) end


vgui.Register("CRPPanel",PANEL,"DPanel")
