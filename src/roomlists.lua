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
            trigger = false,
        },
        {
            name = "wardrobe",
            image = love.graphics.newImage("assets/furniture/wardrobe.png"),
            x = -52,
            y = -176,
            trigger = false,
        },
        {
            name = "nightstand",
            image = love.graphics.newImage("assets/furniture/bed_nightstand.png"),
            x = 12,
            y = -98,
            trigger = false,
        },
        {
            name = "bunk bed",
            image = love.graphics.newImage("assets/furniture/bunk_bed.png"),
            x = 72,
            y = -36,
            colliders = { 336, 242, 371, 225, 446, 263, 446, 334, 413, 348, 336, 309 },
            on_clicked = function(world)
                -- give items to Smoochus
            end,
            can_interact = true,
            trigger = false,
        },
        {
            name = "cat bed",
            image = love.graphics.newImage("assets/furniture/cat-bed.png"),
            x = -62,
            y = 92,
            trigger = false,
        },
        {
            name = "living room door",
            image = love.graphics.newImage("assets/door_frame.png"),
            x = -128,
            y = 12,
            colliders = { 122, 262, 122, 376, 168, 398, 168, 285 },
            on_clicked = function(world)
                swap_room(world, world.livingroom, 400, 200)
            end,
            can_interact = true,
            trigger = true,
        },
    },
    bedroom_floorcolliders =
    {
        56, 324, 206, 248, 392, 348, 248, 420
    },
    livingroom = {
        {
            name = "grandfather clock",
            image = love.graphics.newImage("assets/furniture/grandfather_clock.png"),
            x = -64,
            y = -302,
            colliders = { 324, 196, 364, 176, 404, 198, 366, 216 },
            trigger = false,
        },
        {
            name = "tv stand",
            image = love.graphics.newImage("assets/furniture/tv_stand.png"),
            x = 52,
            y = -164,
            colliders = { 440, 268, 484, 244, 608, 302, 560, 326 },
            trigger = false,
        },
        {
            name = "side table",
            image = love.graphics.newImage("assets/furniture/living_room_side_table.png"),
            x = -84,
            y = -143,
            colliders = { 312, 300, 364, 274, 404, 292, 348, 320 },
            on_clicked = function(world)
                -- pick up mug
            end,
            trigger = false,
        },
        {
            name = "couch",
            image = love.graphics.newImage("assets/furniture/couch.png"),
            x = -24,
            y = -52,
            colliders = { 360, 318, 408, 298, 526, 354, 480, 376 },
            on_clicked = function(world)
                -- pick up blankets
            end,
            can_interact = true,
            trigger = false,
        },
        {
            name = "bedroom door",
            x = -24,
            y = -52,
            colliders = { 410, 90, 452, 112, 452, 220, 410, 199 },
            on_clicked = function(world)
                swap_room(world, world.bedroom, 250, 250)
            end,
            can_interact = true,
            trigger = true,
        },
        {
            name = "plant",
            image = love.graphics.newImage("assets/furniture/living_room_plant.png"),
            x = -32,
            y = 100,
            colliders = { 372, 528, 402, 542, 432, 528, 402, 512 },
            trigger = false,
        },
        {
            name = "bug",
            image = love.graphics.newImage("assets/furniture/living_room_bug.png"),
            x = -172,
            y = 24,
            colliders = { 410, 90, 452, 112, 452, 220, 410, 199 },
            trigger = false,
        },
        {
            name = "shelves",
            image = love.graphics.newImage("assets/furniture/living_room_shelves.png"),
            x = -380,
            y = -140,
            colliders = { 410, 90, 452, 112, 452, 220, 410, 199 },
            trigger = false,
        },
        {
            name = "cat tree",
            image = love.graphics.newImage("assets/furniture/cat_tree.png"),
            x = 116,
            y = 16,
            colliders = { 410, 90, 452, 112, 452, 220, 410, 199 },
            trigger = false,
        },
    },
    livingroom_floorcolliders =
    {
        32, 344, 364, 178, 732, 362, 398, 526
    },
}
