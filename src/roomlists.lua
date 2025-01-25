return {
    bedroom = {
        {
            name = "rug",
            image = love.graphics.newImage("assets/furniture/rug.png"),
            x = -180,
            y = 0,
            hascolliders = false,
            colliders = { 0,0 , 0,0 , 0,0 },
        },
        {
            name = "wardrobe",
            image = love.graphics.newImage("assets/furniture/wardrobe.png"),
            x = -52,
            y = -176,
            hascolliders = false,
            colliders = { 0,0 , 0,0 , 0,0 },
        },
        {
            name = "nightstand",
            image = love.graphics.newImage("assets/furniture/bed_nightstand.png"),
            x = 12,
            y = -98,
            hascolliders = false,
            colliders = { 0,0 , 0,0 , 0,0 },
        },
        {
            name = "bunk bed",
            image = love.graphics.newImage("assets/furniture/bunk_bed.png"),
            x = 72,
            y = -36,
            hascolliders = true,
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
            hascolliders = false,
            colliders = { 0,0 , 0,0 , 0,0 },
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
    }
}
