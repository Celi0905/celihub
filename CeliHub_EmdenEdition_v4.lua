-- ============================================================
-- CeliHub | Emden Edition v4
-- Made by Celi 💫
-- ============================================================

-- // Services
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local TeleportService  = game:GetService("TeleportService")

-- ============================================================
-- // KEY SYSTEM
-- ============================================================

local VALID_KEY   = "celi2026"
local KEY_WEBSITE = "key.celihub.site"

local function ShowKeyScreen()
    -- Altes Key GUI entfernen falls vorhanden
    local coreGui = game:GetService("CoreGui")
    local existing = coreGui:FindFirstChild("CeliHubKeyScreen")
    if existing then existing:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CeliHubKeyScreen"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    ScreenGui.Parent = coreGui

    -- Halbtransparenter Hintergrund (man sieht das Spiel)
    local BG = Instance.new("Frame", ScreenGui)
    BG.Size = UDim2.fromScale(1, 1)
    BG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BG.BackgroundTransparency = 0.45
    BG.BorderSizePixel = 0

    -- Karte zentriert
    local Card = Instance.new("Frame", BG)
    Card.Size = UDim2.fromOffset(440, 310)
    Card.Position = UDim2.fromScale(0.5, 0.5)
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.BackgroundColor3 = Color3.fromRGB(15, 15, 24)
    Card.BorderSizePixel = 0
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 16)

    -- Roter Akzentbalken oben
    local Accent = Instance.new("Frame", Card)
    Accent.Size = UDim2.new(1, 0, 0, 4)
    Accent.Position = UDim2.new(0, 0, 0, 0)
    Accent.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    Accent.BorderSizePixel = 0
    Instance.new("UICorner", Accent).CornerRadius = UDim.new(0, 16)

    -- Titel
    local Title = Instance.new("TextLabel", Card)
    Title.Size = UDim2.new(1, 0, 0, 42)
    Title.Position = UDim2.fromOffset(0, 14)
    Title.BackgroundTransparency = 1
    Title.Text = "🚨  CeliHub  |  Emden Edition"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    -- Website Hinweis
    local WebLabel = Instance.new("TextLabel", Card)
    WebLabel.Size = UDim2.new(1, -40, 0, 20)
    WebLabel.Position = UDim2.new(0, 20, 0, 60)
    WebLabel.BackgroundTransparency = 1
    WebLabel.Text = "🔑  Key holen auf:"
    WebLabel.TextColor3 = Color3.fromRGB(140, 140, 200)
    WebLabel.Font = Enum.Font.Gotham
    WebLabel.TextSize = 13
    WebLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Kopier-Button für Website
    local CopyBG = Instance.new("Frame", Card)
    CopyBG.Size = UDim2.new(1, -40, 0, 32)
    CopyBG.Position = UDim2.new(0, 20, 0, 82)
    CopyBG.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    CopyBG.BorderSizePixel = 0
    Instance.new("UICorner", CopyBG).CornerRadius = UDim.new(0, 8)

    local CopyBtn = Instance.new("TextButton", CopyBG)
    CopyBtn.Size = UDim2.fromScale(1, 1)
    CopyBtn.BackgroundTransparency = 1
    CopyBtn.Text = "📋  key.celihub.site  —  Klicken zum Kopieren"
    CopyBtn.TextColor3 = Color3.fromRGB(160, 160, 240)
    CopyBtn.Font = Enum.Font.Code
    CopyBtn.TextSize = 13

    CopyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(KEY_WEBSITE) end)
        CopyBtn.Text = "✅  Kopiert!"
        CopyBtn.TextColor3 = Color3.fromRGB(80, 220, 120)
        task.wait(1.5)
        CopyBtn.Text = "📋  key.celihub.site  —  Klicken zum Kopieren"
        CopyBtn.TextColor3 = Color3.fromRGB(160, 160, 240)
    end)

    -- Trennlinie
    local Divider = Instance.new("Frame", Card)
    Divider.Size = UDim2.new(1, -40, 0, 1)
    Divider.Position = UDim2.new(0, 20, 0, 126)
    Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    Divider.BorderSizePixel = 0

    -- Input Label
    local InputLabel = Instance.new("TextLabel", Card)
    InputLabel.Size = UDim2.new(1, -40, 0, 20)
    InputLabel.Position = UDim2.new(0, 20, 0, 136)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = "Key eingeben:"
    InputLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
    InputLabel.Font = Enum.Font.Gotham
    InputLabel.TextSize = 12
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Input Hintergrund
    local InputBG = Instance.new("Frame", Card)
    InputBG.Size = UDim2.new(1, -40, 0, 42)
    InputBG.Position = UDim2.new(0, 20, 0, 158)
    InputBG.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
    InputBG.BorderSizePixel = 0
    Instance.new("UICorner", InputBG).CornerRadius = UDim.new(0, 8)

    local InputBox = Instance.new("TextBox", InputBG)
    InputBox.Size = UDim2.new(1, -16, 1, 0)
    InputBox.Position = UDim2.fromOffset(8, 0)
    InputBox.BackgroundTransparency = 1
    InputBox.PlaceholderText = "Key hier eingeben..."
    InputBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 110)
    InputBox.Text = ""
    InputBox.TextColor3 = Color3.fromRGB(230, 230, 230)
    InputBox.Font = Enum.Font.Code
    InputBox.TextSize = 15
    InputBox.ClearTextOnFocus = false

    -- Status
    local Status = Instance.new("TextLabel", Card)
    Status.Size = UDim2.new(1, -40, 0, 20)
    Status.Position = UDim2.new(0, 20, 0, 206)
    Status.BackgroundTransparency = 1
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(220, 80, 80)
    Status.Font = Enum.Font.Gotham
    Status.TextSize = 13
    Status.TextXAlignment = Enum.TextXAlignment.Left

    -- Login Button
    local BtnBG = Instance.new("Frame", Card)
    BtnBG.Size = UDim2.new(1, -40, 0, 44)
    BtnBG.Position = UDim2.new(0, 20, 0, 250)
    BtnBG.BackgroundColor3 = Color3.fromRGB(200, 35, 35)
    BtnBG.BorderSizePixel = 0
    Instance.new("UICorner", BtnBG).CornerRadius = UDim.new(0, 10)

    local BtnLabel = Instance.new("TextButton", BtnBG)
    BtnLabel.Size = UDim2.fromScale(1, 1)
    BtnLabel.BackgroundTransparency = 1
    BtnLabel.Text = "🔓  Einloggen"
    BtnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    BtnLabel.Font = Enum.Font.GothamBold
    BtnLabel.TextSize = 16

    local done = Instance.new("BindableEvent")

    local function DoVerify()
        local key = InputBox.Text:lower():gsub("%s+", "")
        if key == "" then
            Status.TextColor3 = Color3.fromRGB(220, 80, 80)
            Status.Text = "❌ Bitte einen Key eingeben!"
            return
        end
        if key == VALID_KEY then
            Status.TextColor3 = Color3.fromRGB(60, 220, 100)
            Status.Text = "✅ Key gültig! Lade CeliHub..."
            BtnLabel.Text = "✅ Zugang gewährt!"
            BtnBG.BackgroundColor3 = Color3.fromRGB(30, 160, 80)
            task.wait(1.0)
            ScreenGui:Destroy()
            done:Fire()
        else
            Status.TextColor3 = Color3.fromRGB(220, 80, 80)
            Status.Text = "❌ Falscher Key! Hol ihn auf key.celihub.site"
            InputBox.Text = ""
            BtnBG.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
            task.wait(0.3)
            BtnBG.BackgroundColor3 = Color3.fromRGB(200, 35, 35)
        end
    end

    BtnLabel.MouseButton1Click:Connect(DoVerify)
    InputBox.FocusLost:Connect(function(enter) if enter then DoVerify() end end)

    done.Event:Wait()
    done:Destroy()
