function CitadelleRP.API:DrawHudPNJ(entity, title, desc, color)

    local pos = entity:GetPos()
	local ang = entity:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 85)

	local alpha = (LocalPlayer():GetPos():DistToSqr(entity:GetPos()) / 500^2)
	alpha = math.Clamp(1 - alpha, 0 ,1)

	local a = Angle(0,0,90)
	a.y = entity:GetAngles().y + 90

	if LocalPlayer():GetPos():DistToSqr(entity:GetPos()) < 500^2 then

		cam.Start3D2D(pos +  Vector(0, 0, math.sin(CurTime())*2), a, 0.05)
			draw.RoundedBox( 0, 300, -1300, 800, 280, Color( 35, 35, 35, 250 * alpha ))
			draw.RoundedBox( 0, 300, -1300, 800, 20, Color( 180, 180, 180, 255 * alpha ))

			draw.SimpleTextOutlined(title, CitadelleRP.API:CreateFont(100, "Righteous", 400), 300+400, -1200, Color(255, 255, 255, 255 * alpha), 1, 1, 0, Color(25, 25, 25, 100 * alpha));		
			draw.SimpleTextOutlined(desc, CitadelleRP.API:CreateFont(80, "Righteous", 400), 300+400, -1100, Color(255, 255, 255, 200 * alpha), 1, 1, 0, Color(25, 25, 25, 100 * alpha));				
		cam.End3D2D();
		
	end 
end



