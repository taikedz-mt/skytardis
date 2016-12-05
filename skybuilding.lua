-- Create the sky buldings, check for them

function skytardis:checkOwnerAt(pos,owner)
	local tellermeta = minetest.get_meta(pos)
	local knownowner = tellermeta:get_string("owner")
	if knownowner ~= "" and knownowner ~= owner then
		return false
	end
	return true
end

function skytardis:setOwnerAt(pos,owner)
	local tellermeta = minetest.get_meta(pos)
	local knownowner = tellermeta:get_string("owner")
	if not skytardis:checkOwnerAt(pos,owner) then
		return false
	end

	tellermeta:set_string("owner",owner)
	return true
end

--------------------------------------------- getting

function skytardis:getSkyBoundsFor(landx,landz)
	local bounds = skytardis:derive_blockbounds(landx,landz)
	local base_altitude = 100 -- in prod, should be 31000
	local increment = skytardis:derive_altitude(landx,landz)

	bounds.pos1.y = base_altitude + increment
	bounds.pos2.y = base_altitude + increment

	return bounds
end

function skytardis:getSkyStructureFor(landx, landz)
	-- get the sky structure info, given the land coordinates
	local bounds = skytardis:getSkyBoundsFor(landx,landz)
	local tellermeta = minetest.get_meta(bounds.pos1)
	local owner = tellermeta:get_string("owner")
	-- returns a table {owner,pos} identifying the owner of the structure and the position of the door
	if owner then
		return {
			owner = owner,
			pos = math.floor( ( bounds.pos1.x + bounds.pos2.x ) / 2),
		}
	end

	-- or nil if nothing appropriate was found
end

----------------------------------------------------- setting

function skytardis:setSkyStructureAt(skypos)
	-- TODO -- load schematic
	-- load a vmanip for the coords
	-- load a sky structure schematic into the vmanip

	-- floor
	for tx=0,31 do
		for ty=0,63 do
			for tz=0,31 do
				local tpos = {x=skypos.x + tx, y=skypos.y, z=skypos.z + tz}
				if ty % 64 == 0 -- ceiling and floor
				 or tx == tz then -- walls
					minetest.set_node(tpos,{name="skytardis:tardisstone"})
					minetest.debug("Node set at "..minetest.pos_to_string(tpos) )
				end
			end
		end
	end
end

function skytardis:setSkyStructureFor(landx, landz, owner)
	local bounds = skytardis:getSkyBoundsFor(landx,landz)
	if not bounds then
		minetest.log("error",("Could not get bounds (%s , %s)"):format(landx,landz))
		return
	end

	-- check owner
	if not skytardis:checkOwnerAt(bounds.pos1,owner) then
		local knownowner = "" -- TODO get this info
		minetest.chat_send_player(owner,"ABORT - your pocket dimension interferes with that of "..knownowner )
		return false
	end

	if not skytardis:setSkyStructureAt(bounds.pos1) then
		minetest.chat_send_player(owner,"Could not create sky structure")
		minetest.log("error","Could not set sky structure at "..minetest.pos_to_string(bounds.pos1).." for "..owner)
	end

	if not skytardis:setOwnerAt(bounds.pos1,owner) then
		minetest.chat_send_player(owner,"Could not set owner !")
		minetest.log("error","Could not set owner for "..owner.." at "..minetest.pos_to_string(bounds.pos1) )
		minetest.log("error",dump(skytardis:getSkyStructureFor(bounds.pos1) ))
		return false
	end
	return true
end
