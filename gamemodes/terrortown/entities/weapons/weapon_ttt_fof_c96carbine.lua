SWEP.Base = "weapon_ttt_fof_base"

SWEP.PrintName = "Mauser Carbine"

SWEP.Icon = "vgui/tttfof/weapons/c96carbine"

SWEP.IsTwoHandedGun = true

SWEP.Primary.Damage = 20
SWEP.Primary.HeadshotDamage = 25
SWEP.Primary.Delay = 60 / 1000
SWEP.Primary.Cone = 0.05
SWEP.Primary.Recoil = 2
SWEP.Primary.ClipSize = 10
SWEP.Primary.Sound = "c96carbine.Single"

SWEP.DryFireSound = "TFA_DOI_C96.Empty"

SWEP.ViewModel = "models/weapons/tfa_doi/v_doi_c96_carbine.mdl"
SWEP.WorldModel = "models/weapons/tfa_doi/w_doi_c96_carbine.mdl"
SWEP.ViewModelFOV = 80

SWEP.UseHands = true

SWEP.FalloffStart = 150
SWEP.FalloffHalf = 640
SWEP.FalloffEnd = 960

-- don't let people run and gun with this thing lmao
SWEP.HipfireDamageMultiplier = 0.5

SWEP.WalkingSpeed = 136

SWEP.LastBulletPrimaryAnim = ACT_VM_PRIMARYATTACK_EMPTY
SWEP.DryFireAnim = ACT_VM_DRYFIRE
SWEP.ReloadAnim = ACT_VM_RELOAD_EMPTY

SWEP.DryFireTime = 0.6

SWEP.ReloadTime = 4.5
SWEP.InsertTime = 2.5
SWEP.ReloadAnimSpeed = 0.85

SWEP.DeployTime = 1.3
SWEP.DeployAnimSpeed = -0.6
SWEP.DeploySequence = 4
SWEP.DeployEmptySequence = 25

SWEP.ConeAim = 0.05
SWEP.ConeAimRun = 0.125
SWEP.ConeAimJump = 0.3
SWEP.ConeHip = 0.125
SWEP.ConeRun = 0.25
SWEP.ConeJump = 0.35

SWEP.ConeTimeRun = 0.5
SWEP.ConeTimeJump = 0.75

SWEP.AimTime = 0.66
SWEP.AimRecoil = 0.5

SWEP.DeadEyeDeployTime = 0.66
SWEP.DeadEyeDeployAnimSpeed = -1

SWEP.IronSightsPosUnlowered = Vector(-2.332, -2, 2)
SWEP.IronSightsPos = Vector(-2.332, -2, 1)
SWEP.IronSightsAng = Vector(0.336, 0, 0)

SWEP.NewRightHandPos = Vector(-8, -5, -4.5)
SWEP.NewRightHandAng = Angle(10.5, 1, -180)

SWEP.HolsteredOffsetPos = Vector(9, 4.5, 4)

SWEP.GroundSpawnOffsetAng = Angle(0, 180)

SWEP.SilencerModelPath = "models/ttt_fof/silencer_detached_usp.mdl"
SWEP.SilencerOffsetPos = Vector(-5.3, 0, 0)
SWEP.SilencerVMOffsetPos = Vector(-5.3, 0, 0)

SWEP.NewCollisionBoundsMins = Vector(-7.25, -5, -11)
SWEP.NewCollisionBoundsMaxs = Vector(31, -2, -1.5)

SWEP.BulletTracerType = 2

SWEP.ForceMuzzleFlashEffect = 3

SWEP.spawnType = WEAPON_TYPE_SNIPER

SWEP.AutoSpawnable = true
SWEP.AutoSpawnableConVar = "ttt_fof_spawnwep_c96carbine"

SWEP.ThirdPersonSounds = {
	[ACT_VM_RELOAD_EMPTY] = {
		19, "TFA_DOI_C96.Magrelease",
		25, "TFA_DOI_C96.Magout",
		--32, "TFA_DOI_C96.MagFetch",
		64, "TFA_DOI_C96.MagFiddle",
		71, "TFA_DOI_C96.MagIn",
		89, "TFA_DOI_C96.Rattle",
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
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	local name = "models/weapons/tfa_ins2/c_ins2_pmhands.mdl"

	local mdl = TTT_FOF.CLMDL[name]

	if not IsValid(mdl) then
		mdl = ClientsideModel(name)

		mdl:SetNoDraw(true)

		TTT_FOF.CLMDL[name] = mdl
	end

	if mdl:GetParent() ~= vm then
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
	pos:Sub(ang:Up())

	return self.BaseClass.GetViewModelPosition(self, pos, ang)
end
