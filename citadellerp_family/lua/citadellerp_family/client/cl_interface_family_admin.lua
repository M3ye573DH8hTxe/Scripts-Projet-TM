net.Receive("CRP::Family:Client:OpenAdminInterface", function( len )
	local tbl = net.ReadTable()

	if not istable(tbl) then return end

	local FamilyAdminFrame = vgui.Create("CRPFrame")
	FamilyAdminFrame:SetRSize(350, 150)
	FamilyAdminFrame:Center()
	FamilyAdminFrame:SetTitle("Admin - Familles")
	FamilyAdminFrame:SetDraggable( false )
	FamilyAdminFrame:CloseButton( true )	

	local FamillyInviteButtonAccept = vgui.Create( "CRPButton", FamilyAdminFrame )
    FamillyInviteButtonAccept:SetText( "Créer" )
    FamillyInviteButtonAccept:SetRPos( 75, 60 )
    FamillyInviteButtonAccept:SetRSize( 200, 35 )
    FamillyInviteButtonAccept.DoClick = function()
 		
		CitadelleRP.Family:OpenCreateAdminInterface()
        FamilyAdminFrame:Close()
 
    end

    local FamillyInviteButtonDeny = vgui.Create( "CRPButton", FamilyAdminFrame )
    FamillyInviteButtonDeny:SetText( "Modifier" )
    FamillyInviteButtonDeny:SetRPos( 75, 100 )
    FamillyInviteButtonDeny:SetRSize( 200, 35 )
    FamillyInviteButtonDeny.DoClick = function()
 		
		CitadelleRP.Family:OpenEditAdminInterface(tbl)
        FamilyAdminFrame:Close()
 
    end

end)

