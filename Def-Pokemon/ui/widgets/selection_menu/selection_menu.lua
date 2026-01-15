local event = require('event.event')
local SoundController = require('core.components.sound_controller')
local Input = require('core.systems.input')

---@class widget.selection_menu: druid.widget
local M = {}

local CURSOR_OFFSET = 180

function M:view_update_cursor(self)
	local node_pos = gui.get_position(self.options[self.current_cursor].node)
	node_pos.x = node_pos.x - CURSOR_OFFSET
	gui.set_position(self.cursor_node, node_pos)
end

function M:next_option(self)
	if self.current_cursor < 1 then
		self.current_cursor = #self.options
	elseif self.current_cursor > #self.options then
		self.current_cursor = 1
	end
	self:view_update_cursor(self)
	SoundController.play('Thip', SoundController.GROUP_SFX)
end

-- function M:on_select(index)
-- 	print('selected ' .. self.current_cursor)
-- end

function M:set_data(data)
	self.data = data
	for i = 1, 3 do
		local node = 'selection_menu/option_text_' .. i
		local text = self.druid:new_text(node, self.data[i])
		self.options[i].text = text
	end
end

function M:init()
	self.cursor_node = gui.get_node('selection_menu/cursor')
	self.current_cursor = 1
	self.selected = nil

	self.on_option_select = event.create()

	self.options = {}
	for i = 1, 3 do
		local node = 'selection_menu/option_' .. i
		local index = i
		local callback = function()
			self:on_click(index)
		end
		local option = self.druid:new_button(node, callback)
		self.options[i] = option
	end


end
function M:on_click(index)
	self.on_option_select:trigger(index)
	SoundController.play('Thip', SoundController.GROUP_SFX)
end

function M:on_input(action_id, action)
	if action_id == Input.UP and action.pressed then
		self.current_cursor = self.current_cursor - 1
		self:next_option(self)
		return true
	elseif action_id == Input.DOWN and action.pressed then
		self.current_cursor = self.current_cursor + 1
		self:next_option(self)
		return true
	elseif action_id == Input.CONFIRM then
		if action.pressed then
			self.selected = self.options[self.current_cursor]
			if self.selected then
				self.selected:on_click()
				return true
			end
		end
	end
	return false
end


return M
