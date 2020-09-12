local blur = Material( 'pp/blurscreen' )
local gradient = Material( "gui/gradient_up", "smooth" )

surface.DrawBlur = function( x, y, w, h, amount )
    surface.SetDrawColor( 255, 255, 255, 255 )
    surface.SetMaterial( blur )

    for i = 1, 3 do
        blur:SetFloat( '$blur', ( i / 3 ) * ( amount or 6 ) )
        blur:Recompute()

        render.UpdateScreenEffectTexture()

        render.SetScissorRect( x, y, x + w, y + h, true )
            surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
        render.SetScissorRect( 0, 0, 0, 0, false )
    end
end


surface.DrawGradient = function( x, y, w, h )

    surface.SetDrawColor( 0, 0, 0, 200 )
    surface.SetMaterial( gradient )
    surface.DrawTexturedRect( x, y, w, h )

end