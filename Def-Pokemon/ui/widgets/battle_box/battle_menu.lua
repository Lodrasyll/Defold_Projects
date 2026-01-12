local SoundController = require('core.components.sound_controller')
local Input = require('core.systems.input')

---@class widget.battle_menu: druid.widget
local M = {}

local CURSOR_OFFSET = 180

local function view_update_cursor(self)
	local node_pos = gui.get_position(self.options[self.current_cursor].node)
	node_pos.x = node_pos.x - CURSOR_OFFSET
	gui.set_position(self.cursor_node, node_pos)
end

local function next_option(self)
	if self.current_cursor < 1 then
		self.current_cursor = #self.options
	elseif self.current_cursor > #self.options then
		self.current_cursor = 1
	end
	view_update_cursor(self)
	SoundController.play('Thip', SoundController.GROUP_SFX)
end

function M:on_select()
	print('selected ' .. self.current_cursor)
end

function M:init()
	self.current_cursor = 1
	self.selected = nil

	self.options = {}
	for i = 1, 3 do
		local node = 'wild_menu/option_' .. i
		local option = self.druid:new_button(node)
		self.options[i] = option
	end
	
	self.cursor_node = gui.get_node('wild_menu/cursor')
end

function M:on_input(action_id, action)
	if action_id == Input.UP and action.pressed then
		self.current_cursor = self.current_cursor - 1
		next_option(self)
		return true
	elseif action_id == Input.DOWN and action.pressed then
		self.current_cursor = self.current_cursor + 1
		next_option(self)
		return true
	elseif action_id == Input.START and action.pressed then
		self.selected = self.options[self.current_cursor]
		if self.selected then
			self:on_select()
			SoundController.play('confirm', SoundController.GROUP_SFX)
			return true
		end
	end
	return false
end


return M
