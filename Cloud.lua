-- GardenUI v2 — Dropdown-equipped pet spawner
local Players = game:GetService("Players")
local RepStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Placeholder remote events
local dupPetRemote = RepStorage:FindFirstChild("DuplicatePet")
local dupFruitRemote = RepStorage:FindFirstChild("DuplicateFruit")
local spawnPetRemote = RepStorage:FindFirstChild("SpawnPet")
local spawnSeedRemote = RepStorage:FindFirstChild("SpawnSeed")

-- Full list of pet names
local PetList = {
  "Kitsune","Raccoon Dragonfly","Disco Bee","T-Rex","Capybara","Triceratops","Mole",
  "Queen Bee","Scarlet Macaw","Night Owl","Red Fox","Iguanodon","Fennec Fox","Owl",
  "Blood Kiwi","Orange Tabby","Spotted Deer","Rabbit","Bunny","Dog","Golden Lab","Cow",
  "Silver Monkey","Sea Otter","Polar Bear","Turtle","Panda","Blood Hedgehog","Frog",
  "Moon Cat","Firefly","Petal Bee","Tarantula Hawk","Moth","Ostrich","Peacock","Meerkat",
  "Sand Snake","Bald Eagle","Raptor","Stegosaurus","Pterodactyl","Parasaurolophus",
  "Iguanodon","Pachycephalosaurus","Tanuki","Tanchozuru","Red Fox","Dragonfly","Disco Bee",
  "Queen Bee","Kitsune"
}

-- Create GUI
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
playerGui:FindFirstChild("GardenHUD")?.Destroy()
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "GardenHUD"
screenGui.ResetOnSpawn = false

-- Main frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0,280,0,220)
frame.Position = UDim2.new(0,20,0,100)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Active = true
frame.Draggable = true

local Title = Instance.new("TextLabel", frame)
Title.Size = UDim2.new(1,0,0,30)
Title.BackgroundColor3 = Color3.fromRGB(25,25,25)
Title.Text = "Garden UI v2"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local function createButton(text, yPos, cb)
  local b = Instance.new("TextButton", frame)
  b.Size = UDim2.new(0,260,0,30)
  b.Position = UDim2.new(0,10,0,yPos)
  b.BackgroundColor3 = Color3.fromRGB(75,75,75)
  b.Text = text
  b.TextColor3 = Color3.fromRGB(240,240,240)
  b.Font = Enum.Font.SourceSans
  b.TextSize = 16
  b.MouseButton1Click:Connect(cb)
  return b
end

local spawnWindow

