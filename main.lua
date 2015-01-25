-- -- -- -- -- --
-- COMMON --
-- -- -- -- -- --

-- game settings --
local gameMode
local delta

-- resolution --
local screenX
local screenY
local offsetX
local offsetY
local areaX = 1000
local areaY = 800
local activeResolution
local numerOfResolutions

-- sound --
local sound
local soundText

-- debug --
local debugMode
local debugModeText

-- buttons --
local isEscPressed
local isSpacePressed
local isEnterPressed
local isUpPressed
local isDownPressed
local isLeftPressed
local isRightPressed

-- fonts --
local fontBig
local fontMedium
local fontSmall
local fontSmallMedium

-- images --
local pacmanSprites

-- game variables --

function loadStuff()
	fontBig = love.graphics.newFont(48)
	fontMedium = love.graphics.newFont(36)
	fontSmall = love.graphics.newFont(14)
	fontSmallMedium = love.graphics.newFont(28)

	pacmanSprites = {}
	pacmanSprites[1] = {}
	pacmanSprites[2] = {}
	pacmanSprites[3] = {}
	pacmanSprites[4] = {}
	pacmanSprites[1][1] = love.graphics.newImage("images/pacman/up/pacman1up.png")
	pacmanSprites[1][2] = love.graphics.newImage("images/pacman/up/pacman2up.png")
	pacmanSprites[1][3] = love.graphics.newImage("images/pacman/up/pacman3up.png")
	pacmanSprites[2][1] = love.graphics.newImage("images/pacman/right/pacman1right.png")
	pacmanSprites[2][2] = love.graphics.newImage("images/pacman/right/pacman2right.png")
	pacmanSprites[2][3] = love.graphics.newImage("images/pacman/right/pacman3right.png")
	pacmanSprites[3][1] = love.graphics.newImage("images/pacman/down/pacman1down.png")
	pacmanSprites[3][2] = love.graphics.newImage("images/pacman/down/pacman2down.png")
	pacmanSprites[3][3] = love.graphics.newImage("images/pacman/down/pacman3down.png")
	pacmanSprites[4][1] = love.graphics.newImage("images/pacman/left/pacman1left.png")
	pacmanSprites[4][2] = love.graphics.newImage("images/pacman/left/pacman2left.png")
	pacmanSprites[4][3] = love.graphics.newImage("images/pacman/left/pacman3left.png")

	cornerSprites = {}
	cornerSprites[1] = love.graphics.newImage("images/maze/1.png")
	cornerSprites[2] = love.graphics.newImage("images/maze/2.png")
	cornerSprites[3] = love.graphics.newImage("images/maze/3.png")
	cornerSprites[4] = love.graphics.newImage("images/maze/4.png")
	cornerSprites[5] = love.graphics.newImage("images/maze/5.png")
	cornerSprites[6] = love.graphics.newImage("images/maze/6.png")

	resetMenu()

	createResolutions()
	changeResolution(1)

	sound = false
	changeSoundSetting()
	debugMode = false
	changeDebugSetting()

	love.keyboard.setKeyRepeat(true)
end

-- game settings functions --

function createResolutions()
	-- creates a table of accepted resolutions --
	resolutions = {}

	resolutions[1] = {}
	resolutions[1].x = 1440
	resolutions[1].y = 900
	resolutions[1].name = "1440x900"

	resolutions[2] = {}
	resolutions[2].x = 1600
	resolutions[2].y = 900
	resolutions[2].name = "1600x900"

	resolutions[3] = {}
	resolutions[3].x = 1680
	resolutions[3].y = 1050
	resolutions[3].name = "1680x1050"

	resolutions[4] = {}
	resolutions[4].x = 1920
	resolutions[4].y = 1080
	resolutions[4].name = "1920x1800"

	resolutions[5] = {}
	resolutions[5].x = 2560
	resolutions[5].y = 1440
	resolutions[5].name = "2560x1440"

	numerOfResolutions = 5
end


function changeResolution(res)
	-- changes resolution --
	love.window.setMode(resolutions[res].x, resolutions[res].y, {fullscreen=true, fullscreentype="normal"})
	offsetX = (resolutions[res].x - areaX) / 2
	offsetY = (resolutions[res].y - areaY) / 2
	activeResolution = res
end

