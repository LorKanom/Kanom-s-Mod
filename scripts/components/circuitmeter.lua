-- scripts/components/circuitmeter.lua

local CircuitMeter = Class(function(self, inst)
    self.inst = inst
    self.max_charge = 60 -- Carga máxima de energia
    self.current_charge = 0 -- Carga atual
    self.pins_enabled = 0 -- Número de pinos habilitados
    self.is_enabled = false -- Medidor está habilitado?
end)

-- Habilita o medidor de circuitos
function CircuitMeter:Enable()
    self.is_enabled = true
    self.inst:StartUpdatingComponent(self)
end

-- Atualiza o medidor de circuitos
function CircuitMeter:OnUpdate(dt)
    if self.is_enabled then
        -- Atualiza o número de pinos habilitados
        self.pins_enabled = math.floor(self.current_charge / 10)

        -- Aplica buffs quando a carga está no máximo
        if self.current_charge >= self.max_charge then
            self.inst.components.combat.damagemultiplier = 1.2 -- Buff de dano
            self.inst.components.locomotor.runspeed = 1.2 -- Buff de velocidade
        else
            self.inst.components.combat.damagemultiplier = 1.0
            self.inst.components.locomotor.runspeed = 1.0
        end
    end
end

-- Adiciona carga ao medidor
function CircuitMeter:AddCharge(amount)
    self.current_charge = math.min(self.current_charge + amount, self.max_charge)
end

-- Remove carga do medidor
function CircuitMeter:RemoveCharge(amount)
    self.current_charge = math.max(self.current_charge - amount, 0)
end

return CircuitMeter