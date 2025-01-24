local push = require("push")

local gameWidth, gameHeight = 500, 500

local player_new = require("player")
local player

function love.load()
    love.window.setTitle("Hooky and Smoochus <3")

    player = player_new()
    bg = love.graphics.newImage("assets/bgs/test_room.png")

    push:setupScreen(gameWidth, gameHeight, love.graphics.getWidth(), love.graphics.getHeight(), {fullscreen = false, pixelperfect = true, highdpi = false, resizable =  true})
end

function love.update(dt)
    player:update(dt)

    push:resize(love.graphics.getWidth(), love.graphics.getHeight());
end

function love.draw()
    push:setBorderColor(0.2, 0.2, 0.2)
    push:start()
    love.graphics.draw(bg, (gameWidth/2)-(bg:getWidth()/2),
                           (gameHeight/2)-(bg:getHeight()/2))
    player:draw()
    push:finish()
end