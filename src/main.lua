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

local fade_out_factor = 0
local has_resized_for_outro = false
local outro_font = love.graphics.newFont("assets/elliott.ttf", 32)

local snowflakes = {}

function reset_snowflakes()
    snowflakes = {}
    for i = 1, 100, 1 do
        table.insert(snowflakes, {
            x = love.math.random(0, world.currentRoom.bg:getWidth()),
            y = love.math.random(0, world.currentRoom.bg:getHeight()),
            xvel = (math.random() - 0.5) * 100,
            xaccel = (math.random() - 0.5) * 100,
            yvel = math.random(15, 50)
        })
    end
end

function love.load()
    -- Window setup
    love.window.setTitle("Hooky and Smoochus <3")
    love.graphics.setBackgroundColor(0.67, 0.62, 0.91)
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
    table.insert(world.kitchen.floorcols, roomlist.kitchen_floorcolliders2)
    world.game_room = room_new("assets/bgs/game_room.png", roomlist.game_room, roomlist.game_room_floor_colliders);

    -- Init player
    world.player = player_new()

    -- Set starting room
    world.currentRoom = world.bedroom
    
    -- Tasks
    world.task_num = 0
    world.complete = false

    -- Helper
    world.find_furn = function(furn_name)
        for key, furn in pairs(world.currentRoom.furniture) do
            if furn.name == furn_name then
                return furn
            end
        end
        return nil
    end

    -- Size window to starting room image
    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())

    -- Create snowflakes
    reset_snowflakes()

    local start_sound = love.audio.newSource("assets/audio/sfx/gameStart.mp3", "static")
    start_sound:play()
end

function love.resized()
    reset_snowflakes()
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
    love.graphics.setColor(1, 1, 1, 1)
    world.currentRoom:update(world, dt)
    if world.complete then
        fade_out_factor = fade_out_factor + dt
    end
    input.reset()

    for index, flake in ipairs(snowflakes) do
        flake.xaccel = flake.xaccel + (math.random() - 0.5) * 1000
        flake.xaccel = math.max(-1000, math.min(flake.xaccel, 1000))
        flake.xvel = flake.xvel + flake.xaccel * dt * dt
        flake.x = flake.x + flake.xvel * dt
        flake.y = flake.y + dt * flake.yvel

        if flake.y > love.graphics.getHeight() + 20 or flake.x < -100 or flake.x > love.graphics.getWidth() then
            flake.y = -20
            flake.x = math.random() * love.graphics.getWidth()
            flake.xvel = (math.random() - 0.5) * 100
            flake.xaccel = (math.random() - 0.5) * 100
            flake.yvel = math.random(15, 50)
        end
    end
end

function love.draw()
    for index, flake in ipairs(snowflakes) do
        love.graphics.setColor(0.8, 0.8, 0.83, 1)
        love.graphics.rectangle("fill", flake.x, flake.y, 5, 5)
    end

    world.currentRoom:draw(world)

    love.graphics.setColor(20/255, 16/255, 19/255, math.min(fade_out_factor / 3, 1))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    if fade_out_factor > 6 then
        if not has_resized_for_outro then
            love.window.setMode(800, 600)
            has_resized_for_outro = true
        end
        outro_text = love.graphics.newText(outro_font, "Thank you for playing!\nMade with LOVE2D by James, Angus, And Braeden.\nCozy Winter Jam 2025")
        love.graphics.setColor(0.8, 0.8, 0.8, 1)
        love.graphics.draw(outro_text, love.graphics.getWidth() / 2 - outro_text:getWidth() / 2, love.graphics.getHeight() / 2 - outro_text:getHeight() / 2)
    end
end
