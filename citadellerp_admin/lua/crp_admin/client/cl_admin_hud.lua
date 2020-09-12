function CitadelleRP.Admin:DrawHudAdmin( ply )

  	if ply:IsInStaff() then 

		local intW, intH = ScrW(), ScrH()
	    local intBoxWeight, intBoxHeight = intW *.14, intH *.075

	 	CitadelleRP.API:DrawLinearGradient( intW - intBoxWeight, 0, intBoxWeight, intBoxHeight, Color( 0, 0, 0, 0 ), Color( 40, 40, 40, 225 ), false )
	    CitadelleRP.API:DrawLinearGradient( intW - intBoxWeight, 0, intBoxWeight, intBoxHeight * 0.08, Color( 0, 0, 0, 0 ), Color( 120, 120, 120, 225 ), false )

	    surface.SetFont(CitadelleRP.API:CreateFont(30,"Righteous",600))
		draw.SimpleTextOutlined("MODE ADMIN", CitadelleRP.API:CreateFont(30,"Righteous",600), ScrW() - 20 - select(1, surface.GetTextSize("MODE ADMIN")), 10, Color(255,255,255), 0, 0, 1, color_black )

		local col
		local xNoclipTextWide = select(1, surface.GetTextSize("MODE ADMIN"))

		if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then col = Color( 39, 174, 96 ) else col = Color( 192, 57, 43 ) end
		draw.SimpleTextOutlined( "NoClip", CitadelleRP.API:CreateFont(28,"Righteous",400), ScrW() - 20 - xNoclipTextWide, 42, col, 0, 0, 1, color_black )


		if LocalPlayer():GetRenderMode() == 4 then col = Color( 39, 174, 96 ) else col = Color( 192, 57, 43 ) end
		surface.SetFont(CitadelleRP.API:CreateFont(28,"Righteous",400))
		draw.SimpleTextOutlined( "Cloak", CitadelleRP.API:CreateFont(28,"Righteous",400), ScrW() - 20 - select(1, surface.GetTextSize("Cloak")) , 42, col, 0, 0, 1, color_black )


		for k, v in pairs( player.GetAll() ) do
			
			if v == LocalPlayer() then continue end
			if LocalPlayer():GetPos():Distance(v:GetPos()) < 325 and not v:InVehicle() then continue end

			local Pos = ( v:GetPos() + Vector( 0, 0, 75 ) ):ToScreen()
			draw.SimpleTextOutlined( v:Nick(), CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y - 60, color_white, 1, 1, 1, color_black )
			draw.SimpleTextOutlined( v:getDarkRPVar("job"), CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y - 50, color_white, 1, 1, 1, color_black )
			draw.SimpleTextOutlined( v:Health().."❤", CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y - 40, color_white, 1, 1, 1, color_black )
			draw.SimpleTextOutlined( v:Armor().."%", CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y - 30, color_white, 1, 1, 1, color_black )
			draw.SimpleTextOutlined( v:GetUserGroup(), CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y - 20, color_white, 1, 1, 1, color_black )

			local colorPlayer = (v:isCP() and Color(0, 102, 204, 200)) or Color(204, 0, 0, 200)
			draw.SimpleTextOutlined( "●", CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y, colorPlayer, 1, 1, 1, color_black )
			if v:IsStaff() and v:GetNWBool("IS_MOD", false)  then
				draw.SimpleTextOutlined( "En service", "Trebuchet18", Pos.x, Pos.y - 10, Color( 255, 0, 0 ), 1, 1, 1, color_black )
			end

		end
	
		for k, v in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do

			local Pos = ( v:GetPos() + Vector( 0, 0, 75 ) ):ToScreen()
			draw.SimpleTextOutlined( "●", CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y-40, Color(0, 204, 0, 200), 1, 1, 1, color_black )
			draw.SimpleTextOutlined( v:GetVehicleClass(), CitadelleRP.API:CreateFont(15,"Righteous",200), Pos.x, Pos.y-30, color_white, 1, 1, 1, color_black )

		end

	end

end

hook.Add("HUDPaint", "CRP:Admin:HudPaint", function()
	
	local ply = LocalPlayer()
	CitadelleRP.Admin:DrawHudAdmin( ply )

end)