SWEP.Base = "weapon_ttt_fof_base"

SWEP.PrintName = "Mauser Pistol"

SWEP.Icon = "vgui/tttfof/weapons/c96pistol"

SWEP.Primary.Damage = 30
SWEP.Primary.HeadshotDamage = 40
SWEP.Primary.Delay = 60 / 400
SWEP.Primary.Cone = 0.024
SWEP.Primary.Recoil = 1.8
SWEP.Primary.ClipSize = 8 --10
SWEP.Primary.Sound = "Weapon_C96.Single"

SWEP.DryFireSound = "Weapon_C96.Empty"

-- don't shoot as fast as possible when lmb is held down
SWEP.Primary.SemiAutomatic = true

-- will automatically shoot at this interval while lmb is held down
SWEP.Primary.SemiAutomaticDelay = 0.5

SWEP.ViewModel = "models/weapons/v_c96_one_handed.mdl"
SWEP.WorldModel = "models/weapons/w_c96_one_handed.mdl"
SWEP.ViewModelFOV = 80

-- tfa viewmodels are weird, see SWEP:PreDrawViewModel below
SWEP.UseHands = true

-- different animation for shooting the last shot in the clip
SWEP.LastBulletPrimaryAnim = ACT_VM_PRIMARYATTACK_EMPTY

 -- use the objectively cooler reload animation
SWEP.ReloadAnim = ACT_VM_RELOAD_EMPTY

SWEP.DryFireTime = 0.6

SWEP.ReloadTime = 4.8
SWEP.InsertTime = 2.7
SWEP.ReloadAnimSpeed = 0.9

SWEP.DeployTime = 1
SWEP.DeployAnimSpeed = -0.4 -- reversed
SWEP.DeploySequence = 6 -- actually the holster sequence
SWEP.DeployEmptySequence = 22 -- actually the empty holster sequence

SWEP.ConeAim = 0.023
SWEP.ConeRun = 0.2
SWEP.ConeJump = 0.35

SWEP.ConeTimeRun = 0.36 -- time to recover from running inaccuracy
SWEP.ConeTimeJump = 0.55 -- time to recover from jumping inaccuracy

SWEP.AimTime = 0.6 -- time to aim down sights
SWEP.AimRecoil = 1

-- max cone to use after shooting, this makes spamming shots less accurate
SWEP.ConeRecov = 0.1
-- time to keep max cone before accuracy recovers, default is 0
SWEP.ConeRecovStartTime = 0.2
-- time to fully recover accuracy, default is 1
SWEP.ConeRecovEndTime = 1
-- how much inaccuracy each shot adds, default is equal to the value of ConeRecovEndTime
SWEP.ConeRecovTimePerShot = 0.5
-- multiplies ConeRecovTimePerShot based on current inaccuracy, default is 1
-- lower values means less inaccuracy added per shot while inaccuracy is already high
SWEP.ConeRecovTimePerShotMult = 0.5

SWEP.DeadEyeAttackDelay = 0.3
SWEP.DeadEyeDeployTime = 0.5
SWEP.DeadEyeDeployAnimSpeed = -0.8 -- reversed

SWEP.IronSightsPosUnlowered = Vector(-2.627, -2, 1.6877)
SWEP.IronSightsPos = Vector(-2.627, -2, 0.6877)
SWEP.IronSightsAng = Vector(1.04, 0.0329, 0)

-- offset from the owner's holster in third person (on the hip or back or leg)
SWEP.HolsteredOffsetPos = Vector(-0.5, -1.5, -0.5)
SWEP.HolsteredOffsetAng = Angle(180, 40, 85)

-- offset from the owner's right hand in third person
SWEP.NewRightHandPos = Vector(4.2, -1.2, -3.9)
SWEP.NewRightHandAng = Angle(0, 0, 180)

-- rotates the gun when spawned on the floor so it matches the rotation of the other guns
SWEP.GroundSpawnOffsetAng = Angle(0, 180)

SWEP.SilencerModelPath = "models/ttt_fof/silencer_detached_usp.mdl"
-- silencer's offset from muzzle in third person
SWEP.SilencerOffsetPos = Vector(0, 0, 0)
-- silencer's offset from muzzle in viewmodel
SWEP.SilencerVMOffsetPos = Vector(-0.25, 0, 0)

-- see entities/effects/ttt_fof_tracer.lua for tracer types
SWEP.BulletTracerType = 2

-- some models doesn't automatically do a muzzleflash effect for some reason
SWEP.ForceMuzzleFlashEffect = 3

SWEP.AutoSpawnable = true
-- name of the cvar used to toggle whether it should spawn or not
SWEP.AutoSpawnableConVar = "ttt_fof_spawnwep_c96pistol"

-- you need to decompile the viewmodel with Crowbar to know what values to put here
SWEP.ThirdPersonSounds = {
	[ACT_VM_RELOAD_EMPTY] = {
		--12, "Weapon_C96.MagFetch",
		37, "Weapon_C96.MagFiddle",
		44, "Weapon_C96.ClipIn",
		59, "Weapon_C96.RoundsIn_01",
		68, "Weapon_C96.RoundsIn_02",
		96, "Weapon_C96.ClipRemove",
		98, "Weapon_C96.Boltrelease",
		128, "Weapon_C96.Rattle",
	},
}

if SERVER then
	return
end

function SWEP:FireAnimationEvent(pos, ang, event, options, vm)
	if event ~= 21 then
		return
	end

	local data = EffectData()
	data:SetFlags(0)
	data:SetEntity(vm)
	data:SetAttachment(1)
	data:SetScale(0.5)

	util.Effect("CS_MuzzleFlash", data)

	local data = EffectData()
	data:SetFlags(0)
	data:SetEntity(vm)

	local att = vm:GetAttachment(2)
	data:SetOrigin(att and att.Pos or pos)
	data:SetAngles(att and att.Ang or ang)

	util.Effect("ShellEject", data)

	return true
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	-- fixes invisible hands

	local name = "models/weapons/tfa_ins2/c_ins2_pmhands.mdl"

	local mdl = TTT_FOF.CLMDL[name]

	if not IsValid(mdl) then
		mdl = ClientsideModel(name)

		mdl:SetNoDraw(true)

		TTT_FOF.CLMDL[name] = mdl
	end

	if mdl:GetParent() ~= vm then
		mdl:SetPos(vm:GetPos())
		mdl:GetAngles(vm:GetAngles())
		mdl:SetParent(vm)
		mdl:AddEffects(EF_BONEMERGE)
		mdl:Spawn()
	end

	mdl:SetupBones()

	local hands = ply:GetHands()

	if IsValid(hands) and hands:GetParent() ~= mdl then
		hands:SetParent(mdl)
	end

	return self.BaseClass.PreDrawViewModel(self, vm, wep, ply)
end

function SWEP:GetViewModelPosition(pos, ang)
	-- shift viewmodel position down a little bit

	pos:Sub(ang:Up())

	return self.BaseClass.GetViewModelPosition(self, pos, ang)
end
