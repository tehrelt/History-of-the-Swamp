modifier_troll_warlord_fervor_lua = class({})

--------------------------------------------------------------------------------

function modifier_troll_warlord_fervor_lua:IsHidden( kv )
    return false -- Ли будет она скрытой(модификатор)
end

function modifier_troll_warlord_fervor_lua:IsDebuff( kv )
    return false -- Это дебафф?
end

function modifier_troll_warlord_fervor_lua:IsPurgable( kv )
    return false -- Ли смогут развеять модификатор?
end

function modifier_troll_warlord_fervor_lua:RemoveOnDeath( kv )
    return false -- Хотите убрать модификатор, когда умерли
end

function modifier_troll_warlord_fervor_lua:OnCreated( kv )
    self:SetStackCount(1) -- Как только создана дает 1 стак
    self.stack_multiplier = self:GetAbility():GetSpecialValueFor("attack_speed") -- Ключ
    self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks") -- Ключ
    self.currentTarget = {} -- Текущая цель
end

function modifier_troll_warlord_fervor_lua:OnRefresh( kv ) -- Обновилась
    self.stack_multiplier = self:GetAbility():GetSpecialValueFor("attack_speed") -- Ключ
    self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks") -- Ключ
end

function modifier_troll_warlord_fervor_lua:DeclareFunctions() -- Очистить функции. Точно не знаю(
    local funcs = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK
    }

    return funcs
end

function modifier_troll_warlord_fervor_lua:OnAttack( params ) -- Вы атаковали
    if IsServer() then
        -- фильтр
        pass = false
        if params.attacker==self:GetParent() then -- Проверяет кто атаковал
            pass = true
        end

        -- логика!
        if pass then
            if self.currentTarget==params.target then -- Проверяет ли атакует ли он ту же самую цель
                self:AddStack() -- добавить стак
            else -- альтернатива
                self:ResetStack() -- ?(
                self.currentTarget = params.target -- Снимает, стаки если вы атаковали
            end
        end
    end
end

function modifier_troll_warlord_fervor_lua:GetModifierAttackSpeedBonus_Constant( params )
    local passive = 1
    if self:GetParent():PassivesDisabled() then
        passive = 0 -- Если пассивная ноль тогда она работать не будет.
    end
    return self:GetStackCount() * self.stack_multiplier * passive -- Мы получаем стаки и проверяет ли работает пассивная?
end

function modifier_troll_warlord_fervor_lua:AddStack() -- Проверяем ли максимум стаков набили
    if not self:GetParent():PassivesDisabled() then -- Пассивная не отключена значит сделай это
        if self:GetStackCount() < self.max_stacks then -- Проверяем стаки если self:GetStackGound() < self.max_stacks тогда дать стак либо так будет self:GetStackGound() <= self.max_stacks (тогда стаки не получите)
            self:IncrementStackCount() -- Прибавляет стак
        end
    end
end

function modifier_troll_warlord_fervor_lua:ResetStack()
    if not self:GetParent():PassivesDisabled() then -- Если способность не отключена
        self:SetStackCount(1)
    end
end