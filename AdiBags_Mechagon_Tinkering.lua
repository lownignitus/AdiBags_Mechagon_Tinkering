--[[
Title: AdiBags - Mechagon Tinkering
Version: v1.0.7
Author LownIgnitus - Mihkael-Alexstrasza
Add various Mechagon Tinkering items to AdiBags filter groups
]]


local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local L = addon.L
local MatchIDs
local Result = {}

local function AddToSet(Set, List)
	for _, v in ipairs(List) do
		Set[v] = true
	end
end

-- Tinkering Parts
local parts = {
	166846, --Spare Parts
	166970, --Energy Cell
	166971, --Empty Energy Cell
	167562, --Ionized Minnow
	168215, --Machined Gear Assembly
	168216, --Tempered Plating
	168217, --Hardened Spring
	168262, --Sentry Fish
	168327, --Chain Ignitercoil
	168832, --Galvanic Oscillator
	168946, --Bundle of Recyclable Parts
	169610, --S.P.A.R.E. Crate
}

-- Mechagon Boxes
local boxes = {
	167744, --Aspirant's Equipment Cache
	168264, --Recycling Requisition
	168266, --Strange Recycling Requisition
	169471, --Cogfrenzy's Construction Toolkit
	169838, --Azeroth Mini: Starter Pack
	170061, --Rustbolt Supplies
	298140, --Rustbolt Requisitions
}

-- Item blueprints
local blueprints = {
	167042, --Blueprint: Scrap Trap
	167652, --Blueprint: Hundred-Fathom Lure
	167787, --Blueprint: Mechanocat Laser Pointer
	167836, --Blueprint: Canned Minnows
	167843, --Blueprint: Vaultbot Key
	167844, --Blueprint: Emergency Repair Kit
	167845, --Blueprint: Emergency Powerpack
	167846, --Blueprint: Mechano-Treat
	167847, --Blueprint: Ultrasafe Transporter: Mechagon
	167871, --Blueprint: G99.99 Landshark
	168062, --Blueprint: Rustbolt Gramophone
	168063, --Blueprint: Rustbolt Kegerator
	168219, --Blueprint: Beastbot Powerpack
	168220, --Blueprint: Re-Procedurally Generated Punchcard
	168248, --Blueprint: BAWLD-371
	168490, --Blueprint: Protocol Transference Device
	168491, --Blueprint: Personal Time Displacer
	168492, --Blueprint: Emergency Rocket Chicken
	168493, --Blueprint: Battle Box
	168494, --Blueprint: Rustbolt Resistance Insignia
	168495, --Blueprint: Rustbolt Requisitions	
	168906, --Blueprint: Holographic Digitalization Relay
	168908, --Blueprint: Experimental Adventurer Augment
	169112, --Blueprint: Advanced Adventurer Augment
	169134, --Blueprint: Extraodinary Adventurer Augment
	169167, --Blueprint: Orange Spraybot
	169168, --Blueprint: Green Spraybot
	169169, --Blueprint: Blue Spraybot
	169170, --Blueprint: Utility Mechanoclaw
	169171, --Blueprint: Microbot XD
	169172, --Blueprint: Perfectly Timed Differential
	169173, --Blueprint: Anti-Gravity Pack
	169174, --Blueprint: Rustbolt Pocket Turret
	169175, --Blueprint: Annoy-o-Tron Gang
	169176, --Blueprint: Encrypted Black Market Radio
	169190, --Blueprint: Mega-Sized Spare Parts
}

-- Mount Paints
local paint = {
	167796, --Paint Vial: Mechagon Gold
	167790, --Paint Vial: Fireball Red
	167791, --Paint Vial: Battletorn Blue
	167792, --Paint Vial: Fel Mint Green
	167793, --Paint Vial: Overload Orange
	167794, --Paint Vial: Lemonade Steel
	167795, --Paint Vial: Copper Trim
	168001, --Paint Vial: Big-ol Bronze
	170146, --Paint Bottle: Nukular Red
	170147, --Paint Bottle: Goblin Green
	170148, --Paint Bottle: Electric Blue
}

