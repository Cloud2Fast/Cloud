-- GardenUI v1 for Grow A Garden v1572

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GardenUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0, 20, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.Text = "Grow A Garden Helper"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = mainFrame

-- Function to create buttons easily
local function createButton(text, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 260, 0, 35)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.Parent = mainFrame
    btn.AutoButtonColor = true
    return btn
end

-- Placeholder functions for the actions
local function duplicatePet()
    print("[GardenUI] Duplicate Pet pressed")
    -- TODO: Add your remote call here to duplicate pet you currently hold
    -- Example: call spawn pet remote with current pet data
end

local function duplicateFruit()
    print("[GardenUI] Duplicate Fruit pressed")
    -- TODO: Add your remote call here to duplicate fruit you currently hold
end

local function spawnPetUI()
    print("[GardenUI] Spawn Pet pressed")
    showSpawnWindow("Pet")
end

local function spawnSeedUI()
    print("[GardenUI] Spawn Seed pressed")
    showSpawnWindow("Seed")
end

-- Create the buttons
local btnDuplicatePet = createButton("Duplicate Pet", UDim2.new(0, 20, 0, 40))
local btnDuplicateFruit = createButton("Duplicate Fruit", UDim2.new(0, 20, 0, 80))
local btnSpawnPet = createButton("Spawn Pet", UDim2.new(0, 20, 0, 120))
local btnSpawnSeed = createButton("Spawn Seed", UDim2.new(0, 20, 0, 160))

btnDuplicatePet.MouseButton1Click:Connect(duplicatePet)
btnDuplicateFruit.MouseButton1Click:Connect(duplicateFruit)
btnSpawnPet.MouseButton1Click:Connect(spawnPetUI)
btnSpawnSeed.MouseButton1Click:Connect(spawnSeedUI)

-- UI popup for spawning pets/seeds with inputs and minimize/close buttons
local spawnWindow

function showSpawnWindow(kind)
    if spawnWindow then spawnWindow:Destroy() end
    
    spawnWindow = Instance.new("Frame")
    spawnWindow.Size = UDim2.new(0, 320, 0, 220)
    spawnWindow.Position = UDim2.new(0, 350, 0, 100)
    spawnWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    spawnWindow.BorderSizePixel = 0
    spawnWindow.Parent = screenGui
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.Text = "Spawn " .. kind
    titleLabel.Parent = spawnWindow
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 0)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 18
    closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Parent = spawnWindow
    closeBtn.MouseButton1Click:Connect(function()
        spawnWindow:Destroy()
        spawnWindow = nil
    end)
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -70, 0, 0)
    minimizeBtn.Text = "_"
    minimizeBtn.Font = Enum.Font.SourceSansBold
    minimizeBtn.TextSize = 18
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    minimizeBtn.TextColor3 = Color3.new(1,1,1)
    minimizeBtn.Parent = spawnWindow
    
    local inputs = {}
    
    if kind == "Pet" then
        inputs.Name = Instance.new("TextBox")
        inputs.Name.Size = UDim2.new(0, 280, 0, 25)
        inputs.Name.Position = UDim2.new(0, 20, 0, 50)
        inputs.Name.PlaceholderText = "Pet Name (e.g., Dragon)"
        inputs.Name.BackgroundColor3 = Color3.fromRGB(50,50,50)
        inputs.Name.TextColor3 = Color3.new(1,1,1)
        inputs.Name.Parent = spawnWindow
        
        inputs.Age = Instance.new("TextBox")
        inputs.Age.Size = UDim2.new(0, 280, 0, 25)
        inputs.Age.Position = UDim2.new(0, 20, 0, 85)
        inputs.Age.PlaceholderText = "Age (number)"
        inputs.Age.BackgroundColor3 = Color3.fromRGB(50,50,50)
        inputs.Age.TextColor3 = Color3.new(1,1,1)
        inputs.Age.Parent = spawnWindow
        
        inputs.Weight = Instance.new("TextBox")
        inputs.Weight.Size = UDim2.new(0, 280, 0, 25)
        inputs.Weight.Position = UDim2.new(0, 20, 0, 120)
        inputs.Weight.PlaceholderText = "Weight (number)"
        inputs.Weight.BackgroundColor3 = Color3.fromRGB(50,50,50)
        inputs.Weight.TextColor3 = Color3.new(1,1,1)
        inputs.Weight.Parent = spawnWindow
        
    elseif kind == "Seed" then
        inputs.Name = Instance.new("TextBox")
        inputs.Name.Size = UDim2.new(0, 280, 0, 25)
        inputs.Name.Position = UDim2.new(0, 20, 0, 50)
        inputs.Name.PlaceholderText = "Seed Name (e.g., AppleSeed)"
        inputs.Name.BackgroundColor3 = Color3.fromRGB(50,50,50)
        inputs.Name.TextColor3 = Color3.new(1,1,1)
        inputs.Name.Parent = spawnWindow
        
        inputs.Amount = Instance.new("TextBox")
        inputs.Amount.Size = UDim2.new(0, 280, 0, 25)
        inputs.Amount.Position = UDim2.new(0, 20, 0, 85)
        inputs.Amount.PlaceholderText = "Amount (number)"
        inputs.Amount.BackgroundColor3 = Color3.fromRGB(50,50,50)
        inputs.Amount.TextColor3 = Color3.new(1,1,1)
        inputs.Amount.Parent = spawnWindow
    end
    
    -- Spawn button
    local spawnBtn = Instance.new("TextButton")
    spawnBtn.Size = UDim2.new(0, 280, 0, 40)
    spawnBtn.Position = UDim2.new(0, 20, 0, kind == "Pet" and 160 or 130)
    spawnBtn.Text = "Spawn " .. kind
    spawnBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    spawnBtn.TextColor3 = Color3.new(1,1,1)
    spawnBtn.Font = Enum.Font.SourceSansBold
    spawnBtn.TextSize = 18
    spawnBtn.Parent = spawnWindow
    
    spawnBtn.MouseButton1Click:Connect(function()
        if kind == "Pet" then
            print("[GardenUI] Spawning Pet with:")
            print("Name:", inputs.Name.Text)
            print("Age:", inputs.Age.Text)
            print("Weight:", inputs.Weight.Text)
            -- TODO: Add remote call to spawn pet using inputs values
        elseif kind == "Seed" then
            print("[GardenUI] Spawning Seed with:")
            print("Name:", inputs.Name.Text)
            print("Amount:", inputs.Amount.Text)
            -- TODO: Add remote call to spawn seed using inputs values
        end
        spawnWindow:Destroy()
        spawnWindow = nil
    end)
    
    minimizeBtn.MouseButton1Click:Connect(function()
        if spawnWindow.Size.Y.Offset > 30 then
            spawnWindow.Size = UDim2.new(spawnWindow.Size.X.Scale, spawnWindow.Size.X.Offset, 0, 30)
        else
            spawnWindow.Size = UDim2.new(spawnWindow.Size.X.Scale, spawnWindow.Size.X.Offset, 0, 220)
        end
    end)
end

-- Hide GUI with Right Ctrl key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

print("[GardenUI] Loaded successfully.")
