local M = {}

-- 1. 先定义基础常量 (Local Variables)
local TILE_SIZE = 16 * 4
local SCREEN_WIDTH = sys.get_config_number('display.width')
local SCREEN_HEIGHT = sys.get_config_number('display.height')
local PADDING = 2

-- 2. 在这里处理你的计算逻辑
-- 先算出宽度
local map_width = math.ceil(SCREEN_WIDTH / TILE_SIZE)
local map_height = math.ceil(SCREEN_HEIGHT / TILE_SIZE)

-- 处理奇偶居中逻辑 (如果宽度是奇数，减1变为偶数)
if map_width % 2 ~= 0 then
    map_width = map_width - 1
end

-- 3. 构建最终的导出表
M.DunConst = {
    -- 基础配置
    TILE_SIZE = TILE_SIZE,
    SCREEN_WIDTH = SCREEN_WIDTH,
    SCREEN_HEIGHT = SCREEN_HEIGHT,
    PADDING = PADDING,
    MAX_ROOMS = 25,

    -- 计算后的结果
    ROOMMAP_WIDTH = map_width,
    ROOMMAP_HEIGHT = map_height,

    TileConfig = {
        layers = {
            ground = 'ground',
            wall = 'wall',
            void = 'void',
            door = 'door',
            doorway = 'doorway'
        },
        ids = {
            empty = 19,
            floors = {
                7, 8, 9, 10, 11, 12, 13,
                26, 27, 28, 29, 30, 31, 32,
                45, 46, 47, 48, 49, 50, 51,
                64, 65, 66, 67, 68, 69, 70,
                88, 89, 107, 108
            },
            walls = {
                top = { 58, 59, 60 },
                bottom = { 79, 80, 81 },
                left = { 77, 96, 115 },
                right = { 78, 97, 116 },
            },
            corners = {
                tl = 4, tr = 5, bl = 23, br = 24
            },
            doors = {
                top = { left = 134, right = 135 },
                bottom = { left = 153, right = 154 }
            },
            door_test = 120
        }
    },

}


return M
