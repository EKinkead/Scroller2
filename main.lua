local widget = require("widget")

--[[

TTTTTTTTTTTTTTTTTTTTTTTIIIIIIIIIILLLLLLLLLLL             EEEEEEEEEEEEEEEEEEEEEE
T:::::::::::::::::::::TI::::::::IL:::::::::L             E::::::::::::::::::::E
T:::::::::::::::::::::TI::::::::IL:::::::::L             E::::::::::::::::::::E
T:::::TT:::::::TT:::::TII::::::IILL:::::::LL             EE::::::EEEEEEEEE::::E
TTTTTT  T:::::T  TTTTTT  I::::I    L:::::L                 E:::::E       EEEEEE
        T:::::T          I::::I    L:::::L                 E:::::E             
        T:::::T          I::::I    L:::::L                 E::::::EEEEEEEEEE   
        T:::::T          I::::I    L:::::L                 E:::::::::::::::E   
        T:::::T          I::::I    L:::::L                 E:::::::::::::::E   
        T:::::T          I::::I    L:::::L                 E::::::EEEEEEEEEE   
        T:::::T          I::::I    L:::::L                 E:::::E             
        T:::::T          I::::I    L:::::L         LLLLLL  E:::::E       EEEEEE
      TT:::::::TT      II::::::IILL:::::::LLLLLLLLL:::::LEE::::::EEEEEEEE:::::E
      T:::::::::T      I::::::::IL::::::::::::::::::::::LE::::::::::::::::::::E
      T:::::::::T      I::::::::IL::::::::::::::::::::::LE::::::::::::::::::::E
      TTTTTTTTTTT      IIIIIIIIIILLLLLLLLLLLLLLLLLLLLLLLLEEEEEEEEEEEEEEEEEEEEEE                                                                
		 ,---.   ,-----.,------.  ,-----. ,--.   ,--.   ,------.,------.  
		'   .-' '  .--./|  .--. ''  .-.  '|  |   |  |   |  .---'|  .--. ' 
		`.  `-. |  |    |  '--'.'|  | |  ||  |   |  |   |  `--, |  '--'.' 
		.-'    |'  '--'\|  |\  \ '  '-'  '|  '--.|  '--.|  `---.|  |\  \  
		`-----'  `-----'`--' '--' `-----' `-----'`-----'`------'`--' '--' 

			  ___        ___     _      _  ___      _               _ 
			 | _ )_  _  | __|_ _(_)__  | |/ (_)_ _ | |_____ __ _ __| |
			 | _ \ || | | _|| '_| / _| | ' <| | ' \| / / -_) _` / _` |
			 |___/\_, | |___|_| |_\__| |_|\_\_|_||_|_\_\___\__,_\__,_|
			      |__/                                                

									V2.2.1

]]
require ("loq_util") -- so I can atrace,
display.setStatusBar( display.HiddenStatusBar ) -- Get rid of that thing
display.setDefault ("magTextureFilter", "nearest") -- make it nice and pixeled

--set the required vars and tables.
local currentMap = {}
local infoBox = {}

local myTable = {}
local myText1, myText2,myText3,myText4,myText5,myText6,myText7,myText8,myText9,myText10,myText11,myText12,myText13
local myText1_shdw, myText2_shdw,myText3_shdw,myText4_shdw,myText5_shdw,myText6_shdw,myText7_shdw,myText8_shdw,myText9_shdw,myText10_shdw,myText11_shdw,myText12_shdw,myText13_shdw
local mapClickXY 
local MapTouchInfo = {}
MapTouchInfo.x = 640
MapTouchInfo.y = 320
local containerWidth = 960
local containerHeight = 640
local mapTileName = { "nothing", "grassy plains", "forests", "mountains", "sea", "swamp", "wetlands", "blank", "blank", "blank", "castle"}
-- THESE are just vars set up for my two fancy math functions that I dont use. You can ignore this.
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
local Destination = {}
Destination.x = 0
Destination.y = 0

local ScaleAdjust = 1
local ScaleAdjustX = 0
local ScaleAdjustY = 0

local Hlines = {}

