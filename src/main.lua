local push = require("push")

local gameWidth, gameHeight = 500, 500

local room_new = require("room")
local bedroom

local player_new = require("player")
local player

local world = {}

function love.load()
    love.window.setTitle("Hooky and Smoochus <3")

    table.insert(world, bedroom)
    world.bedroom = room_new("assets/bgs/test_room.png")

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
    world.bedroom:draw(gameWidth, gameHeight)
    player:draw()
    push:finish()
end