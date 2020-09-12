hook.Add("Initialize", "InitOptimization", function()
	hook.Remove("PlayerTick", "TickWidgets")

	if SERVER then
		if timer.Exists("CheckHookTimes") then
			timer.Remove("CheckHookTimes")
		end
	end

	if CLIENT then
		hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
		hook.Remove("RenderScreenspaceEffects", "RenderBloom")
		hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
		hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
		hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
		hook.Remove("RenderScreenspaceEffects", "RenderSobel")
		hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
		hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
		hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
		hook.Remove("RenderScene", "RenderStereoscopy")
		hook.Remove("RenderScene", "RenderSuperDoF")
		hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
		hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
		hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
		hook.Remove("PostRender", "RenderFrameBlend")
		hook.Remove("PreRender", "PreRenderFrameBlend")
		hook.Remove("Think", "DOFThink")
		hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
		hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
		/*hook.Remove("PostDrawEffects", "RenderWidgets")
		hook.Remove("PostDrawEffects", "RenderHalos")*/
	end
end)
	
hook.Add("OnEntityCreated", "DisableShadow", function(ent)
	ent:DrawShadow(false)
end)

function InDeadZone(ply)
	return false
end


--if SERVER then
	--hook.Add("PlayerInitialSpawn","GmodMcoreTest1", function(ply)

		--timer.Simple(60, function()

			--ply:SendLua([[LocalPlayer():ConCommand("gmod_mcore_test 1")]])
			--ply:SendLua([[LocalPlayer():ConCommand("mat_queue_mode -1")]])
			--ply:SendLua([[LocalPlayer():ConCommand("cl_threaded_bone_setup 1")]])
			--ply:SendLua([[LocalPlayer():ConCommand("mat_hdr_level 0")]])
			--ply:SendLua([[LocalPlayer():ConCommand("physgun_wheelspeed 15")]])	

		--end)

	--end)
--end