-- Mechagon Minis
local minis = {
	169794, --Azeroth Mini: Izira Gearsworn
	169795, --Azeroth Mini: Bondo Bigblock
	169796, --Azeroth Mini Collection: Mechagon
	169797, --Azeroth Mini: Wrenchbot
	169840, --Azeroth Mini: Gazlowe
	169841, --Azeroth Mini: Erazmin
	169842, --Azeroth Mini: Roadtrogg
	169843, --Azeroth Mini: Cork Stuttguard
	169844, --Azeroth Mini: Overspark
	169845, --Azeroth Mini: HK-8
	169846, --Azeroth Mini: King Mechagon
	169849, --Azeroth Mini: Naeno Megacrash
	169851, --Azeroth Mini: Cogstar
	169852, --Azeroth Mini: Blastatron
	169876, --Azeroth Mini: Sapphronetta
	169895, --Azeroth Mini: Beastbot
	169896, --Azeroth Mini: Pascal-K1N6
}

-- Mechagon Misc
local misc = {
	168497, --Rustbolt Resistance Insignia
	169107, --T.A.R.G.E.T. Device
	169688, --Vinyl: Gnomeregan Forever
	169689, --Vinyl: Mimiron's Brainstorm
	169690, --Vinyl: Battle of Gnomeregan
	169691, --Vinyl: Depths of Ulduar
	169692, --Vinyl: Triumph of Gnomeregan
}

local function MatchIDs_Init(self)
	wipe(Result)

	if self.db.profile.moveParts then
		AddToSet(Result, parts)
	end

	if self.db.profile.moveBoxes then
		AddToSet(Result, parts)
	end

	if self.db.profile.moveBlueprints then
		AddToSet(Result, parts)
	end

	if self.db.profile.movePaint then
		AddToSet(Result, parts)
	end

	if self.db.profile.moveMinis then
		AddToSet(Result, parts)
	end

	if self.db.profile.moveMisc then
		AddToSet(Result, parts)
	end

	return Result
 end

local setFilter = AdiBags:RegisterFilter("Mechagon Tinkering", 98, "ABEvent-1.0")
setFilter.uiName = L["Mechagon Tinkering"]
setFilter.uiDesc = L["Mechagon Tinkering Parts & Items."]

function setFilter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace("Mechagon Tinkering", {
		profile = {
			moveParts = true,
			moveBoxes = true,
			moveBlueprints = true,
			movePaint = true,
			moveMinis = true,
			moveMisc = true,
		}
	})
end

function setFilter:Update()
	MatchIDs = nil
	self:SendMessage("AdiBags_FiltersChanged")
end

function setFilter:OnEnable()
	AdiBags:UpdateFilters()
end

function setFilter:OnDisable()
	AdiBags:UpdateFilters()
end

function setFilter:Filter(slotData)
	MatchIDs = MatchIDs or MatchIDs_Init(self)
	if MatchIDs[slotData.itemId] then
		return L["Mechagon Tinkering"]
	end
end

function setFilter:GetOptions()
	return {
		moveParts = {
			name = L["Tinkering Parts"],
			desc = L["Display Tinkering Parts"],
			type = "toggle",
			order = 10
		},
		moveBoxes  = {
			name = L["Mechagon Boxes"],
			desc = L["Display Mechagon Boxes"],
			type = "toggle",
			order = 20
		},
		moveBlueprints = {
			name = L["Item Blueprints"],
			desc = L["Display Item Blueprints"],
			type = "toggle",
			order = 30
		},
		movePaint = {
			name = L["Mount Paints"],
			desc = L["Display Mount Paints"],
			type = "toggle",
			order = 40
		},
		moveMinis = {
			name = L["Mechagon Minis"],
			desc = L["Display Mechagon Minis"],
			type = "toggle",
			order = 50
		},
		moveMisc = {
			name = L["Mechagon Misc"],
			desc = L["Display Mechagon Misc"],
			type = "toggle",
			order = 60
		},
	},
	AdiBags:GetOptionHandler(self, false, function()
		return self:Update()
	end)
end
