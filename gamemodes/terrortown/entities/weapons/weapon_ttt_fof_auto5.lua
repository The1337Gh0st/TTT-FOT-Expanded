SWEP.Base = "weapon_ttt_fof_base"

SWEP.PrintName = "Auto Shotgun" --"Browning Auto-5"

SWEP.Icon = "vgui/tttfof/weapons/auto5"

SWEP.IsTwoHandedGun = true

SWEP.UseHands = true

SWEP.Primary.Damage = 6
SWEP.Primary.HeadshotDamage = 8
SWEP.Primary.NumShots = 6
SWEP.Primary.Delay = 60 / 360
SWEP.Primary.Cone = 0.045
SWEP.Primary.Recoil = 3.6
SWEP.Primary.ClipSize = 5
SWEP.Primary.Sound = "auto5.Single"

SWEP.DryFireSound = "TFA_INS2.Auto5.Empty"

SWEP.Primary.SemiAutomatic = true
SWEP.Primary.SemiAutomaticDelay = 0.5

SWEP.ViewModel = "models/weapons/c_ins2_auto5_ins.mdl"
SWEP.WorldModel = "models/weapons/w_ins2_auto5.mdl"
SWEP.ViewModelFOV = 70

SWEP.ReloadsSingly = true

SWEP.FalloffStart = 200

SWEP.HeadshotFalloffStart = 150
SWEP.HeadshotFalloffEnd = 225

SWEP.LimbshotMultiplier = 1

SWEP.DryFireTime = 0.66

SWEP.ReloadTime = 0.8
SWEP.ReloadTimeConsecutive = 0.9
SWEP.ReloadTimeFinish = 0.6
SWEP.InsertTime = 0.4

SWEP.ReloadAnimSpeed = 0.8
SWEP.ReloadAnimSpeedConsecutive = 0.86
SWEP.ReloadAnimSpeedFinish = 0.75

SWEP.ReloadEmptyAnim = ACT_VM_RELOAD_EMPTY

SWEP.ReloadEmptyTime = 3
SWEP.ReloadEmptyInsertTime = 1.3
SWEP.ReloadEmptyAnimSpeed = 1.05

SWEP.DeployTime = 1.25
SWEP.DeployAnimSpeed = 0.5

SWEP.ConeAim = 0.03
SWEP.ConeRun = 0.125
SWEP.ConeJump = 0.2

SWEP.ConeTimeRun = 0.25
SWEP.ConeTimeJump = 0.5

SWEP.AimTime = 0.5
SWEP.AimRecoil = 2.5

SWEP.ConeRecov = 0.15
SWEP.ConeRecovStartTime = 0.22
SWEP.ConeRecovEndTime = 1
SWEP.ConeRecovTimePerShot = 0.5
SWEP.ConeRecovTimePerShotMult = 0.5

SWEP.DeadEyeCone = 0.025
SWEP.DeadEyeAttackDelay = 0.25
SWEP.DeadEyeAttackAnimSpeed = 1
SWEP.DeadEyeDeployTime = 0.66
SWEP.DeadEyeDeployAnimSpeed = 1

SWEP.IronSightsPosUnlowered = Vector(-3.37, -2, 2.65)
SWEP.IronSightsPos = Vector(-3.37, -2, 1.5)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.NewRightHandPos = Vector(7, -1, -3)
SWEP.NewRightHandAng = Angle(16, 1.2, 180)

SWEP.GroundSpawnOffsetAng = Angle(0, 180)

SWEP.SilencerModelPath = "models/ttt_fof/silencer_detached_tmp.mdl"
SWEP.SilencerOffsetPos = Vector(2, 0.02, -0.12)
SWEP.SilencerVMOffsetPos = Vector(0.6, -0.105, 0)

SWEP.spawnType = WEAPON_TYPE_SHOTGUN

SWEP.AutoSpawnable = true
SWEP.AutoSpawnableConVar = "ttt_fof_spawnwep_auto5"

SWEP.ForceMuzzleFlashEffect = 1

SWEP.ThirdPersonSounds = {
	[ACT_VM_RELOAD] = {
		13, "TFA_INS2.Auto5.ShellInsert",
	},
	[ACT_VM_RELOAD_EMPTY] = {
		27, "TFA_INS2.Auto5.Boltback",
		44, "TFA_INS2.Auto5.ShellInsertSingle",
		59, "TFA_INS2.Auto5.Boltrelease",
	}
}

function SWEP:PreReload()
	local vm = self:GetOwnerViewModel()

	if vm then
		if self:Clip1() == 0 then
			vm:SetBodygroup(1, 1)
		end

		vm:SetBodygroup(2, 1)
	end
end

function SWEP:PostReload()
	local vm = self:GetOwnerViewModel()

	if vm then
		vm:SetBodygroup(1, 0)
		vm:SetBodygroup(2, 0)
	end
end

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
	data:SetScale(1)

	util.Effect("CS_MuzzleFlash", data)

	local data = EffectData()
	data:SetFlags(0)
	data:SetEntity(vm)

	local att = vm:GetAttachment(3)
	data:SetOrigin(att and att.Pos or pos)
	data:SetAngles(att and att.Ang or ang)

	util.Effect("ShotgunShellEject", data)
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
	pos:Sub(ang:Up())

	if self:GetActivity() == ACT_VM_DRAW then -- better deploy animation
		local vm = self:GetOwnerViewModel()

		local mult = vm and vm:GetCycle() or 1

		if mult ~= 1 then
			mult = math.ease.InOutBack(
				mult < 0.4 and mult * 2.5 or 1 - (mult - 0.4) * (5 / 3)
			)

			ang:RotateAroundAxis(ang:Right(), mult * 20)

			local up = ang:Up()

			up:Mul(mult * -5)

			pos:Add(up)
		end
	end

	return self.BaseClass.GetViewModelPosition(self, pos, ang)
end
