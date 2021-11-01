--[[
CrewPackXP Aircraft File Flight Factor 767 / 757
]]

local cpxpData = {}

function cpxpData.cpxpAircraftDelay()
    if (XPLMFindDataRef("anim/17/button") == nil) then
        return false
    else
        return true
    end
end

return cpxpData
