-- Laghu Hub GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local AutoFarmBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local HopBtn = Instance.new("TextButton")

-- ScreenGui setup
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- MainFrame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

-- UICorner
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title
Title.Parent = MainFrame
Title.Text = "Laghu Hub"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- AutoFarm Button
AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.Text = "⚔ Auto Farm"
AutoFarmBtn.Size = UDim2.new(1, -20, 0, 40)
AutoFarmBtn.Position = UDim2.new(0, 10, 0, 60)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ESP Button
ESPBtn.Parent = MainFrame
ESPBtn.Text = "🍇 Fruit ESP"
ESPBtn.Size = UDim2.new(1, -20, 0, 40)
ESPBtn.Position = UDim2.new(0, 10, 0, 110)
ESPBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Server Hop Button
HopBtn.Parent = MainFrame
HopBtn.Text = "🌐 Server Hop"
HopBtn.Size = UDim2.new(1, -20, 0, 40)
HopBtn.Position = UDim2.new(0, 10, 0, 160)
HopBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
HopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- AutoFarm Logic
AutoFarmBtn.MouseButton1Click:Connect(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    while task.wait(0.5) do
        vu:Button1Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end
end)

-- ESP Logic
ESPBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            local esp = Instance.new("BillboardGui", v)
            esp.Size = UDim2.new(0, 100, 0, 50)
            esp.AlwaysOnTop = true
            local label = Instance.new("TextLabel", esp)
            label.Size = UDim2.new(1,0,1,0)
            label.Text = v.Name
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.new(1,0,0)
            label.TextScaled = true
        end
    end
end)

-- Server Hop Logic
HopBtn.MouseButton1Click:Connect(function()
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local PlaceId = game.PlaceId
    local url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
    local servers = HttpService:JSONDecode(game:HttpGet(url)).data

    for _, server in ipairs(servers) do
        if server.playing < server.maxPlayers then
            TeleportService:TeleportToPlaceInstance(PlaceId, server.id, game.Players.LocalPlayer)
            break
        end
    end
end)
