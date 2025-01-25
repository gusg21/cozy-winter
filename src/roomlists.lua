return {
    bedroom = {
        {
            name = "rug",
            image = love.graphics.newImage("assets/furniture/rug.png"),
            x = -180,
            y = 0,
            hascolliders = true,
            colliders = { 0,0 , 0,0 , 0,0 }
        },
        {
            name = "wardrobe",
            image = love.graphics.newImage("assets/furniture/wardrobe.png"),
            x = -52,
            y = -176,
            hascolliders = true,
            colliders = { 0,0 , 0,0 , 0,0 }
        },
        {
            name = "nightstand",
            image = love.graphics.newImage("assets/furniture/bed_nightstand.png"),
            x = 12,
            y = -98,
            hascolliders = true,
            colliders = { 0,0 , 0,0 , 0,0 }
        },
        {
            name = "bunk bed",
            image = love.graphics.newImage("assets/furniture/bunk_bed.png"),
            x = 72,
            y = -36,
            hascolliders = true,
            colliders = {300,300 , 400,300 , 400,400 , 300,400}
        },
    },
    bedroom_floorcolliders = 
    {
        56,324 , 206,248 , 392,348 , 248,420
    }
}
