if SERVER then
    AddCSLuaFile()
end

WEAPONS = WEAPONS or {}

-- gather all the weapons
local listOfAllWeapons = weapons.GetList()

-- Initialize rarity table
local rarityTable = {
    common = {},
    uncommon = {},
    rare = {}
}

-- when the game starts, we sort the weapons into tables
hook.Add("Initialize", "PopulateWeaponRarityTable", function()
	print("PopulateWeaponRarityTable has ran!")
	for _, weapon in ipairs(listOfAllWeapons) do
		-- if weapon has no rarity, dont include it
		if weapon.Rarity then
			if weapon.Rarity == "common" then
				table.insert(rarityTable.common, weapon.ClassName)
			elseif weapon.Rarity == "uncommon" then
				table.insert(rarityTable.uncommon, weapon.ClassName)
			elseif weapon.Rarity == "rare" then
				table.insert(rarityTable.rare, weapon.ClassName)
			end
		end
	end
end)

-- function to get a random weapon with rarity
function WEAPONS.GetRandomWeaponBasedOnRarity()
	print("WEAPONS.GetRandomWeaponBasedOnRarity() ran!")
    local raritySelection = math.random()

    local selectedCategory
    if raritySelection < 0.6 then
        selectedCategory = "common"
    elseif raritySelection < 0.9 then
        selectedCategory = "uncommon"
    else
        selectedCategory = "rare"
    end

    -- select a random weapon from the winning category
    local weaponList = rarityTable[selectedCategory]
    if weaponList and #weaponList > 0 then
        local weaponToSpawn = weaponList[math.random(#weaponList)]
        return weaponToSpawn
	else
		return nil
    end
end