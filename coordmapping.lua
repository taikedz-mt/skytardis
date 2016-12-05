-- Map x,z coords to y coord
-- Map x,z point coords to { (x1,z1) , (x2,z2) } bounds

local mathround = function(x)
	local fx = math.floor(x)
	local part = x-fx
	if part < 0.5 then
		return fx
	end
	return fx+1
end

function skytardis:derive_blockbounds(x,z)
	-- returns bounds x1,z1 / x2,z2 for a given point
	local w = 32 -- width of the blockspace, in nodes

	local x1 = x - x % w
	local z1 = z - z % w

	local x2 = x1 + w
	local z2 = z1 + w

	if x < 0 then
		x1 = x1 - 1
		x2 = x2 - 1
	end

	if z < 0 then
		z1 = z1 - 1
		z2 = z2 - 1
	end

	return {
		pos1 = {x=x1,z=z1},
		pos2 = {x=x2,z=z2}
	}
end

function skytardis:derive_altitude(x,z)
	-- returns an altitude which will be added to 31000 as the position of the skystructure
	-- no two returned altitiudes can be within a value of 64 from eachother

	-- sky strcutre should be 32 * 64 * 32 nodes
	-- and is expected to fit from y = {31000 .. 32500}

	x = math.abs(x)
	z = math.abs(z)

	local skyb_h = 64 -- sky building height
	local skyb_w = 32 -- sky building width
	local skysp = 1500 -- sky space available veritcally
	local landnode_max = math.floor( math.sqrt( ( skysp - skysp % skyb_h)/skyb_h ) )
	local landn_c = skyb_w / landnode_max -- land node count

	local xfactor = ( x - x % landn_c ) / landn_c
	local zfactor = landnode_max * ( z - z % landn_c ) / landn_c

	--[[
	minetest.debug("xf "..xfactor .. " / zf "..zfactor
		.. " / landnode_max "..landnode_max
		.. " / landn_c "..landn_c
	)
	--]]

	local yalt = ( xfactor + zfactor ) * 64

	return yalt
end

function skytardis:getBoundsAt(skypos)
	-- get sky structure boundaries given a sky position
	local bounds = skytardis:derive_blockbounds(skypos.x, skypos.z)
	local ty = skypos.y - skytardis.base_altitude

	bounds.pos1.y = ty - (ty % 64)
	bounds.pos2.y = bounds.pos1.y + 64

	return bounds
end
