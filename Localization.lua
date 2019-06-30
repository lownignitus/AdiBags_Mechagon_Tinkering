local addonName, addon = ...

local L = setmetatable({}, {
	__index = function(self, key)
		if key then
			rawset(self, key, tostring(key))
		end
		return tostring(key)
	end,
})
addon.L = L

local locale = GetLocale()

if locale == "deDE" then
--Translation missing
elseif locale == "enUS" then
	L["Mechagon Tinkering"] = true
	L["Mechagon Tinkering Parts & Items."] = true
	L["Tinkering Parts"] = true
	L["Display Tinkering Parts"] = true
	L["Mechagon Boxes"] = true
	L["Display Mechagon Boxes"] = true
	L["Item Blueprints"] = true
	L["Display Item Blueprints"] = true
	L["Mount Paints"] = true
	L["Display Mount Paints"] = true
	L["Mechagon Minis"] = true
	L["Display Mechagon Minis"] = true
	L["Mechagon Misc"] = true
	L["Display Mechagon Misc"] = true
elseif locale == "esES" then
--Translation missing
elseif locale == "esMX" then
--Translation missing
elseif locale == "frFR" then
--Translation missing
elseif locale == "itIT" then
--Translation missing
elseif locale == "koKR" then
--Translation missing
elseif locale == "ptBR" then
--Translation missing
elseif locale == "ruRU" then
--Translation missing
elseif locale == "zhCN" then
--Translation missing
elseif locale == "zhTW" then
--Translation missing
end

-- values by their key
for k,v in pairs(L) do
	if v == true then
		L[k] = k
	end
end
