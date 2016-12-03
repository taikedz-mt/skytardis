# Sky TARDIS (Little Big House)

As [requested by Kosmos](https://forum.minetest.net/viewtopic.php?f=47&t=15722)

An implementation fo a TARDIS-like mod, using structures in the sky as bigger inner places.

On land, structures can be built to access a pocket dimension - you can't ubild too close to someone else's space, otherwise pocket dimensions will overlap!

## Progress

Currently mapping the coords of a land structure have been coded - they can be tested by running `lua test.lua` if you have a lua interpreter

On Linux, `apt-get install lua` or `yum install lua` should do the trick.

The nodes are preliminary and probably will change massively

Next to do is the skybuilding API

The expectation is to create a schem, and load it at the sky position (which is the lowest south-westerly point of the building)
