-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
SERVER = IsDuplicityVersion()
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODULE
-----------------------------------------------------------------------------------------------------------------------------------------
local modules = {}
function module(Resource, patchs)
    if not patchs then
        patchs = Resource
        Resource = "vrp"
    end

    local key = Resource .. patchs
    local checkModule = modules[key]
    if checkModule then
        return checkModule
    else
        local code = LoadResourceFile(Resource, patchs .. ".lua")
        if code then
            local floats = load(code, Resource .. "/" .. patchs .. ".lua")
            if floats then
                local resAccept, resUlts = xpcall(floats, debug.traceback)
                if resAccept then
                    modules[key] = resUlts
                    return resUlts
                end
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function async(func)
    if func then
        Citizen.CreateThreadNow(func)
    else
        return
            setmetatable({wait = wait, p = promise.new()}, {__call = areturn})
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARSEINT
-----------------------------------------------------------------------------------------------------------------------------------------
function parseInt(Value, Force)
    local Number = tonumber(Value) or 0

    if Force and Number <= 0 then Number = 1 end

    if Number and Number > 0 then Number = math.floor(Number) end

    return Number
end