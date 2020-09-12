net.Receive("CRP::Family:Client:Invite", function( len )

	local family_name = net.ReadString() or "Unknown"

	local FamillyInviteInterface = vgui.Create("CRPFrame")
	FamillyInviteInterface:SetRSize(350, 200)
    FamillyInviteInterface:Center()
	FamillyInviteInterface:SetTitre("Invitation de " .. family_name)
    FamillyInviteInterface:SetDraggable( false )
    FamillyInviteInterface:CloseButton( true )	
    FamillyInviteInterface.Paint = function(self, w, h)

        CitadelleRP.API:DrawBlur(self, 3)

        surface.SetDrawColor( self.colorBackground )
        surface.DrawRect( 0, 0, w, h )

        CitadelleRP.API:DrawGradient(self)

        surface.SetDrawColor( self.colorOutline )
        surface.DrawOutlinedRect( 0, 0, w, h )

        draw.SimpleText( self.titre, CitadelleRP.API:GetFont(40,"Righteous",800), w / 2, 0 + 30, Color( 255, 255, 255 ), 1, 1 )
        draw.SimpleText( "La famille " .. family_name .. " vous invite à les rejoindre !", CitadelleRP.API:GetFont(20,"Righteous",300), w / 2, 0 + 100, Color( 255, 255, 255 ), 1, 1 )


    end



    local FamillyInviteButtonAccept = vgui.Create( "CRPButton", FamillyInviteInterface )
    FamillyInviteButtonAccept:SetTitre( "Refuser" )
    FamillyInviteButtonAccept:SetRPos( 50, 150 )
    FamillyInviteButtonAccept:SetRSize( 100, 30 )
    FamillyInviteButtonAccept.DoClick = function()
 		
        net.Start( "CRP::Family:Server:Invite" )
			net.WriteString("Invite:Response")
            net.WriteBool(false)
            net.WriteString(family_name)
        net.SendToServer()
        FamillyInviteInterface:Close()
 
    end


    local FamillyInviteButtonDeny = vgui.Create( "CRPButton", FamillyInviteInterface )
    FamillyInviteButtonDeny:SetTitre( "Accepter" )
    FamillyInviteButtonDeny:SetRPos( 200, 150 )
    FamillyInviteButtonDeny:SetRSize( 100, 30 )
    FamillyInviteButtonDeny.DoClick = function()
 		
        net.Start( "CRP::Family:Server:Invite" )
            net.WriteString("Invite:Response")
            net.WriteBool(true)
            net.WriteString(family_name)
        net.SendToServer()
        FamillyInviteInterface:Close()
 
    end

end)