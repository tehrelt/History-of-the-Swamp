function Main( keys )
	local caster = keys.caster
	local target = keys.target
	local money = 500
	local target_money = target:GetGold()

	if target_money > 499 then
		target:EmitSound("DOTA_Item.Hand_Of_Midas")
		local midas_particle = ParticleManager:CreateParticle("particles/roscommidas/roscom_midas.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)	
		ParticleManager:SetParticleControlEnt(midas_particle, 1, keys.caster, PATTACH_POINT_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), false)

		local bonusGold = money
		local Steal = money * -1

		caster:ModifyGold(bonusGold, false, 0)
		target:ModifyGold(Steal, false, 0)
	end
end


-- -createhero bounty_hunter 