skytardis = {}
skytardis.base_altitude = minetest.setting_get("skytardis.base_altitude") or 100 -- should default to 31000 out of tests

local path = minetest.get_modpath("skytardis")
--dofile(path.."/abm.lua")
--dofile(path.."/protection.lua")
dofile(path.."/skybuilding.lua")
dofile(path.."/coordmapping.lua")
dofile(path.."/nodes.lua")
