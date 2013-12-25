
require ("loq_util")

display.setStatusBar( display.HiddenStatusBar ) -- Get rid of that thing
display.setDefault ("magTextureFilter", "nearest") -- make it nice and pixeled




local currentMap = {}
local myTable = {}
local myText1
local myText2
local myText3
local myText4
local myText5
local myText6
local myText7
local myText8
local myText9
local Destination = {}
Destination.x = 0
Destination.y = 0

local abs = math.abs
local atan = math.atan
local atan2 = math.atan2
local rad = math.rad
local deg = math.deg
local pi = math.pi
local pi2 = pi * 2
local sqrt = math.sqrt
local floor = math.floor
local cos = math.cos
local sin = math.sin


-- Test = display.newImage( "images/img_Backdrop2.png")

-- Some kind of map thing
--foot = display.newImage("mapTile1.png", 100, 100)

-- Set up the map. Best to NOT do this with hardcoded Numbers, so you can make minimaps, etc.


myTable = require("TileMaps.mapLarge") -- testing a large map
--myTable = require("TileMaps.16x16start")
atrace (xinspect(myTable))


-- check out some of these variables for the map I am loading
print (myTable.layers[1].properties.mapName)
print (myTable.width)
print (myTable.height)
print (myTable.tileheight)


currentMap.mapWidth = myTable.width -- This is how many items(rows) are in 1 row of a map.
currentMap.mapHeigth = myTable.height -- This is how many down
currentMap.TileSizeSquared = myTable.tileheight -- how many pixels a square
-- mapHeigth = 
currentMap.xBounds = myTable.tilewidth*myTable.width
currentMap.yBounds = myTable.tileheight*myTable.height


-- print (currentMap.TileSizeSquared)

currentMap.mapData = myTable.layers[1].data

-- atrace (currentMap.mapData )
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




-- think of Y as Rows, and X as columns
local row = 0
local column =0
local mapLocation = 0
local myMapGroup = display.newGroup()
local tileNumber
local currentTile = {}

local drawX = 0
local drawY = 0

for row=1, (currentMap.mapHeigth) do  -- This will start at the top first row and work down
										   -- The reason it starts at 0 and to mapHeigth-1 is because of MAGIC STEP below...

			for column=1, (currentMap.mapWidth) do
				-- mapLocation = mapLocation + 1 
				drawX = drawX+ currentMap.TileSizeSquared
					
				
				tileNumber = currentMap.mapData [((currentMap.mapWidth*(row-1))+ (column)  ) ] 
			-- 	print (currentMap.mapData [((currentMap.mapWidth*(row-1))+ (column)  ) ] )
				io.write (tileNumber) -- this will print the column in the Terminal
				--Now that we have the correct tile, lets append the correct filename for the tile.
				
				currentTile = display.newImage( "images/mapTile" .. tileNumber .. ".png" )
				currentTile.anchorX = 0 ; currentTile.anchorY = 0
				currentTile.x = 0 
				currentTile.y = 0 
				

				currentTile.x = currentTile.x + (column-1) * currentMap.TileSizeSquared  -- more MAGIC STEP. since we set that first row to ZERO, if you are on it it won't multiply an extra 20
 				currentTile.y = currentTile.y + drawY

 				myMapGroup:insert(currentTile)

			end

			drawY = drawY + currentMap.TileSizeSquared -- this moves the tiledrawn down 1 on the app screen

			io.write ("\n") -- This moves the terminal to the next line

end



-- Put the map in a container
containerWidth = 639
containerHeight = 639
local container = display.newContainer( containerWidth, containerHeight )
container:insert( myMapGroup, true ) 


function angle(x1, y1, x2, y2)
        local xDelta, yDelta = x2-x1, y2-y1
        local angle = atan2(yDelta, xDelta) * 180 / math.pi
        return angle
end
 
function calcVector(obj1,obj2)
    local xDist = obj1.x - obj2.x
    local yDist = obj1.y - obj2.y
    local dist = 5
    
    local angle = -( atan2( yDist , xDist ) * ( 180 / pi ) ) + 90
    local xFinal = obj1.x +( sin( angle * pi / 180 ) * dist )
    local yFinal = obj1.y +( cos( angle * pi / 180 ) * dist )
    final = {}
    final.angle = angle
            
    local distance = sqrt ( ( xDist * xDist ) + ( yDist * yDist ) )
        if(distance>dist) then
            final.vx = obj1.x - xFinal
            final.vy = obj1.y - yFinal
            else
            final.vx = 0
            final.vy = 0
            end
           
            return final

end

local onUpdate = function( event )

-- print ("OMG: " .. Destination.x .. "  /  " .. Destination.y)

 --[[
 	math.floor(Destination.x)
 	math.floor(Destination.y)
 	if Destination.x ~=0 or Destination.y ~=0 then
	    temp = calcVector(myMapGroup, Destination)
	    myMapGroup.x = myMapGroup.x + temp.vx
	    myMapGroup.y = myMapGroup.y  + temp.vy
	end
]]

end

