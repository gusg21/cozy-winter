local push = require("push")

local gameWidth, gameHeight = 500, 500
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false})

local player_new = require("player")
local player

function love.load()
    love.window.setTitle("Hooky and Smoochus <3")

    player = player_new()
    bg = love.graphics.newImage("assets/bgs/test_room.png")
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    push:setBorderColor(0.2, 0.2, 0.2)
    push:start()
    love.graphics.draw(bg, (gameWidth/2)-(bg:getWidth()/2),
                           (gameHeight/2)-(bg:getHeight()/2))
    player:draw()
    push:finish()
end