end

ShowKeyScreen()

-- ============================================================
-- // Rayfield laden (nach Key)
-- ============================================================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ============================================================
-- // Player References
-- ============================================================
local Player    = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid  = Character:WaitForChild("Humanoid")
local RootPart  = Character:WaitForChild("HumanoidRootPart")

Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid  = char:WaitForChild("Humanoid")
    RootPart  = char:WaitForChild("HumanoidRootPart")
end)

-- ============================================================
-- // VARS
-- ============================================================
local SpeedMultiplier   = 1
local FlyEnabled        = false
local NoclipEnabled     = false
local InfiniteJump      = false
local GodMode           = false
local VehicleFlyEnabled = false
local AimbotEnabled     = false
local AimbotTarget      = nil
local EMDEN_GROUP_ID    = 0

-- Keybinds als echte KeyCode-Werte gespeichert
local Keybinds = {
    Fly           = Enum.KeyCode.X,
    Noclip        = Enum.KeyCode.N,
    SavePos       = Enum.KeyCode.T,
    ReturnPos     = Enum.KeyCode.R,
    EmergencyStop = Enum.KeyCode.F5,
}

-- ============================================================
-- // UTILITY
-- ============================================================
local function Notify(title, text, dur)
    Rayfield:Notify({Title=title, Content=tostring(text), Duration=dur or 3})
end

-- ============================================================
-- // MOVEMENT
-- ============================================================
local function ApplySpeedHack()
    RunService.Heartbeat:Connect(function()
        if not Humanoid or not RootPart then return end
        if Humanoid.MoveDirection.Magnitude > 0 then
            local v = Humanoid.MoveDirection * (16 * SpeedMultiplier)
            RootPart.Velocity = Vector3.new(v.X, RootPart.Velocity.Y, v.Z)
        end
    end)
end

local function SetupInfiniteJump()
    UserInputService.JumpRequest:Connect(function()
        if InfiniteJump and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local FlyBodyVelocity = nil
local function ToggleFly()
    FlyEnabled = not FlyEnabled
    if FlyEnabled then
        Notify("✈️ Fly", "Aktiviert! WASD + Space/Shift", 3)
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.zero
        bv.Parent = RootPart
        FlyBodyVelocity = bv
        RunService.Heartbeat:Connect(function()
            if not FlyEnabled or not FlyBodyVelocity or not FlyBodyVelocity.Parent then return end
            local dir = Vector3.zero
            local cam = Workspace.CurrentCamera
            if UserInputService:IsKeyDown(Enum.KeyCode.W)          then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S)          then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A)          then dir -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D)          then dir += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space)      then dir += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)  then dir -= Vector3.yAxis end
            FlyBodyVelocity.Velocity = dir.Magnitude > 0 and dir.Unit * 60 or Vector3.zero
        end)
    else
        FlyEnabled = false
        if FlyBodyVelocity and FlyBodyVelocity.Parent then
            FlyBodyVelocity:Destroy()
        end
        FlyBodyVelocity = nil
        Notify("✈️ Fly", "Deaktiviert.", 2)
    end
end

local function ToggleNoclip()
    NoclipEnabled = not NoclipEnabled
    Notify("👻 NoClip", NoclipEnabled and "Aktiviert!" or "Deaktiviert.", 2)
    if NoclipEnabled then
        RunService.Stepped:Connect(function()
            if not NoclipEnabled or not Character then return end
            for _, p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end)
    else
        if Character then
            for _, p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end
end

local function ToggleGodMode()
    GodMode = not GodMode
    if GodMode then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health    = math.huge
        Notify("🛡️ God Mode", "Aktiviert!", 3)
    else
        Humanoid.MaxHealth = 100
        Humanoid.Health    = 100
        Notify("🛡️ God Mode", "Deaktiviert.", 2)
    end
end

