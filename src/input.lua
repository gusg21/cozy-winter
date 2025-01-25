local key_down_this_frame = false
local mouse_down_this_frame = false

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
    if love.mouse.isDown(button) and not mouse_down_this_frame then
        mouse_down_this_frame = true
        return true
    else
        return false
    end
end

love.keyreleased = function()
    key_down_this_frame = false
end

love.mousereleased = function()
    mouse_down_this_frame = false
end

return {
    keyHeld = input_key_held,
    keyOnce = input_key_once,
    mouseHeld = input_mouse_held,
    mouseOnce = input_mouse_once,
}