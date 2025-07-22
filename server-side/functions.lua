Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

function query(query, params) return vRP.Query(query, params) end

function getSource(user_id) return vRP.Source(user_id) end

function getIdentity(id) return vRP.Identity(id) end

function getName(user_id)
    return getIdentity(user_id) and getIdentity(user_id).Name .. " " ..getIdentity(user_id).Lastname or nil
end

function getAccount(Passport)
    local Accounts = query("accounts/Account", {
        License = getIdentity(id) and getLicense(id) or nil
    }) or {}
    if Accounts[1] then
        return {
            Discord = Accounts[1].Discord or "N/A",
            ID = Accounts[1].Passport or "N/A",
            License = Accounts[1].License or "N/A"
        }
    end
    return {
        Discord = "N/A",
        ID = "N/A",
        License = "N/A"
    }
end
