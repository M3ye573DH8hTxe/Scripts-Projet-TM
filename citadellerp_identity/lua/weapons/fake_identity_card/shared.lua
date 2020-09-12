if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Fausse carte"
	SWEP.Slot = 2
	SWEP.SlotPos = 2
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Titan"
SWEP.Instructions = "Gardez cette carte en main pour la montrer aux autres joueurs."
SWEP.Contact = "https://steamcommunity.com/id/vukein/"
SWEP.Purpose = ""

SWEP.HoldType = "pistol";
SWEP.WorldModel = ""

SWEP.AnimPrefix	 = "pistol"
SWEP.Category = "CitadelleRP - Identité"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize() self:SetHoldType("pistol") end
function SWEP:CanPrimaryAttack ( ) return false; end
function SWEP:CanSecondaryAttack ( ) return false; end

function SWEP:DrawWorldModel()
end

function SWEP:PreDrawViewModel(vm)
    return true
end

function SWEP:SetupDataTables()
    self:NetworkVar( "String", 0, "NameCard" )
    self:NetworkVar( "bool", 0, "PermisCard" )
    self:NetworkVar( "bool", 0, "LicenseCard" )
end


if CLIENT then

surface.CreateFont( "vukein_font", {
	font = "Roboto",
	size = 24,
	weight = 1500,
	antialias = true,
} )

surface.CreateFont( "vukein_font_bis", {
	font = "Roboto",
	size = 20,
	weight = 1500,
	antialias = true,
} )

surface.CreateFont( "vukein_font_yn", {
	font = "Roboto",
	size = 28,
	weight = 1500,
	antialias = true,
} )

local VUMat = Material("fake_id_card.png")

function SWEP:DrawHUD()
	local LW, LH = 500, 250
	local W,H = ScrW()-LW-5, ScrH()-LH-5
	
	local LP = LocalPlayer()
	LP.PIcon = LP.PIcon or vgui.Create( "ModelImage")
	LP.PIcon:SetSize(155,155)
	LP.PIcon:SetModel(LP:GetModel())
					
	surface.SetMaterial(VUMat)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(W, H, LW, LH)

	LP.PIcon:SetPos(W+20,H+67)
	LP.PIcon:SetPaintedManually(false)
	LP.PIcon:PaintManual()
	LP.PIcon:SetPaintedManually(true)					
		
	local TextW,TextH = W+175, H + 75
	
	draw.SimpleText(self:GetNameCard(), "vukein_font", TextW, TextH, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	--draw.SimpleText(LP:SteamID(), "vukein_font", TextW, TextH+30, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	draw.SimpleText("Permis : SOON", "vukein_font", TextW, TextH+60, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

	draw.SimpleText("Licence d'armes :", "vukein_font", TextW, TextH+90, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	
	if LP:getDarkRPVar("HasGunlicense") then
		draw.SimpleText("OUI", "vukein_font", TextW+160, TextH+92, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	else
		draw.SimpleText("NON", "vukein_font", TextW+160, TextH+92, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	end
	

	local DIS = 0
	local CS = 5 
	local LicenseW, LicenseH = W+325, H+90

end


hook.Add("PreDrawTranslucentRenderables", "DrawDICards", function()
	local LPlayer = LocalPlayer()
	for k,v in pairs(player.GetAll()) do
		local CurWep = v:GetActiveWeapon()
		if v != LPlayer and IsValid(CurWep) and v:GetActiveWeapon():GetClass() == "fake_identity_card" and v:HasWeapon("fake_identity_card") then
			if LPlayer:GetPos():Distance(v:GetPos()) > 1000 then return end
			v.PIcon = v.PIcon or vgui.Create( "ModelImage")
			v.PIcon:SetSize(90,93)
			v.PIcon:SetModel(v:GetModel())
			
			local boneindex = v:LookupBone("ValveBiped.Bip01_R_Hand")
			if boneindex then	
				local HPos, HAng = v:GetBonePosition(boneindex)
				
				HAng:RotateAroundAxis(HAng:Forward(), -90)
				HAng:RotateAroundAxis(HAng:Right(), -90)
				HAng:RotateAroundAxis(HAng:Up(), 5)
				HPos = HPos + HAng:Up()*4 + HAng:Right()*-5 + HAng:Forward()*1
				
				cam.Start3D2D(HPos, HAng, 1)
					surface.SetMaterial(VUMat)
					surface.SetDrawColor(255, 255, 255, 255)
					surface.DrawTexturedRect(0, 0, 15, 8)
				cam.End3D2D()
				cam.Start3D2D(HPos, HAng, .05)
					v.PIcon:SetPos(12,45)
					v.PIcon:SetPaintedManually(false)
					v.PIcon:PaintManual()
					v.PIcon:SetPaintedManually(true)					
					
					local TextW = 105
					
					draw.SimpleText(CurWep:GetNameCard(), "vukein_font_bis", TextW, 50, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					--draw.SimpleText(v:SteamID(), "vukein_font_bis", TextW, 70, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					draw.SimpleText("Permis : SOON", "vukein_font_bis", TextW, 90, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					draw.SimpleText("Licence d'armes :", "vukein_font_bis", TextW, 110, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					
					if v:getDarkRPVar("HasGunlicense") then
						draw.SimpleText("OUI", "vukein_font_yn", TextW+75, 125, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					else
						draw.SimpleText("NON", "vukein_font_yn", TextW+75, 125, Color( 0, 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
					end
					

					local LicenseW = 225
					local DIS = 35
					local CS = 40 

				cam.End3D2D()
				
			end		
		end
	end
end)
end