function white()
	love.graphics.setColor(255, 255, 255, 255)
end

function red()
	love.graphics.setColor(255, 0, 0, 255)
end

function blue()
	love.graphics.setColor(0, 0, 255, 255)
end

function yellow()
	love.graphics.setColor(255, 255, 0, 255)
end

function greenAlpha()
	love.graphics.setColor(0, 255, 0, 90)
end

function yellowAlpha()
	love.graphics.setColor(255, 255, 0, 127)
end

function redAlpha()
	love.graphics.setColor(255, 0, 0, 127)
end

function changeSoundSetting()
	if sound then
		sound = false
		soundText = "Off"
	else
		sound = true
		soundText = "On"
	end
end

function changeDebugSetting()
	if debugMode then
		debugMode = false
		debugModeText = "Off"
	else
		debugMode = true
		debugModeText = "On"
	end
end

-- -- -- -- -- --
-- MENU --
-- -- -- -- -- --

local menuBgR = 0
local menuBgG = 0
local menuBgB = 0

local menuMode
local menuActive

local menuTimer
local menuEnabled
local menuPositions = 4

function resetMenu()
	menuActive = 1
	menuTimer = 0
	menuEnabled = false
end

-- DRAW FUNCTIONS --

function drawArea()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("line", offsetX, offsetY, areaX, areaY)
end

function drawMenu()
	if menuMode == "main" then
		drawMainMenu()
	end
	if menuMode == "settings" then
		drawSettings()
	end
	if menuMode == "credits" then
		drawCredits()
	end
	drawGameDebugInfo()
end

function drawMainMenu()
	drawArea()
	love.graphics.setBackgroundColor(menuBgR, menuBgG, menuBgB)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(fontBig)
	love.graphics.print("PACMAN 0.2", offsetX+160, offsetY+100)
	love.graphics.setFont(fontMedium)
	if menuActive == 1 then red() else white() end
	love.graphics.print("NEW GAME", offsetX+200, offsetY+300)
	if menuActive == 2 then red() else white() end
	love.graphics.print("GAME SETTINGS", offsetX+200, offsetY+350)
	if menuActive == 3 then red() else white() end
	love.graphics.print("CREDITS", offsetX+200, offsetY+400)
	if menuActive == 4 then red() else white() end
	love.graphics.print("QUIT", offsetX+200, offsetY+450)
end

function drawSettings()
	drawArea()
	love.graphics.setBackgroundColor(menuBgR, menuBgG, menuBgB)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(fontBig)
	love.graphics.print("PACMAN 0.2 alpha", offsetX+160, offsetY+100)
	love.graphics.setFont(fontMedium)
	white()
	love.graphics.print("RESOLUTION", offsetX+200, offsetY+300)
	love.graphics.print("SOUND", offsetX+200, offsetY+350)
	love.graphics.print("DEV MODE", offsetX+200, offsetY+400)
	if menuActive == 1 then red() else white() end
	love.graphics.print(tostring(resolutions[activeResolution].name), offsetX+450, offsetY+300)
	if menuActive == 2 then red() else white() end
	love.graphics.print(tostring(soundText), offsetX+450, offsetY+350)
	if menuActive == 3 then red() else white() end
	love.graphics.print(tostring(debugModeText), offsetX+450, offsetY+400)
	if menuActive == 4 then red() else white() end
	love.graphics.print("SAVE", offsetX+450, offsetY+450)
end

function drawCredits()
	drawArea()
	love.graphics.setBackgroundColor(menuBgR, menuBgG, menuBgB)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setFont(fontBig)
	love.graphics.print("PACMAN 0.1 alpha", offsetX+160, offsetY+100)
	love.graphics.setFont(fontMedium)
	love.graphics.print("CREDITS", offsetX+200, offsetY+300)
	love.graphics.print("Game by Pawel Blach", offsetX+200, offsetY+400)
	love.graphics.print("Press space", offsetX+200, offsetY+500)
end

-- UPDATE FUNCTIONS --

function menuTimerWait()
	if menuTimer > 0.2 then
		menuEnabled = true
	else
		menuEnabled = false
	end
end

function menuTimerAdd()
	menuTimer = menuTimer + delta
end

