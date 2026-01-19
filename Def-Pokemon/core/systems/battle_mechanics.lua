local M  = {}

--简化的宝可梦伤害公式：
--Damage = (((2 * Level / 5 + 2) * Power * A / D) / 50 + 2)

---@param attacker instance 攻击方的 PokemonEngine 实例
---@param defender instance 防守方的 PokemonEngine 实例
---@param move_power number 技能威力 (如果不传，默认为 40，即撞击)
function M.calculate_damege(attacker, defender, move_power)
    local power = move_power or 40
    local level = attacker.level
    local attack = attacker.attack
    local defense = defender.defense

    local damage = (((2 * level / 5 + 2) * power * attack / defense) / 50 + 2)
    local random_multiple = math.random(85, 100) / 100 -- 增加一点点随机浮动 (0.85 ~ 1.0)
    damage = math.floor(damage * random_multiple)

    return math.max(1, damage) -- 至少造成 1 点伤害
end

return M