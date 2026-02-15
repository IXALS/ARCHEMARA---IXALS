--[[ 
    IXALS
    V13 Edition: Removed Hitbox, Added Full Bright (Universal)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==========================================
-- VARIABEL SISTEM
-- ==========================================
local uiKeybind = Enum.KeyCode.K
local isBinding = false

local infHpEnabled = false
local animTweakEnabled = false
local animMultiplier = 5
local infStaminaEnabled = false
local noclipEnabled = false
local flyEnabled = false
local flySpeedMultiplier = 2
local baseFlySpeed = 50
local noFallDamageEnabled = false
local fullBrightEnabled = false -- NEW VAR: Full Bright

local flyCtrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}
local bv, bg

-- ==========================================
-- PEMBUATAN UI (GLASSMORPHISM)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IXALS"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 580) -- Ukuran disesuaikan ulang
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -290)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.4
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 100) -- Warna Kuning Terang (Tema Full Bright)
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.BackgroundTransparency = 0.5
Header.BorderSizePixel = 0
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "IXALS V13"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- FUNGSI BUILDER UI
local function CreateButton(parent, text, posY, height)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, height or 40)
    Btn.Position = UDim2.new(0.05, 0, 0, posY)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Btn.BackgroundTransparency = 0.3
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.Parent = parent
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(100, 100, 100)
    Stroke.Transparency = 0.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = Btn
    return Btn
end

local function CreateInput(parent, text, posX, posY, sizeX)
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(sizeX, 0, 0, 30)
    Box.Position = UDim2.new(posX, 0, 0, posY)
    Box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Box.BackgroundTransparency = 0.4
    Box.Text = text
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 13
    Box.Parent = parent
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Box
    return Box
end

local function CreateLabel(parent, text, posX, posY, sizeX)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(sizeX, 0, 0, 15)
    Lbl.Position = UDim2.new(posX, 0, 0, posY)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = parent
    return Lbl
end

local function TweenClick(btn)
    local ts = TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.85, 0, 0, btn.Size.Y.Offset - 4)})
    ts:Play()
    ts.Completed:Wait()
    TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.9, 0, 0, btn.Size.Y.Offset + 4)}):Play()
end

local function ToggleVisual(btn, state, onText, offText, onColor)
    if state then
        btn.Text = onText
        btn.BackgroundColor3 = onColor or Color3.fromRGB(0, 200, 150)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.1
    else
        btn.Text = offText
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.BackgroundTransparency = 0.3
    end
end

-- ==========================================
-- KOMPONEN UI
-- ==========================================
local ToggleHpBtn = CreateButton(MainFrame, "Infinite HP (God Mode): OFF", 50)

-- NEW FULL BRIGHT BUTTON
local ToggleFullBrightBtn = CreateButton(MainFrame, "Full Bright (No Shadows): OFF", 100)

local ToggleAnimBtn = CreateButton(MainFrame, "Fast Attack Anim: OFF", 150)
CreateLabel(MainFrame, "Anim Speed (Mult):", 0.05, 195, 0.4)
local SpeedInput = CreateInput(MainFrame, "5", 0.5, 190, 0.45)

local ToggleStaminaBtn = CreateButton(MainFrame, "Infinite Stamina/Energy: OFF", 230)
local ToggleNoclipBtn = CreateButton(MainFrame, "Noclip (Walk Through Walls): OFF", 280)
local ToggleNoFallBtn = CreateButton(MainFrame, "Anti-Fall Damage: OFF", 330)
local ToggleFlyBtn = CreateButton(MainFrame, "Fly Mode: OFF", 380)

CreateLabel(MainFrame, "Fly Speed (0 - 5):", 0.05, 425, 0.4)
local FlySpeedInput = CreateInput(MainFrame, "2", 0.5, 420, 0.45)

local BindLabel = CreateLabel(MainFrame, "Hide UI Keybind:", 0.05, 465, 0.5)
local BindBtn = CreateButton(MainFrame, "K", 485, 35)

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0.9, 0, 0, 30)
InfoLabel.Position = UDim2.new(0.05, 0, 0, 535)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Full Bright removes dark fogs and shadows, giving you perfect vision in caves/night."
InfoLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 11
InfoLabel.TextWrapped = true
InfoLabel.Parent = MainFrame

-- ==========================================
-- LOGIKA SISTEM
-- ==========================================

BindBtn.MouseButton1Click:Connect(function()
    TweenClick(BindBtn)
    BindBtn.Text = "Press any key..."
    isBinding = true
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if isBinding and input.UserInputType == Enum.UserInputType.Keyboard then
        uiKeybind = input.KeyCode
        BindBtn.Text = input.KeyCode.Name
        isBinding = false
        return
    end
    if not gp and input.KeyCode == uiKeybind then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

ToggleHpBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleHpBtn)
    infHpEnabled = not infHpEnabled
    ToggleVisual(ToggleHpBtn, infHpEnabled, "Infinite HP: ON", "Infinite HP: OFF", Color3.fromRGB(255, 50, 50))
end)

-- FULL BRIGHT LOGIC
ToggleFullBrightBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleFullBrightBtn)
    fullBrightEnabled = not fullBrightEnabled
    ToggleVisual(ToggleFullBrightBtn, fullBrightEnabled, "Full Bright: ON", "Full Bright: OFF", Color3.fromRGB(255, 200, 50))
end)

ToggleAnimBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleAnimBtn)
    animTweakEnabled = not animTweakEnabled
    ToggleVisual(ToggleAnimBtn, animTweakEnabled, "Fast Attack Anim: ON", "Fast Attack Anim: OFF")