local function ToggleRainbow()
    _G.CeliRainbow = not _G.CeliRainbow
    Notify("🌈 Rainbow", _G.CeliRainbow and "On" or "Off", 2)
    if _G.CeliRainbow then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0),
                Color3.fromRGB(255,255,0), Color3.fromRGB(0,255,0),
                Color3.fromRGB(0,0,255), Color3.fromRGB(75,0,130),
                Color3.fromRGB(148,0,211)
            }
            local i = 1
            while _G.CeliRainbow do
                if Character then
                    for _, p in pairs(Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.Color = colors[i] end
                    end
                end
                i = (i % #colors) + 1
                task.wait(0.3)
            end
        end)
    end
end

local function ToggleESP()
    _G.CeliESP = not _G.CeliESP
    Notify("👁️ ESP", _G.CeliESP and "Aktiviert!" or "Deaktiviert.", 2)
    if _G.CeliESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                local h = Instance.new("Highlight")
                h.FillColor    = Color3.fromRGB(0, 255, 0)
                h.OutlineColor = Color3.fromRGB(255, 255, 255)
                h.Parent       = plr.Character
            end
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _, o in pairs(plr.Character:GetChildren()) do
                    if o:IsA("Highlight") then o:Destroy() end
                end
            end
        end
    end
end

local function ToggleNameTags()
    _G.CeliNameTags = not _G.CeliNameTags
    Notify("🏷️ NameTags", _G.CeliNameTags and "Aktiviert!" or "Deaktiviert.", 2)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            if _G.CeliNameTags then
                if plr.Character:FindFirstChild("CeliTag") then continue end
                local gui    = Instance.new("BillboardGui", plr.Character)
                gui.Name        = "CeliTag"
                gui.Adornee     = plr.Character:FindFirstChild("Head")
                gui.Size        = UDim2.new(0,200,0,50)
                gui.AlwaysOnTop = true
                local lbl = Instance.new("TextLabel", gui)
                lbl.BackgroundTransparency = 1
                lbl.Size       = UDim2.new(1,0,1,0)
                lbl.Text       = plr.Name
                lbl.TextColor3 = Color3.new(1,1,1)
                lbl.TextStrokeTransparency = 0
                lbl.Font       = Enum.Font.GothamBold
                lbl.TextSize   = 16
            else
                local t = plr.Character:FindFirstChild("CeliTag")
                if t then t:Destroy() end
            end
        end
    end
end

-- ============================================================
-- // AIMBOT
-- ============================================================
local function GetNearestPlayer()
    local cam       = Workspace.CurrentCamera
    local nearest   = nil
    local minDist   = math.huge
    local center    = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = cam:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearest = plr
                    end
                end
            end
        end
    end
    return nearest
end

local AimbotConnection = nil
local function ToggleAimbot()
    AimbotEnabled = not AimbotEnabled
    Notify("🎯 Aimbot", AimbotEnabled and "Aktiviert! (Nächster Spieler)" or "Deaktiviert.", 3)

    if AimbotConnection then
        AimbotConnection:Disconnect()
        AimbotConnection = nil
    end

    if AimbotEnabled then
        AimbotConnection = RunService.RenderStepped:Connect(function()
            if not AimbotEnabled then return end
            local target = GetNearestPlayer()
            if target and target.Character then
                local head = target.Character:FindFirstChild("Head")
                if head then
                    local cam = Workspace.CurrentCamera
                    cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
                end
            end
        end)
    end
end

local SilentAimEnabled = false
-- Silent Aim: Schuss geht zum nächsten Spieler ohne Kamera zu drehen
local function ToggleSilentAim()
    SilentAimEnabled = not SilentAimEnabled
    Notify("🔇 Silent Aim", SilentAimEnabled and "Aktiviert!" or "Deaktiviert.", 3)
end

-- ============================================================
-- // TELEPORT
-- ============================================================
local TeleportLocations = {
    ["🚔 Polizei"]     = CFrame.new(0, 5, 0),
    ["🏥 Krankenhaus"] = CFrame.new(100, 5, 50),
    ["🚒 Feuerwehr"]   = CFrame.new(-150, 5, 80),
    ["✈️ Flughafen"]   = CFrame.new(300, 5, -200),
    ["🚢 Hafen"]       = CFrame.new(-300, 5, 200),
    ["🏦 Bank"]        = CFrame.new(50, 5, 150),
    ["⛽ Tankstelle"]  = CFrame.new(-100, 5, -100),
    ["🏠 Spawn"]       = CFrame.new(0, 5, 0),
}

local function TeleportTo(name)
    local cf = TeleportLocations[name]
    if cf and RootPart then
        RootPart.CFrame = cf
        Notify("📍 Teleport", "➡️ " .. name, 2)
    end
end

local function TeleportToPlayer(playerName)
    local t = Players:FindFirstChild(playerName)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
        RootPart.CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(3, 0, 0)
        Notify("📍 Teleport", "➡️ Zu " .. playerName, 2)
    else
        Notify("📍 Teleport", "❌ Spieler nicht gefunden!", 3)
    end
end

local function SavePosition()
    if RootPart then
        _G.CeliSavedPos = RootPart.CFrame
        Notify("📍 Position", "Gespeichert!", 2)
    end
end

local function ReturnToPosition()
    if _G.CeliSavedPos and RootPart then
        RootPart.CFrame = _G.CeliSavedPos
        Notify("📍 Position", "Zurückgekehrt!", 2)
    else
        Notify("📍 Position", "❌ Keine Position gespeichert!", 3)
    end
end

-- ============================================================
-- // FAHRZEUG SYSTEM (komplett überarbeitet)
-- ============================================================

-- Alle Fahrzeuge auf der Map finden
local function FindAllVehicles()
    local vehicles = {}
    local seen = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if (obj:IsA("VehicleSeat") or obj:IsA("Seat")) then
            local model = obj:FindFirstAncestorOfClass("Model")
            if model and not seen[model] then
                seen[model] = true
                table.insert(vehicles, {
                    seat  = obj,
                    model = model,
                    name  = model.Name,
                    pos   = obj.Position
                })
            end
        end
    end
    return vehicles
end

-- Nächstes Fahrzeug finden und reinsetzen
local function FindAndSitInNearestVehicle()
    Notify("🚗 Fahrzeug", "🔍 Suche nächstes Fahrzeug...", 2)
    task.wait(0.3)
    local vehicles = FindAllVehicles()
    if #vehicles == 0 then
        Notify("🚗 Fahrzeug", "❌ Keine Fahrzeuge auf dem Server!", 3)
        return
    end
    local closest, minDist = nil, math.huge
    for _, v in ipairs(vehicles) do
        local d = (RootPart.Position - v.pos).Magnitude
        if d < minDist then minDist = d; closest = v end
    end
    if closest then
        RootPart.CFrame = closest.seat.CFrame + Vector3.new(0, 3, 0)
        task.wait(0.35)
        closest.seat:Sit(Humanoid)
        Notify("🚗 Eingesessen", closest.name .. "\n(" .. math.floor(minDist) .. " Studs entfernt)", 4)
    end
end

-- Fahrzeug GUI (alle Fahrzeuge auswählen + TP/Einsetzen)
local VehicleGuiOpen = false
local function OpenVehicleSelector()
    if VehicleGuiOpen then return end
    local vehicles = FindAllVehicles()
    if #vehicles == 0 then
        Notify("🚗 Fahrzeuge", "❌ Keine Fahrzeuge gefunden!", 3)
        return
    end

    VehicleGuiOpen = true
    local coreGui = game:GetService("CoreGui")

    local SGui = Instance.new("ScreenGui")
    SGui.Name = "CeliVehicleSelector"
    SGui.ResetOnSpawn = false
    SGui.DisplayOrder = 100
    SGui.Parent = coreGui

    -- Hintergrund (halbtransparent)
    local Overlay = Instance.new("Frame", SGui)
    Overlay.Size = UDim2.fromScale(1, 1)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.BorderSizePixel = 0

    -- Fenster
    local Win = Instance.new("Frame", Overlay)
    Win.Size = UDim2.fromOffset(380, 420)
    Win.Position = UDim2.fromScale(0.5, 0.5)
    Win.AnchorPoint = Vector2.new(0.5, 0.5)
    Win.BackgroundColor3 = Color3.fromRGB(15, 15, 24)
    Win.BorderSizePixel = 0
    Instance.new("UICorner", Win).CornerRadius = UDim.new(0, 14)

    -- Titel
    local TBar = Instance.new("Frame", Win)
    TBar.Size = UDim2.new(1, 0, 0, 44)
    TBar.BackgroundColor3 = Color3.fromRGB(200, 35, 35)
    TBar.BorderSizePixel = 0
    Instance.new("UICorner", TBar).CornerRadius = UDim.new(0, 14)

    local TLabel = Instance.new("TextLabel", TBar)
    TLabel.Size = UDim2.new(1, -50, 1, 0)
    TLabel.Position = UDim2.fromOffset(14, 0)
    TLabel.BackgroundTransparency = 1
    TLabel.Text = "🚗  Fahrzeug auswählen  (" .. #vehicles .. " gefunden)"
    TLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TLabel.Font = Enum.Font.GothamBold
    TLabel.TextSize = 15
    TLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Schließen Button
    local CloseBtn = Instance.new("TextButton", TBar)
    CloseBtn.Size = UDim2.fromOffset(36, 36)
    CloseBtn.Position = UDim2.new(1, -40, 0, 4)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.BorderSizePixel = 0
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

    CloseBtn.MouseButton1Click:Connect(function()
        SGui:Destroy()
        VehicleGuiOpen = false
    end)

    -- Scroll Frame für Fahrzeuge
    local Scroll = Instance.new("ScrollingFrame", Win)
    Scroll.Size = UDim2.new(1, -16, 1, -54)
    Scroll.Position = UDim2.fromOffset(8, 50)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(200, 35, 35)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder

    local Padding = Instance.new("UIPadding", Scroll)
    Padding.PaddingTop = UDim.new(0, 4)
    Padding.PaddingLeft = UDim.new(0, 4)
    Padding.PaddingRight = UDim.new(0, 4)

    -- Sortiere nach Entfernung
    table.sort(vehicles, function(a, b)
        return (RootPart.Position - a.pos).Magnitude < (RootPart.Position - b.pos).Magnitude
    end)

    for idx, v in ipairs(vehicles) do
        local dist = math.floor((RootPart.Position - v.pos).Magnitude)
        local Row = Instance.new("Frame", Scroll)
        Row.Size = UDim2.new(1, 0, 0, 60)
        Row.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
        Row.BorderSizePixel = 0
        Row.LayoutOrder = idx
        Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 8)

        -- Name
        local NameLbl = Instance.new("TextLabel", Row)
        NameLbl.Size = UDim2.new(1, -140, 0, 26)
        NameLbl.Position = UDim2.fromOffset(10, 6)
        NameLbl.BackgroundTransparency = 1
        NameLbl.Text = "🚗  " .. v.name
        NameLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        NameLbl.Font = Enum.Font.GothamBold
        NameLbl.TextSize = 13
        NameLbl.TextXAlignment = Enum.TextXAlignment.Left
        NameLbl.TextTruncate = Enum.TextTruncate.AtEnd

        -- Entfernung
        local DistLbl = Instance.new("TextLabel", Row)
        DistLbl.Size = UDim2.new(1, -140, 0, 20)
        DistLbl.Position = UDim2.fromOffset(10, 32)
        DistLbl.BackgroundTransparency = 1
        DistLbl.Text = "📏 " .. dist .. " Studs entfernt"
        DistLbl.TextColor3 = Color3.fromRGB(130, 130, 160)
        DistLbl.Font = Enum.Font.Gotham
        DistLbl.TextSize = 11
        DistLbl.TextXAlignment = Enum.TextXAlignment.Left

        -- TP Button
        local TPBtn = Instance.new("TextButton", Row)
        TPBtn.Size = UDim2.fromOffset(60, 36)
        TPBtn.Position = UDim2.new(1, -132, 0, 12)
        TPBtn.BackgroundColor3 = Color3.fromRGB(35, 100, 200)
        TPBtn.Text = "📍 TP"
        TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TPBtn.Font = Enum.Font.GothamBold
        TPBtn.TextSize = 12
        TPBtn.BorderSizePixel = 0
        Instance.new("UICorner", TPBtn).CornerRadius = UDim.new(0, 7)

        local vRef = v
        TPBtn.MouseButton1Click:Connect(function()
            RootPart.CFrame = vRef.seat.CFrame + Vector3.new(0, 4, 0)
            Notify("📍 TP", "Zu " .. vRef.name, 2)
        end)

        -- Einsetzen Button
        local SitBtn = Instance.new("TextButton", Row)
        SitBtn.Size = UDim2.fromOffset(64, 36)
        SitBtn.Position = UDim2.new(1, -66, 0, 12)
        SitBtn.BackgroundColor3 = Color3.fromRGB(200, 35, 35)
        SitBtn.Text = "🚗 Rein"
        SitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SitBtn.Font = Enum.Font.GothamBold
        SitBtn.TextSize = 12
        SitBtn.BorderSizePixel = 0
        Instance.new("UICorner", SitBtn).CornerRadius = UDim.new(0, 7)

        SitBtn.MouseButton1Click:Connect(function()
            RootPart.CFrame = vRef.seat.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.3)
            vRef.seat:Sit(Humanoid)
            Notify("🚗 Eingesessen", vRef.name, 3)
            SGui:Destroy()
            VehicleGuiOpen = false
        end)
    end

    -- Canvas Größe anpassen
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 12)
    end)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #vehicles * 66 + 12)