function updateMenu()
	menuTimerWait()
	if isEscPressed then
		if menuEnabled then
			love.event.push( 'quit' )
		end
	end
	if menuMode == "main" then
		updateMainMenu()
	end
	if menuMode == "settings" then
		updateSettings()
	end
	if menuMode == "credits" then
		updateCredits()
	end
	if isUpPressed and (menuActive > 1) then
		if menuEnabled then
			menuActive = menuActive - 1
			menuTimer = 0
		end
	end
	if isDownPressed and (menuActive < menuPositions) then
		if menuEnabled then
			menuActive = menuActive + 1
			menuTimer = 0
		end
	end
	menuTimerAdd()
end

function updateMainMenu()
	if isEnterPressed and menuEnabled then
		if menuActive == 1 then
			menuPositions = 3
			initGame()
		end
		if menuActive == 2 then
			menuMode = "settings"
			menuPositions = 4
			resetMenu()
		end
		if menuActive == 3 then
			menuMode = "credits"
			resetMenu()
		end
		if menuActive == 4 then
			love.event.push( 'quit' )
		end
	end
end

function updateSettings()
	if isEnterPressed and menuEnabled then
		if menuActive == 1 then
			if activeResolution < numerOfResolutions then
				activeResolution = activeResolution + 1
			else
				activeResolution = 1
			end
			menuTimer = 0
		end
		if menuActive == 2 then
			changeSoundSetting()
			menuTimer = 0
		end
		if menuActive == 3 then
			changeDebugSetting()
			menuTimer = 0
		end
		if menuActive == 4 then
			changeResolution(activeResolution)
			menuPositions = 4
			resetMenu()
			menuMode = "main"
		end
	end
end

function updateCredits()
	if isSpacePressed then
		resetMenu()
		menuPositions = 4
		menuMode = "main"
	end
end

-- -- -- -- -- --
-- GAME --
-- -- -- -- -- --

local pacman
local tunnel
local mapSizeX
local mapSizeY
local gridSize = 24
local gridX = 28
local gridY = 30
local gridOffsetX
local gridOffsetY
local dotSize = 0.14 * gridSize
local score = 0
local lives = 3
local specialDotMaxTime = 3

function initPacman()
	pacman = {}
	pacman.mapX = 13
	pacman.mapY = 16
	pacman.lastMapX = pacman.mapX
	pacman.lastMapY = pacman.mapY
	pacman.x = pacman.mapX * gridSize + gridSize * 0.5
	pacman.y = pacman.mapY * gridSize + gridSize * 0.5
	pacman.speed = 140
	pacman.size = gridSize * 0.5 - 4
	pacman.sprite = 1
	pacman.spriteInc = true
	pacman.direction = 4
	pacman.directionText = "left"
	pacman.nextDirection = 4
	pacman.nextDirectionText = "left"
	pacman.movement = 0
	pacman.distance = 0
	pacman.image = 1
	pacman.specialDotActive = false
	pacman.specialDotTimer = 0
	pacman.upFree = false
	pacman.downFree = false
	pacman.leftFree = false
	pacman.rightFree = false
	pacman.sameSpriteTimer = 0
	if map[pacman.mapX][pacman.mapY-1] == false then
		pacman.upFree = true
	end
	if map[pacman.mapX][pacman.mapY+1] == false then
		pacman.downFree = true
	end
	if map[pacman.mapX-1][pacman.mapY] == false then
		pacman.leftFree = true
	end
	if map[pacman.mapX+1][pacman.mapY] == false then
		pacman.rightFree = true
	end
end

