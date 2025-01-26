local input = require("input")
local function swap_room(world, newroom, sx, sy)
    world.currentRoom = newroom
    world.player.pos.x = sx
    world.player.pos.y = sy
    love.window.setMode(world.currentRoom.bg:getWidth(), world.currentRoom.bg:getHeight())
    input.reset()
    reset_snowflakes()
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
            on_clicked = function(world, furn)
                -- give items to Smoochus
                if not world.player.held_item and world.task_num ~= 3 then
                    return
                end

                if world.task_num == 3 then
                    world.complete = true
                    furn.image = love.graphics.newImage("assets/furniture/bunk_bed_both.png")
                    return
                end

                if world.player.held_item.furniture.name == "blankets" and world.task_num == 0 then
                    world.task_num = world.task_num + 1
                    world.player.held_item = nil
                elseif world.player.held_item.furniture.name == "hot choco" and world.task_num == 1 then
                    world.task_num = world.task_num + 1
                    world.player.held_item = nil
                elseif world.player.held_item.furniture.name == "game console" and world.task_num == 2 then
                    world.task_num = world.task_num + 1
                    world.player.held_item = nil
                end
            end,
            ui_bg = love.graphics.newImage("assets/ui/ui_bg.png"),
            blankets_image = love.graphics.newImage("assets/furniture/folded_blankets.png"),
            hot_choco_image = love.graphics.newImage("assets/furniture/hot_chocolate.png"),
            game_console_image = love.graphics.newImage("assets/furniture/game_console.png"),
            hooky_image = love.graphics.newImage("assets/player/hooky.png"),
            custom_draw = function(world, furn, x, y)
                if world.complete then return end

                local xx = x + 15
                local yy = y - 77 + (math.sin(love.timer.getTime()) * 4.0)
                love.graphics.draw(furn.ui_bg, xx, yy)
                if world.task_num == 0 then
                    love.graphics.draw(furn.blankets_image, xx + 10, yy + 2)
                end
                if world.task_num == 1 then
                    love.graphics.draw(furn.hot_choco_image, xx + 10, yy + 2)
                end
                if world.task_num == 2 then
                    love.graphics.draw(furn.game_console_image, xx + 10, yy + 2)
                end
                if world.task_num == 3 then
                    love.graphics.draw(furn.hooky_image, xx + 10, yy + 2)
                end
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
    },
    bedroom_floorcolliders =
    {
        56, 324, 206, 248, 400, 348, 248, 420
    },
    livingroom = {
        {
            name = "blankets",
            image = love.graphics.newImage("assets/furniture/blanket.png"),
            x = 41,
            y = -15,
            colliders = { 421, 339, 474, 366, 474, 312, 423, 284 },
            trigger = true,
            on_clicked = function(world, furn)
                print("BLANKY")
                furn.hidden = true
                if world.player.held_item == nil then
                    world.player:hold_item({
                        image = love.graphics.newImage("assets/furniture/folded_blankets.png"),
                        furniture = furn,
                    })
                end
            end,
            cx = 26,
            cy = 58
        },
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
            trigger = false,
            cx = 16,
            cy = 141
        },
        {
            name = "mug",
            image = love.graphics.newImage("assets/furniture/empty_mug.png"),
            x = -58,
            y = -86,
            colliders = { 322, 250, 326, 217, 352, 219, 351, 260 },
            on_clicked = function(world, furn)
                -- pick up mug
                furn.hidden = true
                if world.task_num == 1 then
                    if world.player.held_item == nil then
                        world.player:hold_item({
                            image = love.graphics.newImage("assets/furniture/empty_mug.png"),
                            furniture = furn,
                        })
                    end
                end
            end,
            trigger = true,
            cx = 10,
            cy = 94
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
            on_clicked = function(world, furn)
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
            on_clicked = function(world, furn)
                swap_room(world, world.game_room, 180, 310)
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
            on_clicked = function(world, furn)
                swap_room(world, world.kitchen, 460, 300)
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
    kitchen = {
        {
            name = "living room door",
            x = -24,
            y = -52,
            colliders = { 425, 202, 466, 181, 466, 287, 425, 308 },
            on_clicked = function(world, furn)
                swap_room(world, world.livingroom, 100, 375)
            end,
            can_interact = true,
            trigger = true,
        },
        {
            name = "fridge",
            image = love.graphics.newImage("assets/furniture/fridge.png"),
            x = -240,
            y = -96,
            always = "behind",
        },
        {
            name = "counter",
            image = love.graphics.newImage("assets/furniture/countertop_in_real.png"),
            x = -338,
            y = -10,
            always = "behind",
        },
        {
            name = "hot choco",
            image = love.graphics.newImage("assets/furniture/hot_chocolate.png"),
            x = -262,
            y = 9,
            cx = 13,
            cy = 20,
            on_clicked = function (world, furn)
                furn.hidden = true
                if world.player.held_item == nil then
                    world.player:hold_item({
                        image = love.graphics.newImage("assets/furniture/hot_chocolate.png"),
                        furniture = furn,
                    })
                end
            end,
            custom_draw = function (world, furn, x, y)
            end,
            trigger = true,
            can_interact = true,
            hidden = true,
            colliders = { 139, 292, 176, 291, 176, 327, 139, 328 },
        },
        {
            name = "kettle",
            image = love.graphics.newImage("assets/furniture/kettle.png"),
            x = -292,
            y = 19,
            cx = 13,
            cy = 20,
            start_time = 0,
            started = false,
            font = love.graphics.newFont("assets/elliott.ttf", 32),
            on_clicked = function (world, furn)
                if not world.player.held_item then
                    return
                end
                if world.player.held_item.furniture.name == "mug" then
                    furn.x = -327
                    furn.y = 53
                    furn.colliders = { 69, 332, 104, 331, 106, 367, 74, 368 }
                    furn.started = true
                    furn.start_time = love.timer.getTime()
                    world.player.held_item = nil
                end
            end,
            custom_draw = function (world, furn, x, y)
                if furn.started then
                    local seconds = 5 - (love.timer.getTime() - furn.start_time)
                    if seconds < 0 then
                        seconds = 0
                        furn.hidden = true
                        world.find_furn("hot choco").hidden = false
                    end
                    local time_text = love.graphics.newText(furn.font, string.format("%d:%.2d", math.floor(seconds / 60), seconds % 60))
                    love.graphics.draw(time_text, x - time_text:getWidth() / 2, y - time_text:getHeight() - 30)
                end
            end,
            trigger = true,
            can_interact = true,
            colliders = { 109, 292, 136, 291, 146, 327, 105, 328 },
        },
        {
            name = "oven",
            image = love.graphics.newImage("assets/furniture/oven.png"),
            x = -390,
            y = 18,
            always = "behind",
        },
        {
            name = "island",
            image = love.graphics.newImage("assets/furniture/countertop.png"),
            x = -220,
            y = 10,
            trigger = false,
            can_interact = false,
            colliders = { 209, 433, 269, 400, 410, 469, 346, 499 },
            cx = 30,
            cy = 142,
        },
        {
            name = "clock",
            image = love.graphics.newImage("assets/furniture/kitchen_clock.png"),
            x = -70,
            y = -120,
            always = "behind"
        },
        {
            name = "wine",
            image = love.graphics.newImage("assets/furniture/wine.png"),
            x = -90,
            y = -80,
            always = "behind"
        },
        {
            name = "table",
            image = love.graphics.newImage("assets/furniture/table.png"),
            x = 12,
            y = -40,
            trigger = false,
            can_interact = false,
            colliders = { 458, 357, 594, 290, 645, 314, 519, 383 },
            cx = 78,
            cy = 98,
        },
    },
    -- TODO: multiple colliders to move all across kitchen
    kitchen_floorcolliders = {
        172, 432, 576, 232, 746, 318, 340, 518
    },
    kitchen_floorcolliders2 = {
        192, 440, 116, 400, 259, 328, 352, 376
    },
    game_room = {
        {
            name = "living room door",
            image = love.graphics.newImage("assets/door_frame.png"),
            x = 36,
            y = 28,
            colliders = { 168, 338, 170, 227, 214, 204, 215, 314 },
            on_clicked = function(world, furn)
                swap_room(world, world.livingroom, 630, 330)
            end,
            can_interact = true,
            trigger = true,
            flip_h = true,
            always = "infront",
            cx = -1,
            cy = 113
        },
        {
            name = "game console",
            image = love.graphics.newImage("assets/furniture/game_console.png"),
            x = -30,
            y = 30,
            colliders = { 140, 229, 172, 201, 192, 212, 156, 247 },
            cx = 12,
            cy = 68,
            trigger = true,
            can_interact = true,
            on_clicked = function (world, furn)
                if world.task_num ~= 2 then return end
                if world.player.held_item == nil then
                    furn.hidden = true
                    world.player:hold_item({
                        image = furn.image,
                        furniture = furn,
                    })
                end
            end
        },
        {
            name = "pool table",
            image = love.graphics.newImage("assets/furniture/pool_table.png"),
            x = -128,
            y = -152,
            colliders = { 70, 249, 212, 171, 282, 212, 146, 287 },
            cx = 22,
            cy = 196,
        },
    },
    game_room_floor_colliders = {
        5, 282, 216, 178, 352, 246, 143, 351
    }
}