end

-- Vehicle Fling (verbessert - findet Seat im aktuellen Fahrzeug)
local function VehicleFling()
    if not Character or not Humanoid then return end
    -- Prüfe ob Spieler in einem Fahrzeug sitzt
    local seatPart = Humanoid.SeatPart
    if seatPart then
        local model = seatPart:FindFirstAncestorOfClass("Model")
        if model then
            local primaryPart = model.PrimaryPart or seatPart
            primaryPart.Velocity = Vector3.new(0, 600, 0)
            Notify("💥 Fling", "Fahrzeug geflingt!", 3)
            return
        end
    end
    -- Fallback: Schaue nach VehicleSeat im Model
    local char = Player.Character
    if char then
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                -- Nichts
            end
        end
    end
    Notify("💥 Fling", "❌ Du sitzt in keinem Fahrzeug!", 3)
end

local function ToggleVehicleFly()
    VehicleFlyEnabled = not VehicleFlyEnabled
    Notify("✈️ Vehicle Fly", VehicleFlyEnabled and "Aktiviert" or "Deaktiviert", 2)
    if VehicleFlyEnabled then
        local seatPart = Humanoid and Humanoid.SeatPart
        if not seatPart then
            Notify("✈️ Vehicle Fly", "❌ Du sitzt in keinem Fahrzeug!", 3)
            VehicleFlyEnabled = false
            return
        end
        local bv = Instance.new("BodyVelocity", seatPart)
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.zero
        RunService.Heartbeat:Connect(function()
            if not VehicleFlyEnabled or not bv.Parent then
                pcall(function() bv:Destroy() end)
                return
            end
            local cam = Workspace.CurrentCamera
            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W)     then dir += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S)     then dir -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.yAxis end
            bv.Velocity = dir.Magnitude > 0 and dir.Unit * 120 or Vector3.zero
        end)
    end
