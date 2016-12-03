skytardis = {}
minetest = {}

function minetest.debug(arg)
	print(arg)
end

function dump(arg,indent)
	if indent == nil then indent = "" end
	local plusdent = indent .. "  "
	local dstring = ""

	if type(arg) == "table" then
		dstring = dstring.. indent.."{" .."\n"
		for k,v in pairs(arg) do
			if type(v) == "table" then
				dstring = dstring.. indent.. tostring(k).." -> "..tostring(dump(v,plusdent)) .."\n"
			else
				dstring = dstring.. indent.. tostring(k).." -> "..tostring(v) .."\n"
			end
		end
		 dstring = dstring.. indent.."}" .."\n"
	else
		dstring = dstring.. tostring(arg) .."\n"
	end
	return dstring
end

dofile("coordmapping.lua")

function giveme(x,z)
local y = skytardis.derive_altitude(x,z)
local bounds = skytardis.derive_blockbounds(x,z)
print("For "..tostring(x)..","..tostring(z).." we go to:\t"..tostring(y) .. " -> "..tostring(y+64).." / "..dump(bounds))
end

local testspots = {
	{0,0},
	{1,1},
	{-1,1},
	{1,-1},
	{-1,-1,},
	{-2,-2},
	{15,15},
	{15,16},
	{-27,48},
--	{,},
}

for _,v in pairs(testspots) do
	giveme(v[1],v[2])
end
