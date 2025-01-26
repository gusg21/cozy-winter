local key_down_this_frame = false
local mouse_down_this_frame = false
local mouse_released_this_frame = false

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

local function input_key_held(key)
    if love.keyboard.isDown(key) then
        return true
    else
        return false
    end
end

local function input_key_once(key)
    if love.keyboard.isDown(key) and not key_down_this_frame then
        key_down_this_frame = true
        return true
    else
        return false
    end
end

local function input_mouse_held(button)
    if love.mouse.isDown(button) then
        return true
    else
        return false
    end
end

local function input_mouse_once(button)
    return mouse_down_this_frame
end

local function input_mouse_reset()
    mouse_down_this_frame = false
    mouse_released_this_frame = false
end

local function input_mouse_released(btn)
    return mouse_released_this_frame
end

local function input_mouse_in_collider(col)
    return pointInConvexPolygon(love.mouse.getX(), love.mouse.getY(), col)
end

love.keyreleased = function()
    key_down_this_frame = false
end

love.mousepressed = function()
    mouse_down_this_frame = true
end

love.mousereleased = function()
    mouse_down_this_frame = false
    mouse_released_this_frame = true
end

return {
    keyHeld = input_key_held,
    keyOnce = input_key_once,
    mouseHeld = input_mouse_held,
    mouseOnce = input_mouse_once,
    mouseInCollider = input_mouse_in_collider,
    reset = input_mouse_reset,
    mouseReleased = input_mouse_released,
}