local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local oldKick
oldKick = hookfunction(LocalPlayer.Kick, function(self, ...)
    print("Kick attempt blocked!")
    return nil
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" then
        print("Namecall kick attempt blocked!")
        return wait(9e9)
    end
    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

local function blockTeleports()
    if game:GetService("TeleportService") then
        for _, func in pairs(getgc()) do
            if type(func) == "function" and getfenv(func).script and getfenv(func).script == game:GetService("TeleportService") then
                hookfunction(func, function() 
                    return wait(9e9)
                end)
            end
        end
    end
end

blockTeleports()
