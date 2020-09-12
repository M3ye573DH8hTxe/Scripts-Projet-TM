CitadelleRP.HUD.tblNotification = CitadelleRP.HUD.tblNotification or {}

CitadelleRP.HUD.iconsNotification = {
    [0] = Material( "vgui/notices/generic" ),
    [1] = Material( "vgui/notices/error" ),
    [2] = Material( "vgui/notices/undo" ),
    [3] = Material( "vgui/notices/hint" ),
    [4] = Material( "vgui/notices/cleanup" ),
}

-- override gmod
function notification.AddLegacy( text, type, length )
    surface.SetFont( CitadelleRP.API:CreateFont(18, "Coolvetica Rg", 400) )
    
    surface.PlaySound( "buttons/button15.wav" )

    table.insert( CitadelleRP.HUD.tblNotification, {
        text = text,
        type = type,
        time = CurTime() + length,

        x = ScrW(), 
        y = ScrH(),
        w = 10 + 32 + 10 + surface.GetTextSize( text ) + 10,
        h = 5 + 32 + 5
    } )
end

-- drawing notifications
hook.Add( "HUDPaint", "SlawerNotification:HUDPaint", function()
    for k, v in pairs( CitadelleRP.HUD.tblNotification ) do
        v.x = Lerp( FrameTime() * 10, v.x, v.time < CurTime() && ScrW() + 10 || ScrW() - 10 - v.w )
        v.y = Lerp( FrameTime() * 10, v.y, ScrH() - k * ( v.h + 10 ) - ScrH() * .25  )

        CitadelleRP.API:DrawLinearGradient( v.x, v.y, v.w, v.h, Color( 10, 10, 10, 30 ), Color( 40, 40, 40, 225 ), false )
        CitadelleRP.API:DrawLinearGradient( v.x, v.y, v.w, v.h * 0.08, Color( 90, 90, 90, 30 ), Color( 120, 120, 120, 225 ), false )

        draw.SimpleText( v.text, CitadelleRP.API:CreateFont(18, "Coolvetica Rg", 400), v.x + 10 + 32 + 10, v.y + v.h / 2, color_white, 0, 1 )

        surface.SetDrawColor( color_white )
        surface.SetMaterial( CitadelleRP.HUD.iconsNotification[v.type] )
        surface.DrawTexturedRect( v.x + 10, v.y + 5, 32, 32 )

        if v.time < CurTime() && v.x >= ScrW() then
            table.remove( CitadelleRP.HUD.tblNotification, k )
        end
    end
end)