concommand.Add("getPosEntity", function ( ply )

    if not ply:IsSuperAdmin() then return end

    local entity = ply:GetEyeTrace().Entity

    if !IsValid( entity ) then return end

    local vecPos = string.Explode( " ", tostring( entity:GetPos() ) )
    local angPos = string.Explode( " ", tostring( entity:GetAngles() ) )


    print("===================================")
    print('Vector( ' .. vecPos[1] .. ", " .. vecPos[2] .. ", " .. vecPos[3] .. " )")
    print('Angle( ' .. angPos[1] .. ", " .. angPos[2] .. ", " .. angPos[3] .. " )" )
    print("===================================")

end)