function initMap()
	local i
	local j
	local k

	contents, size = love.filesystem.read("maps/maze.map", gridX*gridY )
	map = {}
	for i = 0, gridX, 1 do
		map[i] = {}
		for j = 0, gridY, 1 do
			map[i][j] = false
		end
	end

	j = 0
	k = 0
	for i = 1, #contents do
    	local c = contents:sub(i,i)
    	if c == "1" then
    		map[j][k] = true
    	end
    	j = j + 1
    	if j == gridX then
    		j = 0
    		k = k + 1
    	end
	end

	contents, size = love.filesystem.read("maps/dots.map", gridX*gridY )
	dots = {}
	for i = 0, gridX, 1 do
		dots[i] = {}
		for j = 0, gridY, 1 do
			dots[i][j] = false
		end
	end

	j = 0
	k = 0
	for i = 1, #contents do
    	local c = contents:sub(i,i)
    	if c == "1" then
    		dots[j][k] = true
    	end
    	j = j + 1
    	if j == gridX then
    		j = 0
    		k = k + 1
    	end
	end

	contents, size = love.filesystem.read("maps/corners.map", gridX*gridY )
	corners = {}
	for i = 0, gridX, 1 do
		corners[i] = {}
		for j = 0, gridY, 1 do
			corners[i][j] = 0
		end
	end

	j = 0
	k = 0
	for i = 1, #contents do
    	local c = contents:sub(i,i)
    	if c == "1" then
    		corners[j][k] = 1
    	end
    	if c == "2" then
    		corners[j][k] = 2
    	end
    	if c == "3" then
    		corners[j][k] = 3
    	end
    	if c == "4" then
    		corners[j][k] = 4
    	end
    	if c == "5" then
    		corners[j][k] = 5
    	end
    	if c == "6" then
    		corners[j][k] = 6
    	end
    	j = j + 1
    	if j == gridX then
    		j = 0
    		k = k + 1
    	end
	end

	tunnel = {}
	tunnel[1] = {}
	tunnel[2] = {}
	tunnel[1].x = 1
	tunnel[1].y = 13
	tunnel[2].x = 26
	tunnel[2].y = 13

	specialDots = {}
	specialDots[1] = {}
	specialDots[2] = {}
	specialDots[3] = {}
	specialDots[4] = {}
	specialDots[1].x = 1
	specialDots[1].y = 3
	specialDots[1].active = true
	specialDots[2].x = 26
	specialDots[2].y = 3
	specialDots[2].active = true
	specialDots[3].x = 1
	specialDots[3].y = 22
	specialDots[3].active = true
	specialDots[4].x = 26
	specialDots[4].y = 22
	specialDots[4].active = true
end

function initGame()
	gameMode = "game"
	initMap()
	initPacman()
	gridOffsetX = (areaX * 0.5) - (gridX * gridSize * 0.5) + offsetX
	gridOffsetY = (areaY * 0.5) - (gridY * gridSize * 0.5) + offsetY
	pacman.lastMapX = pacman.mapX
	pacman.lastMapY = pacman.mapY
	initPause()
end

-- DRAW FUNCTIONS --

function drawGameDebugInfo()
	if debugMode then
		local debug_counter = 1
		local debug_offset = 15
		white()
		love.graphics.setFont(fontSmall)
   		love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, debug_counter*debug_offset)
   		if sound then
   			debug_counter = debug_counter + 1
   			love.graphics.print("Sound: On", 10, debug_counter*debug_offset)
   		end
   		if isUpPressed then
   			debug_counter = debug_counter + 1
   			love.graphics.print("Up pressed", 10, debug_counter*debug_offset)
   		end
   		if isDownPressed then
   			debug_counter = debug_counter + 1
   			love.graphics.print("Down pressed", 10, debug_counter*debug_offset)
   		end
   		if isLeftPressed then
   			debug_counter = debug_counter + 1
   			love.graphics.print("Left pressed", 10, debug_counter*debug_offset)
   		end
   		if isRightPressed then
   			debug_counter = debug_counter + 1
   			love.graphics.print("Right pressed", 10, debug_counter*debug_offset)
   		end
	end
end

function drawGrid()
	if debugMode then
		for i = 0, gridY, 1 do
			red()
			love.graphics.rectangle("fill", gridOffsetX, gridOffsetY+(i*gridSize), gridSize*gridX, 1)
			if (i < gridY) then
				white()
				love.graphics.setFont(fontSmall)
	   			love.graphics.print(tostring(i), gridOffsetX-20, gridOffsetY+(i*gridSize)+5)
	   		end
		end
		for i = 0, gridX, 1 do
			red()
			love.graphics.rectangle("fill", gridOffsetX+(i*gridSize), gridOffsetY, 1, gridSize*gridY)
			if (i < gridX) then
				white()
				love.graphics.setFont(fontSmall)
	   			love.graphics.print(tostring(i), gridOffsetX+(i*gridSize)+5, gridOffsetY-20)
	   		end
		end
	end
end

