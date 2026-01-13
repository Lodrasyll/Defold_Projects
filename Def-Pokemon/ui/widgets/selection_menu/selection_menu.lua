local SoundController = require('core.components.sound_controller')
local monarch = require('monarch.monarch')
local Input = require('core.systems.input')

---@class widget.selection_menu: druid.widget
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

function M:on_select(index)
	print('selected ' .. self.current_cursor)
	self.wild_menu_data.on_select(self.current_cursor)
end

function M:init()
	self.wild_menu_data = monarch.data('wild_menu')

	self.current_cursor = 1
	self.selected = nil

	self.options = {}
	for i = 1, 3 do
		local node = 'selection_menu/option_' .. i
		local option = self.druid:new_button(node)
		self.options[i] = option
	end

	if self.wild_menu_data then
		for i = 1, 3 do
			local node = 'selection_menu/text_' .. i
			local text = self.wild_menu_data.options_text[i]
			self.druid:new_text(node, text)
		end
	end
	
	self.cursor_node = gui.get_node('selection_menu/cursor')
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
	elseif action_id == Input.START or action_id == Input.CONFIRM then
		if action.pressed then
			self.selected = self.options[self.current_cursor]
			if self.selected then
				self:on_select()
				SoundController.play('confirm', SoundController.GROUP_SFX)
				return true
			end
		end
	end
	return false
end


return M
