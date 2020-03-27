troll_warlord_fervor_lua = class({})
LinkLuaModifier( "modifier_troll_warlord_fervor_lua", "lua_abilities/troll_warlord_fervor_lua/modifier_troll_warlord_fervor_lua", LUA_MODIFIER_MOTION_NONE ) -- Ссылка на модификатор

--------------------------------------------------------------------------------

function troll_warlord_fervor_lua:GetIntrinsicModifierName() -- Если, это пассивная тогда активировать(Просто включает модификатор не важная какая способность активная или неактивная)
    return "modifier_troll_warlord_fervor_lua" -- Ссылка на активацию модификатора
end