# Work in progress PY + SE Compatibility mod


This mod requires some editing in SE's mod to work
- remove py blacklist in SE's info.json

I also recommend removing the following code in SE
- in space-exploration\prototypes\phase-3\resources.lua, change line 9 to `if string.starts(resource.name, data_util.mod_prefix) then` to prevent SE from interfering with PY resources
- in space-exploration-postprocess\prototypes\phase-4\sanity.lua, comment out the block that make sure there are no impossible energy loops