myTable = require("TileMaps.mapLarge") 
--myTable = require("TileMaps.16x16start")
-- atrace (xinspect(myTable))

function setUpMap (map2Load)

end

local function odd(num)	if num % 2 == 0 then
 	   return false 	
 	   else 	   
 	   return true	
 	 end
 end

-- check out some of these variables for the map I am loading
-- get an idea what I'm working with.
print (myTable.layers[1].properties.mapName)
print (myTable.width)
print (myTable.height)
print (myTable.tileheight)
print (myTable.tilesets[1].properties.numberFrames)
print (myTable.tilesets[1].tileheight)
print (myTable.tilesets[1].properties.filename)

-- Best to NOT do this with hardcoded Numbers, so you can make minimaps, etc. So I will pull those myTable numbers 
-- and put them in my current map.

currentMap.mapWidth = myTable.width -- This is how many items(rows) are in 1 row of a map.
currentMap.mapheight = myTable.height -- This is how many down
currentMap.TileSizeSquared = myTable.tileheight -- 

currentMap.tileWidth = myTable.tilewidth --how many pixels a square is
currentMap.tileHeight = myTable.tileheight -- same

local sheetData = {
	    --required parameters
    width = myTable.tilesets[1].tilewidth,
    height = myTable.tilesets[1].tileheight,
    numFrames = myTable.tilesets[1].properties.numberFrames,
    sheetContentWidth=myTable.tilesets[1].imagewidth ,
    sheetContentHeight=myTable.tilesets[1].imagewidth
}

print ("MAIDEN: ".. myTable.tilesets[1].image)

 local mapSheet = graphics.newImageSheet( "images/TileMapHexH.png" , sheetData ) --
 
  local sequenceData_mapTiles = {
    { name = "tile1", start=1, count=1, time=30 },
    { name = "tile2", start=2, count=1, time=30 },
    { name = "tile3", start=3, count=1, time=30 },
    { name = "tile4", start=4, count=1, time=30 },
    { name = "tile5", start=5, count=1, time=30 },
    { name = "tile6", start=6, count=1, time=30 },
    { name = "tile7", start=7, count=1, time=30 },
    { name = "tile8", start=8, count=1, time=30 },
    { name = "tile9", start=9, count=1, time=30 },
    { name = "tile10", start=10, count=1, time=30 },
    { name = "tile11", start=11, count=1, time=30 }
  }

--local animation = display.newSprite( mapSheet, sequenceData_mapTiles )
--animation.x = display.contentWidth/2  --center the sprite horizontally
--animation.y = display.contentHeight/2  --center the sprite vertically
--animation:setSequence( "tile6" )
--animation:play()

currentMap.xBounds = 520
currentMap.yBounds = 680

currentMap.mapData = myTable.layers[1].data 

-- drawMap
local row = 0
local column =0
local mapLocation = 0
local myMapGroup = display.newGroup()
local tileNumber
local currentTile = {}

local drawX = 0
local drawY = 0

local OffsetX = 0
local OffsetY = 0

for row=1, (currentMap.mapheight) do  -- This will start at the top first row and work down

 	if odd(row) then  
 		local OffsetX = 0
		local OffsetY = 0   
  	else
  		--local OffsetX = 10
		--local OffsetY = -5 
 	     
    end
										   

			for column=1, (currentMap.mapWidth) do
				
				drawX = (drawX+ currentMap.tileWidth ) -- + OffsetX  -- this advances the tiles in X (or columns) so they can 'move onto the next one'
								
			 	-- tileNumber is the product or tile that is up next to be drawn on the screen with *MAGIC MATH!*
				tileNumber = currentMap.mapData [((currentMap.mapWidth*(row-1))+ (column)  ) ] 
				--currentTile = display.newImage( "images/mapTile" .. tileNumber  .. ".png" )
				currentTile = display.newSprite( mapSheet, sequenceData_mapTiles )
				currentTile :setSequence( "tile" ..  tileNumber  )
				currentTile :play()

				-- This is interesting... the below is for Gr2.0 , anchors are the new refpoints
				currentTile.anchorX = 0 ; currentTile.anchorY = 0

				if odd(row) then
				currentTile.x = (currentTile.x + (column-1) * currentMap.tileWidth) ---+ OffsetX  -- more MAGIC STEP. since we set that first row to ZERO, if you are on it it won't multiply an extra 20
 				currentTile.y = (currentTile.y + drawY) -- + OffsetY
 				else
				currentTile.x = (currentTile.x + (column-1) * currentMap.tileWidth) +(currentMap.tileWidth * .5) --+ OffsetX  -- more MAGIC STEP. since we set that first row to ZERO, if you are on it it won't multiply an extra 20
 				currentTile.y = (currentTile.y + drawY) - (currentMap.tileWidth * .25)   -- + OffsetY
 				end

 				myMapGroup:insert(currentTile)

			end

			if odd(row) then

			drawY = (drawY + currentMap.tileHeight) -- + OffsetY -- this advances tiles in Y (or rows) so the tiledrawn down 1 on the app screen
			else
			drawY = (drawY + currentMap.tileHeight) - (currentMap.tileWidth * .5) 
			end