function CitadelleRP.Family:OpenCreateAdminInterface()


	local FamilyAdminFrame = vgui.Create("CRPFrame")
	FamilyAdminFrame:SetRSize(750, 500)
	FamilyAdminFrame:Center()
	FamilyAdminFrame:SetTitle("Créer une famille")
	FamilyAdminFrame:SetDraggable( false )
	FamilyAdminFrame:CloseButton( true )	


	-- Name

	local FamilyAdminName = vgui.Create("CRPTextEntry", FamilyAdminFrame)
	FamilyAdminName:SetRPos(30, 65)
	FamilyAdminName:SetRSize(400, 30)
	FamilyAdminName:SetPlaceholderText("Nom de la famille")

	-- Owner 

	local FamilyAdminOwner= vgui.Create("DComboBox", FamilyAdminFrame)
	FamilyAdminOwner:SetPos(30, 115)
	FamilyAdminOwner:SetSize(400, 30)
	FamilyAdminOwner:SetValue( "Nom" )
	for k, v in pairs(player.GetAll()) do
	 	FamilyAdminOwner:AddChoice(v:Nick(), v)
	end

	local FamilyAdminTeamChief= vgui.Create("DComboBox", FamilyAdminFrame)
	FamilyAdminTeamChief:SetPos(30, 165)
	FamilyAdminTeamChief:SetSize(400, 30)
	FamilyAdminTeamChief:SetValue( "TEAM CHEF" )
	for k, v in pairs(RPExtraTeams) do
	 	FamilyAdminTeamChief:AddChoice(v.name)
	end



	local FamilyAdminTeamMember= vgui.Create("DComboBox", FamilyAdminFrame)
	FamilyAdminTeamMember:SetPos(30, 215)
	FamilyAdminTeamMember:SetSize(400, 30)
	FamilyAdminTeamMember:SetValue( "TEAM MEMBRE" )
	for k, v in pairs(RPExtraTeams) do
	 	FamilyAdminTeamMember:AddChoice(v.name)
	end



	-- Skin Owner
	local tblSkinLeader = {}

	local FamilyAdminSkinOwner = vgui.Create("CRPTextEntry", FamilyAdminFrame)
	FamilyAdminSkinOwner:SetRPos(30, 265)
	FamilyAdminSkinOwner:SetRSize(400, 30)
	FamilyAdminSkinOwner:SetPlaceholderText("Chemin d'accès du skin du chef")

	

	local FamilyAdminSkinOwnerButton= vgui.Create("CRPButton", FamilyAdminFrame)
	FamilyAdminSkinOwnerButton:SetRPos(450, 265)
	FamilyAdminSkinOwnerButton:SetRSize(200, 30)
	FamilyAdminSkinOwnerButton:SetText("Ajouter")

	FamilyAdminSkinOwnerButton.DoClick = function(self)
		
		table.insert(tblSkinLeader, FamilyAdminSkinOwner:GetValue())
		FamilyAdminSkinOwner:SetValue("")

	end

	-- Skin members 
	local tblSkin = {}
	local FamilyAdminSkinMembers = vgui.Create("CRPTextEntry", FamilyAdminFrame)
	FamilyAdminSkinMembers:SetRPos(30, 315)
	FamilyAdminSkinMembers:SetRSize(400, 30)
	FamilyAdminSkinMembers:SetPlaceholderText("Chemin d'accès du skin d'un membre")


	local FamilyAdminSkinMembersButton= vgui.Create("CRPButton", FamilyAdminFrame)
	FamilyAdminSkinMembersButton:SetRPos(450, 315)
	FamilyAdminSkinMembersButton:SetRSize(200, 30)
	FamilyAdminSkinMembersButton:SetText("Ajouter")
	FamilyAdminSkinMembersButton.DoClick = function(self)
		
		table.insert(tblSkin, FamilyAdminSkinMembers:GetValue())
		FamilyAdminSkinMembers:SetValue("")

	end

	-- Cancel
	local FamilyAdminCancel= vgui.Create("CRPButton", FamilyAdminFrame)
	FamilyAdminCancel:SetRPos(30, 415)
	FamilyAdminCancel:SetRSize(300, 50)
	FamilyAdminCancel:SetText("Annuler")
	FamilyAdminCancel.DoClick = function(self)
		FamilyAdminFrame:Remove()
	end
	-- Create
	local FamilyAdminCreate= vgui.Create("CRPButton", FamilyAdminFrame)
	FamilyAdminCreate:SetRPos(420,415)
	FamilyAdminCreate:SetRSize(300, 50)
	FamilyAdminCreate:SetText("Créer")
	FamilyAdminCreate.DoClick = function(self)

		net.Start("CRP::Family:Server:ManageFamily")
			net.WriteString("Manage:Create")
			net.WriteString(FamilyAdminName:GetValue())
			net.WriteEntity(FamilyAdminOwner:GetOptionData(1))
			net.WriteString(FamilyAdminTeamChief:GetSelected())
			net.WriteString(FamilyAdminTeamMember:GetSelected())
			net.WriteTable(tblSkinLeader)
			net.WriteTable(tblSkin)
		net.SendToServer()
		tblSkin = {}
		tblSkinLeader = {}
		FamilyAdminFrame:Remove()
	end

end

function CitadelleRP.Family:OpenEditAdminInterface(tbl)

	local FamilyAdminEditFrame = vgui.Create("CRPFrame")
	FamilyAdminEditFrame:SetRSize(750, 500)
	FamilyAdminEditFrame:Center()
	FamilyAdminEditFrame:SetTitle("Editer une famille")
	FamilyAdminEditFrame:SetDraggable( false )
	FamilyAdminEditFrame:CloseButton( true )	


	local pList = vgui.Create( "DScrollPanel", FamilyAdminEditFrame )
    pList:SetSize( FamilyAdminEditFrame:GetWide() - 20, FamilyAdminEditFrame:GetTall() - 110 - 10 )
    pList:SetPos( 10, 110 )
	local scrollbar = pList:GetVBar()
    scrollbar:SetHideButtons( true )
    function scrollbar:Paint(w, h)
        draw.RoundedBox( 1, 5, 5, w, h, Color( 42, 42, 40, 230 ) )
    end
    function scrollbar.btnGrip:Paint(w, h)
        draw.RoundedBox( 1, 5, 0, w, h, Color( 72, 72, 70 ) )
    end        


	local pListLayout = vgui.Create( "DIconLayout", pList )
    pListLayout:SetSize( pList:GetWide(), pList:GetTall() )
    pListLayout:SetSpaceY( 5 )


    for k,v in SortedPairs( tbl, false ) do

		local Bouton = vgui.Create( "CRPButton", pListLayout )
        Bouton:SetRSize( pListLayout:GetWide(), 100 )
        Bouton:SetText(v["name"])

    end



end

