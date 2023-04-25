SWEP.Base = "weapon_ttt_fof_base"

SWEP.PrintName = "Gewehr Rifle"

SWEP.Icon = "vgui/tttfof/weapons/gewehr"

SWEP.IsTwoHandedGun = true

SWEP.Primary.Damage = 65
SWEP.Primary.HeadshotDamage = 90
SWEP.Primary.Delay = 2
SWEP.Primary.Cone = 0.00125
SWEP.Primary.Recoil = 5
SWEP.Primary.ClipSize = 5
SWEP.Primary.Sound = "gewehr.Single"

SWEP.DryFireSound = "TFA_WW1_MODEL1899.Empty"

SWEP.ViewModel = "models/weapons/gewehr/v_mauser1889.mdl"
SWEP.WorldModel = "models/weapons/gewehr/w_mauser1889.mdl"
SWEP.ViewModelFOV = 63

SWEP.UseHands = true

SWEP.ReloadsSingly = true

SWEP.FalloffDisabled = true

SWEP.LimbshotMultiplier = 35 / 65

SWEP.PenetrationDamageMultiplier = 1

SWEP.AttackAnimSpeed = 0.9

SWEP.PumpAnim = ACT_VM_PULLBACK_HIGH

SWEP.PumpTime = 1.6
SWEP.PumpAnimSpeed = 1.06

SWEP.ReloadTime = 0.85
SWEP.ReloadTimeConsecutive = 1
SWEP.ReloadTimeFinish = 0.9
SWEP.InsertTime = 0.3

SWEP.ReloadAnimSpeedConsecutive = 0.9

SWEP.DeployTime = 1.3
SWEP.DeployAnimSpeed = 0.5

SWEP.ConeAim = 0.00125
SWEP.ConeAimRun = 0.09375
SWEP.ConeAimJump = 0.2
SWEP.ConeHip = 0.25
SWEP.ConeRun = 0.35
SWEP.ConeJump = 0.5

SWEP.ConeTimeRun = 0.4
SWEP.ConeTimeJump = 0.65

SWEP.AimTime = 0.66
SWEP.AimRecoil = 2.5

SWEP.DeadEyeAttackDelay = 1
SWEP.DeadEyeAttackAnimSpeed = 0.02
SWEP.DeadEyePumpTime = 0.99
SWEP.DeadEyePumpAnimSpeed = 1.6
SWEP.DeadEyeDeployTime = 0.66
SWEP.DeadEyeDeployAnimSpeed = 1

SWEP.DeadEyeNerfAttackDelay = 0.5

SWEP.IronSightsPosUnlowered = Vector(-2.82, 0, 2.679)
SWEP.IronSightsPos = Vector(-2.82, 0, 1.679)
SWEP.IronSightsAng = Vector(0.273, 0, 0)

SWEP.NewRightHandPos = Vector(5.5, -1, -1.2)
SWEP.NewRightHandAng = Angle(10, 1, 180)

SWEP.HolsteredOffsetPos = Vector(10, 0.5, -4)
SWEP.HolsteredOffsetAng = Angle(180, 218, -12)

SWEP.GroundSpawnOffsetAng = Angle(0, 180)

SWEP.SilencerOffsetPos = Vector(1.2, -0.03, -0.12)
SWEP.SilencerVMOffsetPos = Vector(0.6, -0.12, -0.01)

SWEP.BulletTracerType = 4

SWEP.ForceMuzzleFlashEffect = 2

SWEP.spawnType = WEAPON_TYPE_SNIPER

SWEP.AutoSpawnable = true
SWEP.AutoSpawnableConVar = "ttt_fof_spawnwep_gewehr"

SWEP.ThirdPersonSounds = {
	[ACT_VM_PULLBACK_HIGH] = {
		11, "TFA_WW1_MODEL1899.BoltRelease",
		15, "TFA_WW1_MODEL1899.Boltback",
		25, "TFA_WW1_MODEL1899.Boltforward",
		29, "TFA_WW1_MODEL1899.BoltLatch",
	},
	[ACT_SHOTGUN_RELOAD_START] = {
		4, "TFA_WW1_MODEL1899.BoltRelease",
		10, "TFA_WW1_MODEL1899.Boltback",
	},
	[ACT_VM_RELOAD] = {
		8, "TFA_WW1_MODEL1899.Roundin"
	},
	[ACT_SHOTGUN_RELOAD_FINISH] = {
		7, "TFA_WW1_MODEL1899.Boltforward",
		11, "TFA_WW1_MODEL1899.BoltLatch",
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
	data:SetAttachment(5)
	data:SetScale(1.5)

	util.Effect("CS_MuzzleFlash", data)

	return true
end

function SWEP:ViewModelDrawn(vm)
	if self:GetActivity() ~= self.PumpAnim then
	elseif not self.DoRifleShellEject then
		if vm:GetCycle() < 0.4 then
			self.DoRifleShellEject = true
		end
	elseif vm:GetCycle() > 0.4 then
		self.DoRifleShellEject = nil

		local data = EffectData()
		data:SetFlags(0)
		data:SetEntity(vm)

		local att = vm:GetAttachment(3)
		data:SetOrigin(att and att.Pos or vm:GetPos())
		data:SetAngles(att and att.Ang or vm:GetAngles())

		util.Effect("RifleShellEject", data)
	end

	return self.BaseClass.ViewModelDrawn(self, vm)
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
	local act = self:GetActivity()

	local x, y, z = 0, 0, -1

	if act == ACT_VM_RELOAD then
		x, y, z = 1, -1, 0
	elseif act == ACT_SHOTGUN_RELOAD_START then
		local mult = 1
		local vm = self:GetOwnerViewModel()

		if vm then
			mult = vm:GetCycle()
		end

		x, y, z = mult, -mult, mult - 1
	elseif act == ACT_SHOTGUN_RELOAD_FINISH then
		local mult = 1
		local vm = self:GetOwnerViewModel()

		if vm then
			mult = 1 - vm:GetCycle()
		end

		x, y, z = mult, -mult, mult - 1
	end

	local fwd, rgt, up = ang:Forward(), ang:Right(), ang:Up()

	fwd:Mul(x)
	rgt:Mul(y)
	up:Mul(z)

	pos:Add(fwd)
	pos:Add(rgt)
	pos:Add(up)

	return self.BaseClass.GetViewModelPosition(self, pos, ang)
end
