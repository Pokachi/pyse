local util = require("data-util")

--remove processed-chemical from all but burner generator, car, spider-vehicle, and locomotive
if data.raw["fuel-category"]["processed-chemical"] then
  -- add fuel category to burner types
  for _, type in pairs({"assembling-machine", "beacon", "boiler", "furnace", "inserter", "lab", "mining-drill", "reactor", "generator-equipment"}) do
    for _, proto in pairs(data.raw[type]) do
      if proto.name ~= "fuel-processor" then
        for _, burner_slot in pairs({"burner", "energy_source"}) do
          if proto[burner_slot] then
            local burner = proto[burner_slot]
            --if not burner.fuel_categories then
            --  burner.fuel_categories = {"chemical"}
            --end
            if burner.fuel_categories then
              for i = #burner.fuel_categories, 1, -1 do
				if burner.fuel_categories[i] == "processed-chemical" then
				  table.remove(burner.fuel_categories, i)
				end
			  end
            end
          end
        end
      end
    end
  end
end

--remove py storages
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
		if data.raw.item["py-" .. storage_name .. logistic] ~= nil then
			data.raw.item["py-" .. storage_name .. logistic] = nil
		end
	end
end