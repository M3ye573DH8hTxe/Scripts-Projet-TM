net.Receive("CRP::Police:Bac:CasierOpen", function( len )
	
	local CasierFrame = vgui.Create( "CRPFrame" )

    CasierFrame:SetSize( 700, 650 )
    CasierFrame:SetTitle("Casier de la BAC")
    CasierFrame:Center()
    CasierFrame:SetDraggable( false )
    CasierFrame:CloseButton( true )    

    
    local PanelModel = vgui.Create( "CRPPanel", CasierFrame )
    PanelModel:SetRSize(225, 500)
    PanelModel:SetRPos(375, 85)
    function PanelModel:Paint(w, h)
        surface.SetDrawColor( Color(0, 0, 0, 50) )
        surface.DrawRect( 0, 0, w, h )
    end


    local PMPreview = vgui.Create( "CRPModelPanel", PanelModel )
    PMPreview:SetRPos( 0, 0 )
    PMPreview:SetRSize( 225, 400)
    PMPreview:SetLookAt( Vector( 0, 0, 36 ) ) 
    PMPreview:SetFOV( 40 )
    PMPreview:SetModel( LocalPlayer():GetModel() )
    function PMPreview:LayoutEntity( ent )
        if self:IsDown() then
            local curposx, curposy = self:CursorPos()
            if self.prevx == nil or self.prevy == nil then self.prevx, self.prevy = curposx, curposy end
                ent:SetAngles( Angle( 0, -( self.prevx - curposx ), 0 ) )
        else
            self.prevx, self.prevy = nil, nil
        end
    end



    local PanelListModel = vgui.Create( "CRPPanel", CasierFrame )
    PanelListModel:SetRSize(225, 500)
    PanelListModel:SetRPos(100, 85)
    function PanelListModel:Paint(w, h)
        surface.SetDrawColor( Color(0, 0, 0, 50) )
        surface.DrawRect( 0, 0, w, h )
    end


    local pScroll = vgui.Create( "CRPScrollPanel", PanelListModel )
    pScroll:SetRSize(225, 400)
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
    pList:SetSpaceY( 50 )
    pList:SetSpaceX( 15 )
     

    for k,v in SortedPairs( CitadelleRP.Police.Config.SkinsBac or {} ) do
        local panel = pList:Add( 'SpawnIcon' )
        panel:SetSize( CitadelleRP.API:RespX(65), CitadelleRP.API:RespY(65) )
        panel:SetModel(v.Model)
        panel.DoClick = function()
            PMPreview:SetModel(v.Model)
        end

    end



    local EquipCostumeBouton = vgui.Create("CRPButton", PanelListModel)
    EquipCostumeBouton:SetRPos(  0, 400 )
    EquipCostumeBouton:SetRSize(225, 100)
    EquipCostumeBouton:SetText("Equiper")
    EquipCostumeBouton:SetBackgroundColorHover(EquipCostumeBouton:getColor("red"))
    EquipCostumeBouton.Paint = function(self, w, h)

        self:drawRect(0,0,w,h,self:GetBackgroundColor())

        self:SetLerp(Lerp(RealFrameTime() * 8,self:GetLerp(),self:IsHovered() && w + 40 || 0))

        surface.SetDrawColor(self:GetBackgroundColorHover())
        draw.NoTexture()
        surface.DrawPoly({
            { x = 0, y = 0 },
            { x = self:GetLerp() - 40, y = 0 },
            { x = self:GetLerp(), y = h },
            { x = 0, y = h }
        })

        if self:IsHovered() then
            if LocalPlayer():GetModel() == PMPreview:GetModel() then
                draw.SimpleText("Choisir un costume",self:GetFont(),w/2,h/2,self:GetTextColor(),1,1 )
                return
            end
        else
            draw.SimpleText(self:GetText(),self:GetFont(),w/2,h/2,self:GetTextColor(),1,1)
        end


    end
    EquipCostumeBouton.DoClick = function()

        net.Start("CRP::Police:Bac:Server")
        net.WriteString("ServerBac:Equip")
        net.WriteString(PMPreview:GetModel())
        net.SendToServer()
    end 

    local ResetCostumeBouton = vgui.Create("CRPButton", PanelModel)
    ResetCostumeBouton:SetRPos(  0, 400 )
    ResetCostumeBouton:SetRSize(225, 100)
    ResetCostumeBouton:SetText("Rénitialiser")
    ResetCostumeBouton.DoClick = function()
        net.Start("CRP::Police:Bac:Server")
        net.WriteString("ServerBac:Reset")
        net.SendToServer()
    end 


end)