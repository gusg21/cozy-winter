local function room_update(room, dt)
    -- nothing yet
end

local function room_draw(room, sw, sh)
    love.graphics.draw(room.bg, (sw/2)-(room.bg:getWidth()/2),
                                (sh/2)-(room.bg:getHeight()/2))
    for i,furniture in ipairs(room.furniture) do 
        love.graphics.draw(furniture.image, furniture.x + room.bg:getWidth()/2, furniture.y + room.bg:getHeight()/2)
    end
end

local function room_new(bgfilename, furniturelist)
    return {
        bg = love.graphics.newImage(bgfilename),
        furniture = furniturelist,
        update = room_update,
        draw = room_draw
    }
end

return room_new