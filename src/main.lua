local push = require("push")
local player_new = require("player")
local room_new = require("room")
local roomlist = require("roomlists")
local input = require("input")

local player
local bedroom, livingroom, kitchen

local bgtrack, ambience
local play_music = true

local world = {
    currentRoom = nil,
}

function love.load()
    -- Window setup
    love.window.setTitle("Hooky and Smoochus <3")
    love.graphics.setBackgroundColor(0.91, 0.62, 0.72)
    love.window.setVSync(1)
    bgtrack = love.audio.newSource("assets/audio/music/CARE.mp3", "static")
    ambience = love.audio.newSource("assets/audio/music/PATIENCE.mp3", "static")
    love.audio.play(bgtrack)

    -- Add objects to world
    table.insert(world, bedroom)
    table.insert(world, livingroom)
    table.insert(world, kitchen)
    table.insert(world, player)

    -- Init rooms
    world.bedroom = room_new("assets/bgs/bed_room.png", roomlist.bedroom, roomlist.bedroom_floorcolliders)
    world.livingroom = room_new("assets/bgs/living_room.png", roomlist.livingroom, roomlist.livingroom_floorcolliders)
    world.kitchen = room_new("assets/bgs/kitchen.png", roomlist.kitchen, roomlist.kitchen_floorcolliders)

    -- Init player
    world.player = player_new()

    -- Set starting room
    world.currentRoom = world.bedroom

    -- Size window to starting room image
    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())
end

function love.update(dt)
    if not bgtrack:isPlaying() and not ambience:isPlaying() then
        play_music = not play_music
    end
    if play_music then
        love.audio.play(bgtrack)
    else
        love.audio.play(ambience)
    end
    world.currentRoom:update(world, dt)
    input.reset()
end

function love.draw()
    world.currentRoom:draw(world)
end