end

-- Put the map in a container
-- container are nifty new Groups you can do other stuff with.

local container = display.newContainer( containerWidth, containerHeight )
container:insert( myMapGroup, true ) 

--[[

Hlines = {}
for row  = 0, 15 do
print ("R:" .. row)
 	Hlines[row] = display.newLine( 0, (row *currentMap.tileHeight) , 480, (row *currentMap.tileHeight) )
	Hlines[row].strokeWidth =2
	Hlines[row]:setStrokeColor( 1, 0, 0, 1 )
end
]]

local troopsSheet = graphics.newImageSheet( "images/".. myTable.tilesets[2].name .. ".png", sheetData ) --

local sequenceData_Troops = {

    { name = "infantry", frames={ 1,2}, time=900},
    { name = "calvary", frames={ 3,4}, time=900},
    { name = "captain", frames={ 5,6}, time=900},
    { name = "sorcerer", frames={ 7,8}, time=900}
  }

--for i=1 #myTable.ob
--ArmyRed = {}
atrace (myTable.layers[2].objects )

BlueArmy = {}

for i=1, #myTable.layers[2].objects do

	--redArmy = display.newSprite( mapSheet, sequenceData_mapTiles )
	BlueArmy[i] = display.newSprite( troopsSheet, sequenceData_Troops )
	BlueArmy[i] :setSequence( myTable.layers[2].objects[i].name  )
	BlueArmy[i] :play()
	myMapGroup:insert (BlueArmy[i])

	tempX = myTable.layers[2].objects[i].x + 1
	tempY = myTable.layers[2].objects[i].y / myTable.tilesets[1].tileheight

	BlueArmy[i].x = myTable.layers[2].objects[i].x 
 	BlueArmy[i].y = tempY * (myTable.tilesets[1].tileheight*.75)

	BlueArmy[i].anchorX = 0
	BlueArmy[i].anchorY = 1

	print ("X:" ..( myTable.layers[2].objects[i].x / myTable.tilesets[1].tileheight).. " is EVEN NUMBER + "..(myTable.tilesets[1].tileheight / 2) .. " adjustment." )
--		setFillColor()setFillColor()setFillColor()
	if odd (myTable.layers[2].objects[i].y / myTable.tilesets[1].tilewidth ) then
		print ("X:" .. ( myTable.layers[2].objects[i].x / myTable.tilesets[1].tilewidth) .. " is odd number")
		 -- 5
	else
		print ("X:" ..( myTable.layers[2].objects[i].x / myTable.tilesets[1].tileheight).. " is EVEN NUMBER + " ..(myTable.tilesets[1].tileheight / 2) .. " adjustment." )
		BlueArmy[i].x = BlueArmy[i].x + (myTable.tilesets[1].tileheight / 2)
	end

end





--updateOjects()

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

-- *** Move the screen or touch a tile ***



