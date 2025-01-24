local push = require("push")
local vec2 = require("cpml/vec2")

local function player_update(player, dt)
    if love.mouse.isDown(1) then
        -- move to target object
    end
    if math.abs(player.target.x - player.pos.x) > 0.1 and math.abs(player.target.y - player.pos.y) > 0.1 then
        local dir = vec2.new(player.target.x - player.pos.x, player.target.y - player.pos.y)
        player.pos = player.pos + (vec2.normalize(dir) * player.speed * dt)
    end
end

local function player_draw(player)
    love.graphics.rectangle("fill", player.pos.x, player.pos.y, player.size.x, player.size.y)
end

local function player_new()
    return {
        pos = vec2.new(250, 250),
        size = vec2.new(50, 50),
        target = vec2.new(250, 250),
        speed = 100,
        update = player_update,
        draw = player_draw,
    }
end

return player_new