end)

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val then animMultiplier = val else SpeedInput.Text = tostring(animMultiplier) end
end)

ToggleStaminaBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleStaminaBtn)
    infStaminaEnabled = not infStaminaEnabled
    ToggleVisual(ToggleStaminaBtn, infStaminaEnabled, "Infinite Stamina: ON", "Infinite Stamina: OFF")
end)

ToggleNoclipBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleNoclipBtn)
    noclipEnabled = not noclipEnabled
    ToggleVisual(ToggleNoclipBtn, noclipEnabled, "Noclip: ON", "Noclip: OFF", Color3.fromRGB(150, 50, 255))
end)

ToggleNoFallBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleNoFallBtn)
    noFallDamageEnabled = not noFallDamageEnabled
    ToggleVisual(ToggleNoFallBtn, noFallDamageEnabled, "Anti-Fall Damage: ON", "Anti-Fall Damage: OFF", Color3.fromRGB(255, 150, 50))
    if not noFallDamageEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        end
    end
end)

ToggleFlyBtn.MouseButton1Click:Connect(function()
    TweenClick(ToggleFlyBtn)
    flyEnabled = not flyEnabled
    ToggleVisual(ToggleFlyBtn, flyEnabled, "Fly Mode: ON", "Fly Mode: OFF", Color3.fromRGB(50, 150, 255))
    if flyEnabled then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            bg = Instance.new("BodyGyro", hrp)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = hrp.CFrame
            bv = Instance.new("BodyVelocity", hrp)
            bv.velocity = Vector3.new(0,0,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        end
    else
        if bg then bg:Destroy() end
        if bv then bv:Destroy() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end)

FlySpeedInput.FocusLost:Connect(function()
    local val = tonumber(FlySpeedInput.Text)
    if val then flySpeedMultiplier = math.clamp(val, 0, 5) end
    FlySpeedInput.Text = tostring(flySpeedMultiplier)
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.W then flyCtrl.f = 1
    elseif input.KeyCode == Enum.KeyCode.S then flyCtrl.b = -1
    elseif input.KeyCode == Enum.KeyCode.A then flyCtrl.l = -1
    elseif input.KeyCode == Enum.KeyCode.D then flyCtrl.r = 1
    elseif input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Space then flyCtrl.u = 1
    elseif input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.LeftShift then flyCtrl.d = -1
    end
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.W then flyCtrl.f = 0
    elseif input.KeyCode == Enum.KeyCode.S then flyCtrl.b = 0
    elseif input.KeyCode == Enum.KeyCode.A then flyCtrl.l = 0
    elseif input.KeyCode == Enum.KeyCode.D then flyCtrl.r = 0
    elseif input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Space then flyCtrl.u = 0
    elseif input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.LeftShift then flyCtrl.d = 0
    end
end)


-- ==========================================
-- MAIN LOOPS
-- ==========================================
RunService.RenderStepped:Connect(function()
    -- Full Bright Execution (Di loop agar tidak tertimpa oleh script siang/malam dari game)
    if fullBrightEnabled then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9 -- Menghilangkan Kabut
        Lighting.Brightness = 2
        Lighting.ClockTime = 14 -- Memaksa waktu menjadi jam 2 siang
    end

    -- Anim Tweaker
    if animTweakEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChild("Animator")
            if animator then
                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                    if track.Priority == Enum.AnimationPriority.Action or track.Priority == Enum.AnimationPriority.Action2 or track.Priority == Enum.AnimationPriority.Action3 then
                        if track.Speed ~= animMultiplier then track:AdjustSpeed(animMultiplier) end
                    end
                end
            end
        end
    end
    
    -- Fly Physics
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and bv and bg then
        bg.cframe = Camera.CFrame
        local moveDir = Vector3.new(0,0,0)
        moveDir = moveDir + (Camera.CFrame.LookVector * (flyCtrl.f + flyCtrl.b))
        moveDir = moveDir + (Camera.CFrame.RightVector * (flyCtrl.r + flyCtrl.l))
        moveDir = moveDir + (Camera.CFrame.UpVector * (flyCtrl.u + flyCtrl.d))
        
        if moveDir.Magnitude > 0 then
            bv.velocity = moveDir.Unit * (baseFlySpeed * flySpeedMultiplier)
        else
            bv.velocity = Vector3.new(0,0,0)
        end
    end
end)

-- Loop Fisika (Stepped)
RunService.Stepped:Connect(function()
    if not LocalPlayer.Character then return end
    local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")

    if infHpEnabled and humanoid then
        if humanoid.Health < humanoid.MaxHealth and humanoid.Health > 0 then
            humanoid.Health = humanoid.MaxHealth
        end
    end
    
    if noclipEnabled then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
    
    if infStaminaEnabled then
        if humanoid and humanoid.WalkSpeed < 16 then humanoid.WalkSpeed = 16 end
        for _, val in pairs(LocalPlayer.Character:GetDescendants()) do
            if val:IsA("NumberValue") or val:IsA("IntValue") then
                local nama = string.lower(val.Name)
                if (nama:match("stamina") or nama:match("energy")) and val.Value < 100 then
                    val.Value = 100
                end
            end
        end
    end
    
    if noFallDamageEnabled and humanoid then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        for _, script in pairs(LocalPlayer.Character:GetDescendants()) do
            if script:IsA("LocalScript") and string.match(string.lower(script.Name), "fall") then
                script.Disabled = true
            end
        end
    end
end)
