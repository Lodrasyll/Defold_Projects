local M = {}

M.matches = {}

local game_data = require('data.configs.game_data')
local utils = require('core.utils.utils')
local board_width = game_data.board_width
local board_height = game_data.board_height


function M.calculated_match()
    local board = game_data.board
    M.matches = {}
    local match_num = 1

    -- 水平方向检测匹配
    for y = 0, board_height - 1 do
        local color_match = nil
        if board[0][y] then
            color_match = board[0][y].color
        end
        match_num = 1

        for x = 1, board_width - 1 do
            local current_brick = board[x][y]
            local current_color = nil
            if current_brick ~= nil then
                current_color = current_brick.color
            end

            if color_match ~= nil and current_color ~= nil and
            current_color == color_match then
                match_num = match_num + 1
            else
                color_match = board[x][y].color

                if match_num >= 3 then
                    local match = {}
                    for x2 = x - 1, x - match_num, -1 do
                        table.insert(match, board[x2][y])
                    end

                    table.insert(M.matches, match)
                end

                color_match = current_color
                match_num = 1
            end
        end
        -- 边界问题，当最后一个依然为匹配项的时候
        if match_num >= 3 then
            local match = {}
            for x = board_width - 1, board_width - match_num, -1 do
                table.insert(match, board[x][y])
            end
            table.insert(M.matches, match)
        end
    end

    -- 垂直方向检测匹配
    for x = 0, board_width - 1 do
        local color_match = nil
        if board[x][0] then
            color_match = board[x][0].color
        end

        match_num = 1

        for y = 1, board_height - 1 do
            local current_brick = board[x][y]
            local current_color = nil
            if current_brick ~= nil then
                current_color = current_brick.color
            end
            if color_match ~= nil and current_color ~= nil and
            current_color == color_match then
                match_num = match_num + 1
            else
                color_match = board[x][y].color

                if match_num >= 3 then
                    local match = {}
                    for y2 = y - 1, y - match_num, -1 do
                        table.insert(match, board[x][y2])
                    end

                    table.insert(M.matches, match)
                end

                color_match = current_color
                match_num = 1
            end
        end
        -- 边界问题，当最后一个依然为匹配项的时候
        if match_num >= 3 then
            local match = {}
            for y = board_height - 1, board_height - match_num, -1 do
                table.insert(match, board[x][y])
            end
            table.insert(M.matches, match)
        end
    end

    return #M.matches > 0 and M.matches or false
end

function M.remove_match()
    local board = game_data.board
    if M.matches then
        for key, match in pairs(M.matches) do
            for key, brick in pairs(match) do
                if brick.id then
                    go.delete(brick.id)
                end

                board[brick.x][brick.y] = nil
            end
        end
    end

    M.matches = {}
end

function M.get_falling_brick(factory_url)
    local board = game_data.board
    
    for x = 0, board_width - 1 do
        local space = false
        local space_y = -1
        local y = 0
        while y <= board_height - 1 do
            local brick = board[x][y]
            if space then
                if brick then
                    board[x][space_y] = brick
                    brick.y = space_y
                    board[x][y] = nil
                    space = false
                    y = space_y
                    space_y = -1
                elseif brick == nil then
                    space = true
                    if space_y == -1 then
                        space_y = y
                    end
                end
            end
            
            y = y + 1
        end
        
    end

    for x = 0, board_width - 1 do
        for y = board_height - 1, 0, -1 do
            local brick = board[x][y]
            if not brick then
                local color = game_data.colors_list[math.random(#game_data.colors_list)]
                local slot_index = { x, y }
                local pos = utils.board_slot_to_world(slot_index)
                local new_id = factory.create(factory_url, pos, nil, { color = hash(color) })
                board[x][y] = {
                    id = new_id,
                    x = x,
                    y = y,
                    color = hash(color),
                    pos = pos
                }
            end
        end
    end
end


return M