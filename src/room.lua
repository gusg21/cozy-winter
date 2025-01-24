local keyDownThisFrame = false

local function room_update(room, dt)
    -- SELECT FURNITURE
    if keyDownThisFrame ~= true and love.keyboard.isDown("q") then
        if room.findex == 1 then
            room.findex = #room.furniture
        else
            room.findex = room.findex - 1
        end 

        keyDownThisFrame = true
    end
    if keyDownThisFrame ~= true and love.keyboard.isDown("e") then
        if room.findex == #room.furniture then
            room.findex = 1
        else
            room.findex = room.findex + 1
        end 

        keyDownThisFrame = true
    end

    -- MOVE FURNITURE
    if keyDownThisFrame ~= true and love.keyboard.isDown("up") then
        room.furniture[room.findex].y = room.furniture[room.findex].y - 1
        keyDownThisFrame = true
    end
    if keyDownThisFrame ~= true and love.keyboard.isDown("down") then
        room.furniture[room.findex].y = room.furniture[room.findex].y + 1
        keyDownThisFrame = true
    end
    if keyDownThisFrame ~= true and love.keyboard.isDown("left") then
        room.furniture[room.findex].x = room.furniture[room.findex].x - 1
        keyDownThisFrame = true
    end
    if keyDownThisFrame ~= true and love.keyboard.isDown("right") then
        room.furniture[room.findex].x = room.furniture[room.findex].x + 1
        keyDownThisFrame = true
    end
end

love.keyreleased = function(key)
    keyDownThisFrame = false
end

local function room_draw(room, sw, sh)
    love.graphics.draw(room.bg, (sw/2)-(room.bg:getWidth()/2),
                                (sh/2)-(room.bg:getHeight()/2))
    for i,furniture in ipairs(room.furniture) do 
        love.graphics.draw(furniture.image, furniture.x + room.bg:getWidth()/2, furniture.y + room.bg:getHeight()/2)
    end

    love.graphics.print(room.findex)
    love.graphics.print(room.furniture[room.findex].name, 40, 0)
    love.graphics.print(room.furniture[room.findex].x, 0, 20)
    love.graphics.print(room.furniture[room.findex].y, 40, 20)

end

local function room_new(bgfilename, furniturelist)
    return {
        bg = love.graphics.newImage(bgfilename),
        furniture = furniturelist,
        findex = 2,
        update = room_update,
        draw = room_draw
    }
end

return room_new