local onScreenTouchMap = function( event )
	
	local moveMode = true 

    local t = event.target 
	local phase = event.phase

	if "began" == phase then

		t.isFocus = true 
		t.x0 = event.x  -- where is the X of the users finger
		t.y0 = event.y  -- where is the Y of the users finger
		
		-- I take those (cords) and I adjust them for the map to find what is in the table.

		local tempX =  (math.floor ( ( (t.x0-1 + (myMapGroup.x*-1)) / currentMap.tileWidth + ScaleAdjustX ) ))+1
		local tempY =  (math.floor ( ( (t.y0-1 + (myMapGroup.y*-1)) / currentMap.tileHeight+ ScaleAdjustY ) ))+1
		mapClickXY = (( (tempY-1) * currentMap.mapWidth ) + tempX )
	
		if odd(tempY) then 
			print ("is ODDnumber")
			print ("ODD! row:" .. row)
			mapClickXY = (( (tempY-1) * currentMap.mapWidth ) + tempX )
			ScaleAdjustY= (math.floor ( ( (t.y0-1 + (myMapGroup.y*-1)) / currentMap.tileHeight+ ScaleAdjustY ) ))+1
		else
			print ("is EVEN number")
			print ("EVEN! row:" .. row)
		end
 


--[[

	for i=0, 15 do
		if Hlines[i] then
		Hlines[i]:removeSelf()
		end
	end

-- Hlines[row]:adjust( 0, row *(currentMap.tileHeight * .25), 480, row *(currentMap.tileHeight * .25) )


	colorR = math.random(0,1)
	colorG = math.random(0,1)
	colorB = math.random(0,1)

	for row  = 0, 15 do

	selectYHeight = currentMap.tileHeight*.8
	tileYDisplacement = (currentMap.tileHeight*.2) / 2

	print ("selectYHeight: " ..currentMap.tileHeight*.8)
	print ("tileYDisplacement: " ..currentMap.tileHeight*.2)

	Hlines = {}
	print ("R:" .. row)
	 Hlines[row] = display.newLine( 0, (row *(selectYHeight))+tileYDisplacement, 480, (row *(selectYHeight))+tileYDisplacement )
		Hlines[row].strokeWidth =1
		Hlines[row]:setStrokeColor( colorR, colorG, colorB, 1 )
	--	Hlines[row].x = 44
	-- 	Hlines[row]:adjust( 0, row *(currentMap.tileHeight * .25), 480, row *(currentMap.tileHeight * .25) )

	end

]]




	--	if odd(tempY) then
	--		local tempX =  (math.floor ( ( (t.x0-1 + (myMapGroup.x*-1)) / currentMap.tileWidth ) ))+1
	--	else
	--		local tempX =  (math.floor ( ( (t.x0-1 + (myMapGroup.x*-1)) / currentMap.tileWidth ) ))+1
	--	end

	--	mapClickXY = (( (tempY-1) * currentMap.mapWidth ) + tempX )

		myText7.text= ( "Touched State"  )
		myText7_shdw.text= ( "Touched State"  )

		myText8.text = ("t.x0: " .. t.x0) 
		myText8_shdw.text = ("t.x0: " .. t.x0)

		myText9.text = ("tempX:" .. tempX)
		myText9_shdw.text = ("tempX:" .. tempX)

		myText10.text = ("t.y0: " .. t.y0)
		myText10_shdw.text = ("t.y0: " .. t.y0)
		myText11.text = ("tempY:" .. tempY)
		myText11_shdw.text = ("tempY:" .. tempY)

		myText12.text = ( "mapXY: " .. mapClickXY )
		myText12_shdw.text = ( "mapXY: " .. mapClickXY )

		if mapTileName[currentMap.mapData[mapClickXY]] ~= nil then
		
		myText13.text = ( "mapTile: " ..  mapTileName[currentMap.mapData[mapClickXY]] )
		myText13_shdw.text = ( "mapTile: " .. mapTileName[currentMap.mapData[mapClickXY]] )

		end

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

		if moveMode == true then

			if myMapGroup.x + (event.x  - t.x0 ) >0 then myMapGroup.x =-0;elseif myMapGroup.x + (event.x  - t.x0 ) <-520 then myMapGroup.x =-520;else
				-- moveMapX
				myMapGroup.x = myMapGroup.x + (event.x  - t.x0 )
				t.x0 = event.x
			end

			-- Check Bounds
			if myMapGroup.y + (event.y  - t.y0 ) >0 then myMapGroup.y =0;elseif myMapGroup.y + (event.y  - t.y0 ) <-430 then myMapGroup.y =-430;else
				-- moveMapY
				myMapGroup.y = myMapGroup.y +(event.y  - t.y0 )
				t.y0 = event.y
			end
		end

	end

	myText3.text = ( "myMapGroup.x: ".. myMapGroup.x)
	myText3_shdw.text = ( "myMapGroup.x: ".. myMapGroup.x)

	myText4.text = ( "myMapGroup.y: ".. myMapGroup.y)
	myText4_shdw.text = ( "myMapGroup.y: ".. myMapGroup.y)

	-- return true
