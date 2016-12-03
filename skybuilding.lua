-- Create the sky buldings, check for them

function skytardis:checkOwnerAt(pos,owner)
	local tellermeta = minetest.get_meta(pos)
	local knownowner = tellermeta.get_string("owner")
	if knownowner and knownowner ~= owner then
		return false
	end
	return true
end

function skytardis:setOwnerAt(pos,owner)
	local tellermeta = minetest.get_meta(pos)
	local knownowner = tellermeta.get_string("owner")
	if not skytardis:checkOwnerAt(pos,owner) then
		return false
	end

	tellermeta.set_string("owner",owner)
	return true
end

--------------------------------------------- getting

function skytardis:getSkyBoundsFor(landx,landz)
	local bounds = skytardis:derive_blockbounds(landx,landz)
	local base_altitude = skytardis:derive_altitude(lanxd,landz)

	bounds.pos1.y = base_altitude
	bounds.pos2.y = pase_altitude

	return bounds
end

function skytardis:getSkyStructureFor(landx, landz)
	-- get the sky structure info, given the land coordinates
	local bounds = skytardis:getSkyBoundsFor(landx,landz)
	local tellermeta = minetest.get_meta(bounds.pos1)
	local owner = tellermeta.get_string("owner")
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
end

function skytardis:setSkyStructureFor(landx, landz, owner)
	local bounds = skytardis:getSkyBoundsFor(landx,landz)
	if not bounds then
		minetest.log("error","Could not get bounds (%s , %s)":format(landx,landz))
		return
	end

	-- check owner
	if not skytardis:checkOwnerAt(bounds.pos1,owner) then
		minetest.chat_send_player(owner,"ABORT - your pocket dimension interferes with that of "..knownowner)
		return false
	end

	if skytardis:setSkyStructureAt(bounds.pos1) then -- takes care of file opening etc
		minetest.chat_send_player(owner,"Could not create sky structure")
		minetest.log("error","Could not set sky structure at "..minetest.pos_to_string(nounds.pos1).." for "..owner)
	end

	if not skytardis:setOwnerAt(bounds.pos1,owner) then
		minetest.chat_send_player(owner,"Could not set owner !")
		minetest.log("error","Could not set owner for "..owner.." at "..minetest.pos_to_string(bounds.pos1) )
		minetest.log("error",dump(skytardis:getSkyStructureFor(bounds.pos1) ))
		return false
	end
	return true
end
