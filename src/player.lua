local vec2 = require("cpml/vec2")
local input = require("input")

local base_click_sound = love.audio.newSource("assets/audio/sfx/UIClick.mp3", "static")

local function pointInConvexPolygon(x, y, poly)
    local imax = #poly

    local function isVerticesClockwise(poly)
        local sum = 0
        local imax = #poly
        local x1, y1 = poly[imax - 1], poly[imax]
        for i = 1, imax - 1, 2 do
            local x2, y2 = poly[i], poly[i + 1]
            sum = sum + (x2 - x1) * (y2 + y1)
            x1, y1 = x2, y2
        end
        local isClockwise = sum < 0
        return isClockwise
    end

    local sign = isVerticesClockwise(poly) and 1 or -1
    local x1, y1 = poly[imax - 1], poly[imax]
    for i = 1, imax - 1, 2 do
        local x2, y2 = poly[i], poly[i + 1]
        local dotProduct = (x - x1) * (y1 - y2) + (y - y1) * (x2 - x1)
        if sign * dotProduct < 0 then
            return false
        end
        x1, y1 = x2, y2
    end
    return true
end

local function player_update(player, world, dt)
    player.is_moving = false

    if world.complete then return end

    -- Do WASD movement
    if not world.currentRoom.editing then
        local in_room = false
        local in_furniture = false
        if input.keyHeld("w") then
            local next_pos = player.pos.y - (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil and not furniture.trigger then
                    if pointInConvexPolygon(player.pos.x, next_pos, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            for i, coltable in ipairs(world.currentRoom.floorcols) do
                if pointInConvexPolygon(player.pos.x, next_pos, coltable) then
                    in_room = true
                end
            end
            if not in_furniture and in_room then
                player.pos.y = next_pos
                player.is_moving = true
            end
        end
        if input.keyHeld("a") then
            local next_pos = player.pos.x - (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil and not furniture.trigger then
                    if pointInConvexPolygon(next_pos, player.pos.y, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            for i, coltable in ipairs(world.currentRoom.floorcols) do
                if pointInConvexPolygon(next_pos, player.pos.y, coltable) then
                    in_room = true
                end
            end

            if not in_furniture and in_room then
                player.pos.x = next_pos
                player.flip_image = false
                player.is_moving = true
            end
        end
        if input.keyHeld("s") then
            local next_pos = player.pos.y + (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil and not furniture.trigger then
                    if pointInConvexPolygon(player.pos.x, next_pos, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            for i, coltable in ipairs(world.currentRoom.floorcols) do
                if pointInConvexPolygon(player.pos.x, next_pos, coltable) then
                    in_room = true
                end
            end
            if not in_furniture and in_room then
                player.pos.y = next_pos
                player.is_moving = true
            end
        end
        if input.keyHeld("d") then
            local next_pos = player.pos.x + (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil and not furniture.trigger then
                    if pointInConvexPolygon(next_pos, player.pos.y, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            for i, coltable in ipairs(world.currentRoom.floorcols) do
                if pointInConvexPolygon(next_pos, player.pos.y, coltable) then
                    in_room = true
                end
            end
            if not in_furniture and in_room then
                player.pos.x = next_pos
                player.flip_image = true
                player.is_moving = true
            end
        end

        in_room = true
        in_furniture = false
    end

    local time = 0.2
    if player.is_moving and not player.was_moving then
        local sound = player.step_sounds[love.math.random(1, 7)]
        sound:setVolume(0.2)
        sound:play()
        player.walk_sound_counter = time
    end

    if player.is_moving then
        player.walk_sound_counter = player.walk_sound_counter - dt
        if player.walk_sound_counter <= 0 then
            local sound = player.step_sounds[love.math.random(1, 7)]
            sound:setVolume(0.1)
            sound:play()
            player.walk_sound_counter = time
        end
    end

    if not player.is_moving then
        player.walk_sound_counter = 0
    end

    -- Clicking on colliders
    if input.mouseReleased(1) then
        local x, y = love.mouse.getPosition()
        local mouX = x ~= nil
        local mouY = y ~= nil

        local mouseVec = vec2.new(x, y)
        local iscloseenough = vec2.dist(mouseVec, player.pos) < 100
        for i, furniture in ipairs(world.currentRoom.furniture) do
            if furniture.colliders ~= nil and not furniture.hidden then
                if mouX and mouY and pointInConvexPolygon(x, y, furniture.colliders) then
                    if furniture.on_clicked ~= nil and iscloseenough then
                        local uiclick = base_click_sound
                        local nothing = false
                        if furniture.click_sound then
                            if furniture.click_sound ~= "none" then
                                uiclick = furniture.click_sound
                            else
                                nothing = true
                            end
                        end
                        if not nothing then
                            uiclick:setPitch(math.random() * 0.5 + 0.8)
                            love.audio.play(uiclick)
                        end
                        furniture.on_clicked(world, furniture)
                        break
                    end
                end
            end
        end
    end

    player.was_moving = player.is_moving
end

local function player_draw(player)
    local flip_x = 1
    if player.flip_image then
        flip_x = -1
    end

    -- Check if player flipped
    local image = player.image
    if player.is_moving then
        love.graphics.draw(player.walk_images[math.floor(((love.timer.getTime() * 15) % 4) + 1)], player.pos.x,
            player.pos.y - 10, 0, flip_x, 1,
            player.image:getWidth() / 2, player.image:getHeight() / 2)
    else
        love.graphics.draw(player.image, player.pos.x, player.pos.y - 10, 0, flip_x, 1,
            player.image:getWidth() / 2, player.image:getHeight() / 2)
    end


    if player.held_item ~= nil then
        love.graphics.draw(player.held_item.image, player.pos.x, player.pos.y - 20, 0, flip_x, 1,
            player.held_item.image:getWidth() / 2,
            player.held_item.image:getHeight() / 2)
    end
end

local function player_hold_item(player, item)
    player.held_item = item
end

local function player_new()
    return {
        pos = vec2.new(215, 300),
        speed = 100,
        image = love.graphics.newImage("assets/player/hooky.png"),
        walk_images = {
            love.graphics.newImage("assets/player/hooky2.png"),
            love.graphics.newImage("assets/player/hooky3.png"),
            love.graphics.newImage("assets/player/hooky4.png"),
            love.graphics.newImage("assets/player/hooky5.png"),
        },
        step_sounds = {
            love.audio.newSource("assets/audio/sfx/footStep01.wav", "static"),
            love.audio.newSource("assets/audio/sfx/footStep02.wav", "static"),
            love.audio.newSource("assets/audio/sfx/footStep03.wav", "static"),
            love.audio.newSource("assets/audio/sfx/footStep04.wav", "static"),
            love.audio.newSource("assets/audio/sfx/footStep05.wav", "static"),
            love.audio.newSource("assets/audio/sfx/footStep06.wav", "static"),
            love.audio.newSource("assets/audio/sfx/footStep07.wav", "static"),
        },
        flip_image = false,
        held_item = nil,
        update = player_update,
        draw = player_draw,
        hold_item = player_hold_item,
        is_moving = false,
        walk_sound_counter = 0,
        was_moving = false
    }
end

return player_new