end

-- Below is the box I use to make my info readable.

infoBox[2] = display.newRect(325, 5, 150 , 240 ) -- (112, 96, 288, 360)
local color = {0, 0, .2} -- weird way you make color in gr2.0
infoBox[2]:setFillColor(unpack(color)) -- weird way part 2.  :/
infoBox[2].alpha = .8

infoBox[2].anchorY = 0
infoBox[2].anchorX = 0

 
--TouchPoint = {}
--TouchPoint[1] = display.newImage( "images/tile20_20.png" , 0, 0  )
--TouchPoint[1].anchorX = 0;TouchPoint[1].anchorY = 0


myText1_shdw= display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 331, 21, native.systemFont, 12 )
myText1_shdw:setFillColor( 0, 0, 0, 1 ); myText1_shdw.anchorX = 0 ; myText1_shdw.anchorY = 1
myText1 = display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 330, 20, native.systemFont, 12 )
myText1:setFillColor( 0, 1, 0, 1 ); myText1.anchorX = 0 ; myText1.anchorY = 1
----
myText2_shdw= display.newText( "MapType: "..  myTable.layers[1].name, 331, 41, native.systemFont, 12 )
myText2_shdw:setFillColor(0,0,0,1); myText2_shdw.anchorX = 0 ; myText2_shdw.anchorY = 1
myText2 = display.newText( "MapType: "..  myTable.layers[1].name, 330, 40, native.systemFont, 12 )
myText2:setFillColor(0,1,0,1); myText2.anchorX = 0 ; myText2.anchorY = 1

