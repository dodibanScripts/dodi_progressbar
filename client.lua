

-- RegisterCommand('openMinigame', function()
--     TriggerEvent('dodi_minigame_bar:Tip', "Acerte o alvo 3x pressionando [E]!", 2000)
--     SetNuiFocus(true, false)
--     MC.StartFocus(GetCurrentResourceName())
--     SendNUIMessage({
--         action = "openMinigame",
--         hits = 3, -- Número de acertos necessários
--         speeds = {1.9, 1.3, 1.0}, -- Velocidades por etapa
--         successEvent = "minigameSuccess", -- Evento de sucesso
--         failEvent = "minigameFail" -- Evento de falha
--     })
-- end, false)

RegisterCommand('startprogress', function(source, args, rawCommand)
    SendNUIMessage({
        type = "startProgressBar"
    })
end, false)

RegisterCommand('startCrafting', function()
    TriggerEvent('crafting_minigame:Tip', "Iniciando o crafting...", 2000)
    SetNuiFocus(true, false)
 
    SendNUIMessage({
        action = "openCraftingMinigame",
        craftDuration = 30000, -- Duração do crafting em milissegundos
        successEvent = "craftingSuccess" -- Evento de sucesso após o término da barra de progresso
    })
end, false)

RegisterCommand('closeCraftingMinigame', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeCraftingMinigame"
    })
 
end, false)

RegisterNUICallback('closeCraftingMinigame', function(data, cb)
    SetNuiFocus(false, false)
    
    -- Acione o evento de sucesso passado
    if data.successEvent then
        TriggerEvent(data.successEvent)
    else
        -- Fallback para um evento padrão caso o evento de sucesso não seja especificado
        TriggerEvent('craftingSuccess')
    end
    

    cb('ok')
end)


exports('startCraftingMinigame', function(craftDuration, successEvent)
    SetNuiFocus(true, false)

    SendNUIMessage({
        action = "openCraftingMinigame",
        craftDuration = craftDuration, -- Passa a duração do crafting para o JavaScript
        successEvent = successEvent -- Evento de sucesso que será acionado
    })
end)


-- Lidar com o sucesso do minigame de crafting
RegisterNetEvent('craftingSuccess')
AddEventHandler('craftingSuccess', function()
    print('Crafting concluído com sucesso!')
    TriggerEvent('crafting_minigame:Tip', "Você conseguiu criar o item!", 2000)
    -- Aqui, adicione o código para dar o item ao jogador
    -- Exemplo: TriggerServerEvent('giveCraftedItem', 'item_name')
end)
