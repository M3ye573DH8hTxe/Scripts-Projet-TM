
AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Matériel de crochettage"
    SWEP.Slot = 5
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
end

SWEP.Author = "Brickwall"
SWEP.Category = "DarkRP SWEP Replacements" -- change the name
SWEP.Instructions = "Clique droite/gauche pour crochetter une porte"

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/sterling/c_enhanced_lockpicks.mdl" ) -- just change the model 
SWEP.WorldModel = ( "models/sterling/w_enhanced_lockpicks.mdl" )
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
	self:SetWeaponHoldType( "pistol" )
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsLockpicking")
    self:NetworkVar("Bool", 1, "IsStuck")
    self:NetworkVar("Float", 0, "LockpickStartTime")
    self:NetworkVar("Float", 1, "LockpickEndTime")
    self:NetworkVar("Float", 2, "NextSoundTime")
    self:NetworkVar("Int", 0, "ClickTime")
    self:NetworkVar("Int", 1, "Stage")
    self:NetworkVar("Entity", 0, "LockpickEnt")
end

--[[-------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------]]
function SWEP:CreateProgressStages()
    self.ProgressStages = {}
    local TotalPercent = 0
    for i = 1, 1+1 do
        if( i != 1+1 ) then
            local percent = math.random( (100/(1+1))*0.9, (100/(1+1)) )
            self.ProgressStages[i] = percent
            TotalPercent = TotalPercent+percent
        else
            self.ProgressStages[i] = 100-TotalPercent
        end
    end
end

function SWEP:PrimaryAttack()
    local function RunAnimation()
		if( IsValid( self ) ) then
			local VModel = self.Owner:GetViewModel()
			local EnumToSeq = VModel:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
			VModel:SendViewModelMatchingSequence( EnumToSeq )
		end
	end
    
    self:SetNextPrimaryFire(CurTime() + 0.25)
    self:SetNextSecondaryFire(CurTime() + 0.25)
	
    if self:GetIsLockpicking() then 
        if( self:GetIsStuck() ) then
			if( not self.ProgressStages ) then
				self:CreateProgressStages()
			end
			
            RunAnimation()
            self:SetIsStuck( false )
            self:SetStage( self:GetStage()+1 )
            self:SetLockpickStartTime( CurTime() )
            self:SetLockpickEndTime( CurTime() + (self.ProgressStages[self:GetStage()]/100)*10)

            local total = 0
            for k, v in pairs( self.ProgressStages ) do
                if( k >= self:GetStage() ) then continue end
                total = total+v
            end
            self.PreviousPercent = total
        else
            self:Fail()
        end
        return    
    end

    self:GetOwner():LagCompensation(true)
    local trace = self:GetOwner():GetEyeTrace()
    self:GetOwner():LagCompensation(false)
    local ent = trace.Entity

    if not IsValid(ent) or ent.DarkRPCanLockpick == false then return end
    local canLockpick = hook.Call("canLockpick", nil, self:GetOwner(), ent, trace)

    if canLockpick == false then return end
    if canLockpick ~= true and (
            trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 4000 or
            (not GAMEMODE.Config.canforcedooropen and ent:getKeysNonOwnable()) or
            (not ent:isDoor() and not ent:IsVehicle() and not string.find(string.lower(ent:GetClass()), "vehicle") and (not GAMEMODE.Config.lockpickfading or not ent.isFadingDoor))
        ) then
        return
    end
	
	self:CreateProgressStages()

    self:SetHoldType("pistol")

    self:SetIsStuck( false )
    self:SetStage( 1 )
    self:SetIsLockpicking(true)
    self:SetLockpickEnt(ent)
    self:SetLockpickStartTime(CurTime())
    self:SetLockpickEndTime(CurTime() + (self.ProgressStages[self:GetStage()]/100)*10)

    RunAnimation()

    self.PreviousPercent = 0

    if IsFirstTimePredicted() then
        hook.Call("lockpickStarted", nil, self:GetOwner(), ent, trace)
    end

    local onFail = function(ply) if ply == self:GetOwner() then hook.Call("onLockpickCompleted", nil, ply, false, ent) end end

    -- Lockpick fails when dying or disconnecting
    hook.Add("PlayerDeath", self, fc{onFail, fn.Flip(fn.Const)})
    hook.Add("PlayerDisconnected", self, fc{onFail, fn.Flip(fn.Const)})
    -- Remove hooks when finished
    hook.Add("onLockpickCompleted", self, fc{fp{hook.Remove, "PlayerDisconnected", self}, fp{hook.Remove, "PlayerDeath", self}})
end