----
myText3_shdw = display.newText( "myMapGroup.x: ".. myMapGroup.x, 331, 61, native.systemFont, 12 )
myText3_shdw:setFillColor(0,0,0,1); myText3_shdw.anchorX = 0 ; myText3_shdw.anchorY = 1
myText3 = display.newText( "myMapGroup.x: ".. myMapGroup.x, 330, 60, native.systemFont, 12 )
myText3:setFillColor(1,1,0,1); myText3.anchorX = 0 ; myText3.anchorY = 1
----
myText4_shdw = display.newText( "myMapGroup.y: "..  myMapGroup.y, 331, 81, native.systemFont, 12 )
myText4_shdw:setFillColor(0,0,0,1); myText4_shdw.anchorX = 0 ; myText4_shdw.anchorY = 1
myText4 = display.newText( "myMapGroup.y: "..  myMapGroup.y, 330, 80, native.systemFont, 12 )
myText4:setFillColor(1,1,0,1); myText4.anchorX = 0 ; myText4.anchorY = 1
----
myText5_shdw = display.newText( "xBounds: "..  currentMap.xBounds, 331, 101, native.systemFont, 12 )
myText5_shdw:setFillColor(0,0,0,1); myText5_shdw.anchorX = 0 ; myText5_shdw.anchorY = 1
myText5 = display.newText( "xBounds: "..  currentMap.xBounds, 330, 100, native.systemFont, 12 )
myText5:setFillColor(1,1,0,1); myText5.anchorX = 0 ; myText5.anchorY = 1
----
myText6_shdw = display.newText( "yBounds: "..  currentMap.yBounds, 331, 121, native.systemFont, 12 )
myText6_shdw:setFillColor(0,0,0,1); myText6_shdw.anchorX = 0 ; myText6_shdw.anchorY = 1
myText6 = display.newText( "yBounds: "..  currentMap.yBounds, 330, 120, native.systemFont, 12 )
myText6:setFillColor(1,1,0,1); myText6.anchorX = 0 ; myText6.anchorY = 1
----
myText7_shdw = display.newText( " " , 331, 161, native.systemFont, 12 )
myText7_shdw:setFillColor(0,0,0,1); myText7_shdw.anchorX = 0 ; myText7_shdw.anchorY = 1
myText7 = display.newText( " " , 330, 160, native.systemFont, 12 )
myText7:setTextColor(0,0,150,255); myText7.anchorX = 0 ; myText7.anchorY = 1
----
myText8_shdw = display.newText( "TouchX: " , 331, 181, native.systemFont, 12 )
myText8_shdw:setFillColor(0,0,0,1); myText8_shdw.anchorX = 0 ; myText8_shdw.anchorY = 1
myText8 = display.newText( "TouchX: " , 330, 180, native.systemFont, 12 )
myText8:setFillColor(1,1,0,1); myText8.anchorX = 0 ; myText8.anchorY = 1
----
myText9_shdw = display.newText( "TouchY: " , 331, 201, native.systemFont, 12 )
myText9_shdw:setFillColor(0,0,0,1); myText9_shdw.anchorX = 0 ; myText9_shdw.anchorY = 1
myText9 = display.newText( "TouchY: " , 330, 200, native.systemFont, 12 )
myText9:setFillColor(1,1,0,1); myText9.anchorX = 0 ; myText9.anchorY = 1
----
myText10_shdw = display.newText( "TouchX: " , 409, 181, native.systemFont, 12 )
myText10_shdw:setFillColor(0,0,0,1); myText10_shdw.anchorX = 0 ; myText10_shdw.anchorY = 1
myText10 = display.newText( "TouchX: " , 408, 180, native.systemFont, 12 )
myText10:setFillColor(1,1,0,1); myText10.anchorX = 0 ; myText10.anchorY = 1
----
myText11_shdw = display.newText( "TouchY: " , 409, 201, native.systemFont, 12 )
myText11_shdw:setFillColor(0,0,0,1); myText11_shdw.anchorX = 0 ; myText11_shdw.anchorY = 1
myText11 = display.newText( "TouchY: " , 408, 200, native.systemFont, 12 )
myText11:setFillColor(1,1,0,1); myText11.anchorX = 0 ; myText11.anchorY = 1
----
myText12_shdw = display.newText( "mapXY: " , 331, 221, native.systemFont, 12 )
myText12_shdw:setFillColor(0,0,0,1); myText12_shdw.anchorX = 0 ; myText12_shdw.anchorY = 1
myText12 = display.newText( "mapXY: " , 330, 220, native.systemFont, 12 )
myText12:setFillColor(1,1,0,1); myText12.anchorX = 0 ; myText12.anchorY = 1
----
myText13_shdw = display.newText( "mapTile: " , 331, 241, native.systemFont, 12 )
myText13_shdw:setFillColor(0,0,0,1); myText13_shdw.anchorX = 0 ; myText13_shdw.anchorY = 1
myText13 = display.newText( "mapTile: " , 330, 240, native.systemFont, 12 )
myText13:setFillColor(1,0,0,1); myText13.anchorX = 0 ; myText13.anchorY = 1

mapTouchArea = display.newRect(0, 0, MapTouchInfo.x , MapTouchInfo.x ) -- (112, 96, 288, 360)
mapTouchArea.anchorY = 0
mapTouchArea.anchorX = 0
mapTouchArea.isVisible = false -- change this and alpha if you want to draw the box to look at it.
mapTouchArea.alpha = .3        -- basically it covers the entire screen.
mapTouchArea.isHitTestable = true  -- these guys are magic. they make it so invisible boxes so you can set up touch events on them.

--Destination.x = myMapGroup.x -- ignore, more fun stuff for all that math junk commented out way above... that treser2 game stuff.
--Destination.x = myMapGroup.y




local Button_ZoomUpReleased = function( event )

