local input = require("input")
local function swap_room(world, newroom, sx, sy)
    world.currentRoom = newroom
    world.player.pos.x = sx
    world.player.pos.y = sy
    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())
    input.reset()
end

return {
    bedroom = {
        {
            name = "rug",
            image = love.graphics.newImage("assets/furniture/rug.png"),
            x = -200,
            y = 0,
            always = "behind"
        },
        {
            name = "wardrobe",
            image = love.graphics.newImage("assets/furniture/wardrobe.png"),
            x = -52,
            y = -176,
            cx = 9,
            cy = 174,
            always = "behind",

        },
        {
            name = "nightstand",
            image = love.graphics.newImage("assets/furniture/bed_nightstand.png"),
            x = 12,
            y = -98,
            cx = 16,
            cy = 130,
            always = "behind",
        },
        {
            name = "bunk bed",
            image = love.graphics.newImage("assets/furniture/bunk_bed.png"),
            x = 72,
            y = -36,
            colliders = { 322, 312, 332, 248, 450, 260, 448, 324 },
            on_clicked = function(world)
                -- give items to Smoochus
            end,
            can_interact = true,
            trigger = true,
            cx = 12,
            cy = 99,
            always = "behind",
        },
        {
            name = "cat bed",
            image = love.graphics.newImage("assets/furniture/cat-bed.png"),
            x = -62,
            y = 92,
            always = "behind",
            cx = 69,
            cy = 13
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
            always = "infront"
        },

        -- TODO: FIX POS IN PLAYER, MAKE ALL COLLIDERS
    },
    bedroom_floorcolliders =
    {
        56, 324, 206, 248, 400, 348, 248, 420
    },
    livingroom = {
        {
            name = "grandfather clock",
            image = love.graphics.newImage("assets/furniture/grandfather_clock.png"),
            x = -64,
            y = -302,
            colliders = { 324, 196, 364, 176, 404, 198, 368, 216 },
            trigger = false,
            cx = 47,
            cy = 195,
        },
        {
            name = "tv stand",
            image = love.graphics.newImage("assets/furniture/tv_stand.png"),
            x = 52,
            y = -164,
            colliders = { 438, 266, 486, 238, 610, 302, 560, 326 },
            trigger = false,
            cx = 5,
            cy = 123,
        },
        {
            name = "side table",
            image = love.graphics.newImage("assets/furniture/living_room_side_table.png"),
            x = -84,
            y = -143,
            colliders = { 312, 300, 362, 272, 402, 294, 348, 320 },
            on_clicked = function(world)
                -- pick up mug
            end,
            trigger = false,
            cx = 16,
            cy = 141
        },
        {
            name = "couch",
            image = love.graphics.newImage("assets/furniture/couch.png"),
            x = -24,
            y = -52,
            colliders = { 356, 316, 404, 292, 526, 354, 480, 376 },
            can_interact = false,
            trigger = false,
            cx = 1,
            cy = 62,
        },
        {
            name = "bedroom door",
            x = -24,
            y = -52,
            colliders = { 410, 92, 452, 114, 452, 221, 410, 200 },
            on_clicked = function(world)
                swap_room(world, world.bedroom, 160, 361)
            end,
            can_interact = true,
            trigger = true,
        },
        {
            name = "gameroom door",
            x = -24,
            y = -52,
            colliders = { 638, 206, 676, 224, 676, 334, 638, 314 },
            on_clicked = function(world)
                swap_room(world, world.bedroom, 215, 300)
            end,
            can_interact = true,
            trigger = true,
        },
        {
            name = "plant",
            image = love.graphics.newImage("assets/furniture/living_room_plant.png"),
            x = -32,
            y = 100,
            colliders = { 350, 524, 402, 492, 452, 522, 400, 550 },
            trigger = false,
            cx = 48,
            cy = 109,
        },
        {
            name = "rug",
            image = love.graphics.newImage("assets/furniture/living_room_bug.png"),
            x = -24,
            y = -61,
            always = "behind",
        },
        {
            name = "shelves",
            image = love.graphics.newImage("assets/furniture/living_room_shelves.png"),
            x = -380,
            y = -140,
        },
        {
            name = "cat tree",
            image = love.graphics.newImage("assets/furniture/cat_tree.png"),
            x = 112,
            y = 10,
            colliders = { 480, 376, 526, 354, 570, 376, 526, 398 },
            trigger = false,
            cx = 2,
            cy = 57,
        },
        {
            name = "kitchen door",
            image = love.graphics.newImage("assets/door_frame.png"),
            x = -324,
            y = -32,
            colliders = { 56, 272, 56, 384, 104, 408, 104, 296 },
            on_clicked = function(world)
                swap_room(world, world.bedroom, 215, 300)
            end,
            can_interact = true,
            trigger = true,
            always = "infront"
        },
    },
    livingroom_floorcolliders =
    {
        32, 344, 364, 178, 732, 362, 398, 526
    },
}
