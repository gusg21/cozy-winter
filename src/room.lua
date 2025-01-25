local edit = false
local key_down_this_frame = false
local editing_col = false
local edit_floor = true

local push = require("push")

local function room_update(room, dt)
    local shift_down
    if love.keyboard.isDown("lshift") then
        shift_down = 9
    else
        shift_down = 0
    end
    -- EDIT MODE
    if not key_down_this_frame and love.keyboard.isDown("e") then
        edit = not edit
        key_down_this_frame = true
    end
    if edit then
        -- SELECT FURNITURE
        if not key_down_this_frame and love.keyboard.isDown("a") then
            if room.findex == 1 then
                room.findex = #room.furniture
            else
                room.findex = room.findex - 1
            end
            while room.furniture[room.findex].colliders == nil do
                if room.findex == 1 then
                    room.findex = #room.furniture
                else
                    room.findex = room.findex - 1
                end
            end
            room.cindex = 1
            key_down_this_frame = true
        end
        if not key_down_this_frame and love.keyboard.isDown("d") then
            if room.findex == #room.furniture then
                room.findex = 1
            else
                room.findex = room.findex + 1
            end
            while room.furniture[room.findex].colliders == nil do
                if room.findex == #room.furniture then
                    room.findex = 1
                else
                    room.findex = room.findex + 1
                end
            end
            room.cindex = 1
            key_down_this_frame = true
        end

        -- SELECTING COLLIDER
        if not key_down_this_frame and love.keyboard.isDown("s") then
            if edit_floor then
                if room.cindex == 1 then
                    room.cindex = #room.floorcols
                else
                    room.cindex = room.cindex - 1
                end
            else
                if room.cindex == 1 then
                    room.cindex = #room.furniture[room.findex].colliders
                else
                    room.cindex = room.cindex - 1
                end
            end
            key_down_this_frame = true
        end

        if not key_down_this_frame and love.keyboard.isDown("w") then
            if edit_floor then
                if room.cindex == #room.floorcols then
                    room.cindex = 1
                else
                    room.cindex = room.cindex + 1
                end
            else
                if room.cindex == #room.furniture[room.findex].colliders then
                    room.cindex = 1
                else
                    room.cindex = room.cindex + 1
                end
            end
            key_down_this_frame = true
        end


        -- EDITING COLLIDER
        if not key_down_this_frame and love.keyboard.isDown("c") then
            editing_col = not editing_col
            key_down_this_frame = true
        end

        if not key_down_this_frame and love.keyboard.isDown("f") then
            edit_floor = not edit_floor
            room.cindex = 1
            key_down_this_frame = true
        end

        -- MOVE FURNITURE
        if not key_down_this_frame and love.keyboard.isDown("up") then
            if editing_col then
                if not edit_floor then
                    if room.cindex % 2 ~= 0 then
                        room.furniture[room.findex].colliders[room.cindex] = room.furniture[room.findex].colliders
                            [room.cindex] + 1 + shift_down
                    else
                        room.furniture[room.findex].colliders[room.cindex] = room.furniture[room.findex].colliders
                            [room.cindex] - 1 - shift_down
                    end
                else
                    if room.cindex % 2 ~= 0 then
                        room.floorcols[room.cindex] = room.floorcols[room.cindex] + 1 + shift_down
                    else
                        room.floorcols[room.cindex] = room.floorcols[room.cindex] - 1 - shift_down
                    end
                end
            else
                room.furniture[room.findex].y = room.furniture[room.findex].y + 1 + shift_down
            end
            key_down_this_frame = true
        end
        if not key_down_this_frame and love.keyboard.isDown("down") then
            if editing_col then
                if not edit_floor then
                    if room.cindex % 2 ~= 0 then
                        room.furniture[room.findex].colliders[room.cindex] = room.furniture[room.findex].colliders
                            [room.cindex] - 1 - shift_down
                    else
                        room.furniture[room.findex].colliders[room.cindex] = room.furniture[room.findex].colliders
                            [room.cindex] + 1 + shift_down
                    end
                else
                    if room.cindex % 2 ~= 0 then
                        room.floorcols[room.cindex] = room.floorcols[room.cindex] - 1 - shift_down
                    else
                        room.floorcols[room.cindex] = room.floorcols[room.cindex] + 1 + shift_down
                    end
                end
            else
                room.furniture[room.findex].y = room.furniture[room.findex].y - 1 - shift_down
            end
            key_down_this_frame = true
        end
        if not editing_col and not key_down_this_frame and love.keyboard.isDown("left") then
            room.furniture[room.findex].x = room.furniture[room.findex].x - 1 - shift_down
            key_down_this_frame = true
        end
        if not editing_col and not key_down_this_frame and love.keyboard.isDown("right") then
            room.furniture[room.findex].x = room.furniture[room.findex].x + 1 + shift_down
            key_down_this_frame = true
        end
    end
end


love.keyreleased = function(key)
    key_down_this_frame = false
end

local function room_draw(room, sw, sh)
    love.graphics.draw(room.bg, (sw / 2) - (room.bg:getWidth() / 2),
        (sh / 2) - (room.bg:getHeight() / 2))
    for i, furniture in ipairs(room.furniture) do
        love.graphics.draw(furniture.image, furniture.x + room.bg:getWidth() / 2, furniture.y + room.bg:getHeight() / 2)
        if edit and editing_col and furniture.colliders ~= nil then
            love.graphics.setColor(0, 1, 0)
            love.graphics.polygon("line", furniture.colliders)
            love.graphics.setColor(1, 1, 1)
        end
    end

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 100, 380, 50, 50)
    love.graphics.setColor(1, 1, 1, 1)

    -- draw colliders
    if edit then
        if editing_col then
            love.graphics.setColor(0, 1, 0)

            love.graphics.polygon("line", room.floorcols)
        end

        -- draw editing text
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(room.findex)
        love.graphics.print(room.cindex, 140, 40)
        love.graphics.print(room.furniture[room.findex].name, 40, 0)
        love.graphics.print(room.furniture[room.findex].x, 0, 20)
        love.graphics.print(room.furniture[room.findex].y, 40, 20)
        if not edit_floor then
            love.graphics.print(room.furniture[room.findex].colliders[room.cindex], 80, 20)
        else
            love.graphics.print(room.floorcols[room.cindex], 80, 20)
        end
        love.graphics.print("editing colliders:", 0, 40)
        love.graphics.print(tostring(editing_col), 100, 40)
        love.graphics.print("editing floor col:", 0, 60)
        love.graphics.print(tostring(edit_floor), 100, 60)
    end
end

local function room_new(bgfilename, furniturelist, floorcolliders)
    return {
        bg = love.graphics.newImage(bgfilename),
        furniture = furniturelist,
        findex = 4,
        floorcols = floorcolliders,
        cindex = 1,
        update = room_update,
        draw = room_draw,
    }
end

function swap_room(world, roomname)

end

return room_new
