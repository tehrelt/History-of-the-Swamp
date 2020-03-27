function CheckScepter ( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability

	if caster:HasScepter() then 
		ability:SetHidden(false)
	end
end