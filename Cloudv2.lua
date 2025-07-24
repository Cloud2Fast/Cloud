-- CloudUI Trial v3: Try spawn/duplicate remotes
local plr = game.Players.LocalPlayer
local pg = plr:WaitForChild("PlayerGui")
pg:FindFirstChild("CloudUI")?.Destroy()

local gui = Instance.new("ScreenGui", pg)
gui.Name = "CloudUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 300)
frame.Position = UDim2.new(0.5, -160, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.Active = true
frame.Draggable = true

-- Title bar
local bar = Instance.new("Frame", frame)
bar.Size = UDim2.new(1,0,0,30)
bar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", bar)
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.Text = "CloudUI Trial v3"

local close = Instance.new("TextButton", bar)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,0)
close.Text = "X"
close.Font = Enum.Font.SourceSansBold
close.TextSize = 18
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(180,0,0)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Helper for trial
local trialRemotes = {
    "SpawnPet", "PlacePet", "GivePet", "PetService.Spawn",
    "DuplicatePet", "RespawnPet", "UsePet", "PetRemote"
}

local function tryRemote(name, ...)
    local rs = game:GetService("ReplicatedStorage")
    local rem = rs:FindFirstChild(name) or rs:WaitForChild(name, 2) rescue nil
    if rem and (rem:IsA("RemoteEvent") or rem:IsA("RemoteFunction")) then
        print("[CloudUI] • Calling remote:", name, ...)
        if rem:IsA("RemoteEvent") then
            rem:FireServer(...)
        else
            rem:InvokeServer(...)
        end
    else
        print("[CloudUI] ✘ No remote found:", name)
    end
end

-- Buttons
local function button(text, y, cb)
    local b=Instance.new("TextButton", frame)
    b.Size=UDim2.new(0,280,0,40)
    b.Position=UDim2.new(0,20,0,y)
    b.BackgroundColor3=Color3.fromRGB(60,60,60)
    b.Font=Enum.Font.SourceSans
    b.TextSize=16
    b.TextColor3=Color3.new(1,1,1)
    b.Text=text
    b.MouseButton1Click:Connect(cb)
end

-- Duplicate Pet button: tries remotes with no args
button("Duplicate Pet (trial)", 50, function()
    for _,nm in ipairs(trialRemotes) do
        tryRemote(nm)
    end
end)

-- Spawn Pet: input basics then try calling
button("Spawn Pet (trial)", 110, function()
    local typename = "Dragon"  -- change to one of your valid names
    local age = 10
    local weight = 5
    for _,nm in ipairs(trialRemotes) do
        tryRemote(nm, typename, age, weight)
    end
end)

-- Duplicate Fruit: same trial
button("Duplicate Fruit (trial)", 170, function()
    for _,nm in ipairs({"SpawnFruit","DuplicateFruit","FruitRemote","PlaceFruit"}) do
        tryRemote(nm)
    end
end)

-- Spawn Seed: trial
button("Spawn Seed (trial)", 230, function()
    for _,nm in ipairs({"SpawnSeed","PlaceSeed","SeedRemote","GiveSeed"}) do
        tryRemote(nm, "AppleSeed")
    end
end)
