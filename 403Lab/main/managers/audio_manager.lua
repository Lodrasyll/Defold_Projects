local M = {}

M.sounds = {
	click = 'main:/sfx#click_sound'
}

M.music = {
	moon = 'main:/music#moon'
}

function M.play_music(id)
	sound.play(M.music[id])
end

function M.play_sfx(id)
	
	sound.play(M.sounds[id])
end

return M