-- Spawn window generator
local function showSpawnWindow(kind)
  spawnWindow?.Destroy()
  spawnWindow = Instance.new("Frame", screenGui)
  spawnWindow.Size = UDim2.new(0,320,0,260)
  spawnWindow.Position = UDim2.new(0,350,0,100)
  spawnWindow.BackgroundColor3 = Color3.fromRGB(40,40,40)
  spawnWindow.Active = true
  spawnWindow.Draggable = true

  local title = Instance.new("TextLabel", spawnWindow)
  title.Size = UDim2.new(1,0,0,30)
  title.BackgroundColor3 = Color3.fromRGB(30,30,30)
  title.Text = (kind == "Pet" and "Spawn Pet" or "Spawn Seed")
  title.TextColor3 = Color3.new(1,1,1)
  title.Font = Enum.Font.SourceSansBold
  title.TextSize = 18
  
  local closeBtn = Instance.new("TextButton", spawnWindow)
  closeBtn.Size = UDim2.new(0,30,0,30)
  closeBtn.Position = UDim2.new(1,-35,0,0)
  closeBtn.Text = "X"
  closeBtn.TextColor3 = Color3.new(1,1,1)
  closeBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
  closeBtn.Font = Enum.Font.SourceSansBold
  closeBtn.TextSize = 18
  closeBtn.MouseButton1Click:Connect(function()
    spawnWindow:Destroy(); spawnWindow=nil
  end)

  local minimizeBtn = Instance.new("TextButton", spawnWindow)
  minimizeBtn.Size = UDim2.new(0,30,0,30)
  minimizeBtn.Position = UDim2.new(1,-70,0,0)
  minimizeBtn.Text = "_"
  minimizeBtn.TextColor3 = Color3.new(1,1,1)
  minimizeBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
  minimizeBtn.Font = Enum.Font.SourceSansBold
  minimizeBtn.TextSize = 18
  minimizeBtn.MouseButton1Click:Connect(function()
    if spawnWindow.Size.Y.Offset>30 then
      spawnWindow.Size=UDim2.new(spawnWindow.Size.X.Scale,spawnWindow.Size.X.Offset,0,30)
    else
      spawnWindow.Size=UDim2.new(spawnWindow.Size.X.Scale,spawnWindow.Size.X.Offset,0,260)
    end
  end)

  if kind == "Pet" then
    -- Dropdown label and box
    local dropdownLabel = Instance.new("TextLabel", spawnWindow)
    dropdownLabel.Position = UDim2.new(0,10,0,50)
    dropdownLabel.Size = UDim2.new(0, 100,0,25)
    dropdownLabel.Text = "Select Pet:"
    dropdownLabel.TextColor3 = Color3.new(1,1,1)
    dropdownLabel.BackgroundTransparency = 1

    local dropdown = Instance.new("TextBox", spawnWindow)
    dropdown.Position = UDim2.new(0,120,0,50)
    dropdown.Size = UDim2.new(0,180,0,25)
    dropdown.PlaceholderText = "Type or select pet"
    dropdown.TextColor3 = Color3.new(1,1,1)
    dropdown.BackgroundColor3 = Color3.fromRGB(55,55,55)

    -- Age
    local ageBox = Instance.new("TextBox", spawnWindow)
    ageBox.Position = UDim2.new(0,10,0,90)
    ageBox.Size = UDim2.new(0,140,0,25)
    ageBox.PlaceholderText = "Age (1‑100)"
    ageBox.TextColor3 = Color3.new(1,1,1)
    ageBox.BackgroundColor3 = Color3.fromRGB(55,55,55)

    -- Weight
    local weightBox = Instance.new("TextBox", spawnWindow)
    weightBox.Position = UDim2.new(0,160,0,90)
    weightBox.Size = UDim2.new(0,140,0,25)
    weightBox.PlaceholderText = "Weight (1‑20)"
    weightBox.TextColor3 = Color3.new(1,1,1)
    weightBox.BackgroundColor3 = Color3.fromRGB(55,55,55)

    -- Spawn button
    local submit = Instance.new("TextButton", spawnWindow)
    submit.Size = UDim2.new(0,280,0,30)
    submit.Position = UDim2.new(0,10,0,140)
    submit.Text = "Spawn Pet"
    submit.TextColor3 = Color3.new(1,1,1)
    submit.Font = Enum.Font.SourceSansBold
    submit.TextSize = 17
    submit.BackgroundColor3 = Color3.fromRGB(0,170,0)

    submit.MouseButton1Click:Connect(function()
      local petName = dropdown.Text
      local age = tonumber(ageBox.Text)
      local weight = tonumber(weightBox.Text)
      print("[GardenUI] spawn pet",petName,age,weight)
      if spawnPetRemote then
        spawnPetRemote:FireServer(petName, age or 1, weight or 1)
      else
        warn("SpawnPet remote not found!")
      end
      spawnWindow:Destroy()
      spawnWindow=nil
    end)
  elseif kind=="Seed" then
    -- Seed input
    local seedBox = Instance.new("TextBox", spawnWindow)
    seedBox.Position = UDim2.new(0,10,0,60)
    seedBox.Size = UDim2.new(0,300,0,25)
    seedBox.PlaceholderText = "Seed Name"
    seedBox.TextColor3 = Color3.new(1,1,1)
    seedBox.BackgroundColor3 = Color3.fromRGB(55,55,55)

    local submit = Instance.new("TextButton", spawnWindow)
    submit.Size = UDim2.new(0,300,0,30)
    submit.Position = UDim2.new(0,10,0,110)
    submit.Text = "Spawn Seed"
    submit.TextColor3 = Color3.new(1,1,1)
    submit.Font = Enum.Font.SourceSansBold
    submit.TextSize = 17
    submit.BackgroundColor3 = Color3.fromRGB(0,170,0)

    submit.MouseButton1Click:Connect(function()
      local seedName = seedBox.Text
      print("[GardenUI] spawn seed",seedName)
      if spawnSeedRemote then
        spawnSeedRemote:FireServer(seedName)
      else
        warn("SpawnSeed remote not found!")
      end
      spawnWindow:Destroy()
      spawnWindow=nil
    end)
  end
end

-- Button bindings
createButton("Duplicate Pet", 40, function()
  print("[GardenUI] Duplicate Pet clicked")
  if dupPetRemote then dupPetRemote:FireServer() else warn("dupPetRemote missing") end
end)

createButton("Duplicate Fruit", 90, function()
  print("[GardenUI] Duplicate Fruit clicked")
  if dupFruitRemote then dupFruitRemote:FireServer() else warn("dupFruitRemote missing") end
end)

createButton("Spawn Pet", 140, function() showSpawnWindow("Pet") end)
createButton("Spawn Seed", 180, function() showSpawnWindow("Seed") end)

print("[GardenUI] Loaded v2")
