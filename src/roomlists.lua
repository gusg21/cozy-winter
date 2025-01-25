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
            on_clicked = function(player)
                player.target.x = 0
                player.target.y = 0
            end
        },
        {
            name = "cat bed",
            image = love.graphics.newImage("assets/furniture/cat-bed.png"),
            x = -62,
            y = 92,
        },
    },
    bedroom_floorcolliders = 
    {
        56,324 , 206,248 , 392,348 , 248,420
    },
    bedroom_doorways = 
    {
        {
            -- will contain info about what room it goes to, etc.
        }
    },
    livingroom = {
        {
            name = "grandfather clock",
            image = love.graphics.newImage("assets/furniture/grandfather_clock.png"),
            x = -180,
            y = 0,
        },
        {
            name = "tv stand",
            image = love.graphics.newImage("assets/furniture/tv_stand.png"),
            x = -52,
            y = -176,
        },
    },
    livingroom_floorcolliders = 
    {
        56,324 , 206,248 , 392,348 , 248,420
    },
    livingroom_doorways = 
    {
        {
            -- will contain info about what room it goes to, etc.
        }
    },
}
