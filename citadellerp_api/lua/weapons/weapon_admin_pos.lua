if SERVER then
	util.AddNetworkString("CRP::API:Weapons:Position:GetPos")
else
	SWEP.PrintName = "Weapon - Position"
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author = "Titouns"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

local function GetGAdminInfo()
	local info = net.ReadString()
	if not info or not LocalPlayer():IsAdmin() then return end

	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 325, 65 )
	DFrame:Center()
	DFrame:SetTitle("Position")
	DFrame:SetDraggable( true )
	DFrame:MakePopup()

	local CopyB = vgui.Create( "DButton", DFrame )
	CopyB:SetPos(25, 30)
	CopyB:SetText("Copier")
	CopyB:SetSize(275, 30)
	CopyB.DoClick = function()
		SetClipboardText(info)
		chat.AddText("La position et l'angle du props/entité visé ont été sauvegardés.")
		if IsValid(DFrame) then DFrame:Remove() end
	end
end
net.Receive("CRP::API:Weapons:Position:GetPos", GetGAdminInfo)

if CLIENT then return end

function SWEP:PrimaryAttack()
	local eye = self.Owner:GetEyeTrace()
	if (self.Owner:EyePos():Distance(eye.HitPos) < 1000) and eye.Entity then
		net.Start("CRP::API:Weapons:Position:GetPos")
		local pos, ang = eye.Entity:GetPos(), eye.Entity:GetAngles()
		net.WriteString("{ pos = Vector(" .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. "), ang = Angle(" .. math.Round(ang.p, 1) .. ", " .. math.Round(ang.y, 1) .. ", " .. math.Round(ang.r, 1) .. ") },")
		net.Send(self.Owner)
	end
end