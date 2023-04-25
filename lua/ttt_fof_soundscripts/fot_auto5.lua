return {
{
	name = "auto5.Single",
	channel = CHAN_WEAPON, --see how this is a different channel? Gunshots go here
	volume = 0.7,
	level = 140,
	pitch = {95,105},
	sound = "weapons/tfa_ins2/m1014/m1014_fire.wav",
},
{
	name = "TFA_INS2.Auto5.Empty",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = "weapons/tfa_ins2/m1014/toz_empty.wav",
},
{
	name = "TFA_INS2.Auto5.ShellInsertSingle",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = {
		"weapons/tfa_ins2/m1014/toz_single_shell_insert_1.wav",
		"weapons/tfa_ins2/m1014/toz_single_shell_insert_2.wav",
		"weapons/tfa_ins2/m1014/toz_single_shell_insert_3.wav",
	},
},
{
	name = "TFA_INS2.Auto5.ShellInsert",
	channel = CHAN_ITEM,
	volume = 0.7,
	pitch = {95,105},
	sound = {
		"weapons/tfa_ins2/m1014/toz_shell_insert_1.wav",
		"weapons/tfa_ins2/m1014/toz_shell_insert_2.wav",
		"weapons/tfa_ins2/m1014/toz_shell_insert_3.wav",
	},
},
{
	name = "TFA_INS2.Auto5.Boltback",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = "weapons/tfa_ins2/m1014/toz_pumpback.wav",
},
{
	name = "TFA_INS2.Auto5.Boltrelease",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = "weapons/tfa_ins2/m1014/toz_pumpforward.wav",
},
{
	name = "TFA_INS2.LeanIn",
	channel = CHAN_STATIC,
	volume = 0.001,
	sound = "common/null.wav",
},
}
