-- CloudUI with drag, minimize, close, and 4 buttons
local plr = game.Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")
playerGui:FindFirstChild("CloudUI")?.Destroy()

local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "CloudUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.5, -150, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.Active = true
frame.Draggable = true

local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1,0,0,30)
titleBar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1,0,1,0)
title.Text = "Grow A Garden Helper"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(180,0,0)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-70,0,0)
minBtn.Text = "_"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 18
minBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    if minimized then
        frame.Size = UDim2.new(0,300,0,260)
        for i, v in ipairs(frame:GetChildren()) do
            if v ~= titleBar then v.Visible = true end
        end
        minimized = false
    else
        frame.Size = UDim2.new(0,300,0,30)
        for i, v in ipairs(frame:GetChildren()) do
            if v ~= titleBar then v.Visible = false end
        end
        minimized = true
    end
end)

local function createButton(text, y, cb)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0, 260, 0, 40)
    b.Position = UDim2.new(0, 20, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(60,60,60)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.SourceSans
    b.TextSize = 16
    b.MouseButton1Click:Connect(cb)
end

-- Debug button actions
createButton("Duplicate Pet", 50, function() print("Duplicate Pet clicked") end)
createButton("Duplicate Fruit", 100, function() print("Duplicate Fruit clicked") end)
createButton("Spawn Pet", 150, function() print("Spawn Pet clicked") end)
createButton("Spawn Seed", 200, function() print("Spawn Seed clicked") end)
