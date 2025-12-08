local M = {}
local game_data = require('data.configs.game_data')

local slot_size = game_data.slot_size
local board_spawn_pos = game_data.board_spawn_pos

function M.screen_to_slot(board, x, y)
    local slot_index = vmath.vector3(world_pos.x, world_pos.y, world_pos.z)
    slot_index.x = math.floor((world_pos.x - board_spawn_pos.x) / slot_size)
    slot_index.y = math.floor((world_pos.y - board_spawn_pos.y) / slot_size)
    return slot_index
end

function M.slot_to_screen(board, x, y)
    local pos = vmath.vector3()
    pos.x = board_spawn_pos.x + slot_size / 2 + slot_size * slot_index.x
    pos.y = board_spawn_pos.y + slot_size / 2 + slot_size * slot_index.y
    return pos
end 

function M.is_valid_slot(slot_index)
    return  slot_index.x >= 0 and slot_index.x < game_data.board_width and
            slot_index.y >= 0 and slot_index.y < game_data.board_height
end


return M