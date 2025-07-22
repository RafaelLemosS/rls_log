-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

-- Cache
local discordCache = {}
local idCache = {}

-- Função para extrair o Discord com cache
function getDiscord(id)
    if not id then return "N/A" end
    
    if discordCache[id] then
        return discordCache[id]
    end
    
    local Accounts = getAccount(id)
    
    if Accounts and Accounts.Discord then
        discordCache[id] = Accounts.Discord
    else
        discordCache[id] = "N/A"
    end
    
    return discordCache[id]
end

-- Função para extrair a Licença
function getLicense(user_id)
    return getAccount(user_id) and getAccount(user_id).License or nil
end

-- Função para criar campos padrão do embed
local function createField(name, value, inline)
    return {
        name = "***" .. name .. ":***",
        value = value or "N/A",
        inline = inline or false
    }
end

-- Função para enviar logs para o Discord
function sendLogs(logInfo)
    if not logInfo or not logInfo.webhook then
        print("[Logs] Informação de log inválida.")
        return
    end
    
    local user_id = logInfo.Passport or "N/A"
    local user_name = "N/A"
    local IP = "N/A"
    local fields = {}
    
    if not user_id or user_id == "N/A" then
        print("[Logs] user_id inválido ou não fornecido.")
        return
    end
    
    if tonumber(user_id) and Config.idBloqueado[tonumber(user_id)] then
        return
    end
    
    if tonumber(user_id) then
        local identity = getIdentity(tonumber(user_id))
        user_name = string.format("%s - %s", user_id, getName(user_id) or "")
        if getSource(user_id) then
            local ipPlayer = GetPlayerEndpoint(getSource(user_id))
            IP = ipPlayer and "["..ipPlayer.."](https://check-host.net/ip-info?host="..ipPlayer..")" or "N/A"
        end
    end
    
    -- Campos padrão
    table.insert(fields, createField("Player", "```\n" .. user_name .. "\n```", true))
    if getSource(user_id) then
        table.insert(fields, createField("Source", "```\n" .. getSource(user_id) .. "\n```", true))
    end
    
    if logInfo.discord and tonumber(user_id) then
        local discordID = user_id and getDiscord(user_id) or "N/A"
        local discordTag = (discordID ~= "N/A" and discordID ~= false) and ("<@" .. discordID .. ">") or "N/A"
        table.insert(fields, createField("Discord", discordTag, true))
    end
    
    if logInfo.steam and tonumber(user_id) then
        local identity = getIdentity(tonumber(user_id))
        table.insert(fields, createField("Steam", "```\n" .. getLicense(user_id) .. "\n```", true))
    end
    
    if getSource(user_id) and IP and IP ~= "N/A" and tonumber(user_id) then
        table.insert(fields, createField("IP", "||" .. IP .. "||", true))
    end
    
    -- Campos adicionais
    for _, v in ipairs(logInfo.fields or {}) do
        table.insert(fields, createField(v.name, v.value, v.inline))
    end
    
    -- Envio do log
    local webhookURL = Webhooks[logInfo.webhook] or Webhooks["default"]
    PerformHttpRequest(webhookURL, function() end, "POST", json.encode({
        username = Config.nomeLog .. " | " .. logInfo.webhook,
        avatar_url = Config.avatarLog,
        embeds = {
            {
                author = {
                    name = "Log " .. logInfo.webhook,
                    icon_url = Config.defaultThumbnail,
                    url = Config.discordURL
                },
                color = logInfo.color or 16711680,
                footer = {
                    text = "Registro de logs ・ " .. os.date("%d/%m/%Y %H:%M"),
                    icon_url = Config.defaultFooterIcon
                },
                thumbnail = {url = logInfo.thumb or Config.defaultThumbnail},
                fields = fields
            }
        }
    }), {["Content-Type"] = "application/json"})
    
    -- Captura de tela, se necessário
    if logInfo.print and getSource(tonumber(logInfo.print)) and GetResourceState("discord-screenshot") == "started" then
        exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
            getSource(tonumber(logInfo.print) or tonumber(user_id)),
            webhookURL, {encoding = "jpg", quality = 0.7}, {
                username = Config.nomeLog .. " | " .. logInfo.webhook,
                avatar_url = Config.avatarLog
            }, 30000, function() end)
    end
end

-- Exporta a função
exports("sendLogs", sendLogs)
