local player_new = require("player")
local player

function love.load()
    player = player_new()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end