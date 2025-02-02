-- scripts/wx78_skilltree.lua

local SkillTree = Class(function(self, inst)
    self.inst = inst
    self.sessions = {} -- Sessões da skill tree
    self.unlocked_skills = {} -- Habilidades desbloqueadas
end)

-- Define as sessões da skill tree
function SkillTree:SetSessions(sessions)
    self.sessions = sessions
end

-- Desbloqueia uma habilidade
function SkillTree:UnlockSkill(skill_name)
    if not self.unlocked_skills[skill_name] then
        self.unlocked_skills[skill_name] = true
        self.inst:PushEvent("unlockskill", { skill = skill_name })
    end
end

-- Verifica se uma habilidade está desbloqueada
function SkillTree:HasSkill(skill_name)
    return self.unlocked_skills[skill_name] or false
end

return SkillTree