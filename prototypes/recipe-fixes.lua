local util = require("data-util")

-- replace steam engine with burner turbine since we moved steam engine down the tech tree
util.remove_ingredient( data.raw["recipe"]["flora-collector-mk01"], "steam-engine")
replace_ingredient( data.raw["recipe"]["distilator"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["hpf"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["wpu-mk01"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["washer"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["jaw-crusher"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["fluid-drill-mk01"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["glassworks-mk01"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["moss-farm-mk01"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["fwf-mk01"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["fwf-mk01-with-furnace"], "steam-engine", "burner-turbine")
replace_ingredient( data.raw["recipe"]["solid-separator"], "steam-engine", "burner-turbine")

--make aai storage work with py since we removed py storages
for _, recipe in pairs(data.raw.recipe) do
  -- Normal difficulty
  replace_ingredient(recipe, "py-shed-basic", "aai-strongbox")
  replace_ingredient(recipe, "py-storehouse-basic", "aai-storehouse")
  replace_ingredient(recipe, "py-warehouse-basic", "aai-warehouse")
  replace_ingredient(recipe, "py-deposit-basic", "aai-warehouse")
  replace_ingredient(recipe, "py-warehouse-buffer", "aai-warehouse-buffer")
end


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
for _, logistic in ipairs(logistics) do
  for _, storage_name in ipairs(py_storages) do
	if data.raw.recipe["py-" .. storage_name .. logistic] ~= nil then
		data.raw.recipe["py-" .. storage_name .. logistic] = nil
	end
	if data.raw["logistic-container"]["aai-" .. storage_name .. logistic] ~= nil then
		if storage_name == "strongbox-" then
			data.raw["logistic-container"]["aai-" .. storage_name .. logistic].inventory_size = 40
		end
		if storage_name == "storehouse-" then
			data.raw["logistic-container"]["aai-" .. storage_name .. logistic].inventory_size = 80
		end
		if storage_name == "warehouse-" then
			data.raw["logistic-container"]["aai-" .. storage_name .. logistic].inventory_size = 120
		end
	end
  end
end
table.insert(data.raw.recipe["aai-strongbox"].ingredients, {type = "item", name = "wooden-chest", amount = 10})
table.insert(data.raw.recipe["aai-strongbox"].ingredients, {type = "item", name = "iron-plate", amount = 10})
table.insert(data.raw.recipe["aai-strongbox-active-provider"].ingredients, {type = "item", name = "iron-plate", amount = 10})
table.insert(data.raw.recipe["aai-storehouse"].ingredients, {type = "item", name = "wooden-chest", amount = 80})
table.insert(data.raw.recipe["aai-storehouse"].ingredients, {type = "item", name = "iron-plate", amount = 20})
table.insert(data.raw.recipe["aai-storehouse-passive-provider"].ingredients, {type = "item", name = "iron-plate", amount = 20})
table.insert(data.raw.recipe["aai-warehouse"].ingredients, {type = "item", name = "wooden-chest", amount = 30})
table.insert(data.raw.recipe["aai-warehouse"].ingredients, {type = "item", name = "iron-plate", amount = 200})
table.insert(data.raw.recipe["aai-warehouse-buffer"].ingredients, {type = "item", name = "iron-plate", amount = 30})