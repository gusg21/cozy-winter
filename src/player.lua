local vec2 = require("cpml/vec2")

local function pointInConvexPolygon(x, y, poly)
	-- poly as {x1,y1, x2,y2, x3,y3, ...}
	local imax = #poly

	local function isVerticesClockwise(poly)
		local sum = 0
		local imax = #poly
		local x1, y1 = poly[imax-1], poly[imax]
		for i = 1, imax - 1, 2 do
			local x2, y2 = poly[i], poly[i + 1]
			sum = sum + (x2 - x1) * (y2 + y1)
			x1, y1 = x2, y2
		end
		local isClockwise = sum < 0
		return isClockwise
	end

	local sign = isVerticesClockwise(poly) and 1 or -1
	local x1, y1 = poly[imax-1], poly[imax]
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

local function player_update(player, world, input, dt)
    -- wasd movement
    if not world.currentRoom.editing then
        local in_room = true
        local in_furniture = false
        if input.keyHeld("w") then
            local next_pos = player.pos.y - (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil then
                    if pointInConvexPolygon(player.pos.x, next_pos, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            if not pointInConvexPolygon(player.pos.x, next_pos, world.currentRoom.floorcols) then
                in_room = false
            end
            if not in_furniture and in_room then
                player.pos.y = next_pos
            end
        end
        if input.keyHeld("a") then
            local next_pos = player.pos.x - (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil then
                    if pointInConvexPolygon(next_pos, player.pos.y, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            if not pointInConvexPolygon(next_pos, player.pos.y, world.currentRoom.floorcols) then
                in_room = false
            end
            if not in_furniture and in_room then
                player.pos.x = next_pos
                player.flip_image = false
            end
        end
        if input.keyHeld("s") then
            local next_pos = player.pos.y + (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil then
                    if pointInConvexPolygon(player.pos.x, next_pos, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            if not pointInConvexPolygon(player.pos.x, next_pos, world.currentRoom.floorcols) then
                in_room = false
            end
            if not in_furniture and in_room then
                player.pos.y = next_pos
            end
        end
        if input.keyHeld("d") then
            local next_pos = player.pos.x + (player.speed * dt)
            for i, furniture in ipairs(world.currentRoom.furniture) do
                if furniture.colliders ~= nil then
                    if pointInConvexPolygon(next_pos, player.pos.y, furniture.colliders) then
                        in_furniture = true
                    end
                end
            end
            if not pointInConvexPolygon(next_pos, player.pos.y, world.currentRoom.floorcols) then
                in_room = false
            end
            if not in_furniture and in_room then
                player.pos.x = next_pos
                player.flip_image = true
            end
        end

        in_room = true
        in_furniture = false
    end
    if input.mouseOnce(1) then
        -- move to target object
        local x, y = love.mouse.getPosition()
        local mouX = x ~= nil
        local mouY = y ~= nil
        for i,furniture in ipairs(world.currentRoom.furniture) do
            if furniture.colliders ~= nil then
                if mouX and mouY and pointInConvexPolygon(x, y, furniture.colliders) then
                    if furniture.on_clicked ~= nil then
                        furniture.on_clicked(world)
                    end
                end
            end
        end
    end
end

local function player_draw(player)
    if player.flip_image then
        love.graphics.draw(player.image, player.pos.x - player.size.x/2, player.pos.y- player.size.y/2, 0, -1, 1, player.image:getWidth() / 2, 0)
    else
        love.graphics.draw(player.image, player.pos.x - player.size.x/2, player.pos.y- player.size.y/2, 0, 1, 1, player.image:getWidth() / 2, 0)
    end

end

local function player_new()
    return {
        pos = vec2.new(215, 300),
        size = vec2.new(50, 50),
        speed = 100,
        image = love.graphics.newImage("assets/player/hooky.png"),
        flip_image = false,
        update = player_update,
        draw = player_draw,
    }
end

return player_new