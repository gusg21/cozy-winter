local push = require("push")
local input = require("input")

local editing_col = false
local edit_floor = true

local function table_contains(tbl, x)
    local found = false
    for _, v in pairs(tbl) do
        if v == x then
            found = true
        end
    end
    return found
end

local function room_update(room, world, dt)
    -- Toggle edit mode
    if input.keyOnce("e") then
        room.editing = not room.editing
    end
    -- Edit mode controls
    if room.editing then
        local shift_down
        if input.keyHeld("lshift") then
            shift_down = 9
        else
            shift_down = 0
        end
        -- SELECT FURNITURE
        if input.keyOnce("a") then
            if room.findex == 1 then
                room.findex = #room.furniture
            else
                room.findex = room.findex - 1
            end
            if editing_col and not edit_floor then
                while room.furniture[room.findex].colliders == nil do
                    if room.findex == 1 then
                        room.findex = #room.furniture
                    else
                        room.findex = room.findex - 1
                    end
                end
            end
            room.cindex = 1
        end
        if input.keyOnce("d") then
            if room.findex == #room.furniture then
                room.findex = 1
            else
                room.findex = room.findex + 1
            end
            if editing_col and not edit_floor then
                while room.furniture[room.findex].colliders == nil do
                    if room.findex == #room.furniture then
                        room.findex = 1
                    else
                        room.findex = room.findex + 1
                    end
                end
            end
            room.cindex = 1
        end

        -- SELECTING COLLIDER
        if input.keyOnce("s") then
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
        end

        if input.keyOnce("w") then
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
        end


        -- EDITING COLLIDER
        if input.keyOnce("c") then
            editing_col = not editing_col
        end

        if input.keyOnce("f") then
            if editing_col then
                edit_floor = not edit_floor
                if not edit_floor then
                    while room.furniture[room.findex].colliders == nil do
                        if room.findex == 1 then
                            room.findex = #room.furniture
                        else
                            room.findex = room.findex - 1
                        end
                    end
                end
            end
            room.cindex = 1
        end

        -- MOVE FURNITURE
        if input.keyOnce("up") then
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
                room.furniture[room.findex].y = room.furniture[room.findex].y - 1 - shift_down
            end
        end
        if input.keyOnce("down") then
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
                room.furniture[room.findex].y = room.furniture[room.findex].y + 1 + shift_down
            end
        end
        if not editing_col and input.keyOnce("left") then
            room.furniture[room.findex].x = room.furniture[room.findex].x - 1 - shift_down
        end
        if not editing_col and input.keyOnce("right") then
            room.furniture[room.findex].x = room.furniture[room.findex].x + 1 + shift_down
        end
    end

    -- Player update
    world.player:update(world, dt)
end

local function room_draw(room, world) -- TODO: Some things need to always render in front and behind
    -- Draw background
    love.graphics.draw(room.bg, 0, 0)

    -- Depth table sort
    local lowest
    local lowest_num = 10000
    local depth_draw_table = {}
    while #depth_draw_table ~= #room.furniture do
        lowest_num = 10000
        for i, furniture in ipairs(room.furniture) do
            if not table_contains(depth_draw_table, furniture) then
                if furniture.y < lowest_num then
                    lowest = furniture
                    lowest_num = furniture.y
                end
            end
        end
        table.insert(depth_draw_table, lowest)
    end

    -- Draw furniture and player
    local player_drawn = false
    local furniture_hovered = false
    for i, furniture in ipairs(depth_draw_table) do
        if not player_drawn then
            if world.player.pos.y - (room.bg:getWidth() / 2) < furniture.y then
                world.player:draw()
                player_drawn = true
            end
        end

        -- TODO: Make hovered objects brighter with shader
        if furniture.can_interact and input.mouseInCollider(furniture.colliders) then
            furniture_hovered = true
            love.mouse.setCursor(love.mouse.getSystemCursor("hand"))
            love.graphics.setColor(0.8, 0.8, 0.8)
        end

        if furniture.image ~= nil then
            love.graphics.draw(furniture.image, furniture.x + (room.bg:getWidth() / 2),
                furniture.y + room.bg:getHeight() / 2)
        end

        love.graphics.setColor(1, 1, 1)

        -- Draw collider lines
        if room.editing and editing_col and not edit_floor and furniture.colliders ~= nil then
            love.graphics.setColor(0, 1, 0)
            love.graphics.polygon("line", furniture.colliders)
            love.graphics.setColor(1, 1, 1)
        end
    end

    -- If no objects clickable under mouse, make mouse normal
    if not furniture_hovered then
        love.mouse.setCursor()
    end

    -- If player not drawn, draw them
    if not player_drawn then
        world.player:draw()
        player_drawn = true
    end

    -- Draw editing mode
    if room.editing then
        -- Draw floor colliders
        if editing_col and edit_floor then
            love.graphics.setColor(0, 1, 0)

            love.graphics.polygon("line", room.floorcols)
        end

        -- Draw editing text
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

        love.graphics.print(world.player.pos.x, 400, 0)
        love.graphics.print(world.player.pos.y, 400, 20)
    end
end

local function room_new(bgfilename, furniturelist, floorcolliders)
    return {
        bg = love.graphics.newImage(bgfilename),
        furniture = furniturelist,
        findex = 1,
        floorcols = floorcolliders,
        cindex = 1,
        camera = {
            x = 0,
            y = 0
        },
        update = room_update,
        draw = room_draw,

        editing = false
    }
end

return room_new
