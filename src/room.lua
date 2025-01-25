local key_down_this_frame = false
local editing_col = false

local push = require("push")

local function room_update(room, dt)
    -- SELECT FURNITURE
    if not key_down_this_frame and love.keyboard.isDown("a") then
        if room.findex == 1 then
            room.findex = #room.furniture
        else
            room.findex = room.findex - 1
        end 

        key_down_this_frame = true
    end
    if not key_down_this_frame and love.keyboard.isDown("d") then
        if room.findex == #room.furniture then
            room.findex = 1
        else
            room.findex = room.findex + 1
        end 

        key_down_this_frame = true
    end

    -- SELECTING COLLIDER
    if not key_down_this_frame and love.keyboard.isDown("w") then
        if room.findex == 1 then
            room.findex = #room.furniture
        else
            room.findex = room.findex - 1
        end 

        key_down_this_frame = true
    end
    if not key_down_this_frame and love.keyboard.isDown("s") then
        if room.findex == #room.furniture then
            room.findex = 1
        else
            room.findex = room.findex + 1
        end 

        key_down_this_frame = true
    end

    -- EDITING COLLIDER
    if not key_down_this_frame and love.keyboard.isDown("c") then
        editing_col = not editing_col
        key_down_this_frame = true
    end

    -- MOVE FURNITURE
    if not key_down_this_frame and love.keyboard.isDown("up") then
        if editing_col then
            room.furniture[room.findex].cy = room.furniture[room.findex].cy - 1
        else
            room.furniture[room.findex].y = room.furniture[room.findex].y - 1
        end
        key_down_this_frame = true
    end
    if not key_down_this_frame and love.keyboard.isDown("down") then
        if editing_col then
            room.furniture[room.findex].cy = room.furniture[room.findex].cy + 1
        else
            room.furniture[room.findex].y = room.furniture[room.findex].y + 1
        end
        key_down_this_frame = true
    end
    if not key_down_this_frame and love.keyboard.isDown("left") then
        if editing_col then
            room.furniture[room.findex].cx = room.furniture[room.findex].cx - 1
        else
            room.furniture[room.findex].x = room.furniture[room.findex].x - 1
        end
        key_down_this_frame = true
    end
    if not key_down_this_frame and love.keyboard.isDown("right") then
        if editing_col then
            room.furniture[room.findex].cx = room.furniture[room.findex].cx + 1
        else
            room.furniture[room.findex].x = room.furniture[room.findex].x + 1
        end
        key_down_this_frame = true
    end
end

love.keyreleased = function(key)
    key_down_this_frame = false
end

local function room_draw(room, sw, sh)
    love.graphics.draw(room.bg, (sw/2)-(room.bg:getWidth()/2),
                                (sh/2)-(room.bg:getHeight()/2))
    for i,furniture in ipairs(room.furniture) do 
        love.graphics.draw(furniture.image, furniture.x + room.bg:getWidth()/2, furniture.y + room.bg:getHeight()/2)
    end

    -- draw colliders
    if editing_col then
        love.graphics.setColor(0,1,0)

        love.graphics.polygon("line", room.floorcols)
    end


    -- draw editing text
    love.graphics.setColor(1,1,1)
    love.graphics.print(room.findex)
    love.graphics.print(room.furniture[room.findex].name, 40, 0)
    love.graphics.print(room.furniture[room.findex].x, 0, 20)
    love.graphics.print(room.furniture[room.findex].y, 40, 20)
    love.graphics.print("editing colliders:", 0, 40)
    love.graphics.print(tostring(editing_col), 100, 40)

end

local function room_new(bgfilename, furniturelist, floorcolliders)
    return {
        bg = love.graphics.newImage(bgfilename),
        furniture = furniturelist,
        findex = 1,
        floorcols = floorcolliders,
        cindex = 1,
        update = room_update,
        draw = room_draw,
    }
end

return room_new