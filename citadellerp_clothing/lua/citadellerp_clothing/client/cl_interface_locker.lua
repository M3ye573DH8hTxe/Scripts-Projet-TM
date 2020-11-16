net.Receive("CRP:Clothing:Player:OpenLocker", function ( len )


	local LockerFrame = vgui.Create("CRPFrame")
	LockerFrame:SetRSize(500, 500)
    LockerFrame:Center()
	LockerFrame:SetTitre("Vestiaire")
    LockerFrame:SetDraggable( false )
    LockerFrame:CloseButton( true )	

    --[[

		local DmodelPanel = vgui.Create( "DModelPanel", LockerFrame )
		DmodelPanel:SetSize( 85, 85 )
		DmodelPanel:SetPos( 50, 50 )
		function DmodelPanel:LayoutEntity( Entity ) return end
		DmodelPanel:SetModel( "models/smalls_civilians/pack1/puffer_male_09_f_npc.mdl" )
		
		local startpos = DmodelPanel.Entity:GetBonePosition( DmodelPanel.Entity:LookupBone( "ValveBiped.Bip01_R_Calf" ) or 0) + Vector( 0,5,0 )
		DmodelPanel:SetLookAt( startpos )
		DmodelPanel:SetCamPos( startpos - Vector( -30,-0,0) )
		DmodelPanel.Entity:SetEyeTarget( startpos - Vector( -30,-0,0) )

	]]--
	
end)