-- containerHeight = .3 
-- container
	ScaleAdjust = ScaleAdjust + 0.10

	if ScaleAdjust > 2 then
		ScaleAdjust = 4
		print ("NO! The Limit scaleUp has been hit!")
	else
		container:scale (1.1,1.1)
	end


	container:scale( ScaleAdjust, ScaleAdjust )

	--container:rotate( 24 )
	print ("ScaleAdjust = " .. ScaleAdjust)
	print ("-UP- BUTTON" .. "  / containerHeight=" .. containerHeight)
	print ("-----------" .. "  / containerWidth=" .. containerWidth)

	myText14_shdw.text = ( "ScaleAdjust: "  .. ScaleAdjust)
	myText14.text = ( "ScaleAdjust: " .. ScaleAdjust )

return true
end

local Button_ZoomDownReleased = function( event )



-- containerHeight = .3 
-- container

	ScaleAdjust = ScaleAdjust - 0.10
	if ScaleAdjust < 1 then
		ScaleAdjust = 1
		print ("NO! The Limit scaleDown has been hit!")
	else
		container:scale( .90, .90 )
	end

		print ( "ScaleAdjust = " .. ScaleAdjust )
	print ("DOWN BUTTON" .. "  / containerHeight=" .. containerHeight)
	print ("-----------" .. "  / containerWidth=" .. containerWidth)
	print (" ")

	myText14_shdw.text = ( "ScaleAdjust: "  .. ScaleAdjust)
	myText14.text = ( "ScaleAdjust: " .. ScaleAdjust )


return true
end



infoBox[2] = display.newRect(8, 280, 260 , 36) -- (112, 96, 288, 360)
local color = {0, 0, .2} -- weird way you make color in gr2.0
infoBox[2]:setFillColor(unpack(color)) -- weird way part 2.  :/
infoBox[2].alpha = .8

infoBox[2].anchorY = 0
infoBox[2].anchorX = 0

myText14_shdw = display.newText( "ScaleAdjust: ".. ScaleAdjust, 83, 301, native.systemFont, 12 )
myText14_shdw:setFillColor(0,0,0,1); myText14_shdw.anchorX = 0 ; myText14_shdw.anchorY = 1
myText14 = display.newText( "ScaleAdjust: ".. ScaleAdjust , 82, 300, native.systemFont, 12 )
myText14:setFillColor(1,1,0,1); myText14.anchorX = 0 ; myText14.anchorY = 1

	Button_ZoomUp = widget.newButton
	{
		id = "Button_scout",
		defaultFile = "images/btn_Plus.png",
		overFile = "images/btn_Plus_Down.png",
		label =  "scale", -- rosetta:getString("Scout"),
		font = native.systemFont, -- "Tungsten",
		labelYOffset = 5,
		fontSize = 4,-- _FontSize1,
		emboss = true,
		labelColor = 
		{ 
			default = { 0, 0, 0, 255 },
		},
		isEnabled= true,
		onRelease = Button_ZoomUpReleased,
	}

	Button_ZoomUp.x = 28
	Button_ZoomUp.y = 298 


		Button_ZoomDown = widget.newButton
	{
		id = "Button_scout",
		defaultFile = "images/btn_Minus.png",
		overFile = "images/btn_Minus_Down.png",
		label =  "scale", -- rosetta:getString("Scout"),
		font = native.systemFont, -- "Tungsten",
		labelYOffset = 5,
		fontSize = 4,-- _FontSize1,
		emboss = true,
		labelColor = 
		{ 
			default = { 0, 0, 0, 255 },
		},
		isEnabled= true,
		onRelease = Button_ZoomDownReleased,
	}

	Button_ZoomDown.x = 64
	Button_ZoomDown.y = 298
	--Button_scout.x = _CX *.5 
	--Button_scout.y = _CY * 2.54

-- When they touch the map, goto onScreenTouchMap Above.

mapTouchArea:addEventListener( 'touch', onScreenTouchMap )
--TouchPoint[1].isHitTestable = true 
--TouchPoint[1]:addEventListener( 'tap', onScreenTouchTile )

Runtime:addEventListener( "enterFrame", onUpdate )

--eof-