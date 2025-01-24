local function player_update(player, dt)
    if love.mouse.isDown(1) then
        player.tx = love.mouse.getX()
        player.ty = love.mouse.getY()
    end
    if player.x ~= player.tx and player.y ~= player.ty then
        local dx = player.tx - player.x
        local dy = player.ty - player.y

        player.x = player.x + (dx * player.speed * dt)
        player.y = player.y + (dy * player.speed * dt)
    end
end

local function player_draw(player)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
end

local function player_new()
    return {
        x = 50,
        y = 50,
        w = 50,
        h = 50,
        tx = 50,
        ty = 50,
        speed = 100,
        update = player_update,
        draw = player_draw,
    }
end

return player_new