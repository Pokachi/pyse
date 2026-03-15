local util = require("data-util")

-- Use py glass instead of se glass
for _, tech in pairs(data.raw.technology) do
    if tech.prerequisites then
        for i, prereq in pairs(tech.prerequisites) do
            if prereq == "glass-processing" then
                tech.prerequisites[i] = "glass"
            end
        end
    end
end

data.raw.technology["glass-processing"] = nil

-- Put Underground belt under basic logistic
if data.raw.technology["basic-logistics"] then
	util.tech_lock_recipes("basic-logistics", {"underground-belt"})
	data.raw.technology["logistics"].prerequisites = { "basic-logistics", "alloys-mk01" }
end

-- Explicitly enable pipe recipe because py hard mode need water for copper
if mods["pyhardmode"] then
	util.enable_recipe("pipe")
end

-- remove electric lab from automation science pack because SE moved electric lab to a separate unlock
if data.raw.technology["burner-mechanics"] then
	local tech = data.raw.technology["automation-science-pack"]
	for i = #tech.effects, 1, -1 do
		local effect = tech.effects[i]

		if effect.type == "unlock-recipe" and (effect.recipe == "lab" or effect.recipe == "iron-stick")then
			table.remove(tech.effects, i)
		end
	end
end

-- remove medium electric pole because SE moved medium electric pole to a separate unlock
if data.raw.technology["medium-electric-pole"] then
	local tech = data.raw.technology["electric-energy-distribution-1"]
	for i = #tech.effects, 1, -1 do
		local effect = tech.effects[i]

		if effect.type == "unlock-recipe" and (effect.recipe == "medium-electric-pole" or effect.recipe == "po-medium-electric-fuse")then
			table.remove(tech.effects, i)
		end
	end
end

-- fixing some dependencies
if data.raw.technology["position-beacon"] then
	data.raw.technology["position-beacon"].prerequisites = { "automation-science-pack" }
end
if data.raw.technology["se-medpack"] then
	data.raw.technology["se-medpack"].prerequisites = { "automation-science-pack" }
end
if data.raw.technology["qol-crafting-speed-1-1"] then
	data.raw.technology["qol-crafting-speed-1-1"].prerequisites = { "automation-science-pack" }
end
if data.raw.technology["qol-inventory-size-1-1"] then
	data.raw.technology["qol-inventory-size-1-1"].prerequisites = { "automation-science-pack" }
end
if data.raw.technology["qol-mining-speed-1-1"] then
	data.raw.technology["qol-mining-speed-1-1"].prerequisites = { "automation-science-pack" }
end
if data.raw.technology["qol-movement-speed-1-1"] then
	data.raw.technology["qol-movement-speed-1-1"].prerequisites = { "automation-science-pack" }
end
if data.raw.technology["qol-player-reach-1-1"] then
	data.raw.technology["qol-player-reach-1-1"].prerequisites = { "automation-science-pack" }
end

if data.raw.technology["se-rocket-launch-pad"] then
	data.raw.technology["se-rocket-launch-pad"].visible_when_disabled = false
end
if data.raw.technology["se-space-capsule-navigation"] then
	data.raw.technology["se-space-capsule-navigation"].visible_when_disabled = false
end


-- Remove inserter unlock from electricity because py have separate unlocks for them
if data.raw.technology["electricity"] then
	local tech = data.raw.technology["electricity"]
	for i = #tech.effects, 1, -1 do
		local effect = tech.effects[i]

		if effect.type == "unlock-recipe" and (effect.recipe == "inserter" or effect.recipe == "copper-cable")then
			table.remove(tech.effects, i)
		end
	end
end

-- need inductor before steam research now
util.tech_lock_recipes("automation-science-pack", {"inductor1-2"})


-- tiny storage compat
if mods["est-tiny-storage-tank"] then
	util.tech_lock_recipes("basic-fluid-handling", {"tiny-4way-storage-tank", "tiny-inline-storage-tank"})
end

-- move burner assembly mk01 a bit further down so we have more incentive to use se assembling machine
data.raw.item["burner-assembling-machine"].localised_name = {"", "Burner assembling machine prototype"}
data.raw["assembling-machine"]["burner-assembling-machine"].localised_name = {"", "Burner assembling machine prototype"}
data.raw["assembling-machine"]["burner-assembling-machine"]["energy_source"].fuel_categories = {"chemical", "biomass"}
data.raw.recipe["burner-assembling-machine"].localised_name = {"", "Burner assembling machine prototype"}
data.raw.technology["automation"].prerequisites = { "basic-fluid-handling" }
data.raw.technology["automation-science-pack"].prerequisites = { "burner-mechanics" }
data.raw.technology["moss-mk01"].prerequisites = { "botany-mk01" }
if mods["Nanobots2"] then
	data.raw.technology["nanobots"].prerequisites = { "electricity" }
