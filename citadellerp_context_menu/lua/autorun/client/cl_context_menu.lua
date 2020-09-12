include("autorun/config_context_menu.lua")

--[ Crée par BlackberrX ]

surface.CreateFont( "NPCFONT", {
font = "Roboto",
size = 20,
weight = 1000,
})


hook.Add("ContextMenuOpen", "ContextMenu::OnContextMenuOpenV2", function()

	if not LocalPlayer():IsStaff() then return false end

end)

--3D BUTTONS
hook.Add("OnContextMenuOpen","ContextMenu::OnContextMenuOpen", function()

    gui.EnableScreenClicker(true)


	if !LocalPlayer():IsStaff() then return end


	hook.Add("HUDPaint","ContextMenu::DrawHeadButtons", function()

		for _, v in pairs(player.GetAll()) do

		  	if v:Alive() then

					if v != LocalPlayer() then

		      	local pos = v:EyePos()

		 		    if pos:isInSight({LocalPlayer(), v}) && v:GetPos():Distance(LocalPlayer():GetPos()) < ContextMenu.RenderDistance then

					    pos.z = pos.z
					    pos = pos:ToScreen()

							local x, y = gui.MousePos()

              local d = 0

              local g = 0

							for _, button in pairs(ContextMenu.Buttons) do

                if button.ent == "Player" then

                  if button.gd == "gauche" then

                    gd = -180
                    g = g+1
                    k = g

                  else

                    gd = 50
                    d=d+1
                    k=d

                  end

  						 		if tonumber(x) > tonumber(pos.x+gd) && tonumber(x) < tonumber(pos.x+gd)+button.longueur && tonumber(y) > tonumber(pos.y+ (k-1)*ContextMenu.Espacement) && tonumber(y) < tonumber(pos.y+ (k-1)*ContextMenu.Espacement)+button.hauteur then

  				      		draw.RoundedBox(6, pos.x+gd , pos.y + (k-1)*ContextMenu.Espacement, button.longueur, button.hauteur, button.hovered)

  				            if input.IsMouseDown( MOUSE_LEFT ) == true then

                        if IsValid(v) then

                          button.func(v)

                        end

                        hook.Remove("HUDPaint","ContextMenu::DrawHeadButtons")

  				      	    end

  				        	else

  										draw.RoundedBox(6, pos.x+gd , pos.y + (k-1)*ContextMenu.Espacement, button.longueur, button.hauteur, button.couleur)

  					        end

  					        draw.DrawText(button.name , "NPCFONT", pos.x+gd+ (button.longueur)/2 , pos.y + (k-1)*ContextMenu.Espacement + (button.hauteur-24) / 2  , Color(255,255,255), TEXT_ALIGN_CENTER)

  		        		end

                end

							end

					end

			end

		end

    for _, v in pairs(ents.GetAll()) do

      local pos = v:EyePos()

      if !v:IsPlayer() then

        if v:GetPos():Distance(LocalPlayer():GetPos()) < ContextMenu.RenderDistance then

          pos.z = pos.z
          pos = pos:ToScreen()

          local x, y = gui.MousePos()

          local d = 0

          local g = 0

          for _, button in pairs(ContextMenu.Buttons) do

            if button.ent == v:GetClass() then

              if button.gd == "gauche" then

                gd = -180
                g = g+1
                k = g

              else

                gd = 50
                d=d+1
                k=d

              end

              if tonumber(x) > tonumber(pos.x+gd) && tonumber(x) < tonumber(pos.x+gd)+button.longueur && tonumber(y) > tonumber(pos.y+ (k-1)*ContextMenu.Espacement) && tonumber(y) < tonumber(pos.y+ (k-1)*ContextMenu.Espacement)+button.hauteur then

                draw.RoundedBox(6, pos.x+gd , pos.y + (k-1)*ContextMenu.Espacement, button.longueur, button.hauteur, button.hovered)

                  if input.IsMouseDown( MOUSE_LEFT ) == true then

                    if IsValid(v) then

                      button.func(v)

                    end

                    hook.Remove("HUDPaint","ContextMenu::DrawHeadButtons")

                  end

                else

                  draw.RoundedBox(6, pos.x+gd , pos.y + (k-1)*ContextMenu.Espacement, button.longueur, button.hauteur, button.couleur)

                end

                draw.DrawText(button.name , "NPCFONT", pos.x+gd+ (button.longueur)/2 , pos.y + (k-1)*ContextMenu.Espacement + (button.hauteur-24) / 2  , Color(255,255,255), TEXT_ALIGN_CENTER)

              end

            end

          end

       end

    end

	end)

end)

hook.Add("OnContextMenuClose","ContextMenu::OnContextMenuClose", function()

  gui.EnableScreenClicker(false)

	hook.Remove("HUDPaint","ContextMenu::DrawHeadButtons")

end)
