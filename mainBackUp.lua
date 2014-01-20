

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
local myText10
local myText11
local myText12
local myText13

local myText1_shdw
local myText2_shdw
local myText3_shdw
local myText4_shdw
local myText5_shdw
local myText6_shdw
local myText7_shdw
local myText8_shdw
local myText9_shdw
local myText10_shdw
local myText11_shdw
local myText12_shdw
local myText13_shdw

local mapClickXY 
local MapTouchInfo = {}
MapTouchInfo.x = 640
MapTouchInfo.y = 320
local containerWidth = 960
local containerHeight = 640


-- Each tile is numbered 1-6 in my TILED example. So I am going to set the table below to translate what
-- we click on. Much more exciting than 1,2,3 etc...
local mapTileName = { "nothing", "grassy plains", "forests", "mountains", "sea", "castle"}



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


-- Some kind of map thing...
-- Set up the map. 
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


--
-- OK!  Forget the map above... Let's load a map from TILED!  TILED is the most versitle way to make
-- a tiled map. We should take advantage of the fact it spits out .lua files.
-- 
-- you can download tiled here... http://www.mapeditor.org/ and in my TileMaps directory you can load the source, or you should
-- be able to if you put this in your Documents directory. (might be diff if you dont have mac) 
--
-- two types of maps. I want to go with the large one...
-- with that I exported a .lua file which I am requiring below 

myTable = require("TileMaps.mapLarge") -- testing a large map, note you have to use period instead of / for directory sometimes
--myTable = require("TileMaps.16x16start")

-- this will show me the table in the console and a nifty reason I require loqutil up at the top.
atrace (xinspect(myTable))


-- check out some of these variables for the map I am loading
-- get an idea what I'm working with.
print (myTable.layers[1].properties.mapName)
print (myTable.width)
print (myTable.height)
print (myTable.tileheight)

-- Best to NOT do this with hardcoded Numbers, so you can make minimaps, etc. So I will pull those myTable numbers 
-- and put them in my current map.

currentMap.mapWidth = myTable.width -- This is how many items(rows) are in 1 row of a map.
currentMap.mapheight = myTable.height -- This is how many down
currentMap.TileSizeSquared = myTable.tileheight -- 

currentMap.tileWidth = myTable.tilewidth --how many pixels a square is
currentMap.tileHeight = myTable.tileheight -- same



-- ** THESE NEXT TWO ARE MY HARD CODED SHAME, I AM GOING TO FIX THESE AFTER I AWAKE! *** 
-- you'll see in line #379  ;(
currentMap.xBounds = 520
currentMap.yBounds = 680
--currentMap.xBounds = myTable.tilewidth*myTable.width -- these dont really work, because I didnt take into effect the offsets created with container.
--currentMap.yBounds = myTable.tileheight*myTable.height -- I will prob do some math and make these work.

currentMap.mapData = myTable.layers[1].data -- I found where it puts the meat of the layers. it is here. If you had more layers,
											-- you have to put layers[2,3,4,etc..] in. well you dont, but main layer needs to be
											-- the top one so it comes in [1]


--
-- OK.  We have a map.  Now we draw it...
--
-- i moved these var declarations closer so they will make more sense.
--
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
										   

			for column=1, (currentMap.mapWidth) do
				
				drawX = drawX+ currentMap.tileWidth -- this advances the tiles in X (or columns) so they can 'move onto the next one'
								
			 	-- tileNumber is the product or tile that is up next to be drawn on the screen with *MAGIC MATH!*
				tileNumber = currentMap.mapData [((currentMap.mapWidth*(row-1))+ (column)  ) ] 
				currentTile = display.newImage( "images/mapTile" .. tileNumber .. ".png" )

				-- This is interesting... the below is for Gr2.0 , anchors are the new refpoints
				currentTile.anchorX = 0 ; currentTile.anchorY = 0

				currentTile.x = currentTile.x + (column-1) * currentMap.tileWidth  -- more MAGIC STEP. since we set that first row to ZERO, if you are on it it won't multiply an extra 20
 				currentTile.y = currentTile.y + drawY

 				myMapGroup:insert(currentTile)

			end

			drawY = drawY + currentMap.tileHeight -- this advances tiles in Y (or rows) so the tiledrawn down 1 on the app screen

end

-- Put the map in a container
-- container are nifty new Groups you can do other stuff with.

local container = display.newContainer( containerWidth, containerHeight )
container:insert( myMapGroup, true ) 


--[[
  
  *** See all this commented garbage ? ***

  I am setting this up so I can create way points that will scroll the map
  to a desired location. So I commented all this junk out.
 
  It's all bad ass math by 
  __                      ___ 
 / /________ ___ ___ ____|_  |
/ __/ __/ -_|_-</ -_) __/ __/ 
\__/_/  \__/___/\__/_/ /____/ 
The Corona Programming TITAN

 
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
]]



