
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
local mapClickXY 
local Destination = {}
Destination.x = 0
Destination.y = 0

local mapTileName = { "nothing", "grassy plains", "forests", "mountains", "sea", "castle"}

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

local MapTouchInfo = {}

MapTouchInfo.x = 640
MapTouchInfo.y = 320

local containerWidth = 960
local containerHeight = 640


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
currentMap.mapheight = myTable.height -- This is how many down
currentMap.TileSizeSquared = myTable.tileheight -- how many pixels a square

currentMap.tileWidth = myTable.tilewidth
currentMap.tileHeight = myTable.tileheight
-- mapheight = 
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

for row=1, (currentMap.mapheight) do  -- This will start at the top first row and work down
										   -- The reason it starts at 0 and to mapheight-1 is because of MAGIC STEP below...

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


--
-- Move the screen or touch a tile
--
onScreenSwipeMap = function( event )
	
	local moveMode = true

    local t = event.target
	local phase = event.phase 
	local minmov = 8	-- Minimum movement that registers if they are planning on dragging

	if "began" == phase then
		-- display.getCurrentStage():setFocus(t)
		t.isFocus = true
		t.x0 = event.x
		t.y0 = event.y

		--t.x0 = t.x0 + myMapGroup.x
		--t.y0 = t.y0 + myMapGroup.y


		
		local tempX =  (math.floor ( ( (t.x0-1 + (myMapGroup.x*-1)) / currentMap.tileWidth ) ))+1
		local tempY =  (math.floor ( ( (t.y0-1 + (myMapGroup.y*-1)) / currentMap.tileHeight ) ))+1
		-- local tempY = ((math.floor ( ((t.y0)-1+(0))  / currentMap.tileHeight) )  )  + 1

		--tempX = tempX + (myMapGroup.x * -1)
		--tempY = tempY + (-1(myMapGroup.y * -1)

		mapClickXY = (( (tempY-1) * currentMap.mapWidth ) + tempX )

		myText7.text= ( "Touched State"  )
		myText7_shdw.text= ( "Touched State"  )

		myText8.text = ("t.x0:" .. t.x0)
		myText8_shdw.text = ("t.x0:" .. t.x0)

		myText9.text = ("tempX:" .. tempX)
		myText9_shdw.text = ("tempX:" .. tempX)

		myText10.text = ("t.y0:" .. t.y0)
		myText10_shdw.text = ("t.y0:" .. t.y0)
		myText11.text = ("tempY:" .. tempY)
		myText11_shdw.text = ("tempY:" .. tempY)

		myText12.text = ( "mapXY: " .. mapClickXY )
		myText12_shdw.text = ( "mapXY: " .. mapClickXY )
		myText13.text = ( "mapTile: " ..  mapTileName[currentMap.mapData[mapClickXY]] )
		myText13_shdw.text = ( "mapTile: " .. mapTileName[currentMap.mapData[mapClickXY]] )
		
	

	elseif ("ended" == phase or "cancelled" == phase) then --  and t.x0 ~= nil and t.y0 ~= nil then
		moveMode = false
		display.getCurrentStage():setFocus( nil )
		t.isFocus = false
		t.x0 = nil   
		t.y0 = nil 
		myText7.text= ( " " )
		myText7_shdw.text= ( " " )
	end

	if t.x0 ~= nil or t.y0 ~= nil then
	---- CHECK TO SEE IF TOUCHED OR TOUCHED + DRAGGED
	-- myText7.text= ( "x: " ..(event.x - t.x0) .." > minmov8"  )


	---- MOVE THE MAP

		if moveMode == true then
			--myMapGroup.x = myMapGroup.x 
			print ( "(event.x  - t.x0 ) :" .. (event.x  - t.x0 ) )
			-- Check Bounds
			if myMapGroup.x + (event.x  - t.x0 ) >0 then myMapGroup.x =0;elseif myMapGroup.x + (event.x  - t.x0 ) <-681 then myMapGroup.x =-681;else
			-- moveMapX
			myMapGroup.x = myMapGroup.x + (event.x  - t.x0 )
					t.x0 = event.x
			end

			-- Check Bounds
			if myMapGroup.y + (event.y  - t.y0 ) >0 then myMapGroup.y =0;elseif myMapGroup.y + (event.y  - t.y0 ) <-681 then myMapGroup.y =-681;else
			-- moveMapY
			myMapGroup.y = myMapGroup.y +(event.y  - t.y0 )
					t.y0 = event.y
			end
		end

	end
	myText3.text = ( "X: ".. myMapGroup.x)
	myText3_shdw.text = ( "X: ".. myMapGroup.x)
	myText4.text = ( "Y: ".. myMapGroup.y)
	myText4_shdw.text = ( "Y: ".. myMapGroup.y)

	--if myMapGroup.x >1 then myMapGroup.x=0;Destination.x=0;end
	--if myMapGroup.y >1 then myMapGroup.y=0;Destination.y=0;end
	--if myMapGroup.x < ((currentMap.xBounds*-1) + containerWidth) then myMapGroup.x = ((currentMap.xBounds*-1) + containerWidth);Destination.x=0; end
	--if myMapGroup.y < ((currentMap.yBounds*-1) + containerHeight) then myMapGroup.y = ((currentMap.yBounds*-1) + containerHeight);Destination.x=0; end

	return true
end

--createTextWithShadow("Thats So Panda",35,100, native.systemFont,20,2)
--createTextWithShadow("Oh Yea",35,120, native.systemFont,20,2)
--createTextWithShadow("uh huh",35,140, native.systemFont,20,2)


local red = {0, 0, .2}
infoBox = display.newRect(325, 5, 150 , 240 ) -- (112, 96, 288, 360)
infoBox:setFillColor(unpack(red))
infoBox.alpha = .8
infoBox.anchorY = 0
infoBox.anchorX = 0


myText1_shdw= display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 331, 21, native.systemFont, 12 )
myText1_shdw:setTextColor(0,0,0,255); myText1_shdw.anchorX = 0 ; myText1_shdw.anchorY = 1
myText1 = display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 330, 20, native.systemFont, 12 )
myText1:setTextColor(255,255,0,255); myText1.anchorX = 0 ; myText1.anchorY = 1
----
myText2_shdw= display.newText( "MapType: "..  myTable.layers[1].name, 331, 41, native.systemFont, 12 )
myText2_shdw:setTextColor(0,0,0,255); myText2_shdw.anchorX = 0 ; myText2_shdw.anchorY = 1
myText2 = display.newText( "MapType: "..  myTable.layers[1].name, 330, 40, native.systemFont, 12 )
myText2:setTextColor(255,255,0,255); myText2.anchorX = 0 ; myText2.anchorY = 1

