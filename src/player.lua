local push = require("push")
local vec2 = require("cpml/vec2")

local mouse_down_this_frame = false

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

local function player_update(player, world, dt)
    if not mouse_down_this_frame and love.mouse.isDown(1) then
        -- move to target object
        local x, y = push:toGame(love.mouse.getPosition())
        local mouX = x ~= nil
        local mouY = y ~= nil
        local mouGame = push:toGame(love.mouse.getPosition()) ~= nil

        for i,furniture in ipairs(world.currentRoom.furniture) do
            if mouX and mouY and mouGame and pointInConvexPolygon(x, y, furniture.colliders) and furniture.hascolliders then
                if furniture.on_clicked ~= nil then
                    furniture.on_clicked(player)
                end
            end
        end
        if mouX and mouY and mouGame and pointInConvexPolygon(x, y, world.currentRoom.floorcols) then
                player.target.x = x - (player.size.x/2)
                player.target.y = y - (player.size.y/2)
        end
        mouse_down_this_frame = true
    end
    if math.abs(player.target.x - player.pos.x) > 0.1 and math.abs(player.target.y - player.pos.y) > 0.1 then
        local dir = vec2.new(player.target.x - player.pos.x, player.target.y - player.pos.y)
        player.pos = player.pos + (vec2.normalize(dir) * player.speed * dt)
    end
end

love.mousereleased = function()
    mouse_down_this_frame = false
end

local function player_draw(player)
    love.graphics.draw(player.image, player.pos.x - player.size.x/2, player.pos.y- player.size.y/2)
end

local function player_new()
    return {
        pos = vec2.new(200, 300),
        size = vec2.new(50, 50),
        target = vec2.new(200, 300),
        speed = 100,
        image = love.graphics.newImage("assets/player/hooky.png"),
        update = player_update,
        draw = player_draw,
    }
end

return player_new