-- Move the screen
onScreenSwipeMap = function( event )
	
	local moveMode = false

    local t = event.target
	local phase = event.phase 
	local minmov = 20	-- Minimum movement that registers

	if "began" == phase then
		-- display.getCurrentStage():setFocus(t)
		t.isFocus = true
		t.x0 = event.x
		t.y0 = event.y
		print ("Event.X:" .. event.x)
		print ("Event.Y:" .. event.y)

	elseif ("ended" == phase or "cancelled" == phase) then --  and t.x0 ~= nil and t.y0 ~= nil then
		display.getCurrentStage():setFocus( nil )
		t.isFocus = false
		t.x0 = nil   
		t.y0 = nil 
	end

	if t.x0 ~= nil and t.y0 ~= nil then
	---- CHECK DOWN/UP
		if (event.x - t.x0) < -(minmov) then		-- Swipe right   and areaSquareX < 204 
		io.write("\nMOVING RIGHT!!!!     <-----I====================> t.x0="..event.x - t.x0)
		

		myMapGroup.x = myMapGroup.x + (event.x - t.x0)
		--Destination.x = myMapGroup.x+(event.x - t.x0)
		--myMapGroup.x = myMapGroup.x -1 -- myMapGroup.x+1(event.x - t.x0)
		t.x0 = event.x
		t.y0 = event.y
		
		

		elseif (event.x - t.x0) > (minmov) then -- Swipe Left    and areaSquareX > 92 
		io.write ("\nMOVING LEFT!!!!     <-----I====================> t.x0="..event.x - t.x0)


		myMapGroup.x = myMapGroup.x + (event.x - t.x0)
		--Destination.x = myMapGroup.x+(event.x - t.x0)
		--myMapGroup.x =  myMapGroup.x +1 -- myMapGroup.x+(event.x - t.x0)
		t.x0 = event.x
		t.y0 = event.y

		end
		
		---- CHECK DOWN/UP

		if (event.y - t.y0) > minmov then	-- Swipe Down     and areaSquareY > 408 
		io.write ("\nMOVING UP!!!!     <-----I====================> t.x0="..event.y - t.y0)
		
		-- Destination.y = myMapGroup.y+(event.y - t.y0)
		--myMapGroup.y =  myMapGroup.y +1 -- myMapGroup.y+(event.y - t.y0)
		t.x0 = event.x
		t.y0 = event.y
		

		elseif (event.y - t.y0) < -minmov  then	-- Swipe Down    and areaSquareY < 456 
		io.write ("\nMOVING DOWN!!!!     <-----I====================> t.x0="..event.y - t.y0)
		
		--Destination.y = myMapGroup.y+(event.y - t.y0)
		--myMapGroup.y = myMapGroup.y -1 -- myMapGroup.y+(event.y - t.y0)
		t.x0 = event.x
		t.y0 = event.y
		
		end

	end
	myText3.text = ( "X: ".. myMapGroup.x)
	myText4.text = ( "Y: ".. myMapGroup.y)

	--if myMapGroup.x >1 then myMapGroup.x=0;Destination.x=0;end
	--if myMapGroup.y >1 then myMapGroup.y=0;Destination.y=0;end
	--if myMapGroup.x < ((currentMap.xBounds*-1) + containerWidth) then myMapGroup.x = ((currentMap.xBounds*-1) + containerWidth);Destination.x=0; end
	--if myMapGroup.y < ((currentMap.yBounds*-1) + containerHeight) then myMapGroup.y = ((currentMap.yBounds*-1) + containerHeight);Destination.x=0; end

	return true
end




myText1 = display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 330, 20, native.systemFont, 12 )
myText1.anchorX = 0 ; myText1.anchorY = 1

myText2 = display.newText( "MapType: "..  myTable.layers[1].name, 330, 40, native.systemFont, 12 )
myText2 .anchorX = 0 ; myText2.anchorY = 1

myText3 = display.newText( "X: ".. myMapGroup.x, 330, 60, native.systemFont, 12 )
myText3 .anchorX = 0 ; myText3.anchorY = 1

myText4 = display.newText( "Y: "..  myMapGroup.y, 330, 80, native.systemFont, 12 )
myText4 .anchorX = 0 ; myText4.anchorY = 1

myText5 = display.newText( "xBounds: "..  currentMap.xBounds, 330, 100, native.systemFont, 12 )
myText5 .anchorX = 0 ; myText5.anchorY = 1

myText6 = display.newText( "yBounds: "..  currentMap.yBounds, 330, 120, native.systemFont, 12 )
myText6 .anchorX = 0 ; myText6.anchorY = 1




mapTouchArea = display.newRect(0, 0, 320, 320) -- (112, 96, 288, 360)
mapTouchArea.anchorY = 0
mapTouchArea.anchorX = 0
mapTouchArea.isVisible = false
mapTouchArea.isHitTestable = true

Destination.x = myMapGroup.x
Destination.x = myMapGroup.y

mapTouchArea:addEventListener( 'touch', onScreenSwipeMap )
Runtime:addEventListener( "enterFrame", onUpdate )