----
myText3_shdw = display.newText( "X: ".. myMapGroup.x, 331, 61, native.systemFont, 12 )
myText3_shdw:setTextColor(0,0,0,255); myText3_shdw.anchorX = 0 ; myText3_shdw.anchorY = 1
myText3 = display.newText( "X: ".. myMapGroup.x, 330, 60, native.systemFont, 12 )
myText3:setTextColor(255,255,0,255); myText3.anchorX = 0 ; myText3.anchorY = 1
----
myText4_shdw = display.newText( "Y: "..  myMapGroup.y, 331, 81, native.systemFont, 12 )
myText4_shdw:setTextColor(0,0,0,255); myText4_shdw.anchorX = 0 ; myText4_shdw.anchorY = 1
myText4 = display.newText( "Y: "..  myMapGroup.y, 330, 80, native.systemFont, 12 )
myText4:setTextColor(255,255,0,255); myText4.anchorX = 0 ; myText4.anchorY = 1
----
myText5_shdw = display.newText( "xBounds: "..  currentMap.xBounds, 331, 101, native.systemFont, 12 )
myText5_shdw:setTextColor(0,0,0,255); myText5_shdw.anchorX = 0 ; myText5_shdw.anchorY = 1
myText5 = display.newText( "xBounds: "..  currentMap.xBounds, 330, 100, native.systemFont, 12 )
myText5:setTextColor(255,255,0,255); myText5.anchorX = 0 ; myText5.anchorY = 1
----
myText6_shdw = display.newText( "yBounds: "..  currentMap.yBounds, 331, 121, native.systemFont, 12 )
myText6_shdw:setTextColor(0,0,0,255); myText6_shdw.anchorX = 0 ; myText6_shdw.anchorY = 1
myText6 = display.newText( "yBounds: "..  currentMap.yBounds, 330, 120, native.systemFont, 12 )
myText6:setTextColor(255,255,0,255); myText6.anchorX = 0 ; myText6.anchorY = 1
----
myText7_shdw = display.newText( " " , 331, 161, native.systemFont, 12 )
myText7_shdw:setTextColor(0,0,0,255); myText7_shdw.anchorX = 0 ; myText7_shdw.anchorY = 1
myText7 = display.newText( " " , 330, 160, native.systemFont, 12 )
myText7:setTextColor(255,255,0,255); myText7.anchorX = 0 ; myText7.anchorY = 1
----
myText8_shdw = display.newText( "TouchX: " , 331, 181, native.systemFont, 12 )
myText8_shdw:setTextColor(0,0,0,255); myText8_shdw.anchorX = 0 ; myText8_shdw.anchorY = 1
myText8 = display.newText( "TouchX: " , 330, 180, native.systemFont, 12 )
myText8:setTextColor(255,255,0,255); myText8.anchorX = 0 ; myText8.anchorY = 1
----
myText9_shdw = display.newText( "TouchY: " , 331, 201, native.systemFont, 12 )
myText9_shdw:setTextColor(0,0,0,255); myText9_shdw.anchorX = 0 ; myText9_shdw.anchorY = 1
myText9 = display.newText( "TouchY: " , 330, 200, native.systemFont, 12 )
myText9:setTextColor(255,255,0,255); myText9.anchorX = 0 ; myText9.anchorY = 1
----
myText10_shdw = display.newText( "TouchX: " , 409, 181, native.systemFont, 12 )
myText10_shdw:setTextColor(0,0,0,255); myText10_shdw.anchorX = 0 ; myText10_shdw.anchorY = 1
myText10 = display.newText( "TouchX: " , 408, 180, native.systemFont, 12 )
myText10:setTextColor(255,255,0,255); myText10.anchorX = 0 ; myText10.anchorY = 1
----
myText11_shdw = display.newText( "TouchY: " , 409, 201, native.systemFont, 12 )
myText11_shdw:setTextColor(0,0,0,255); myText11_shdw.anchorX = 0 ; myText11_shdw.anchorY = 1
myText11 = display.newText( "TouchY: " , 408, 200, native.systemFont, 12 )
myText11:setTextColor(255,255,0,255); myText11.anchorX = 0 ; myText11.anchorY = 1
----
myText12_shdw = display.newText( "mapXY: " , 331, 221, native.systemFont, 12 )
myText12_shdw:setTextColor(0,0,0,255); myText12_shdw.anchorX = 0 ; myText12_shdw.anchorY = 1
myText12 = display.newText( "mapXY: " , 330, 220, native.systemFont, 12 )
myText12:setTextColor(255,255,0,255); myText12.anchorX = 0 ; myText12.anchorY = 1
----
myText13_shdw = display.newText( "mapTile: " , 331, 241, native.systemFont, 12 )
myText13_shdw:setTextColor(0,0,0,255); myText13_shdw.anchorX = 0 ; myText13_shdw.anchorY = 1
myText13 = display.newText( "mapTile: " , 330, 240, native.systemFont, 12 )
myText13:setTextColor(255,255,0,255); myText13.anchorX = 0 ; myText13.anchorY = 1


mapTouchArea = display.newRect(0, 0, MapTouchInfo.x , MapTouchInfo.x ) -- (112, 96, 288, 360)
mapTouchArea.anchorY = 0
mapTouchArea.anchorX = 0
mapTouchArea.isVisible = false
mapTouchArea.alpha = .3
mapTouchArea.isHitTestable = true

Destination.x = myMapGroup.x
Destination.x = myMapGroup.y

mapTouchArea:addEventListener( 'touch', onScreenSwipeMap )
Runtime:addEventListener( "enterFrame", onUpdate )

