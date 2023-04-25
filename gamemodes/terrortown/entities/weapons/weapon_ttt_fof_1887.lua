SWEP.Base = "weapon_ttt_fof_base"

SWEP.PrintName = "Repeating Shotgun"

SWEP.Icon = "vgui/tttfof/weapons/winchester_1887"

SWEP.IsTwoHandedGun = true

SWEP.Primary.Damage = 13
SWEP.Primary.HeadshotDamage = 20
SWEP.Primary.NumShots = 5
SWEP.Primary.Delay = 1.7
SWEP.Primary.Cone = 0.037
SWEP.Primary.Recoil = 5
SWEP.Primary.Sound = "m1887.Single"
SWEP.Primary.ClipSize = 7

SWEP.DryFireSound = "Weapon_Shotgun.Empty"

SWEP.ViewModel = "models/weapons/cwc_1887/v_draggo_model1887.mdl"
SWEP.WorldModel = "models/weapons/cwc_1887/w_draggo_model1887.mdl"
SWEP.ViewModelFOV = 60

SWEP.ReloadsSingly = true

SWEP.FalloffStart = 100

SWEP.HeadshotFalloffStart = 150
SWEP.HeadshotFalloffEnd = 250

SWEP.LimbshotMultiplier = 1

-- there's 2 attack sequences, one is just shorter than the other for some reason
-- so use the longer one
SWEP.ShootSequence = 2
SWEP.AttackAnimSpeed = 0.85

SWEP.ReloadTime = 0.8
SWEP.ReloadTimeConsecutive = 0.9
SWEP.ReloadTimeFinish = 0.9
SWEP.InsertTime = 0.12

SWEP.ReloadAnimSpeed = 1
SWEP.ReloadAnimSpeedConsecutive = 0.7
SWEP.ReloadAnimSpeedFinish = 0.96

SWEP.DeployTime = 1.25
SWEP.DeployAnimSpeed = 1.1

SWEP.ConeAim = 0.036
SWEP.ConeRun = 0.1
SWEP.ConeJump = 0.15

SWEP.ConeTimeRun = 0.3
SWEP.ConeTimeJump = 0.5

SWEP.AimTime = 0.5
SWEP.AimRecoil = 2.5

SWEP.DeadEyeCone = 0.025
SWEP.DeadEyeShootSequence = 1
SWEP.DeadEyeAttackDelay = 0.8
SWEP.DeadEyeAttackAnimSpeed = 1.5
SWEP.DeadEyeDeployTime = 0.66
SWEP.DeadEyeDeployAnimSpeed = 1.8

SWEP.ActivityRemap = {
	[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
	[ACT_MP_ATTACK_CROUCH_PRIMARYFIRE] = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN,
}

SWEP.IronSightsPosUnlowered = Vector(-3.06, 0, 1.9)
SWEP.IronSightsPos = Vector(-3.06, 0, 1)
SWEP.IronSightsAng = Vector(-0.09, 0.02, 0)

SWEP.NewRightHandPos = Vector(18, -1, -5.5)
SWEP.NewRightHandAng = Angle(4, 2, 177)

SWEP.HolsteredOffsetPos = Vector(-5, 0.3, 0)

SWEP.GroundSpawnOffsetAng = Angle(0, 180)

SWEP.SilencerModelPath = "models/ttt_fof/silencer_detached_tmp.mdl"
SWEP.SilencerOffsetPos = Vector(-0.3, -0.1, 0)
SWEP.SilencerVMOffsetPos = Vector(5.6, 0, 0.1)

SWEP.NewCollisionBoundsMins = Vector(-20, -1.8, -8)
SWEP.NewCollisionBoundsMaxs = Vector(22, 1.9, 3.6)

SWEP.spawnType = WEAPON_TYPE_SHOTGUN

SWEP.AutoSpawnable = true
SWEP.AutoSpawnableConVar = "ttt_fof_spawnwep_1887"

SWEP.ForceMuzzleFlashEffect = 1

SWEP.ThirdPersonSounds = {
	[ACT_VM_PRIMARYATTACK] = {
		23, "m1887.Pull",
		34, "m1887.Back",
	},
	[ACT_VM_RELOAD] = {
		4, "m1887.Insert",
	},
	[ACT_SHOTGUN_RELOAD_FINISH] = {
		12, "m1887.Back",
	},
	[ACT_SHOTGUN_RELOAD_START] = {
		5, "m1887.Pull",
	},
}

if SERVER then
	return
end

function SWEP:GetViewModelPosition(pos, ang)
	pos:Sub(ang:Up())

	return self.BaseClass.GetViewModelPosition(self, pos, ang)
end
