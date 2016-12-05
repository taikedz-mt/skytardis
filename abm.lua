-- Going up

minetest.register_abm({
	nodenames = {"skytardis:tardiswood"},
	interval = 1,
	chance = 1,
	action = function(pos)
		-- check for player 1 node away
		for obj in pairs( minetest.get_objects_inside_radius(pos,1) ) do
			if obj:is_player() then
				local playername = obj:get_player_name()
				local bounds = skytardis:getSkyBoundsFor(pos.x,pos.z)
				if skytardis:checkOwnerAt(bounds.pos1,playername) then
					-- if player is owner, transport
					obj:moveto(skytardis:getSkyStructureFor(pos.x,pos.z) )
				end
				-- TODO add system to have guests.... rely on nearby protector to provide this info?
			end
		end
	end
})
