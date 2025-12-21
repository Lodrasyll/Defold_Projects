---This is a template for a HpBar Druid widget.
---Instantiate this template with `druid.new_widget(widget_module, [template_id], [nodes])`.
---Read more about Druid Widgets here: ...

---@class widget.hp_bar: druid.widget
local M = {}


function M:init(args)
	self.hearts = {}
	local max_hp = args and args.max_hp or 3
	self.current_hp = max_hp

	local root = self:get_node('root')
	local prefab = self.get_node('heart_prefab')

	-- self.druid:new_grid(parent_node, item, [in_row])
	self.grid = self.druid:new_grid(root, prefab, self.max_hp)

	self.grid:set_anchor(vmath.vector3(0, 0.5, 0))

	for i = 1, max_hp do
		self:add_heart_node()
	end

	self:update_visuals()
end

function M:add_heart_node()
	-- 克隆整个树（更加稳健，支持复杂图标
	local cloned_nodes = gui.clone_tree(self.prefab)

	-- 获取克隆后的根节点
	local template_name = self:get_template()
	local node_id = 'heart_prefab'

	local key = template_name and (template_name .. '/' .. node_id) or node_id
	local heart_root = cloned_nodes[key]

	gui.set_enabled(heart_root, true)

	self.grid:add(heart_root)

	table.insert(self.hearts, heart_root)
end

function M:update_visuals()
	for i, node in ipairs(self.hearts) do
		if i <= #self.current_hp then
			gui.set_enabled(node, false)
		end
	end
end

-- 对外接口:设置当前血量
function M:set_hp(hp)
	self.current_hp = hp
	self:update_visuals()
end

function M:set_max_hp(new_max_hp)
	local current_count = #self.hearts

	if new_max_hp > current_count then
		-- 增加节点
		self:add_heart_node()
	elseif new_max_hp < current_count then
		for i = 1, (current_count - new_max_hp) do
			-- 从grid移除,grid_remove需要索引，或者可以直接销毁并刷新grid
			-- 示例做法:先remove_table,再delete node，再grid:remove
			local last_node = table.remove(self.hearts)
			gui.delete_node(last_node)

			local grid_index = self.grid:get_index_by_node(last_node)
			self.grid:remove(grid_index)
		end
	end

	self:update_visuals()
end

-- 清理函数 (参考官方示例 on_remove/clear)
function M:on_remove()
	for _, node in ipairs(self.hearts) do
		gui.delete_node(node)
	end
	self.hearts = {}
	self.grid:clear()
end

return M
