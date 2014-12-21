-- -- -- -- -- --
-- COMMON --
-- -- -- -- -- --

local gameMode

local delta

-- buttons --
local isEscPressed
local isSpacePressed
local isUpPressed
local isDownPressed
local isLeftPressed
local isRightPressed

function loadStuff()
	--
end









-- -- -- -- -- --
-- MENU --
-- -- -- -- -- --

local menuBgR = 0
local menuBgG = 0
local menuBgB = 0

local menuMode

-- DRAW FUNCTIONS --

function drawMenu()
	love.graphics.setBackgroundColor( menuBgR, menuBgG, menuBgB)
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.print("Pacman 0.1a", 700, 450)
	love.graphics.print("Press space to continue", 700, 465)
end

-- UPDATE FUNCTIONS --

function updateMenu()
	if isSpacePressed then
		gameMode = "game"
	end
end







-- -- -- -- -- --
-- GAME --
-- -- -- -- -- --

-- DRAW FUNCTIONS --

function drawGameDebugInfo()
	love.graphics.setColor( 255, 255, 255, 255 )
   	love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 25)
end

function drawGame()
	drawGameDebugInfo()
end

-- UPDATE FUNCTIONS --

function updateGame()
	if isEscPressed == true then
		love.event.push( 'quit' )
	end
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
end

function love.update(dt)
	delta = dt
	if gameMode == "menu" then
		updateMenu()
	end
	if gameMode == "game" then
		updateGame()
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
	if key == "up" then
		isDownPressed = true
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
	if key == "up" then
		isDownPressed = false
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