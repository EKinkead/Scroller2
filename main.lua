
require ("loq_util")

display.setStatusBar( display.HiddenStatusBar ) -- Get rid of that thing
display.setDefault ("magTextureFilter", "nearest") -- make it nice and pixeled

-- Test = display.newImage( "images/img_Backdrop2.png")

-- Some kind of map thing
--foot = display.newImage("mapTile1.png", 100, 100)

-- Set up the map. Best to NOT do this with hardcoded Numbers, so you can make minimaps, etc.


myTable = require(".images.TileMaps.16x16start")
atrace (xinspect(myTable))

print (myTable.layers[1].properties.mapName)
print (myTable.width)
print (myTable.height)
print (myTable.tileheight)

local currentMap = {}
currentMap.mapWidth = myTable.width -- This is how many items(rows) are in 1 row of a map.
currentMap.mapHeigth = myTable.height -- This is how many down
currentMap.TileSizeSquare = myTable.layers[1].properties.width -- how many pixels a square
-- mapHeigth = 

currentMap.mapData = myTable.layers[1].data

atrace (currentMap.mapData )
--[[
currentMap.mapData = {

			2,2,3,1,1,1,1,1,1,1,1,1,2,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,2,

			}
]]
-- OK.  We have a map.  Now we draw it...
local myText1 = display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 330, 20, native.systemFont, 12 )
myText1 .anchorX = 0 ; myText1.anchorY = 1

local myText2 = display.newText( "MapType: "..  myTable.layers[1].name, 330, 40, native.systemFont, 12 )
myText2 .anchorX = 0 ; myText2.anchorY = 1



-- think of Y as Rows, and X as columns
local row = 0
local column =0
local mapLocation = 0
local myMapGroup = display.newGroup()
local tileNumber
local currentTile = {}

local drawX = -10
local drawY = 0

for row=1, (currentMap.mapHeigth) do  -- This will start at the top first row and work down
										   -- The reason it starts at 0 and to mapHeigth-1 is because of MAGIC STEP below...

			for column=1, (currentMap.mapWidth) do
				-- mapLocation = mapLocation + 1 
				drawX = drawX+ 20
					
				
				tileNumber = currentMap.mapData [((currentMap.mapWidth*(row-1))+ (column)  ) ] 
			-- 	print (currentMap.mapData [((currentMap.mapWidth*(row-1))+ (column)  ) ] )
				io.write (tileNumber) -- this will print the column in the Terminal
				--Now that we have the correct tile, lets append the correct filename for the tile.
				
				currentTile = display.newImage( "images/mapTile" .. tileNumber .. ".png" )
				currentTile.x = 10 
				currentTile.y = 10 
				

				currentTile.x = currentTile.x + (column-1) * 20  -- more MAGIC STEP. since we set that first row to ZERO, if you are on it it won't multiply an extra 20
 				currentTile.y = currentTile.y + drawY

			end

			drawY = drawY + 20 -- this moves the tiledrawn down 1 on the app screen

			io.write ("\n") -- This moves the terminal to the next line

end