end

-- ============================================================
-- // ADMIN CHECKER
-- ============================================================
local function IsInVehicle(plr)
    if not plr.Character then return false end
    local hum = plr.Character:FindFirstChild("Humanoid")
    return hum and hum.SeatPart ~= nil
end

local function IsInAirVehicle(plr)
    if not plr.Character then return false end
    local hum = plr.Character:FindFirstChild("Humanoid")
    if hum and hum.SeatPart then
        local model = hum.SeatPart:FindFirstAncestorOfClass("Model")
        if model then
            local n = model.Name:lower()
            if n:find("heli") or n:find("helicopter") or n:find("plane") or
               n:find("flugzeug") or n:find("aircraft") or n:find("jet") or n:find("drone") then
                return true
            end
        end
    end
    return false
end

local function IsPlayerFlying(plr)
    if not plr.Character then return false end
    if IsInAirVehicle(plr) then return false end
    if IsInVehicle(plr) then return false end
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    for _, obj in pairs(root:GetChildren()) do
        if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") or obj:IsA("BodyPosition") then
            return true
        end
    end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {plr.Character}
    params.FilterType = Enum.RaycastFilterType.Exclude
    local hit = Workspace:Raycast(root.Position, Vector3.new(0, -60, 0), params)
    if not hit and math.abs(root.Velocity.Y) < 2 then return true end
    return false
end

local function IsPlayerSpeedHacking(plr)
    if not plr.Character then return false, 0 end
    if IsInVehicle(plr) then return false, 0 end
    local root = plr.Character:FindFirstChild("HumanoidRootPart")
    if not root then return false, 0 end
    local speed = Vector3.new(root.Velocity.X, 0, root.Velocity.Z).Magnitude
    return speed > 50, math.floor(speed)
end

local function HasAdminIndicator(plr)
    local kws = {"admin","mod","staff","owner","dev","manager","co-owner","support","helper","leiter","sl"}
    local function chk(s)
        s = s:lower()
        for _, kw in ipairs(kws) do
            if s:find(kw) then return true, kw end
        end
        return false, nil
    end
    local ok, kw = chk(plr.Name)
    if ok then return true, kw end
    local ok2, kw2 = chk(plr.DisplayName)
    if ok2 then return true, kw2 end
    if plr.Character then
        for _, obj in pairs(plr.Character:GetDescendants()) do
            if obj:IsA("TextLabel") then
                local ok3, kw3 = chk(obj.Text)
                if ok3 then return true, kw3 end
            end
        end
    end
    return false, nil