function drawPacman()
	--yellow()
	--love.graphics.circle("fill", pacman.x+gridOffsetX, pacman.y+gridOffsetY, pacman.size, 50)
	white()
	--love.graphics.draw(pacmanSprites[pacman.sprite], pacman.x+gridOffsetX-8.5, pacman.y+gridOffsetY-8.5) --math.rad(90*(pacman.direction-1)))
	love.graphics.draw(pacmanSprites[pacman.direction][pacman.sprite], pacman.x+gridOffsetX-8.5, pacman.y+gridOffsetY-8.5)
	drawPacmanDebug()
end

function drawPacmanDebug()
	if debugMode then
		local debug_counter = 1
		local debug_offset = 15
		white()
		love.graphics.setFont(fontSmall)
		debug_counter = debug_counter + 1
		love.graphics.print("Pacman distance: "..tostring(pacman.distance), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1		
   		love.graphics.print("Pacman speed: "..tostring(pacman.speed), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1
   		love.graphics.print("Pacman direction: "..tostring(pacman.directionText), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1
   		love.graphics.print("Pacman next direct: "..tostring(pacman.nextDirectionText), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1
   		love.graphics.print("Pacman mapY: "..tostring(pacman.mapY), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1
   		love.graphics.print("Pacman mapX: "..tostring(pacman.mapX), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1
   		love.graphics.print("Pacman Y: "..tostring(pacman.y), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		debug_counter = debug_counter + 1
   		love.graphics.print("Pacman X: "..tostring(pacman.x), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		if pacman.specialDotActive then
   			debug_counter = debug_counter + 1
   			love.graphics.print("specialDotTimer: "..tostring(pacman.specialDotTimer), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   			debug_counter = debug_counter + 1
   			love.graphics.print("specialDotActive: "..tostring(pacman.specialDotActive), 10, (resolutions[activeResolution].y - debug_counter * debug_offset))
   		end
   		yellowAlpha()
   		love.graphics.rectangle("fill", pacman.mapX * gridSize + gridOffsetX, pacman.mapY * gridSize + gridOffsetY, gridSize, gridSize)
   		if pacman.upFree then
   			greenAlpha()
   			love.graphics.rectangle("fill", pacman.mapX * gridSize + gridOffsetX, (pacman.mapY-1) * gridSize + gridOffsetY, gridSize, gridSize)
   		else
   			redAlpha()
   			love.graphics.rectangle("fill", pacman.mapX * gridSize + gridOffsetX, (pacman.mapY-1) * gridSize + gridOffsetY, gridSize, gridSize)
   		end
   		if pacman.downFree then
   			greenAlpha()
   			love.graphics.rectangle("fill", pacman.mapX * gridSize + gridOffsetX, (pacman.mapY+1) * gridSize + gridOffsetY, gridSize, gridSize)
   		else
   			redAlpha()
   			love.graphics.rectangle("fill", pacman.mapX * gridSize + gridOffsetX, (pacman.mapY+1) * gridSize + gridOffsetY, gridSize, gridSize)
   		end
   		if pacman.leftFree then
   			greenAlpha()
   			love.graphics.rectangle("fill", (pacman.mapX-1) * gridSize + gridOffsetX, pacman.mapY * gridSize + gridOffsetY, gridSize, gridSize)
   		else
   			redAlpha()
   			love.graphics.rectangle("fill", (pacman.mapX-1) * gridSize + gridOffsetX, pacman.mapY * gridSize + gridOffsetY, gridSize, gridSize)
   		end
   		if pacman.rightFree then
   			greenAlpha()
   			love.graphics.rectangle("fill", (pacman.mapX+1) * gridSize + gridOffsetX, pacman.mapY * gridSize + gridOffsetY, gridSize, gridSize)
   		else
   			redAlpha()
   			love.graphics.rectangle("fill", (pacman.mapX+1) * gridSize + gridOffsetX, pacman.mapY * gridSize + gridOffsetY, gridSize, gridSize)
   		end
	end
end

function drawMaze()
	white()
	for i = 0, gridX, 1 do
		for j = 0, gridY, 1 do
			if corners[i][j] > 0 then
				--love.graphics.rectangle("fill", i * gridSize + gridOffsetX, j * gridSize + gridOffsetY, gridSize, gridSize)
				love.graphics.draw(cornerSprites[corners[i][j]], i * gridSize + gridOffsetX, j * gridSize + gridOffsetY)
			end
		end
	end	
	drawMazeDebug()
end

function drawMazeDebug()
	if debugMode then
		blue()
		for i = 0, gridX, 1 do
			for j = 0, gridY, 1 do
				if map[i][j] then
					love.graphics.rectangle("fill", i * gridSize + gridOffsetX, j * gridSize + gridOffsetY, gridSize, gridSize)
				end
			end
		end	
	end
end

function drawDots()
	white()
	for i = 0, gridX, 1 do
		for j = 0, gridY, 1 do
			if dots[i][j] then
				love.graphics.circle("fill", i * gridSize + gridOffsetX + 0.5 * gridSize, j * gridSize + gridOffsetY + 0.5 * gridSize, dotSize, 50)
			end
		end
	end
end

function drawSpecialDots()
	white()
	for i = 1, 4, 1 do
		if specialDots[i].active then
			local specialDotX = specialDots[i].x * gridSize + gridOffsetX + 0.5 * gridSize
			local specialDotY = specialDots[i].y * gridSize + gridOffsetY + 0.5 * gridSize			
			love.graphics.circle("fill", specialDotX, specialDotY, dotSize * 2, 50)
		end
	end
end

function drawScore()
	--
end

function drawLives()
	--
end


function drawGame()
	drawMaze()
	drawDots()
	drawSpecialDots()
	drawScore()
	drawLives()
	drawPacman()
	drawGrid()
	drawGameDebugInfo()
end

-- UPDATE FUNCTIONS --

function updatePacman()
	-- update input --
	if isUpPressed then
		pacman.nextDirection = 1
		pacman.nextDirectionText = "up"		
	end
	if isDownPressed then
		pacman.nextDirection = 3
		pacman.nextDirectionText = "down"
	end
	if isLeftPressed then
		pacman.nextDirection = 4
		pacman.nextDirectionText = "left"
	end
	if isRightPressed then
		pacman.nextDirection = 2
		pacman.nextDirectionText = "right"
	end

	-- check if pacman reaches a tunnel --

	if (pacman.mapX == tunnel[1].x) and (pacman.mapY == tunnel[1].y) then
		pacman.mapX = tunnel[2].x - 1
		pacman.mapY = tunnel[2].y
		pacman.x = pacman.mapX * gridSize + gridSize * 0.5
		pacman.y = pacman.mapY * gridSize + gridSize * 0.5
	end

	if (pacman.mapX == tunnel[2].x) and (pacman.mapY == tunnel[2].y) then
		pacman.mapX = tunnel[1].x + 1
		pacman.mapY = tunnel[1].y
		pacman.x = pacman.mapX * gridSize + gridSize * 0.5
		pacman.y = pacman.mapY * gridSize + gridSize * 0.5
	end


	-- chceck if left/right/up/down free --
	pacman.upFree = false
	pacman.downFree = false
	pacman.leftFree = false
	pacman.rightFree = false
	if map[pacman.mapX][pacman.mapY-1] == false then
		pacman.upFree = true
	end
	if map[pacman.mapX][pacman.mapY+1] == false then
		pacman.downFree = true
	end
	if map[pacman.mapX-1][pacman.mapY] == false then
		pacman.leftFree = true
	end
	if map[pacman.mapX+1][pacman.mapY] == false then
		pacman.rightFree = true
	end

	-- check if pacman out of his box --
	if pacman.x < (pacman.mapX * gridSize + gridSize) then
		pacman.mapX = pacman.mapX - 1
	end
	if pacman.x > (pacman.mapX * gridSize + gridSize) then
		pacman.mapX = pacman.mapX + 1
	end
	if pacman.y < (pacman.mapY * gridSize + gridSize) then
		pacman.mapY = pacman.mapY - 1
	end
	if pacman.y > (pacman.mapY * gridSize + gridSize) then
		pacman.mapY = pacman.mapY + 1
	end

	-- calculate pacman movement --

	pacman.movement = delta * pacman.speed

	-- check if pacman can move --

	if pacman.direction == 1 then
		if pacman.upFree then
			pacman.y = pacman.y - pacman.movement
		end
		if pacman.y > (pacman.mapY * gridSize + 0.5 * gridSize) then
			pacman.y = pacman.y - pacman.movement
		end
	end

	if pacman.direction == 3 then
		if pacman.downFree then
			pacman.y = pacman.y + pacman.movement
		end
		if pacman.y < (pacman.mapY * gridSize + 0.5 * gridSize) then
			pacman.y = pacman.y + pacman.movement
		end
	end

	if pacman.direction == 2 then
		if pacman.rightFree then
			pacman.x = pacman.x + pacman.movement
		end
		if pacman.x < (pacman.mapX * gridSize + 0.5 * gridSize) then
			pacman.x = pacman.x + pacman.movement
		end
	end

	if pacman.direction == 4 then
		if pacman.leftFree then
			pacman.x = pacman.x - pacman.movement
		end
		if pacman.x > (pacman.mapX * gridSize + 0.5 * gridSize) then
			pacman.x = pacman.x - pacman.movement
		end
	end

	-- check if pacman can change direction and if he can, do so --

	if pacman.direction ~= pacman.nextDirection then
		if (math.abs(pacman.x - (pacman.mapX * gridSize + 0.5 * gridSize)) < 2.5) and (math.abs(pacman.y - (pacman.mapY * gridSize + 0.5 * gridSize)) < 2.5) then
			if (pacman.nextDirection == 1) and pacman.upFree then
				pacmanChangeDirection()
			end
			if (pacman.nextDirection == 3) and pacman.downFree then
				pacmanChangeDirection()
			end
			if (pacman.nextDirection == 2) and pacman.rightFree then
				pacmanChangeDirection()
			end
			if (pacman.nextDirection == 4) and pacman.leftFree then
				pacmanChangeDirection()
			end
		end
	end

	-- check if pacman is on a dot --

	if (dots[pacman.mapX][pacman.mapY] == true) then
		dots[pacman.mapX][pacman.mapY] = false
		score = score + 1
	end

	-- check if pacman is on a special dot --
	for i = 1, 4, 1 do
		if (specialDots[i].x == pacman.mapX) and (specialDots[i].y == pacman.mapY) then
			if specialDots[i].active then
				specialDots[i].active = false
				pacman.specialDotActive = true
			end
		end
	end

	-- update pacman special dot timer --
	if pacman.specialDotActive then
		if pacman.specialDotTimer > specialDotMaxTime then
			pacman.specialDotTimer = 0
			pacman.specialDotActive = false
		else
			pacman.specialDotTimer = pacman.specialDotTimer + delta
		end
	end

	-- calculate pacman distance and update sprite --
	if (pacman.lastMapX > pacman.mapX) or (pacman.lastMapX < pacman.mapX) then
		pacman.lastMapX = pacman.mapX
		increasePacmanDistance()
		increasePacmanSprite()
		pacman.sameSpriteTimer = 0
	end
	if (pacman.lastMapY > pacman.mapY) or (pacman.lastMapY < pacman.mapY) then
		pacman.lastMapY = pacman.mapY
		increasePacmanDistance()
		increasePacmanSprite()
		pacman.sameSpriteTimer = 0
	end
	if (pacman.lastMapX == pacman.mapX) and (pacman.lastMapY == pacman.mapY) then
		pacman.sameSpriteTimer = pacman.sameSpriteTimer + delta
	end
	if pacman.sameSpriteTimer > 0.2 then
		pacman.sprite = 1
		pacman.spriteInc = true
	end

end

function increasePacmanDistance()
	pacman.distance = pacman.distance + 1
end

function increasePacmanSprite()
	if pacman.sprite == 3 then
		pacman.spriteInc = false
	end
	if pacman.sprite == 1 then
		pacman.spriteInc = true
	end
	if pacman.spriteInc then
		pacman.sprite = pacman.sprite + 1
	end
	if pacman.spriteInc == false then
		pacman.sprite = pacman.sprite - 1
	end
end


function pacmanChangeDirection()
	pacman.direction = pacman.nextDirection
	pacman.directionText = pacman.nextDirectionText
	pacman.x = pacman.mapX * gridSize + gridSize * 0.5
	pacman.y = pacman.mapY * gridSize + gridSize * 0.5
end

function updateGame()
	menuTimerWait()
	if isEscPressed and menuEnabled then
		gameMode = "pause"
		menuTimer = 0
	end
	updatePacman()
	menuTimerAdd()
end

-- -- -- -- -- --
-- PAUSE --
-- -- -- -- -- --

local pauseOffsetX
local pauseOffsetY
local pauseSizeX
local pauseSizeY

function initPause()
	pauseOffsetX = gridOffsetX + 6 * gridSize
	pauseOffsetY = gridOffsetY + 10 * gridSize
	pauseSizeX = gridX * gridSize - 2 * 6 * gridSize
	pauseSizeY = gridY * gridSize - 2 * 10 * gridSize
end

-- DRAW FUNCTIONS --

function drawPause()
	drawGame()
	love.graphics.setColor(0, 0, 0, 100)
	love.graphics.rectangle("fill", 0, 0, resolutions[activeResolution].x, resolutions[activeResolution].y)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle("fill", pauseOffsetX, pauseOffsetY, pauseSizeX, pauseSizeY)

	white()
	love.graphics.setFont(fontMedium)
	love.graphics.print("PAUSE", pauseOffsetX+30, pauseOffsetY+20)
	love.graphics.setFont(fontSmallMedium)
	if menuActive == 1 then red() else white() end
	love.graphics.print("RETURN TO GAME", pauseOffsetX+30, pauseOffsetY+80)
	if menuActive == 2 then red() else white() end
	love.graphics.print("RETURN TO MENU", pauseOffsetX+30, pauseOffsetY+130)
	if menuActive == 3 then red() else white() end
	love.graphics.print("QUIT GAME", pauseOffsetX+30, pauseOffsetY+180)
	white()
	love.graphics.setFont(fontSmall)
	love.graphics.print("Press space to toggle dev mode", pauseOffsetX+30, pauseOffsetY+220)
end

-- UPDATE FUNCTIONS --

function updatePause()
	menuTimerWait()
	if isSpacePressed and menuEnabled then
		if debugMode then
			debugMode = false
		else
			debugMode = true
		end
		menuTimer = 0
	end
	if isEscPressed and menuEnabled then
		gameMode = "game"
		menuTimer = 0
		resetMenu()
	end
	if isUpPressed and (menuActive > 1) then
		if menuEnabled then
			menuActive = menuActive - 1
			menuTimer = 0
		end
	end
	if isDownPressed and (menuActive < menuPositions) then
		if menuEnabled then
			menuActive = menuActive + 1
			menuTimer = 0
		end
	end
	if isEnterPressed and menuEnabled then
		if menuActive == 1 then
			gameMode = "game"
			menuTimer = 0
			resetMenu()
		end
		if menuActive == 2 then
			gameMode = "menu"
			menuMode = "main"
			menuPositions = 4
			resetMenu()
		end
		if menuActive == 3 then
			love.event.push( 'quit' )
		end
	end
	menuTimerAdd()
end

-- LUA DEFAULT FUNCTIONS --

function love.load()
	loadStuff()
	gameMode = "menu"
	menuMode = "main"
end

function love.draw()
   	if gameMode == "menu" then
   		drawMenu()
   	end
   	if gameMode == "game" then
   		drawGame()
   	end
   	if gameMode == "pause" then
   		drawPause()
   	end 	
end

function love.update(dt)
	delta = dt
	if gameMode == "menu" then
		updateMenu()
	end
	if gameMode == "game" then
		updateGame()
	end
	if gameMode == "pause" then
		updatePause()
	end
end

function love.focus(bool)
end

function love.keypressed( key, unicode )
	if key == "escape" then
		isEscPressed = true
	end
	if key == " " then
		isSpacePressed = true
	end
	if key == "return" then
		isEnterPressed = true
	end
	if key == "up" then
		isUpPressed = true
	end
	if key == "down" then
		isDownPressed = true
	end
	if key == "left" then
		isLeftPressed = true
	end
	if key == "right" then
		isRightPressed = true
	end
end

function love.keyreleased( key, unicode )
	if key == "escape" then
		isEscPressed = false
	end
	if key == " " then
		isSpacePressed = false
	end
	if key == "return" then
		isEnterPressed = false
	end
	if key == "up" then
		isUpPressed = false
	end
	if key == "down" then
		isDownPressed = false
	end
	if key == "left" then
		isLeftPressed = false
	end
	if key == "right" then
		isRightPressed = false
	end
end

function love.quit()
end