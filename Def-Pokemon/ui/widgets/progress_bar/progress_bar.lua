---This is a template for a ProgressBar Druid widget.
---Instantiate this template with `druid.new_widget(widget_module, [template_id], [nodes])`.
---Read more about Druid Widgets here: ...

---@class widget.progress_bar: druid.widget
local M = {}


function M:init()
	-- Now we have next functions to use here:
	-- self:get_node([node_id]) -- Get node inside widget by id
	-- self.druid to access Druid Instance API, like:
	-- self.druid:new_button([node_id], [callback])
	-- self.druid:new_text([node_id], [text])
	-- And all functions from component.lua file
end

return M
