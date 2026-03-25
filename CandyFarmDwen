local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- EKSTRE HAVALI GİRİŞ EKRANI (3 SANİYE)
local ScreenGui = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
TextLabel.Parent = ScreenGui
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.5, -200, 0.5, -50)
TextLabel.Size = UDim2.new(0, 400, 0, 100)
TextLabel.Font = Enum.Font.SpecialElite
TextLabel.Text = "DwenElChavo"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 80
TextLabel.TextStrokeTransparency = 0
TextLabel.TextTransparency = 1

task.spawn(function()
    for i = 1, 0, -0.05 do
        TextLabel.TextTransparency = i
        task.wait(0.05)
    end
    task.wait(2)
    for i = 0, 1, 0.05 do
        TextLabel.TextTransparency = i
        task.wait(0.05)
    end
    ScreenGui:Destroy()
end)

task.wait(3)

-- DEĞİŞKENLER
local running = false
local startPos = nil
local baslangicZamani = os.time()
local yukseklikAyari = 4 
local hizAyari = 0.6 

-- MENÜ KURULUMU
local Window = Rayfield:CreateWindow({
   Name = "DwenElChavo Auto Candy Farm",
   LoadingTitle = "DwenElChavo CandyFarm",
   LoadingSubtitle = "Discord: dwenns",
   ConfigurationSaving = {Enabled = false},
   Discord = {Enabled = false},
   KeySystem = false
})

-- Footer Silme
if game:GetService("CoreGui"):FindFirstChild("RayfieldGui") then
    local rayfieldGui = game:GetService("CoreGui").RayfieldGui
    if rayfieldGui:FindFirstChild("Main") and rayfieldGui.Main:FindFirstChild("Footer") then
        rayfieldGui.Main.Footer:Destroy()
    end
end

local MainTab = Window:CreateTab("Candy Farm", 4483362458)

-- OPTİMİZE EDİLMİŞ GHOST VE BULMA
local function ghostMode(state)
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if state then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false v.CanTouch = false end
        end
        local bp = char.HumanoidRootPart:FindFirstChild("DwenFloat") or Instance.new("BodyVelocity")
        bp.Name = "DwenFloat"
        bp.Parent = char.HumanoidRootPart
        bp.Velocity = Vector3.new(0, 0, 0)
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        local bg = char.HumanoidRootPart:FindFirstChild("DwenGyro") or Instance.new("BodyGyro")
        bg.Name = "DwenGyro"
        bg.Parent = char.HumanoidRootPart
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = startPos or char.HumanoidRootPart.CFrame
    else
        if not running then
            if char.HumanoidRootPart:FindFirstChild("DwenFloat") then char.HumanoidRootPart.DwenFloat:Destroy() end
            if char.HumanoidRootPart:FindFirstChild("DwenGyro") then char.HumanoidRootPart.DwenGyro:Destroy() end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = true v.CanTouch = true end
            end
        end
    end
end

-- EN ÖNEMLİ OPTİMİZASYON BURADA
local function enYakinYumurtayiBul()
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local enYakin = nil
    local enKisaMesafe = math.huge
    
    -- Workspace taramasını sadece belirli aralıklarla yapıyoruz
    local eggs = workspace:GetDescendants()
    for i = 1, #eggs do
        local v = eggs[i]
        if v.Name == "CandyEgg" and (v:IsA("BasePart") or v:IsA("Model")) then
            local pos = (v:IsA("Model") and v:GetModelCFrame().Position) or v.Position
            local mesafe = (char.HumanoidRootPart.Position - pos).Magnitude
            if mesafe < enKisaMesafe then
                enKisaMesafe = mesafe
                enYakin = v
            end
        end
    end
    return enYakin
end

--- ARAYÜZ ---
MainTab:CreateSection("Farm Kontrol")

MainTab:CreateToggle({
   Name = "Candy AutoFarm",
   CurrentValue = false,
   Flag = "FarmToggle",
   Callback = function(Value)
      running = Value
      local char = game.Players.LocalPlayer.Character
      if running then 
          baslangicZamani = os.time()
          if char and char:FindFirstChild("HumanoidRootPart") then
              startPos = char.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
          end
          Rayfield:Notify({Title = "Sistem", Content = "Optimize Edilmiş Farm Başlatıldı!", Duration = 3})
          
          task.spawn(function()
              while running do
                  local hedef = enYakinYumurtayiBul()
                  if hedef and char and char:FindFirstChild("HumanoidRootPart") then
                      ghostMode(true)
                      local hedefCFrame = (hedef:IsA("Model") and hedef:GetModelCFrame()) or hedef.CFrame
                      char.HumanoidRootPart.CFrame = CFrame.new(hedefCFrame.Position + Vector3.new(0, yukseklikAyari, 0)) * startPos.Rotation
                      task.wait(hizAyari) 
                  else
                      -- Yumurta yoksa taramayı yavaşlat (CPU dinlensin)
                      if startPos then
                          ghostMode(true)
                          char.HumanoidRootPart.CFrame = startPos
                      end
                      task.wait(1) -- Yumurta yoksa 1 saniye bekle sonra tekrar bak
                  end
                  task.wait(0.1) -- Genel döngü hızı (0.05'ten 0.1'e çıkarıldı, kasma yapmaz)
              end
              ghostMode(false)
          end)
      else
          ghostMode(false)
      end
   end,
})

MainTab:CreateSection("İnce Ayarlar")

MainTab:CreateSlider({
   Name = "Toplama Hızı",
   Range = {0.1, 2},
   Increment = 0.1,
   Suffix = " Saniye",
   CurrentValue = 0.6,
   Flag = "SpeedSlider",
   Callback = function(Value)
      hizAyari = Value
   end,
})

MainTab:CreateSlider({
   Name = "Yukseklik",
   Range = {0, 5},
   Increment = 0.5,
   Suffix = " Birim",
   CurrentValue = 4,
   Flag = "HeightSlider",
   Callback = function(Value)
      yukseklikAyari = Value
   end,
})

MainTab:CreateSection("Süre Takibi")
local SureLabel = MainTab:CreateLabel("Mesai Süresi: 00:00:00")

task.spawn(function()
    while true do
        if running then
            local s = os.time() - baslangicZamani
            SureLabel:Set(string.format("Mesai Süresi: %02d:%02d:%02d", math.floor(s/3600), math.floor(s/60)%60, s%60))
        end
        task.wait(1)
    end
end)

MainTab:CreateSection("Sosyal Medya")
MainTab:CreateButton({
   Name = "Discord Sunucumuza Katıl",
   Callback = function()
       pcall(function()
           local request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
           request({
               Url = "http://127.0.0.1:6463/rpc?v=1",
               Method = "POST",
               Headers = { ["Content-Type"] = "application/json", ["Origin"] = "https://discord.com" },
               Body = game:GetService("HttpService"):JSONEncode({
                   cmd = "INVITE_BROWSER",
                   args = { code = "EKNqUad32s" },
                   nonce = game:GetService("HttpService"):GenerateGUID(false)
               }),
           })
       end)
   end,
})