end

local function HasAdminTools(plr)
    local found = {}
    if plr.Backpack then
        for _, item in pairs(plr.Backpack:GetChildren()) do
            local n = item.Name:lower()
            if n:find("admin") or n:find("mod") or n:find("ban") or n:find("kick") then
                table.insert(found, item.Name)
            end
        end
    end
    return #found > 0, found
end

local function GetGroupRank(plr)
    if EMDEN_GROUP_ID == 0 then return 0, "Keine Group-ID" end
    local ok, rank = pcall(function() return plr:GetRankInGroup(EMDEN_GROUP_ID) end)
    if ok and rank > 0 then
        local ok2, role = pcall(function() return plr:GetRoleInGroup(EMDEN_GROUP_ID) end)
        return rank, ok2 and role or ("Rang " .. rank)
    end
    return 0, "Kein Mitglied"
end

local function CheckAdmins()
    Notify("🛡️ Admin Checker", "Scanne alle Spieler...", 3)
    task.wait(0.8)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player then
            local lines, sus = {}, false
            if IsInVehicle(plr)    then table.insert(lines, IsInAirVehicle(plr) and "🚁 Im Luft-Fahrzeug" or "🚗 Im Fahrzeug") end
            if IsPlayerFlying(plr) then table.insert(lines, "✈️ FLIEGT (Hack)"); sus=true end
            local sp, spd = IsPlayerSpeedHacking(plr)
            if sp then table.insert(lines, "⚡ SPEED HACK (" .. spd .. "/s)"); sus=true end
            local ht, htk = HasAdminIndicator(plr)
            if ht then table.insert(lines, "🏷️ Admin-Name: '" .. htk .. "'"); sus=true end
            local hatool, toolList = HasAdminTools(plr)
            if hatool then table.insert(lines, "🔑 Admin-Tools: " .. table.concat(toolList, ", ")); sus=true end
            local rank, role = GetGroupRank(plr)
            if rank > 0 then table.insert(lines, "🛡️ Rang: " .. role .. " (" .. rank .. ")"); if rank>=50 then sus=true end end
            if plr.AccountAge < 30 then table.insert(lines, "⚠️ Neues Konto: " .. plr.AccountAge .. " Tage") end
            if #lines == 0 then table.insert(lines, "Nichts Auffälliges.") end
            Notify((sus and "🚨 " or "✅ ") .. plr.Name, table.concat(lines, "\n"), 7)
            task.wait(0.5)
        end
    end
    Notify("✅ Scan", "Admin Check abgeschlossen!", 3)
end

-- ============================================================
-- // SERVER INFO
-- ============================================================
local function CheckServerInfo()
    local isPrivate = game.PrivateServerId ~= nil and game.PrivateServerId ~= ""
    local lines = {
        isPrivate and "🔒 Privater Server" or "🌐 Öffentlicher Server",
        "🎮 PlaceId: " .. tostring(game.PlaceId),
        "🆔 JobId: "   .. tostring(game.JobId):sub(1,16) .. "...",
        "👥 Spieler: " .. #Players:GetPlayers() .. " online"
    }
    local cId = game.CreatorId
    if game.CreatorType == Enum.CreatorType.User then
        local ok, n = pcall(function() return Players:GetNameFromUserIdAsync(cId) end)
        table.insert(lines, "👤 Creator: " .. (ok and n or tostring(cId)))
    else
        table.insert(lines, "👥 Gruppen-Spiel (GroupId: " .. cId .. ")")
    end
    if isPrivate and game.PrivateServerOwnerId and game.PrivateServerOwnerId ~= 0 then
        local ok, n = pcall(function() return Players:GetNameFromUserIdAsync(game.PrivateServerOwnerId) end)
        table.insert(lines, "🔑 PS-Owner: " .. (ok and n or "Unbekannt"))
    end
    for _, l in ipairs(lines) do
        Notify("🌐 Server Info", l, 5)
        task.wait(0.35)
    end
end

-- ============================================================
-- // NOTFALL
-- ============================================================
local function DeactivateAll()
    if FlyEnabled then ToggleFly() end
    NoclipEnabled     = false
    _G.CeliRainbow    = false
    GodMode           = false
    VehicleFlyEnabled = false
    AimbotEnabled     = false
    if AimbotConnection then AimbotConnection:Disconnect(); AimbotConnection = nil end
    if Humanoid then Humanoid.MaxHealth=100; Humanoid.Health=100 end
    if RootPart then
        for _,v in pairs(RootPart:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
        end
    end
    if Character then
        for _,p in pairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=true end
        end
    end
    SpeedMultiplier = 1
    Notify("🛑 NOTFALL", "Alle Hacks deaktiviert!", 4)
end

local function RejoinGame()
    Notify("🔄 Rejoin", "Rejoining...", 2)
    task.wait(1)
    TeleportService:Teleport(game.PlaceId, Player)
end

local function RejoinPrivate()
    local pid = game.PrivateServerId
    if pid and pid ~= "" then
        Notify("🔒 Rejoin PS", "Rejoining...", 2)
        task.wait(1)
        TeleportService:TeleportToPrivateServer(game.PlaceId, pid, {Player})
    else
        Notify("❌", "Kein privater Server erkannt!", 3)
    end
end

-- ============================================================
-- // UI WINDOW
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "CeliHub | Emden Edition 🚨",
    LoadingTitle    = "CeliHub",
    LoadingSubtitle = "Made by Celi 💫",
    ConfigurationSaving = {Enabled=true, FolderName="CeliHubEmden"}
})

