local vec2 = require("cpml/vec2")

local function player_update(player, dt)
    if love.mouse.isDown(1) then
        player.target.x = love.mouse.getX() - (player.size.x / 2)
        player.target.y = love.mouse.getY() - (player.size.y / 2)
    end
    if player.pos.x ~= player.target.x and player.pos.y ~= player.target.y then
        local dir = vec2.new(player.target.x - player.pos.x, player.target.y - player.pos.y)
        player.pos = player.pos + (vec2.normalize(dir) * player.speed * dt)
    end
end

local function player_draw(player)
    love.graphics.rectangle("fill", player.pos.x, player.pos.y, player.size.x, player.size.y)
end

local function player_new()
    return {
        pos = vec2.new(50, 50),
        size = vec2.new(50, 50),
        target = vec2.new(0, 0),
        speed = 100,
        update = player_update,
        draw = player_draw,
    }
end

return player_new