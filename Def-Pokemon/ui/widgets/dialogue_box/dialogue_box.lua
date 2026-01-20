local SoundController = require('core.components.sound_controller')
local event = require('event.event')
local Input = require('core.systems.input')

---@class widget.dialogue_box: druid.widget
local M = {}


function M:init()
	self.dialogue_box = self.druid:new_button('dialogue_box/dialogue_zone', self.on_click)
	self.text_node = self:get_node('dialogue_box/text')
	self.on_dialogue_end = event.create()

	self.current_count = 1

end

function M:set_texts_data(texts)
	self.texts = texts
	self.text_node = self:get_node('dialogue_box/text')
	self.druid:new_text(self.text_node, self.texts[1].text)
end

function M:on_click()
	SoundController.play('sfx_thip', SoundController.GROUP_SFX)
	self:next_text()
end

function M:next_text()
	-- 先增加计数
	self.current_count = self.current_count + 1
	-- 边界检查
	if self.current_count > #self.texts then
		print('close dialogue')
		self.on_dialogue_end:trigger()
		return
	end
	-- 负责实际更新
	self.druid:new_text(self.text_node, self.texts[self.current_count].text)
end

function M:on_input(action_id, action)
	if action_id == Input.CONFIRM and action.pressed then
		self:on_click()
	end
end

return M



