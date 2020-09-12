include("autorun/config_context_menu.lua")
-- NS
util.AddNetworkString("ContextMenu::TPAdmin")
util.AddNetworkString("ContextMenu::RepareVehicule")
util.AddNetworkString("ContextMenu::DeleteVehicule")



net.Receive("ContextMenu::RepareVehicule", function(len, ply)

  if table.HasValue(ContextMenu.Staffs, ply:GetUserGroup()) then

    local ent = net.ReadEntity()

    ent:VC_repairFull_Admin()

  end

end)


net.Receive("ContextMenu::DeleteVehicule", function(len, ply)

  if table.HasValue(ContextMenu.Staffs, ply:GetUserGroup()) then

    local ent = net.ReadEntity()

    ent:Remove()

  end

end)


