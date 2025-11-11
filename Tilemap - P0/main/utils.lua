------------- 常用公共工具箱 -------------
--[[ 
utils.lua 
目的：
- 表明这个模块不是游戏里某个具体对象（比如玩家、敌人、地图），而是放一些通用的小工具函数或常量，能在多个地方被复用。
- 也就是说，它相当于一个“公共工具箱”。

包括：
1. 通用常量与数学工具
2. 坐标与角度转换
3. 随机与概率工具
4. 矢量与距离计算
]]--
-------------------------------------

local M = {}

---- 因tilemap整体放大了2倍，以匹配1280x720的分辨率，故tile尺寸（原始尺寸18x18）也放大2倍 ----
local tile_size = 18 * 2

---- 1. 编写 屏幕空间坐标（世界空间坐标） --> 瓦片地图空间坐标 工具函数 ----
--[[
世界到瓦片转换的数学原理:
- 假设将世界空间坐标均分为大小相等的格子（瓦片）
- 要确定某个物体是否在某个格子内，只需将世界空间坐标（即像素位置）除以单个格子（瓦片）的尺寸即可
- 因此该计算的本质是：该距离能够容纳下多少个格子（瓦片）？就像长度除以计量单位一样（该长度能够以某个计量单位为准，分出多少个？）
]]--
--------------------------------------------------------------------
function M.world_to_tile(position)
	---- 创建一个变量position的副本 --> 变量tile，而非直接引用它 ----
	local tile = vmath.vector3(position.x, position.y, position.z)    
	tile.x = math.ceil(position.x / tile_size)    					-- 因为Defold和lua是从1-based开始索引的，而不是0-based。瓦片格子也不例外 --
	tile.y = math.ceil(position.y / tile_size)
	return tile
end

---- 2. 编写 瓦片地图空间坐标 --> 屏幕空间坐标（世界空间坐标） 工具函数 ----
function M.tile_to_world(tile_coordinate)
	local pos = vmath.vector3()
	pos.x = tile_coordinate.x * tile_size - tile_size / 2
	pos.y = tile_coordinate.y * tile_size - tile_size / 2
	return pos
end

return M