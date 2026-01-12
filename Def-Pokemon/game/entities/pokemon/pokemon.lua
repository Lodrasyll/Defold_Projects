local utils = require('core.utils.utils')

local Pokemon = {}

function Pokemon:init(data, level)
    self.name = data.name

    self.battle_sprite_front = data.BattleSpriteFront
    self.battle_sprite_back = data.BattleSpriteBack

    self.base_hp = data.baseHP
    self.base_attack = data.baseAttack
    self.base_dataense = data.basedataense
    self.base_speed = data.baseSpeed

    self.HP_IV = data.HPIV
    self.attack_IV = data.AttackIV
    self.dataense_IV = data.dataenseIV
    self.speed_IV = data.SpeedTIV

    self.HP = self.base_hp
    self.attack = self.base_attack
    self.dataense = self.base_dataense
    self.speed = self.base_speed

    self.level = level
    self.current_exp = 0
    self.exp_to_level = self.level * self.level * 5 * 0.75

    self:calculate_stats()

    self.current_HP = self.HP
end

function Pokemon:calculate_stats()
    for i = 1, self.level do
        self:stats_level_up()
    end
end

function Pokemon.get_random_pokemon(data)
    local _, pokemon = utils.random_from_dict(data)
    return pokemon
end

function Pokemon:stats_level_up()
    local HPIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.HPIV then
            self.HP = self.HP + 1
            HPIncrease = HPIncrease + 1
        end
    end

    local attackIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.attackIV then
            self.attack = self.attack + 1
            attackIncrease = attackIncrease + 1
        end
    end

    local dataenseIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.dataenseIV then
            self.dataense = self.dataense + 1
            dataenseIncrease = dataenseIncrease + 1
        end
    end

    local speedIncrease = 0

    for j = 1, 3 do
        if math.random(6) <= self.speedIV then
            self.speed = self.speed + 1
            speedIncrease = speedIncrease + 1
        end
    end

    return HPIncrease, attackIncrease, dataenseIncrease, speedIncrease
end

function Pokemon:level_up()
    self.level = self.level + 1
    self.expToLevel = self.level * self.level * 5 * 0.75

    return self:stats_level_up()
end

return Pokemon