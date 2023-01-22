RegisterServerEvent("YlMenu:openmenucheck")
AddEventHandler("YlMenu:openmenucheck", function()
    if IsPlayerAceAllowed(source, "YlMenu.openmenu") then
        TriggerClientEvent("YlMenu:openmenu", source, true)
    else
        TriggerClientEvent("YlMenu:openmenu", source, false)
    end
end)