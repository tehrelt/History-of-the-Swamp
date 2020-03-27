--[[Author: YOLOSPAGHETTI
	Date: March 24, 2016
	Applies the damage to the target and gives the caster's team vision around it]]
function ThundergodsWrath(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local sight_radius = ability:GetLevelSpecialValueFor("sight_radius", (ability:GetLevel() -1))
	local sight_duration = ability:GetLevelSpecialValueFor("sight_duration", (ability:GetLevel() -1))
	
	-- If the target is not invisible, we deal damage to it
	if target:IsInvisible() ~= true then
		ApplyDamage({victim = target, attacker = caster, damage = ability:GetAbilityDamage(), damage_type = ability:GetAbilityDamageType()})
	end
	-- Gives the caster's team vision around the target
	AddFOWViewer(caster:GetTeam(), target:GetAbsOrigin(), sight_radius, sight_duration, false)
	-- Renders the particle on the target
	local particle = ParticleManager:CreateParticle(keys.particle, PATTACH_WORLDORIGIN, target)
	-- Raise 1000 if you increase the camera height above 1000
	ParticleManager:SetParticleControl(particle, 0, Vector(target:GetAbsOrigin().x,target:GetAbsOrigin().y,target:GetAbsOrigin().z + target:GetBoundingMaxs().z ))
	ParticleManager:SetParticleControl(particle, 1, Vector(target:GetAbsOrigin().x,target:GetAbsOrigin().y,1000 ))
	ParticleManager:SetParticleControl(particle, 2, Vector(target:GetAbsOrigin().x,target:GetAbsOrigin().y,target:GetAbsOrigin().z + target:GetBoundingMaxs().z ))
	-- Plays the sound on the target
	EmitSoundOn(keys.sound, target)
end

function LevelUpAbility( event )
	local caster = event.caster
	local this_ability = event.ability		
	local this_abilityName = this_ability:GetAbilityName()
	local this_abilityLevel = this_ability:GetLevel()

	-- The ability to level up
	local ability_name = event.ability_name
	local ability_handle = caster:FindAbilityByName(ability_name)	
	local ability_level = ability_handle:GetLevel()

	-- Check to not enter a level up loop
	if ability_level ~= this_abilityLevel then
		ability_handle:SetLevel(this_abilityLevel)
	end
end

function FuckedUpAnything( event )
	local caster = event.caster
	local this_ability = event.ability		
	local this_abilityName = this_ability:GetAbilityName()
	local this_abilityCooldown = this_ability:GetCooldownTime() 

	-- The ability to cooldown
	local ability_name = event.ability_name
	local ability_handle = caster:FindAbilityByName(ability_name)	
	local ability_cooldown = ability_handle:GetCooldownTime()

	if ability_cooldown ~= this_abilityCooldown then
		ability_handle:StartCooldown(this_abilityCooldown)
	end
end