local MovementTab  = Window:CreateTab("🚀 Movement",     4483362458)
local CombatTab    = Window:CreateTab("🎯 Combat",       4483362458)
local PlayerTab    = Window:CreateTab("🧍 Player Mods",  4483362458)
local VisualsTab   = Window:CreateTab("👁️ Visuals/ESP",  4483362458)
local VehicleTab   = Window:CreateTab("🚗 Fahrzeuge",    4483362458)
local TeleportTab  = Window:CreateTab("📍 Teleport",     4483362458)
local AdminTab     = Window:CreateTab("🛡️ Admin Check",  4483362458)
local ServerTab    = Window:CreateTab("🌐 Server Info",  4483362458)
local EmergencyTab = Window:CreateTab("🚨 Notfall",      4483362458)
local KeybindTab   = Window:CreateTab("⌨️ Keybinds",     4483362458)

-- ============================================================
-- MOVEMENT
-- ============================================================
MovementTab:CreateSlider({
    Name="⚡ Speed Multiplier", Range={1,20}, Increment=0.5, CurrentValue=1,
    Callback=function(v) SpeedMultiplier=v end
})
MovementTab:CreateButton({Name="✈️ Toggle Fly",     Callback=ToggleFly})
MovementTab:CreateButton({Name="👻 Toggle NoClip",  Callback=ToggleNoclip})

-- ============================================================
-- COMBAT
-- ============================================================
CombatTab:CreateSection("🎯 Aimbot")
CombatTab:CreateToggle({
    Name="🎯 Aimbot (Kamera dreht zu Spieler)",
    CurrentValue=false,
    Callback=function(v)
        AimbotEnabled = v
        if v then
            if AimbotConnection then AimbotConnection:Disconnect() end
            AimbotConnection = RunService.RenderStepped:Connect(function()
                if not AimbotEnabled then return end
                local target = GetNearestPlayer()
                if target and target.Character then
                    local head = target.Character:FindFirstChild("Head")
                    if head then
                        Workspace.CurrentCamera.CFrame = CFrame.new(
                            Workspace.CurrentCamera.CFrame.Position, head.Position
                        )
                    end
                end
            end)
            Notify("🎯 Aimbot", "Aktiviert!", 3)
        else
            if AimbotConnection then AimbotConnection:Disconnect(); AimbotConnection=nil end
            Notify("🎯 Aimbot", "Deaktiviert.", 2)
        end
    end
})

CombatTab:CreateSection("💀 Weitere Optionen")
CombatTab:CreateButton({
    Name="🔍 Nächster Spieler anzeigen",
    Callback=function()
        local t = GetNearestPlayer()
        if t then
            local dist = math.floor((RootPart.Position - t.Character.HumanoidRootPart.Position).Magnitude)
            Notify("🔍 Nächster Spieler", t.Name .. "\n📏 " .. dist .. " Studs entfernt", 5)
        else
            Notify("🔍", "Keine Spieler in Sicht!", 3)
        end
    end
})
CombatTab:CreateButton({
    Name="📍 Zum nächsten Spieler TP",
    Callback=function()
        local t = GetNearestPlayer()
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            RootPart.CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(3,0,0)
            Notify("📍 TP", "Zu " .. t.Name, 2)
        end
    end
})

-- ============================================================
-- PLAYER MODS
-- ============================================================
PlayerTab:CreateToggle({Name="∞ Infinite Jump",       CurrentValue=false, Callback=function(v) InfiniteJump=v end})
PlayerTab:CreateToggle({Name="🛡️ God Mode",           CurrentValue=false, Callback=function(v)
    GodMode = v
    if v then Humanoid.MaxHealth=math.huge; Humanoid.Health=math.huge
    else Humanoid.MaxHealth=100; Humanoid.Health=100 end
    Notify("🛡️ God Mode", v and "Aktiviert!" or "Deaktiviert.", 2)
end})
PlayerTab:CreateToggle({Name="🌈 Rainbow Character",  CurrentValue=false, Callback=function(v)
    _G.CeliRainbow = v
    if v then ToggleRainbow() elseif not v then _G.CeliRainbow = false end
end})

-- ============================================================
-- VISUALS
-- ============================================================
VisualsTab:CreateButton({Name="👁️ Toggle ESP",       Callback=ToggleESP})
VisualsTab:CreateButton({Name="🏷️ Toggle NameTags",  Callback=ToggleNameTags})

-- ============================================================
-- FAHRZEUGE
-- ============================================================
VehicleTab:CreateSection("🚗 Fahrzeug Finder")
VehicleTab:CreateButton({
    Name="🗂️ Alle Fahrzeuge anzeigen & auswählen",
    Callback=OpenVehicleSelector
})
VehicleTab:CreateButton({
    Name="🔍 Nächstes Fahrzeug — automatisch einsetzen",
    Callback=FindAndSitInNearestVehicle
})

VehicleTab:CreateSection("🛠️ Fahrzeug Hacks")
VehicleTab:CreateButton({Name="✈️ Vehicle Fly (muss im Fzg sitzen)", Callback=ToggleVehicleFly})
VehicleTab:CreateButton({Name="💥 Vehicle Fling",                    Callback=VehicleFling})

-- ============================================================
-- TELEPORT
-- ============================================================
TeleportTab:CreateSection("📍 Bekannte Orte")
for name, _ in pairs(TeleportLocations) do
    local n = name
    TeleportTab:CreateButton({Name="➡️ " .. n, Callback=function() TeleportTo(n) end})
end

TeleportTab:CreateSection("💾 Position")
TeleportTab:CreateButton({Name="📍 Position speichern",         Callback=SavePosition})
TeleportTab:CreateButton({Name="🔙 Zur gespeicherten Position", Callback=ReturnToPosition})

