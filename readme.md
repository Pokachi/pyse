# Work in progress PY + SE Compatibility mod


This mod requires some editing in SE's mod to work
- remove py blacklist in SE's info.json
- in `space-exploration\prototypes\phase-1\recipe\rocket-landing-pad.lua` and `space-exploration\prototypes\phase-1\recipe\rocket-landing-pad.lua` move `always_show_made_in = true,` inside the recipe block (this is a bug in SE that I've reported, might be fixed in future)
- in `space-exploration\prototypes\phase-2\core-fragments.lua` change `if table_size(products) > 0 then` to `if products ~= nil and table_size(products) > 0 then` at line 73
- in `space-exploration\scripts\universe.lua` change `Universe.default_resource_order` to `Universe.default_resource_order = {
  "iron-ore", "copper-ore", "uranium-ore",  "stone",
  mod_prefix.."vulcanite", mod_prefix.."cryonite", mod_prefix.."vitamelange",
  mod_prefix.."naquium-ore", mod_prefix.."methane-ice", mod_prefix.."water-ice",
  mod_prefix.."beryllium-ore", mod_prefix.."iridium-ore", mod_prefix.."holmium-ore"
}`

I also recommend removing the following code in SE
- in `space-exploration\prototypes\phase-3\resources.lua`, change line 9 to `if string.starts(resource.name, data_util.mod_prefix) then` to prevent SE from interfering with PY resources
- in `space-exploration-postprocess\prototypes\phase-4\sanity.lua`, comment out the block that make sure there are no impossible energy loops