-- This ACtually gets called every frame. Does nothing.
-- It's going to be for game stuff and way point garbage. 
-- For now I can just leave it empty.

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
-- *** Move the screen or touch a tile ***
--
-- The function below is the end result of the event listener function. it is set to a big
-- invisible rectangle that covers the screen. This is the awesome part. Because we are listening for 
-- only 1 touch event. each tile has no idea whats going on, and therefore doesnt require its own event
-- listener. This frees up a TON of CPU time, as we are listening to 1 thing vs. 384 things.(number of tiles on screen)
--
-- You can check out the big mapTouchArea at the bottom of the code by turning mapTouchArea.isVisible = true
--

local onScreenTouchMap = function( event )
	
	local moveMode = true  -- I set this to encapsulate my move commands below. Incase I want to turn it false later..
						   -- for example, if you are not going to be moving the tiles around, just turn this to false.
						   -- me? I am going for Warcraft 1 type game, so I need to be able to see the map.. but hey, maybe
						   -- something will come up and I will not want to move the map.. I have that option.

    local t = event.target -- this basically takes all the data passed from the ( event ) when they touched mapTouchArea 
	local phase = event.phase -- same, but each event has stages, we use this to set up where the player is at when they touch

	if "began" == phase then

		t.isFocus = true -- t is now our focus
		t.x0 = event.x  -- where is the X of the users finger
		t.y0 = event.y  -- where is the Y of the users finger

		-- some magic I am too tired to type about... This is the math.
		-- but nothing here is hardcoded. That's the beauty of this. anysize map or tile can use this.

		local tempX =  (math.floor ( ( (t.x0-1 + (myMapGroup.x*-1)) / currentMap.tileWidth ) ))+1
		local tempY =  (math.floor ( ( (t.y0-1 + (myMapGroup.y*-1)) / currentMap.tileHeight ) ))+1

		-- I take those (cords) and I adjust them for the map to find what is in the table.
		mapClickXY = (( (tempY-1) * currentMap.mapWidth ) + tempX )

		-- all of this changes the states of the text in the text box.
		-- much cooler than watching garbage print in the console.
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
		

		-- these two lines below are the results.
		-- more garbage, but this shows me what exactly is in the map on the part you clicked.
		-- Remember I set up a table called mapTileName = { "nothing", "grassy plains", "forests", "mountains", "sea", "castle"}
		-- Well mapClickXY is the 'product' we are looking for for where the player is in the map. It will return the product
		-- for the table mapTileName shown two lines above! :D
		--
		--
		myText13.text = ( "mapTile: " ..  mapTileName[currentMap.mapData[mapClickXY]] )
		myText13_shdw.text = ( "mapTile: " .. mapTileName[currentMap.mapData[mapClickXY]] )
		
	-- Player lifts his finger off the screen (ended) or he dragged it off the screen (canceled) so...
	-- do some important things.
	elseif ("ended" == phase or "cancelled" == phase) then --  and t.x0 ~= nil and t.y0 ~= nil then
		moveMode = false
		display.getCurrentStage():setFocus( nil )
		t.isFocus = false
		t.x0 = nil   
		t.y0 = nil 
		myText7.text= ( " " )
		myText7_shdw.text= ( " " )
	end

	-- to tired to remember why I needed to say if it's not nil here
	-- but I encapsulated everything in that.
	if t.x0 ~= nil or t.y0 ~= nil then

	---- MOVE THE MAP
	---- Now if you don't plan on moving the map, you can comment everything here out.
	---- Or just set MoveMode to false like I said earlier
		if moveMode == true then
			-- Check Bounds ***NOTE:***
			-- I AM DOING SOME VERY BAD HARDCODING HERE. TOO TIRED to figure out how many tiles in relation to the screen
			-- and myMapGroups relation to the Container. :(  It's always going to be 0,0 for the upper X, upperY. But the far rightX and Bottom Y
			-- need some math based on the tile size/screen size/mapWidth, etc. going back to fix this. I really want 100% dynamic maps.
			-- but for now, I set the bounds with 521 for X and 681 for y(which is (below))
			if myMapGroup.x + (event.x  - t.x0 ) >0 then myMapGroup.x =0;elseif myMapGroup.x + (event.x  - t.x0 ) <-521 then myMapGroup.x =-521;else
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

	-- The last of my display stuff I want to update. Do this last and away from the other stuff, naturally, since it changes
	-- if the player moves their fingers.

	myText3.text = ( "myMapGroup.x: ".. myMapGroup.x)
	myText3_shdw.text = ( "myMapGroup.x: ".. myMapGroup.x)

	myText4.text = ( "myMapGroup.y: ".. myMapGroup.y)
	myText4_shdw.text = ( "myMapGroup.y: ".. myMapGroup.y)

	-- this is some neat garbage I used with those fancy math functions I got from Treser2. It worked out REALLY cool when I tested it.	
	-- but ignore it unless you want to fix it. It broke after I was getting the real meat of what this is about to work. But left it in here
	-- if you want to play around with it.

	--if myMapGroup.x >1 then myMapGroup.x=0;Destination.x=0;end
	--if myMapGroup.y >1 then myMapGroup.y=0;Destination.y=0;end
	--if myMapGroup.x < ((currentMap.xBounds*-1) + containerWidth) then myMapGroup.x = ((currentMap.xBounds*-1) + containerWidth);Destination.x=0; end
	--if myMapGroup.y < ((currentMap.yBounds*-1) + containerHeight) then myMapGroup.y = ((currentMap.yBounds*-1) + containerHeight);Destination.x=0; end

	return true
end

-- Below is the box I use to make my info readable.

infoBox = display.newRect(325, 5, 150 , 240 ) -- (112, 96, 288, 360)
local color = {0, 0, .2} -- weird way you make color in gr2.0
infoBox:setFillColor(unpack(color)) -- weird way part 2.  :/
infoBox.alpha = .8

infoBox.anchorY = 0
infoBox.anchorX = 0

-- You notice I have text with the same thing twice except with _shdw that is the drop shadow.
-- Also my setTextColor is deprecated causing the consoler to bug out on gr2.0 
-- This will change.

myText1_shdw= display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 331, 21, native.systemFont, 12 )
myText1_shdw:setTextColor(0,0,0,255); myText1_shdw.anchorX = 0 ; myText1_shdw.anchorY = 1
myText1 = display.newText( "MapName: "..  myTable.layers[1].properties.mapName, 330, 20, native.systemFont, 12 )
myText1:setTextColor(0,255,0,255); myText1.anchorX = 0 ; myText1.anchorY = 1
----
myText2_shdw= display.newText( "MapType: "..  myTable.layers[1].name, 331, 41, native.systemFont, 12 )
myText2_shdw:setTextColor(0,0,0,255); myText2_shdw.anchorX = 0 ; myText2_shdw.anchorY = 1
myText2 = display.newText( "MapType: "..  myTable.layers[1].name, 330, 40, native.systemFont, 12 )
myText2:setTextColor(0,255,0,255); myText2.anchorX = 0 ; myText2.anchorY = 1

