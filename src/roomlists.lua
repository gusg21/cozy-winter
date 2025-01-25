local function swap_room(world, newroom, sx, sy)
    world.currentRoom = newroom
    world.player.pos.x = sx
    world.player.pos.y = sy
    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())
end

return {
    bedroom = {
        {
            name = "rug",
            image = love.graphics.newImage("assets/furniture/rug.png"),
            x = -180,
            y = 0,
        },
        {
            name = "wardrobe",
            image = love.graphics.newImage("assets/furniture/wardrobe.png"),
            x = -52,
            y = -176,
        },
        {
            name = "nightstand",
            image = love.graphics.newImage("assets/furniture/bed_nightstand.png"),
            x = 12,
            y = -98,
        },
        {
            name = "bunk bed",
            image = love.graphics.newImage("assets/furniture/bunk_bed.png"),
            x = 72,
            y = -36,
            colliders = {336,242 , 371,225 , 446,263 , 446,334 , 413,348 , 336,309},
            on_clicked = function(world)
                -- do something
            end,
        },
        {
            name = "cat bed",
            image = love.graphics.newImage("assets/furniture/cat-bed.png"),
            x = -62,
            y = 92,
        },
        {
            name = "left door",
            image = love.graphics.newImage("assets/door_frame.png"),
            x = -128,
            y = 12,
            colliders = {122,262 , 122,376 , 168,398 , 168,285},
            on_clicked = function(world)
                swap_room(world, world.livingroom, 400, 200)
            end,
        },
    },
    bedroom_floorcolliders = 
    {
        56,324 , 206,248 , 392,348 , 248,420
    },
    livingroom = {
        {
            name = "grandfather clock",
            image = love.graphics.newImage("assets/furniture/grandfather_clock.png"),
            x = -64,
            y = -302,
        },
        {
            name = "tv stand",
            image = love.graphics.newImage("assets/furniture/tv_stand.png"),
            x = 52,
            y = -164,
        },
        {
            name = "side table",
            image = love.graphics.newImage("assets/furniture/living_room_side_table.png"),
            x = -84,
            y = -143,
        },
        {
            name = "couch",
            image = love.graphics.newImage("assets/furniture/couch.png"),
            x = -24,
            y = -52,
            colliders = {360,260 , 396,260 , 512,320 , 512,360 , 480,376 , 360,316},
            on_clicked = function(world)
                -- do something
            end,
        },
        {
            name = "bedroom door",
            x = -24,
            y = -52,
            colliders = {410,90 , 452,112 , 452,220 , 410,199},
            on_clicked = function(world)
                swap_room(world, world.bedroom, 250, 250)
            end,
        },
    },
    livingroom_floorcolliders = 
    {
        32,344 , 364,178 , 732,362 , 398,526
    },
}
