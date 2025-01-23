local x

function love.load()
    x = 10
end

function love.update(dt)
    x = x + dt * 10
end

function love.draw()
    love.graphics.rectangle("fill", x, 50, 50, 50);
end