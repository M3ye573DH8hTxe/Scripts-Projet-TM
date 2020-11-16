
surface.CreateFont( "Bebas:30", {
	font = "Bebas Kai", 
	size = 30,
} )

surface.CreateFont( "Bebas:15", {
	font = "Bebas Kai",
	size = 15,
} )


function MAIRE_HUDPaint()

	draw.SimpleTextOutlined( "Taxe : " .. GetGlobalInt("MAIRE_TAX") .. "%", "Bebas:30", ScrW() - 150, 40, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0, Color( 255, 255, 255, 255 ))
	
end
hook.Add( "HUDPaint", "MAIRE_Hud", MAIRE_HUDPaint )