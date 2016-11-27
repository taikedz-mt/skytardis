minetest.register_node("littlebig:tardisglass",{
	tiles = {"default_glass.png^[colorize:blue:90"},
	walkable = false, -- maybe only when tardiswood is below it?
	groups = {choppy = 1, cracky = 2},
	--drawtype = "glasslike",
})

minetest.register_node("littlebig:tardiswood",{
	tiles = {"default_tree.png^[colorize:blue:90"},
	walkable = false, -- maybe only when tardisglass is above it?
	groups = {choppy = 2, cracky = 1},
	--drawtype = "glasslike",
})

minetest.register_node("littlebig:tardisstone",{
	tiles = {"default_obsidian.png^[colorize:blue:90"},
	groups = {unbreakable = 1}
})
