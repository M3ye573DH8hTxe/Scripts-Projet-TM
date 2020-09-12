net.Receive("CRP::Family:Client:Sync", function ( len )

	local is_family_name = net.ReadBool()
	local tbl = net.ReadTable()
	
    CitadelleRP.Family.Families = {}


	if is_family_name then

		local family_name = net.ReadString()

		for k,v in pairs(tbl) do
		    CitadelleRP.Family.Families[family_name] = {
			    name = v.name,
			    leader = v.leader,
			    members = v.members,
			    skins = v.skins,
			    skin_leader = v.skin_leader
		    }
		end

		return

	end

	CitadelleRP.Family.Families = tbl

	--PrintTable(CitadelleRP.Family.Families)

end)

net.Receive("CRP::Family:Client:OpenMemberInterface", function( len )

	local family_name = net.ReadString() or "Unknown"

	local tbl = CitadelleRP.Family.Families[family_name]

	local FamilyFrame = vgui.Create("CRPFrame")
	FamilyFrame:SetRSize(500, 500)
    FamilyFrame:Center()
	FamilyFrame:SetTitle("Votre famille - " .. family_name)
    FamilyFrame:SetDraggable( false )
    FamilyFrame:CloseButton( true )	



    	-- Invite Player

	local FamilyInviteSelector= vgui.Create("DComboBox", FamilyFrame)
	FamilyInviteSelector:SetPos(CitadelleRP.API:RespX(10), CitadelleRP.API:RespY(75))
	FamilyInviteSelector:SetSize(CitadelleRP.API:RespX(250), CitadelleRP.API:RespY(30))
	FamilyInviteSelector:SetValue( "Nom" )
	for k, v in pairs(player.GetAll()) do
		FamilyInviteSelector:AddChoice(v:Nick(), v)
	end

	local FamilyInviteButton = vgui.Create("CRPButton", FamilyFrame)
	FamilyInviteButton:SetRPos(280, 75)
	FamilyInviteButton:SetRSize(200, 30)
	FamilyInviteButton:SetText("Inviter")
	FamilyInviteButton.DoClick = function(self,w,h)
    	net.Start("CRP::Family:Server:Invite")
			net.WriteString("Invite:Invite")
			net.WriteString(family_name)
    		net.WriteEntity(FamilyInviteSelector:GetOptionData(1))
    	net.SendToServer()
	end


	local DScrollPanel = vgui.Create( "CRPScrollPanel", FamilyFrame )
    DScrollPanel:SetSize(CitadelleRP.API:RespX(470),CitadelleRP.API:RespY(300))
    DScrollPanel:SetPos(CitadelleRP.API:RespX(10),CitadelleRP.API:RespY(130))
    DScrollPanel.Paint = function(self,w,h)

    end
    for k,v in pairs(tbl["members"]) do

        local pl = vgui.Create("CRPPanel", DScrollPanel)
        pl:SetRSize(470,35)
        --pl:SetPos(0,60)
        pl:DockMargin( 0, 0, 0, 5 )
        pl:SetText("")
        pl.Paint = function(self,w,h)
			surface.SetDrawColor( Color(10, 10, 10, 150) )
			surface.DrawRect( 0, 0, w, h)
			if k == tbl.leader then
				draw.SimpleText(" ✸ " .. v.name or k, CitadelleRP.API:CreateFont(20, "Righteous", 350), 5, h/2, Color(200, 200, 200, 200), 0, 1)
				return
			end
			draw.SimpleText(" ◆ " .. v.name or k, CitadelleRP.API:CreateFont(20, "Righteous", 350), 5, h/2, Color(200, 200, 200, 200), 0, 1)
    	end
		print(k)
    	if LocalPlayer():IsLeader() and k ~= "64=" .. LocalPlayer():SteamID64() then
	        local excludeButton = vgui.Create("CRPButton", pl)
	        excludeButton:SetRSize(100, 25)
	        excludeButton:SetRPos(350, 5)
	        excludeButton:SetText("Exclure")
	        excludeButton.DoClick = function() 

	        	net.Start("CRP::Family:Server:ManageFamily")
	        		net.WriteString("Manage:Kick")
	        		net.WriteString(family_name)
	        		net.WriteEntity(player.GetBySteamID64(v))
	        	net.SendToServer()
	        end
	    end
    end

    if LocalPlayer():IsLeader() then

	    local FamilyDisbandCheck = vgui.Create("CRPTextEntry", FamilyFrame)
		FamilyDisbandCheck:SetRPos(10, 450)
		FamilyDisbandCheck:SetRSize(250, 30)
		FamilyDisbandCheck:SetPlaceholderText("Vérification : Ecrivez " .. family_name)



	    local FamilyDisbandButton = vgui.Create("CRPButton", FamilyFrame)
		FamilyDisbandButton:SetRPos(280, 450)
		FamilyDisbandButton:SetRSize(200, 30)
		FamilyDisbandButton:SetText("Dissoudre")

		FamilyDisbandButton.DoClick = function(self,w,h)

			if FamilyDisbandCheck:GetValue() == family_name then
				
		    	net.Start("CRP::Family:Server:ManageFamily")
		    		net.WriteString("Manage:Disband")
		    		net.WriteString(family_name)
		    	net.SendToServer()

		    	FamilyFrame:Remove()
		    end
		end

		return
	end

	local FamilyQuitButton = vgui.Create("CRPButton", FamilyFrame)
	FamilyQuitButton:SetRPos(10, 450)
	FamilyQuitButton:SetRSize(480, 30)
	FamilyQuitButton:SetText("Quitter")
	FamilyQuitButton.DoClick = function(self,w,h)
		net.Start("CRP::Family:Server:ManageFamily")
			net.WriteString(family_name)
			net.WriteString("Manage:Leave")
		net.SendToServer()

		FamilyFrame:Remove()
	end

end)
--PrintTable(CitadelleRP.Family.Families["Lupin"])