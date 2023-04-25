return {
{
	name = "m1887.Single",
	channel = CHAN_WEAPON, --see how this is a different channel? Gunshots go here
	level = 140,
	sound = {
		"^weapons/cwc_1887/fire2.wav",
		"^weapons/cwc_1887/fire3.wav",
		"^weapons/cwc_1887/firesub.wav",
	},
},
{
	name = "CWC_1887_CLICK",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = "weapons/cwc_1887/click.wav",
},
{
	name = "CWC_1887_CLICK2",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = "weapons/cwc_1887/click2.wav",
},
{
	name = "m1887.Pull",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = {
		"weapons/cwc_1887/open1.wav",
		"weapons/cwc_1887/open2.wav",
		"weapons/cwc_1887/open3.wav",
	},
},
{
	name = "m1887.Back",
	channel = CHAN_ITEM,
	volume = 0.7,
	sound = "weapons/cwc_1887/close.wav",
},
{
	name = "m1887.Insert",
	channel = CHAN_ITEM,
	volume = 0.8,
	pitch = {95,105},
	sound = "weapons/cwc_1887/insert1.wav",
},
}
