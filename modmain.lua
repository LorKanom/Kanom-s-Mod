local function OnEquip(inst, owner)
    owner.components.inventory:SetOverflow(inst)
end

local function OnUnequip(inst, owner)
    owner.components.inventory:SetOverflow(nil)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("backpack1")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("backpack")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem:SetOnPutInInventoryFn(function(inst, owner)
        if owner.prefab == "seupersonagem" then -- Substitua "seupersonagem" pelo nome do seu personagem
            inst.components.equippable:Equip(owner)
        end
    end)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("survivor_bag", fn)