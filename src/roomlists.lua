return {
    bedroom = {
        {
            name = "rug",
            image = love.graphics.newImage("assets/furniture/rug.png"),
            x = -180,
            y = 0,
            front = false,
        },
        {
            name = "wardrobe",
            image = love.graphics.newImage("assets/furniture/wardrobe.png"),
            x = -52,
            y = -176,
            front = false,
        },
        {
            name = "nightstand",
            image = love.graphics.newImage("assets/furniture/bed_nightstand.png"),
            x = 12,
            y = -98,
            front = false,
        },
        {
            name = "bunk bed",
            image = love.graphics.newImage("assets/furniture/bunk_bed.png"),
            x = 72,
            y = -36,
            colliders = {336,242 , 371,225 , 446,263 , 446,334 , 413,348 , 336,309},
            on_clicked = function(player)
                player.target.x = 0
                player.target.y = 0
            end,
            front = false,
        },
        {
            name = "cat bed",
            image = love.graphics.newImage("assets/furniture/cat-bed.png"),
            x = -62,
            y = 92,
            front = false,
        },
        {
            name = "left door",
            image = love.graphics.newImage("assets/door_frame.png"),
            x = -128,
            y = 12,
            colliders = {122,262 , 122,376 , 168,398 , 168,285},
            on_clicked = function(player)
                player.target.x = 0
                player.target.y = 0
            end,
            front = true,
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
            x = -429,
            y = -654,
        },
        {
            name = "tv stand",
            image = love.graphics.newImage("assets/furniture/tv_stand.png"),
            x = -262,
            y = -496,
        },
    },
    livingroom_floorcolliders = 
    {
        56,324 , 206,248 , 392,348 , 248,420
    },
}
