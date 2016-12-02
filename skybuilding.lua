-- Create the sky buldings, check for them

function littlebig:setSkyStructureAt(skypos)
	-- load a vmanip for the coords
	-- load a sky structure schematic into the vmanip
end

function littlebig:getSkyBoundsFor(landx,landz)
	local bounds = littlebig:derive_blockbounds(landx,landz)
	local base_altitude = littlebig:derive_altitude(lanxd,landz)

	bounds.pos1.y = base_altitude
	bounds.pos2.y = pase_altitude

	return bounds
end

function littlebig:getSkyStructureFor(landx, landz)
	-- get the sky structure info, given the land coordinates
	local bounds = littlebig:getSkyBoundsFor(landx,landz)
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

function littlebig:checkOwnerAt(pos,owner)
	local tellermeta = minetest.get_meta(pos)
	local knownowner = tellermeta.get_string("owner")
	if knownowner and knownowner ~= owner then
		return false
	end
	return true
end

function littlebig:setOwnerAt(pos,owner)
	local tellermeta = minetest.get_meta(pos)
	local knownowner = tellermeta.get_string("owner")
	if not littlebig:checkOwnerAt(pos,owner) then
		return false
	end

	tellermeta.set_string("owner",owner)
	return true
end


function littlebig:setSkyStructureFor(landx, landz, owner)
	local bounds = littlebig:getSkyBoundsFor(landx,landz)
	if not bounds then
		minetest.log("error","Could not get bounds (%s , %s)":format(landx,landz))
		return
	end

	-- check owner
	if not littlebig:checkOwnerAt(bounds.pos1,owner) then
		minetest.chat_send_player(owner,"ABORT - your pocket dimension interfere's iwth that of "..knownowner)
		return false
	end

	-- TODO -- load schematic
	littlebig:setSkyStructureAt(bounds.pos1) -- takes care of file opening etc

	if not littlebig:setOwnerAt(bounds.pos1,owner) then
		minetest.chat_send_player(owner,"Could not set owner !")
		minetest.log("error","Could not set owner for "..owner.." at "..minetest.pos_to_string(bounds.pos1) )
		minetest.log("error",dump(littlebig:getSkyStructureFor(bounds.pos1) ))
		return false
	end
	return true
end

function littlebig:getSkyStructureAt(skypos)
	-- given a sky position, find the relevant info node
	-- return the sky structure info
end
