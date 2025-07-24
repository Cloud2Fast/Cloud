-- Basic UI with 4 buttons and Close
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "CloudUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.5, -150, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local buttons = {"Duplicate Pet", "Duplicate Fruit", "Spawn Pet", "Spawn Seed"}

for i, name in pairs(buttons) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0, 260, 0, 40)
    btn.Position = UDim2.new(0, 20, 0, 10 + (i - 1) * 50)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.MouseButton1Click:Connect(function()
        print(name .. " button clicked.")
        -- Placeholder: Add real functionality here
    end)
end

-- Close button
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.TextColor3 = Color3.new(1, 0, 0)
close.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
