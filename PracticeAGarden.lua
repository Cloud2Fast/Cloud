local autoFarm = true
local autoSell = true

spawn(function()
    while autoFarm do
        local plots = workspace:FindFirstChild("Plots")
        if plots then
            for _, plot in pairs(plots:GetChildren()) do
                local soil = plot:FindFirstChild("Soil")
                if soil and soil:FindFirstChild("ClickDetector") then
                    fireclickdetector(soil.ClickDetector)
                end
            end
        end
        wait(2)
    end
end)

spawn(function()
    while autoSell do
        local sellPart = workspace:FindFirstChild("Merchant") or workspace:FindFirstChild("SellZone")
        if sellPart and sellPart:FindFirstChild("ClickDetector") then
            fireclickdetector(sellPart.ClickDetector)
        end
        wait(5)
    end
end)
