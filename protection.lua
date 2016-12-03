-- Register protection of the sky building
-- only the owner can have protection
-- maybe have a TARDIS Key item which allows another player to interact

local oldprotect = minetest.is_protected

function tardisprotect = function(pos,owner)
	local tardisbounds = skytardis.getBoundsAt(pos)

	-- pass it on
	return oldprotect(pos,owner)
end

minetest.is_protected = tardisprotect
