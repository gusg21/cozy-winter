local push = require("push")
local player_new = require("player")
local room_new = require("room")
local roomlist = require("roomlists")

local player
local bedroom, livingroom

local world = {
    currentRoom = nil,
}

function love.load()
    -- Window setup
    love.window.setTitle("Hooky and Smoochus <3")
    love.graphics.setBackgroundColor(0.91, 0.62, 0.72)
    love.window.setVSync(1)

    -- Add objects to world
    table.insert(world, bedroom)
    table.insert(world, livingroom)
    table.insert(world, player)

    -- Init rooms
    world.bedroom = room_new("assets/bgs/bed_room.png", roomlist.bedroom, roomlist.bedroom_floorcolliders)
    world.livingroom = room_new("assets/bgs/living_room.png", roomlist.livingroom, roomlist.livingroom_floorcolliders)

    -- Init player
    world.player = player_new()

    -- Set starting room
    world.currentRoom = world.bedroom

    -- Size window to starting room image
    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())
end

function love.update(dt)
    world.currentRoom:update(world, dt)
end

function love.draw()
    world.currentRoom:draw(world)
end
