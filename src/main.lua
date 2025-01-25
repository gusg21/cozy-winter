local push = require("push")

local input = require("input")

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

    table.insert(world, bedroom)
    world.bedroom = room_new("assets/bgs/bed_room.png", roomlist.bedroom, roomlist.bedroom_floorcolliders)
    table.insert(world, livingroom)
    world.livingroom = room_new("assets/bgs/living_room.png", roomlist.livingroom, roomlist.livingroom_floorcolliders)
    world.currentRoom = world.bedroom

    table.insert(world, player)
    world.player = player_new()

    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())
end

function love.update(dt)
    world.currentRoom:update(world, input, dt)
    world.player:update(world, input, dt)
end

function love.draw()
    world.currentRoom:draw(world)
end