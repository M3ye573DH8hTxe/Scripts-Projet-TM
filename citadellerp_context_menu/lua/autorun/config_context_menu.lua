ContextMenu = ContextMenu or {}
ContextMenu.Buttons ={}


function ContextMenu.Remplace(str, ply)

  str = string.Replace(str, "%name%", ply:Nick())
  str = string.Replace(str, "%steamid%", ply:SteamID())
  str = string.Replace(str, "%steamid64%", ply:SteamID64())
  str = string.Replace(str, "%uniqueid%", ply:UniqueID())

  return str

end

local function AddButton(ent, name, couleur, hovered, longueur, hauteur, gd, type, func)

    local button = {}
    button.ent = ent
    button.name = name
    button.couleur = couleur
    button.hovered = hovered
    button.longueur = longueur
    button.hauteur = hauteur
    button.gd = gd

    if type == "commande" then

      button.func = function(ply)

        RunConsoleCommand(ContextMenu.Remplace(func, ply))

      end

    elseif type == "chat" then

      button.func = function(ply)

        RunConsoleCommand("say "..ContextMenu.Remplace(func, ply))

      end

    elseif type == "custom" then

      button.func = func

    end

    table.insert(ContextMenu.Buttons, button)

end


ContextMenu.Staffs = { "Modo-Test", "Modérateur", "admin", "superadmin", "Modo-VIP", "Modo-VIP+", "Modo-Test-VIP", "Modo-Test-VIP+" } 
ContextMenu.Espacement = 40 
ContextMenu.RenderDistance = 600 




AddButton("Player", "Kick", Color(0, 0, 0), Color(160, 160, 160), 100, 30, "droite", "custom", function(ply)

  RunConsoleCommand("ulx","kick",ply:Nick())

end)


AddButton("Player", "Avertissements", Color(0, 0, 0), Color(160, 160, 160), 100, 30, "gauche", "custom", function(ply)

	RunConsoleCommand("say", "!warnings")

end)


AddButton("Player", "Freeze", Color(0, 0, 0), Color(160, 160, 160), 100, 30, "gauche", "custom", function(ply)
		if ply:IsFrozen() then
    	RunConsoleCommand("ulx","unfreeze",ply:Nick())
    else
      RunConsoleCommand("ulx","freeze",ply:Nick())
    end

end)

AddButton("Player", "Vie 100%", Color(0, 0, 0), Color(160, 160, 160), 100, 30, "gauche", "custom", function(ply)

  RunConsoleCommand("ulx","hp",ply:Nick(),100)

end)

AddButton("Player", "Kevlar 100%", Color(0, 0, 0), Color(160, 160, 160), 100, 30, "gauche", "custom", function(ply)

  RunConsoleCommand("ulx","armor",ply:Nick(),100)

end)



AddButton("Player", "Salle Admin", Color(0, 0, 0), Color(160, 160, 160), 100, 30, "gauche", "custom", function(ply)
  net.Start("ContextMenu::TPAdmin")
  net.WriteEntity(ply)
  net.SendToServer()
end)

AddButton("prop_vehicle_jeep", "Supprimer", Color(0, 0, 0), Color(160, 160, 160), 150, 30, "droite", "custom", function(ent)
  net.Start("ContextMenu::DeleteVehicule")
  net.WriteEntity(ent)
  net.SendToServer()
end)

AddButton("prop_vehicle_jeep", "Réparer", Color(0, 0, 0), Color(160, 160, 160), 150, 30, "droite", "custom", function(ent)
  net.Start("ContextMenu::RepareVehicule")
  net.WriteEntity(ent)
  net.SendToServer()
end)

AddButton("prop_ragdoll", "Respawn", Color(0, 0, 0), Color(160, 160, 160), 200, 30, "droite", "custom", function(ent)

	net.Start("MedicMod.AdminRepsawn")
	net.WriteEntity(ent)
	net.SendToServer()

end)
