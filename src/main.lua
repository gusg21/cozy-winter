local player_new = require("player")
local player

function love.load()
    player = player_new()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    bg = love.graphics.newImage("assets/bgs/test_room.png")
    love.graphics.scale(2, 2)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.draw(bg, (love.graphics.getWidth()/2)-(bg:getWidth()/2),
                           (love.graphics.getHeight()/2)-(bg:getHeight()/2))
    player:draw()
end