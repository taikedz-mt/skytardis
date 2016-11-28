-- Create the sky buldings, check for them

function littlebig:setSkyStructureAt(skypos)
	-- load a vmanip for the coords
	-- load a sky structure schematic into the vmanip
end

function littlebig:getSkyStructureFor(landx, landz)
	-- get the sky structure info, given the land coordinates
	-- returns a table {owner,pos} identifying the owner of the structure and the position of the door
	-- or nil if nothing appropriate was found
end

function littlebig:setSkyStructureFor(landx, landz, owner)
	-- derive the coordinates of the sky structure
	-- create a sky structure
	-- the owner of the structure will be set

	-- if a structure owned by someone else already exists, return false
	-- else return sky structure information
	-- if there was an error return nil
end

function littlebig:getSkyStructureAt(skypos)
	-- given a sky position, find the relevant info node
	-- return the sky structure info
end
