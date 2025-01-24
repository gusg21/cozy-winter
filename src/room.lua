local keyDownThisFrame = false

local function room_update(room, dt)
    -- SELECT FURNITURE
    if love.keyboard.isDown("q") then
        if room.findex == 0 then
            room.findex = #room.furniture - 1
        else
            room.findex = room.findex - 1
        end 
    end
    if love.keyboard.isDown("e") then
        if room.findex == #room.furniture - 1 then
            room.findex = 0
        else
            room.findex = room.findex + 1
        end 
    end

    -- MOVE FURNITURE
    if love.keyboard.isDown("up") then
        if room.findex == 0 then
            room.findex = #room.furniture - 1
        else
            room.findex = room.findex - 1
        end 
    end
    if love.keyboard.isDown("down") then
        if room.findex == #room.furniture - 1 then
            room.findex = 0
        else
            room.findex = room.findex + 1
        end 
    end
    if love.keyboard.isDown("left") then
        if room.findex == 0 then
            room.findex = #room.furniture - 1
        else
            room.findex = room.findex - 1
        end 
    end
    if love.keyboard.isDown("right") then
        if room.findex == #room.furniture - 1 then
            room.findex = 0
        else
            room.findex = room.findex + 1
        end 
    end
end

local function room_draw(room, sw, sh)
    love.graphics.draw(room.bg, (sw/2)-(room.bg:getWidth()/2),
                                (sh/2)-(room.bg:getHeight()/2))
    for i,furniture in ipairs(room.furniture) do 
        love.graphics.draw(furniture.image, furniture.x + room.bg:getWidth()/2, furniture.y + room.bg:getHeight()/2)
    end

    love.graphics.print(room.findex)
    --love.graphics.print(type(room.furniture[room.findex].x + room.bg:getWidth()/2) + ", " + type(room.furniture[room.findex].y + room.bg:getHeight()/2))
end

local function room_new(bgfilename, furniturelist)
    return {
        bg = love.graphics.newImage(bgfilename),
        furniture = furniturelist,
        findex = 0,
        update = room_update,
        draw = room_draw
    }
end

return room_new