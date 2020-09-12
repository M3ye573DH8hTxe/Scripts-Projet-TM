CitadelleRP.Identity.Presentation = CitadelleRP.Identity.Presentation or {}
AssociationTable = AssociationTable or {}

function CitadelleRP.Identity.Presentation:OpenPresentationChoice( player )

    --if player:IsFriend(LocalPlayer()) or LocalPlayer():IsFriend(player) then return end

    local PresentationInterface = vgui.Create("CRPFrame")
    PresentationInterface:SetRSize(500, 230)
    PresentationInterface:Center()
    PresentationInterface:SetTitle("Présentation de " .. player:Nick())
    PresentationInterface:AddSimpleText(player:getDarkRPVar("rpname") .. " souhaite vous connaître davantage.", CitadelleRP.API:GetFont("label3"), PresentationInterface:GetWide() / 2, 0 + 100, Color( 255, 255, 255 ), 1, 1)
    PresentationInterface:SetDraggable( false )
    PresentationInterface:CloseButton( true )   


    local PresentationDenyButton = vgui.Create( "CRPButton", PresentationInterface )
    PresentationDenyButton:SetText( "Refuser" )
    PresentationDenyButton:SetRPos( 50, 150 )
    PresentationDenyButton:SetRSize( 175, 50 )
    PresentationDenyButton:SetBackgroundColorHover(PresentationDenyButton:getColor("red"))
    PresentationDenyButton.DoClick = function()

        net.Start( "CRP::Identity:Presentation:Server" )
            net.WriteString("Presentation:Response")
            net.WriteEntity(player)
            net.WriteBool(false)
        net.SendToServer()

        PresentationInterface:Close()
    end


    local PresentationAcceptButton = vgui.Create( "CRPButton", PresentationInterface )
    PresentationAcceptButton:SetText( "Se présenter" )
    PresentationAcceptButton:SetRPos( 250, 150 )
    PresentationAcceptButton:SetRSize( 175, 50 )
    PresentationAcceptButton:SetBackgroundColorHover(PresentationAcceptButton:getColor("green"))
    PresentationAcceptButton.DoClick = function()
        
        net.Start( "CRP::Identity:Presentation:Server" )
            net.WriteString("Presentation:Response")
            net.WriteEntity(player)
            net.WriteBool(true)
        net.SendToServer()
        AddFriend( player )
        PresentationInterface:Close()
 
    end
end


net.Receive("CRP::Identity:Presentation:Client", function(len)

    local typePresentation = net.ReadString()
    if not isstring(typePresentation) then return end

    local player = net.ReadEntity()

    CitadelleRP.API:switch(typePresentation,

        CitadelleRP.API:case("Presentation:Receive", function()

            CitadelleRP.Identity.Presentation:OpenPresentationChoice( player )

        end),

        CitadelleRP.API:case("Presentation:ReceiveBack", function()

            AddFriend(player)
    
        end),

        CitadelleRP.API:default( function() print("[FAMILY-MANAGE] Aucune valeur : Contactez un administrateur") end)
    )

end)





function IsFriend( pTarget )
    return CitadelleRP.Identity.Presentation[ pTarget:Name()] or false
end

function AddFriend(pPlayer )
    CitadelleRP.Identity.Presentation[ pPlayer:Name() ] = {}
end

function ClearFriend( pTarget )
    CitadelleRP.Identity.Presentation[ pTarget:Name() ] = nil
end

function ClearAllFriends( )
    CitadelleRP.Identity.Presentation = {}
end

--ClearAllFriends( )
--PrintTable(CitadelleRP.Identity.Presentation)