TeleportTab:CreateSection("👥 Zu Spieler")
TeleportTab:CreateInput({
    Name="Spielername", PlaceholderText="z.B. Player123",
    RemoveTextAfterFocusLost=false,
    Callback=function(t) if t~="" then TeleportToPlayer(t) end end
})
TeleportTab:CreateButton({
    Name="📋 Spielerliste anzeigen",
    Callback=function()
        local l={}
        for _,p in pairs(Players:GetPlayers()) do
            if p~=Player then table.insert(l,p.Name) end
        end
        Notify("👥 Online", #l>0 and table.concat(l,", ") or "Niemand sonst online!", 5)
    end
})

-- ============================================================
-- ADMIN CHECKER
-- ============================================================
AdminTab:CreateSection("🔍 Analyse")
AdminTab:CreateButton({Name="🛡️ Vollen Admin Check starten",  Callback=CheckAdmins})
AdminTab:CreateButton({
    Name="✈️ Nur Fly/Speed Check",
    Callback=function()
        Notify("Scan", "Scanne...", 2)
        local found=false
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player then
                local fl=IsPlayerFlying(plr)
                local sp,spd=IsPlayerSpeedHacking(plr)
                if fl or sp then
                    found=true
                    Notify("🚨 "..plr.Name, (fl and "✈️ FLIEGT\n" or "") .. (sp and "⚡ SPEED: "..spd or ""), 6)
                end
            end
        end
        if not found then Notify("✅", "Niemand auffällig!", 3) end
    end
})
AdminTab:CreateButton({
    Name="⚠️ Neue Accounts (< 30 Tage)",
    Callback=function()
        local found=false
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player and plr.AccountAge<30 then
                Notify("⚠️ Neues Konto", plr.Name.." ("..plr.AccountAge.." Tage)", 5)
                found=true
            end
        end
        if not found then Notify("✅","Keine neuen Accounts!",3) end
    end
})
AdminTab:CreateSection("⚙️ Einstellungen")
AdminTab:CreateInput({
    Name="Emergency Emden Group-ID", PlaceholderText="Gruppen-ID eingeben",
    RemoveTextAfterFocusLost=false,
    Callback=function(t)
        local id=tonumber(t)
        if id then EMDEN_GROUP_ID=id; Notify("Group-ID","✅ Gesetzt: "..id,3)
        else Notify("❌","Ungültige Zahl!",3) end
    end
})

-- ============================================================
-- SERVER INFO
-- ============================================================
ServerTab:CreateButton({Name="🌐 Server Info anzeigen",  Callback=CheckServerInfo})
ServerTab:CreateButton({
    Name="👥 Alle Spieler + Details",
    Callback=function()
        for _,plr in pairs(Players:GetPlayers()) do
            local rank,role=GetGroupRank(plr)
            local rs=rank>0 and (" | 🛡️ "..role) or ""
            Notify("👤 "..plr.Name,"Konto: "..plr.AccountAge.." Tage"..rs,5)
            task.wait(0.35)
        end
    end
})

-- ============================================================
-- NOTFALL
-- ============================================================
EmergencyTab:CreateSection("⚡ Sofort")
EmergencyTab:CreateButton({Name="🛑 ALLE HACKS DEAKTIVIEREN",         Callback=DeactivateAll})
EmergencyTab:CreateSection("🚪 Verbindung")
EmergencyTab:CreateButton({Name="🔄 Rejoin (öffentlich)",             Callback=RejoinGame})
EmergencyTab:CreateButton({Name="🔒 Rejoin (privater Server)",        Callback=RejoinPrivate})
EmergencyTab:CreateButton({Name="🚪 Spiel verlassen",                 Callback=function()
    Notify("🚪","Verlasse Spiel...",2); task.wait(1); game:Shutdown()
end})
EmergencyTab:CreateSection("🔁 Sonstiges")
EmergencyTab:CreateButton({
    Name="🔁 Charakter respawnen",
    Callback=function()
        Player:LoadCharacter()
        Notify("🔁 Respawn","Charakter neu geladen!",2)
    end
})

-- ============================================================
-- KEYBINDS TAB
-- ============================================================

-- Keybind-Mapping: Aktion → Funktion
local KeybindActions = {
    Fly           = ToggleFly,
    Noclip        = ToggleNoclip,
    SavePos       = SavePosition,
    ReturnPos     = ReturnToPosition,
    EmergencyStop = DeactivateAll,
}

local KeybindLabels = {
    Fly           = "✈️ Fly togglen",
    Noclip        = "👻 NoClip togglen",
    SavePos       = "📍 Position speichern",
    ReturnPos     = "🔙 Zur Position zurück",
    EmergencyStop = "🛑 Alle Hacks OFF",
}

-- Standard Tasten anzeigen
local KeybindDefaults = {
    Fly           = "X",
    Noclip        = "N",
    SavePos       = "T",
    ReturnPos     = "R",
    EmergencyStop = "F5",
}

KeybindTab:CreateSection("⌨️ Tasten anpassen")
KeybindTab:CreateLabel("Drücke den Button, dann die gewünschte Taste.")

for bindKey, label in pairs(KeybindLabels) do
    local bk = bindKey
    KeybindTab:CreateKeybind({
        Name            = label,
        CurrentKeybind  = KeybindDefaults[bk],
        HoldToInteract  = false,
        Callback        = function(newKeyStr)
            -- Rayfield liefert einen String wie "X", "LeftControl" usw.
            local ok, kc = pcall(function()
                return Enum.KeyCode[newKeyStr]
            end)
            if ok and kc then
                Keybinds[bk] = kc
                Notify("⌨️ Keybind", label .. "\n→ " .. newKeyStr, 3)
            end
        end
    })
end

-- ============================================================
-- // INPUT HANDLER — liest live aus Keybinds-Tabelle
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local kc = input.KeyCode
    for action, bound in pairs(Keybinds) do
        if kc == bound and KeybindActions[action] then
            KeybindActions[action]()
        end
    end
end)

-- ============================================================
-- // INIT
-- ============================================================
ApplySpeedHack()
SetupInfiniteJump()

Notify("🚨 CeliHub", "Emden Edition v4 geladen!\nKey: ✅  Viel Spaß!", 5)
