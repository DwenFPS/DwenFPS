repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local API = ReplicatedStorage:WaitForChild("API")
local PetNeed = API:WaitForChild("PetAPI/CompletePetNeed")

-- Anti AFK
player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local farming = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AutoFarmMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,200,0,100)
frame.Position = UDim2.new(0.05,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1,0,1,0)
button.Text = "Auto Farm: OFF"
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(50,50,50)

button.MouseButton1Click:Connect(function()
    farming = not farming
    button.Text = farming and "Auto Farm: ON" or "Auto Farm: OFF"
end)

local needs = {"hungry","thirsty","sleepy","dirty","bored","sick","walk"}

task.spawn(function()
    while true do
        task.wait(0.5)
        if farming then
            for _,need in pairs(needs) do
                pcall(function()
                    PetNeed:FireServer(need)
                end)
            end
        end
    end
end)
