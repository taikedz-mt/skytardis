-- Land building nodes

-- When placing, check the sky strycture - if already present and owned by someone else, allow placing but don't activate
-- Associate a block with its target coordinates othrwise. Once activated, placing anywhere else will lead you there.

minetest.register_node("skytardis:tardisglass",{ -- non-craftable, non-obtainable
	tiles = {"default_glass.png^[colorize:blue:90"},
	groups = {not_in_creative_inventory = 1},
	paramtype = "light",
	light_source = 5,
})

minetest.register_node("skytardis:tardiswood",{
	tiles = {"default_tree.png^[colorize:blue:90"},
	groups = {choppy = 2, cracky = 1},
	stack_max = 1,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local posplus = { x = pos.x, y = pos.y + 1, z = pos.z }
		if minetest.is_protected(posplus,placer) then
			return
		end

		minetest.set_node(posplus, {name = "skytardis:tardisglass"})

		-- need to associate the sky place with this block, as part of inventory,
		-- before trying to create a new sky realm

		local metaraw = minetest.deserialize( itemstack:get_metadata() )
		if not metaraw then
			skytardis:setSkyStructureFor(pos.x, pos.z, placer:get_player_name() )

			metaraw = skytardis:getSkyStructureFor(pos.x, pos.z)

			itemstack:set_metadata( minetest.serialize( metaraw ) )
		end

		local nodemeta = minetest:get_meta(pos)
		nodemeta:set_string("owner",metaraw.owner) -- FIXME actually, use it for the hud display of who's it is
		nodemeta:set_string("pos",minetest.serialize(metaraw.pos) )
	end,
	after_dig_node = function(pos,node,meta,digger)
		local posplus = { x = pos.x, y = pos.y + 1, z = pos.z }
		if minetest.is_protected(posplus,placer) then
			return
		end

		minetest.set_node(posplus, {name = "air"})
	end,
})

-- Sky building nodes

minetest.register_node("skytardis:tardispane",{
	tiles = {"default_glass.png^[colorize:blue:90"},
	groups = {unbreakble=1},
	light_propagates = true,
	sunlight_propagates = true,
	--drawtype = "connectedglass", -- FIXME connected glass property, check
})

minetest.register_node("skytardis:tardisstone",{
	tiles = {"default_obsidian.png^[colorize:blue:90"},
	groups = {unbreakable = 1},
	light_propagates = true,
	sunlight_propagates = true,
})