----
myText3_shdw = display.newText( "myMapGroup.x: ".. myMapGroup.x, 331, 61, native.systemFont, 12 )
myText3_shdw:setTextColor(0,0,0,255); myText3_shdw.anchorX = 0 ; myText3_shdw.anchorY = 1
myText3 = display.newText( "myMapGroup.x: ".. myMapGroup.x, 330, 60, native.systemFont, 12 )
myText3:setTextColor(255,255,0,255); myText3.anchorX = 0 ; myText3.anchorY = 1
----
myText4_shdw = display.newText( "myMapGroup.y: "..  myMapGroup.y, 331, 81, native.systemFont, 12 )
myText4_shdw:setTextColor(0,0,0,255); myText4_shdw.anchorX = 0 ; myText4_shdw.anchorY = 1
myText4 = display.newText( "myMapGroup.y: "..  myMapGroup.y, 330, 80, native.systemFont, 12 )
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
myText7:setTextColor(0,0,150,255); myText7.anchorX = 0 ; myText7.anchorY = 1
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
myText13:setTextColor(255,0,0,255); myText13.anchorX = 0 ; myText13.anchorY = 1


-- Here's the touch area! This is what makes the thing so freaking fast and saves us from having
-- to use 386 or whatever add:eventListeners. well this is the box that draws it at least.


mapTouchArea = display.newRect(0, 0, MapTouchInfo.x , MapTouchInfo.x ) -- (112, 96, 288, 360)
mapTouchArea.anchorY = 0
mapTouchArea.anchorX = 0
mapTouchArea.isVisible = false -- change this and alpha if you want to draw the box to look at it.
mapTouchArea.alpha = .3        -- basically it covers the entire screen.
mapTouchArea.isHitTestable = true  -- these guys are magic. they make it so invisible boxes so you can set up touch events on them.

--Destination.x = myMapGroup.x -- ignore, more fun stuff for all that math junk commented out way above... that treser2 game stuff.
--Destination.x = myMapGroup.y

-- When they touch the map, goto onScreenTouchMap Above.
mapTouchArea:addEventListener( 'touch', onScreenTouchMap )

-- Every frame, go check game stuff. Even though it's turnbased (or what I want to do with it)
-- Go check whats going on every frame, incase I want to put some rules in there to do something
-- everyframe.
Runtime:addEventListener( "enterFrame", onUpdate )

--eof-