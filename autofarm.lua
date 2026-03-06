repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local API = ReplicatedStorage:WaitForChild("API")
local PetNeed = API:WaitForChild("PetAPI/CompletePetNeed")

player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local needs = {"hungry","thirsty","sleepy","dirty","bored","sick","walk"}

while true do
    task.wait(0.5)
    for _,need in pairs(needs) do
        pcall(function()
            PetNeed:FireServer(need)
        end)
    end
end
