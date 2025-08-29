include("autorun/sh_ttt_weapon_rarity.lua")

ENT.Type = "point"
ENT.Base = "base_point"

ENT.autoAmmoAmount = 0

function ENT:KeyValue(key, value)
    if key == "auto_ammo" then
        self.autoAmmoAmount = tonumber(value)
    end
end

function ENT:Initialize()
	-- pick a random one from the table/list idk what it is yet
	local w = WEAPONS.GetRandomWeaponBasedOnRarity()
	print(w)
	
	-- le epic debug
	if w == nil then return end
	
	-- create that weapon entity
	local ent = ents.Create(w)
	if IsValid(ent) then
		-- spawn the weapon in the world
		local pos = self:GetPos()
		ent:SetPos(pos)
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:PhysWake()

		-- if it has ammo boxes enabled
		if ent.AmmoEnt and self.autoAmmoAmount > 0 then
			for i = 1, self.autoAmmoAmount do
				local ammo = ents.Create(ent.AmmoEnt)
				if IsValid(ammo) then
					pos.z = pos.z + 3
					ammo:SetPos(pos)
					ammo:SetAngles(VectorRand():Angle())
					ammo:Spawn()
					ammo:PhysWake()
				end
			end
		end
	end

	-- remove the spawn entity because its done doing things
	self:Remove()
end
