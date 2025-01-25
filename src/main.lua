local push = require("push")

local gameWidth, gameHeight = 500, 500

local world = {
    currentRoom = nil,
}

local room_new = require("room")
local roomlist = require("roomlists")
local bedroom, livingroom

local player_new = require("player")
local player

function love.load()
    love.window.setTitle("Hooky and Smoochus <3")
    push:setupScreen(gameWidth, gameHeight, love.graphics.getWidth(), love.graphics.getHeight(), {fullscreen = false, pixelperfect = true, highdpi = false, resizable =  true})

    table.insert(world, bedroom)
    world.bedroom = room_new("assets/bgs/bed_room.png", roomlist.bedroom, roomlist.bedroom_floorcolliders)
    table.insert(world, livingroom)
    world.livingroom = room_new("assets/bgs/living_room.png", roomlist.livingroom, roomlist.livingroom_floorcolliders)
    world.currentRoom = world.bedroom

    table.insert(world, player)
    world.player = player_new()
end

function love.update(dt)
    world.currentRoom:update(dt)
    world.player:update(world, dt)
    push:resize(love.graphics.getWidth(), love.graphics.getHeight());
end

function love.draw()
    push:setBorderColor(0.2, 0.2, 0.2)
    push:start()

    world.currentRoom:draw(world, gameWidth, gameHeight)

    push:finish()
end