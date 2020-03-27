function Main( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1
	local modifier = keys.modifier
	local max_stacks = ability:GetLevelSpecialValueFor("max_stacks", ability_level)

	-- if caster.chic_target then
	-- 	if caster.chic_target == target then
	-- 		if caster:HasModifier(modifier) then
	-- 			local stack_count = caster:GetModifierStackCount(modifier, ability)

	-- 			if stack_count < max_stacks then
	-- 				caster:SetModifierStackCount(modifier, ability, stack_count + 1)
	-- 			end
	-- 		else
	-- 			ability:ApplyDataDrivenModifier(caster, caster, modifier, {}) 
	-- 			caster:SetModifierStackCount(modifier, ability, 1)
	-- 		end
	-- 	else
	-- 		caster:RemoveModifierByName(modifier)
	-- 		caster.chic_target = target
	-- 	end
	-- else
	-- 	caster.chic_target = target
	-- end

	if caster:HasModifier(modifier) then
		local stack_count = caster:GetModifierStackCount(modifier, ability)

		if stack_count < max_stacks then
			caster:SetModifierStackCount(modifier, ability, stack_count + 1)
		end
	else
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {}) 
		caster:SetModifierStackCount(modifier, ability, 1)
	end
end


function DeathChic( keys )
	local caster = keys.caster
	local modifier = keys.modifier

	caster:RemoveModifierByName(modifier)
end