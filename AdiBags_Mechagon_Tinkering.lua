--[[
Title: AdiBags - Mechagon Tinkering
Version: v1.0.2
Author LownIgnitus - Mihkael-Alexstrasza
Add various Mechagon Tinkering items to AdiBags filter groups
]]


local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local L = addon.L
local MatchIDs
local Tooltip
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
	168262, --Sentry Fish
	168327, --Chain Ignitercoil
	168832, --Galvanic Oscillator
	169610, --S.P.A.R.E. Crate
}

local function MatchIDs_Init(self)
	wipe(Result)

	if self.db.profile.moveParts then
		AddToSet(Result, parts)
	end

	return Result
 end

local function Tooltip_Init()
	local tip, leftside = CreateFrame("GameTooltip"), {}
	for i = 1, 6 do
		local Left, Right = tip:CreateFontString(), tip:CreateFontString()
		Left:SetFontObject(GameFontNormal)
		Right:SetFontObject(GameFontNormal)
		tip:AddFontStrings(Left, Right)
		leftside[i] = Left
	end
	tip.leftside = leftside
	return tip
end

local setFilter = AdiBags:RegisterFilter("Mechagon Tinkering", 98, "ABEvent-1.0")
setFilter.uiName = L["Mechagon Tinkering"]
setFilter.uiDesc = L["Mechagon Tinkering Parts & Items."]

function setFilter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace("Mechagon Tinkering", {
		profile = {
			moveParts = true,
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

	Tooltip = Tooltip or Tooltip_Init()
	Tooltip:SetOwner(UIParent,"ANCHOR_NONE")
	Tooltip:ClearLines()

	if slotData.bag == BANK_CONTAINER then
		Tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
	else
		Tooltip:SetBagItem(slotData.bag, slotData.slot)
	end

	Tooltip:Hide()
end

function setFilter:GetOptions()
	return {
		moveParts = {
			name = L["Tinkering Parts"],
			desc = L["Display Tinkering Parts"],
			type = "toggle",
			order = 10
		},
	},
	AdiBags:GetOptionHandler(self, false, function()
		return self:Update()
	end)
end
