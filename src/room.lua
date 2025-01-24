local function room_update(room, dt)
    -- nothing yet
end

local function room_draw(room, sw, sh)
    love.graphics.draw(room.bg, (sw/2)-(bg:getWidth()/2),
                           (sh/2)-(bg:getHeight()/2))
end

local function room_new(bgfilename)
    return {
        bg = love.graphics.newImage(bgfilename),
        update = room_update,
        draw = room_draw
    }
end

return room_new