end

table.insert(data.raw.technology["burner-mechanics"].effects, {type = "mining-with-fluid", modifier=true})
table.insert(data.raw.technology["burner-mechanics"].effects, {type = "unlock-circuit-network", modifier=true})

--other techs
if mods["textplates"] then
	util.tech_add_prerequisites("textplates-concrete", {"logistic-science-pack"})
end
util.tech_add_prerequisites("se-pulveriser", {"logistic-science-pack"})

--remove  some unnecessary unlocks from steam power and make it a standard science instead of trigger based
local steam_power = data.raw.technology["steam-power"]
for i = #steam_power.effects, 1, -1 do
	local effect = steam_power.effects[i]

	if (effect.type == "unlock-recipe" and (effect.recipe == "small-electric-pole" or effect.recipe == "po-small-electric-fuse")) or effect.type == "mining-with-fluid" or effect.type == "unlock-circuit-network" then
		table.remove(steam_power.effects, i)
	end
end
steam_power.research_trigger = nil
steam_power.unit = {
	count = 20,
	ingredients = {
		{"automation-science-pack", 1},
	},
	time = 10
}
steam_power.ignore_tech_cost_multiplier = true

--update tech cost multiplier for multiplier run
data.raw.technology["engine"].ignore_tech_cost_multiplier = false
data.raw.technology["automation"].ignore_tech_cost_multiplier = false
data.raw.technology["concrete"].ignore_tech_cost_multiplier = false
data.raw.technology["tar-processing"].ignore_tech_cost_multiplier = false
data.raw.technology["fuel-processing"].ignore_tech_cost_multiplier = true
data.raw.technology["electricity"].ignore_tech_cost_multiplier = true
data.raw.technology["basic-fluid-handling"].ignore_tech_cost_multiplier = true
util.tech_add_prerequisites("steam-power", {"automation-science-pack"})
util.tech_add_prerequisites("coal-processing-1", {"steam-power"})
util.tech_lock_recipes("fluid-pressurization", {"steam-engine"})
util.tech_lock_recipes("fuel-processing", {"iron-chest"})


-- use aai storages instead of py storages
util.tech_add_prerequisites("aai-strongbox-logistic", {"chemical-science-pack"})
util.tech_add_prerequisites("aai-strongbox-storage", {"py-science-pack-2"})
data.raw.technology["aai-warehouse-logistic"].unit = {
	count = 1300,
	ingredients = {
		{"automation-science-pack", 10},
		{"py-science-pack-1", 6},
		{"logistic-science-pack", 3},
		{"py-science-pack-2", 2},
		{"chemical-science-pack", 1},
	},
	time = 120
}
data.raw.technology["aai-strongbox-logistic"].unit = {
	count = 800,
	ingredients = {
		{"automation-science-pack", 10},
		{"py-science-pack-1", 6},
		{"logistic-science-pack", 3},
		{"py-science-pack-2", 2},
		{"chemical-science-pack", 1},
	},
	time = 120
}
data.raw.technology["aai-storehouse-logistic"].unit = {
	count = 1000,
	ingredients = {
		{"automation-science-pack", 10},
		{"py-science-pack-1", 6},
		{"logistic-science-pack", 3},
		{"py-science-pack-2", 2},
		{"chemical-science-pack", 1},
	},
	time = 120
}
data.raw.technology["aai-warehouse-storage"].unit = {
	count = 1000,
	ingredients = {
		{"automation-science-pack", 6},
		{"py-science-pack-1", 3},
		{"logistic-science-pack", 2},
		{"py-science-pack-2", 1}
	},
	time = 90
}
data.raw.technology["aai-storehouse-storage"].unit = {
	count = 900,
	ingredients = {
		{"automation-science-pack", 6},
		{"py-science-pack-1", 3},
		{"logistic-science-pack", 2},
		{"py-science-pack-2", 1}
	},
	time = 90
}
data.raw.technology["aai-strongbox-storage"].unit = {
	count = 800,
	ingredients = {
		{"automation-science-pack", 6},
		{"py-science-pack-1", 3},
		{"logistic-science-pack", 2},
		{"py-science-pack-2", 1}
	},
	time = 90
}
for _, tech in pairs(data.raw.technology) do
    if tech.prerequisites then
        for i, prereq in pairs(tech.prerequisites) do
            if prereq == "py-warehouse-research" then
                tech.prerequisites[i] = "aai-warehouse-base"
            end
            if prereq == "py-warehouse-logistics-research" then
                tech.prerequisites[i] = "aai-warehouse-logistic"
            end
        end
    end
end
data.raw.technology["py-warehouse-research"] = nil
data.raw.technology["py-warehouse-logistics-research"] = nil