local Class = require('lib.thirdparty.class')
local utils = require('core.utils.utils')

local Pokemon = Class{}

function Pokemon:init(data, level)
    self.name = data.name
    self.id = data.id

    self.battle_sprite_front = data.BattleSpriteFront
    self.battle_sprite_back = data.BattleSpriteBack

    self.base_hp = data.baseHP
    self.base_attack = data.baseAttack
    self.base_defense = data.baseDefense
    self.base_speed = data.baseSpeed

    self.HP_IV = data.HPIV
    self.attack_IV = data.attackIV
    self.defense_IV = data.defenseIV
    self.speed_IV = data.speedIV

    self.HP = self.base_hp
    self.attack = self.base_attack
    self.defense = self.base_defense
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
    local pokemon_key, pokemon = utils.random_from_dict(data)
    return pokemon_key and pokemon
end

function Pokemon:stats_level_up()
    local hp_increase = 0

    for j = 1, 3 do
        if math.random(6) <= self.HP_IV then
            self.HP = self.HP + 1
            hp_increase = hp_increase + 1
        end
    end

    local attack_increase = 0

    for j = 1, 3 do
        if math.random(6) <= self.attack_IV then
            self.attack = self.attack + 1
            attack_increase = attack_increase + 1
        end
    end

    local defense_increase = 0

    for j = 1, 3 do
        if math.random(6) <= self.defense_IV then
            self.defense = self.defense + 1
            defense_increase = defense_increase + 1
        end
    end

    local speed_increase = 0

    for j = 1, 3 do
        if math.random(6) <= self.speed_IV then
            self.speed = self.speed + 1
            speed_increase = speed_increase + 1
        end
    end

    return hp_increase, attack_increase, defense_increase, speed_increase
end

function Pokemon:level_up()
    self.level = self.level + 1
    self.expToLevel = self.level * self.level * 5 * 0.75

    return self:stats_level_up()
end

return Pokemon