-- Configurações do servidor
Config = {
    nomeLog = "RLS EG",
    avatarLog = "https://cdn.discordapp.com/attachments/1367636886264352789/1390269057651048530/-wAlbIUiQ7axJ2gLAOutsg.png?ex=6880b0f5&is=687f5f75&hm=0a4576ea0fc17e11e2b7298925b7ab1f0ca0bdd4281065bbfaf60cbb79d7835f&",
    defaultThumbnail = "https://cdn.discordapp.com/attachments/1367636886264352789/1393876125041692682/imagem_2025-07-13_054553056-removebg-preview.png?ex=6880a14d&is=687f4fcd&hm=bdd33e0888203699fd28400c19d56a61566726ba0d0e39802a584b039b1700c3&",
    defaultFooterIcon = "https://cdn.discordapp.com/emojis/1123001846374596649.webp?size=96",
    discordURL = 'https://discord.gg/HjC5ApcRAW',
    idBloqueado = {
        [1] = true
    }
}

-- Webhooks do Discord
Webhooks = {["default"] = "WEBHOOK_URL_PADRAO"}

-- EXEMPLO DE USO
-- exports["rls_log"]:sendLogs({
--     ["webhook"] = "NomeDoWebhook", -- Nome do webhook configurado no arquivo de configuração
--     ["thumb"] = "Link da Imagem", -- Link da imagem de thumbnail
--     ["Passport"] = ID, -- ID do player
--     ["steam"] = true, -- Se deseja enviar o Steam ID
--     ["discord"] = true, -- Se deseja enviar o Discord ID
--     ["fields"] = { -- Fields que aparecerão no log (pode adicionar mais fields)
--         {
--             name = "NOME",
--             value = "MENSAGEM"
--         },
--     }
-- })