function SWEP:Holster()
    if( CLIENT ) then
        BES_HINT_LOCKPICK = false
    end

    self:SetIsLockpicking(false)
    self:SetLockpickEnt(nil)
    return true
end

function SWEP:Succeed()
    self:SetHoldType("normal")

    local ent = self:GetLockpickEnt()
    self:SetIsLockpicking(false)
    self:SetLockpickEnt(nil)

    if not IsValid(ent) then return end

    local override = hook.Call("onLockpickCompleted", nil, self:GetOwner(), true, ent)

    if override then return end

    if ent.isFadingDoor and ent.fadeActivate and not ent.fadeActive then
        ent:fadeActivate()
        if IsFirstTimePredicted() then timer.Simple(5, function() if IsValid(ent) and ent.fadeActive then ent:fadeDeactivate() end end) end
    elseif ent.Fire then
        ent:keysUnLock()
        ent:Fire("open", "", .6)
        ent:Fire("setanimation", "open", .6)
	end
	
    self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
    
    self:SetIsStuck( false )
    self:SetStage( 1 )
end

function SWEP:Fail()
    self:SetIsLockpicking(false)
    self:SetHoldType("normal")

    hook.Call("onLockpickCompleted", nil, self:GetOwner(), false, self:GetLockpickEnt())
	self:SetLockpickEnt(nil)
    self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
    
    self:SetIsStuck( false )
    self:SetStage( 1 )
end

function SWEP:Stuck()
    self:SetIsStuck( true )
    self:SetClickTime( CurTime()+2.5 )
    self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end

function SWEP:Think()
    if not self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end

    if not self:GetIsStuck() and CurTime() >= self:GetNextSoundTime() then
        self:SetNextSoundTime(CurTime() + 1)
        local snd = {1,3,4}
        self:EmitSound("weapons/357/357_reload" .. tostring(snd[math.Round(util.SharedRandom("DarkRP_LockpickSnd" .. CurTime(), 1, #snd))]) .. ".wav", 50, 100)
    end

    local trace = self:GetOwner():GetEyeTrace()
    if not IsValid(trace.Entity) or trace.Entity ~= self:GetLockpickEnt() or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 4000 then
        self:Fail()
    elseif self:GetLockpickEndTime() <= CurTime() and self:GetStage() == #self.ProgressStages then
        self:Succeed()
    end

    if( not self:GetIsStuck() and CurTime() >= self:GetLockpickEndTime() ) then
        self:Stuck()
    elseif( self:GetIsStuck() and CurTime() >= self:GetClickTime() ) then
        self:Fail()
        if( CLIENT and not BES_HINT_LOCKPICK ) then
            notification.AddLegacy( "HINT: Press LMB/RMB when the lockpick gets stuck!", 1, 5 )
            BES_HINT_LOCKPICK = true
        end
    end
end

if( CLIENT ) then
    local w = ScrW()
    local h = ScrH()
    local x, y, width, height = w / 2 - w / 10, (h / 4)*3 - (h / 15 + 20)/2, w / 5, h / 15
    local hHeight = 20
    local sizet = 9
    function SWEP:DrawHUD()
        if not self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end

        surface.SetDrawColor( Color( 46, 49, 54 ) )
        surface.DrawRect( x, y, width, height+hHeight )

        local CurStagePercent = self.ProgressStages[self:GetStage()]
        local time = self:GetLockpickEndTime() - self:GetLockpickStartTime()
        local curtime = CurTime() - self:GetLockpickStartTime()
        local status = math.Clamp( ((curtime / time)*(CurStagePercent/100))+(self.PreviousPercent/100), 0, (self.PreviousPercent+CurStagePercent)/100)
        local BarWidth = status * (width - sizet)

        surface.SetDrawColor( Color( 54, 57, 62 ) )
        surface.DrawRect( x + sizet/2, y + sizet/2, width-sizet, height - sizet )

        surface.SetDrawColor( HSVToColor( 90*status, 1, 1 ) )
        surface.DrawRect( x + sizet/2, y + sizet/2, BarWidth, height - sizet )
        surface.SetDrawColor( 80, 80, 80, 200 )
        surface.DrawRect( x + sizet/2, y + sizet/2, BarWidth, height - sizet )


        local status2 = (self:GetIsStuck() and (self:GetClickTime()-CurTime())/2.5) or 1
        local BarWidth2 = status2 * (width - sizet)
        surface.SetDrawColor( Color( 54, 57, 62 ) )
        surface.DrawRect( x + sizet/2, y + height, (width - sizet), hHeight - sizet/2 )
        surface.SetDrawColor( Color( 240, 71, 71 ) )
        surface.DrawRect( x + sizet/2, y + height, BarWidth2, hHeight - sizet/2 )
    end
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack()
end