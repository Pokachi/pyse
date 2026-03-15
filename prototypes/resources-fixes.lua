local util = require("data-util")

data.raw.resource["coal"].autoplace = nil
data.raw["autoplace-control"]["coal"] = nil
data.raw.resource["crude-oil"].autoplace = nil
data.raw["autoplace-control"]["crude-oil"] = nil

local icons = {"__pyraworesgraphics__/graphics/icons/iron-plate.png",
	"__pyraworesgraphics__/graphics/icons/copper-plate.png",
	"__pycoalprocessinggraphics__/graphics/icons/sand.png"}
	
for _, icon in pairs(icons) do
	for _, type_table in pairs({
	  data.raw.item,
	  data.raw.recipe,
	  data.raw.projectile
	}) do
		util.fix_icon_size(type_table, icon)
	end
end