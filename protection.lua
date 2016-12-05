-- Register protection of the sky building
-- only the owner can have protection, allowing them to modify the sky tardis area
-- maybe have a TARDIS Key item which allows another player to interact

local oldprotect = minetest.is_protected

local tardisprotect = function(pos,owner) -- owner is string?
	local bounds = skytardis:getBoundsAt(pos)
	if skytardis:checkOwner(bounds.pos1,owner) then
		return true
	end

	-- pass it on
	return oldprotect(pos,owner)
end

minetest.is_protected = tardisprotect
