net.Receive("CRP::Identity:Client:OpenInterfaceChangeName", function( len )

    local ChangeNameInterface = vgui.Create("CRPFrame")
    ChangeNameInterface:SetRSize(450, 350)
    ChangeNameInterface:Center()
    ChangeNameInterface:SetTitle("Changer de nom")
    ChangeNameInterface:SetDraggable( false )
    ChangeNameInterface:CloseButton( true )   
    ChangeNameInterface:AddSimpleText( "Prix de changement de nom administratif : " .. DarkRP.formatMoney(CitadelleRP.Identity.Config.PriceChangeName), CitadelleRP.API:GetFont("label4"), ChangeNameInterface:GetWide() / 2, 0 + 100, Color( 255, 255, 255 ), 1, 1 )


    local ChangeNameEntryPrenom = vgui.Create("CRPTextEntry", ChangeNameInterface)
    ChangeNameEntryPrenom:SetRPos(75, 190)
    ChangeNameEntryPrenom:SetRSize(300, 30)
    ChangeNameEntryPrenom:SetLabel("Nom")

    local ChangeNameEntryNom = vgui.Create("CRPTextEntry", ChangeNameInterface)
    ChangeNameEntryNom:SetRPos(75, 135)
    ChangeNameEntryNom:SetRSize(300, 30)
    ChangeNameEntryNom:SetLabel("Prénom")

    local ChangeNameButtonChange = vgui.Create( "CRPButton", ChangeNameInterface )
    ChangeNameButtonChange:SetText( "Annuler" )
    ChangeNameButtonChange:SetRPos( 60, 275 )
    ChangeNameButtonChange:SetRSize( 150, 35 )
    ChangeNameButtonChange:SetBackgroundColorHover(ChangeNameButtonChange:getColor("red"))
    ChangeNameButtonChange.DoClick = function() 
        ChangeNameInterface:Close()
    end

    local ChangeNameButtonDeny = vgui.Create( "CRPButton", ChangeNameInterface )
    ChangeNameButtonDeny:SetText( "Accepter" )
    ChangeNameButtonDeny:SetRPos( 240, 275 )
    ChangeNameButtonDeny:SetRSize( 150, 35 )
    ChangeNameButtonDeny:SetBackgroundColorHover(ChangeNameButtonDeny:getColor("green"))
    ChangeNameButtonDeny.DoClick = function()
        local new_name = ChangeNameEntryPrenom:GetValue() .. " " .. ChangeNameEntryNom:GetValue()
        net.Start( "CRP::Identity:Server:ChangeName" )
            net.WriteString(new_name)
        net.SendToServer()
        ChangeNameInterface:Close()
    end

end)
