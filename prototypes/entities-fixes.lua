local util = require("data-util")

local entity = function(name, s)
  local source = s or "assembling-machine"
  return data.raw[source][name]
end

if entity("burner-lab", "lab") then
	entity("burner-lab", "lab").fast_replaceable_group = nil
	entity("burner-lab", "lab").next_upgrade = nil
end



data.raw.reactor["py-burner"]["energy_source"].effectivity = 5


local logistics = {
  "active-provider",
  "buffer",
  "passive-provider",
  "requester",
  "storage",
  "basic"
}
local py_storages = {
  "shed-",
  "strongbox-",
  "storehouse-",
  "warehouse-",
  "deposit-"
}
-- remove py storages
for _, logistic in ipairs(logistics) do
	for _, storage_name in ipairs(py_storages) do
		if data.raw.container["py-" .. storage_name .. logistic] ~= nil then
			data.raw.container["py-" .. storage_name .. logistic] = nil
		end
		if data.raw["logistic-container"]["py-" .. storage_name .. logistic] ~= nil then
			data.raw["logistic-container"]["py-" .. storage_name .. logistic] = nil
		end
	end
end

--misc updates
data.raw["ammo-turret"]["se-meteor-point-defence-container"].additional_pastable_entities = {
  "buffer-chest",
  "requester-chest",
  "aai-strongbox-buffer",
  "aai-strongbox-requester",
  "aai-storehouse-buffer",
  "aai-storehouse-requester",
  "aai-warehouse-buffer",
  "aai-warehouse-requester",
}

data.raw["ammo-turret"]["se-meteor-defence-container"].additional_pastable_entities = {
  "buffer-chest",
  "requester-chest",
  "aai-strongbox-buffer",
  "aai-strongbox-requester",
  "aai-storehouse-buffer",
  "aai-storehouse-requester",
  "aai-warehouse-buffer",
  "aai-warehouse-requester",
}

if mods["aai-vehicles-miner"] then
	data.raw["car"]["vehicle-miner"].inventory_size = 5;
	data.raw["car"]["vehicle-miner-0"].inventory_size = 5;
	data.raw["car"]["vehicle-miner-0-_-solid"].inventory_size = 5;
	data.raw["car"]["vehicle-miner-0-_-ghost"].inventory_size = 5;
end