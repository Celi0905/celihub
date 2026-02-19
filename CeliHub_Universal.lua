-- ============================================================
-- CeliHub | Universal Edition 🌍
-- Made by Celi 💫
-- Funktioniert in fast jedem Roblox Spiel!
-- ============================================================

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Workspace        = game:GetService("Workspace")
local Teams            = game:GetService("Teams")

-- ============================================================
-- Rayfield laden
-- ============================================================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ============================================================
-- Player Setup
-- ============================================================
local Player    = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid  = Character:WaitForChild("Humanoid")
local RootPart  = Character:WaitForChild("HumanoidRootPart")
local Camera    = Workspace.CurrentCamera

Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid  = char:WaitForChild("Humanoid")
    RootPart  = char:WaitForChild("HumanoidRootPart")
end)

-- ============================================================
-- VARS
-- ============================================================
local AimbotEnabled     = false
local AimbotFOV         = 100
local AimbotSmoothing   = 0
local AimbotTarget      = "Head"
local AimbotTeamCheck   = true
local AimbotWallCheck   = false
local SilentAimEnabled  = false
local AimbotConn        = nil

local ESPEnabled        = false
local ESPBoxEnabled     = false
local ESPNameEnabled    = false
local ESPDistEnabled    = false
local ESPHealthEnabled  = false
local ESPChamsEnabled   = false
local ESPTracerEnabled  = false
local ESPTeamCheck      = false
local ESPRange          = 2000

local SpeedEnabled      = false
local SpeedAmount       = 1
local FlyEnabled        = false
local FlyBV             = nil
local NoclipEnabled     = false
local InfiniteJump      = false
local GodMode           = false

local AimbotConnection  = nil

-- ESP storage
local ESPObjects = {}

-- ============================================================
-- Notification
-- ============================================================
local function Notify(title, text, dur)
    Rayfield:Notify({Title=title, Content=tostring(text), Duration=dur or 3})
end

-- ============================================================
-- AIMBOT
-- ============================================================
local function GetNearestTarget()
    local nearest   = nil
    local minDist   = math.huge
    local center    = Camera.ViewportSize / 2

    for _, plr in pairs(Players:GetPlayers()) do
        if plr == Player then continue end
        if AimbotTeamCheck and plr.Team == Player.Team then continue end
        if not plr.Character then continue end

        local hum = plr.Character:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        local target = plr.Character:FindFirstChild(AimbotTarget) or plr.Character:FindFirstChild("Head")
        if not target then continue end

        -- Wall check
        if AimbotWallCheck then
            local params = RaycastParams.new()
            params.FilterDescendantsInstances = {Player.Character, plr.Character}
            params.FilterType = Enum.RaycastFilterType.Exclude
            local dir = target.Position - Camera.CFrame.Position
            local hit = Workspace:Raycast(Camera.CFrame.Position, dir, params)
            if hit then continue end
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(target.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
        if dist < minDist and dist < AimbotFOV then
            minDist = dist
            nearest = target
        end
    end
    return nearest
end

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible    = false
FOVCircle.Filled     = false
FOVCircle.Thickness  = 1.5
FOVCircle.Color      = Color3.fromRGB(220, 40, 40)
FOVCircle.Radius     = AimbotFOV
FOVCircle.Transparency = 1

RunService.RenderStepped:Connect(function()
    -- FOV Circle
    FOVCircle.Position = Camera.ViewportSize / 2
    FOVCircle.Radius   = AimbotFOV

    -- Aimbot
    if AimbotEnabled then
        local target = GetNearestTarget()
        if target then
            if AimbotSmoothing == 0 then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            else
                Camera.CFrame = Camera.CFrame:Lerp(
                    CFrame.new(Camera.CFrame.Position, target.Position),
                    1 / (AimbotSmoothing * 2)
                )
            end
        end
    end
end)

-- ============================================================
-- ESP SYSTEM
-- ============================================================
local function ClearESP(plr)
    if ESPObjects[plr] then
        pcall(function()
            if ESPObjects[plr].highlight then ESPObjects[plr].highlight:Destroy() end
            if ESPObjects[plr].billboard then ESPObjects[plr].billboard:Destroy() end
            if ESPObjects[plr].tracer then ESPObjects[plr].tracer:Remove() end
        end)
        ESPObjects[plr] = nil
    end
end

local function UpdateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr == Player then continue end
        if not plr.Character then
            ClearESP(plr); continue
        end

        local root = plr.Character:FindFirstChild("HumanoidRootPart")
        local hum  = plr.Character:FindFirstChild("Humanoid")
        if not root or not hum then ClearESP(plr); continue end

        local dist = (RootPart.Position - root.Position).Magnitude
        if dist > ESPRange then ClearESP(plr); continue end

        if ESPTeamCheck and plr.Team == Player.Team then ClearESP(plr); continue end

        local isVisible = ESPEnabled or ESPBoxEnabled or ESPNameEnabled or ESPDistEnabled or ESPHealthEnabled or ESPChamsEnabled or ESPTracerEnabled

        if not isVisible then ClearESP(plr); continue end

        if not ESPObjects[plr] then ESPObjects[plr] = {} end
        local obj = ESPObjects[plr]

        -- Highlight / Chams
        if ESPChamsEnabled then
            if not obj.highlight or not obj.highlight.Parent then
                local h = Instance.new("Highlight", plr.Character)
                h.FillColor    = plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(0,200,255)
                h.OutlineColor = Color3.fromRGB(255,255,255)
                h.FillTransparency    = 0.5
                h.OutlineTransparency = 0
                obj.highlight = h
            end
        elseif obj.highlight and obj.highlight.Parent then
            obj.highlight:Destroy(); obj.highlight = nil
        end

        -- NameTag + Distance + Health
        local head = plr.Character:FindFirstChild("Head")
        if (ESPNameEnabled or ESPDistEnabled or ESPHealthEnabled) and head then
            if not obj.billboard or not obj.billboard.Parent then
                local bb = Instance.new("BillboardGui", plr.Character)
                bb.Name = "CeliESP_Tag"; bb.Adornee = head
                bb.Size = UDim2.fromOffset(220, 60)
                bb.StudsOffset = Vector3.new(0, 2.5, 0)
                bb.AlwaysOnTop = true
                obj.billboard = bb

                local bg = Instance.new("Frame", bb)
                bg.Size = UDim2.fromScale(1,1); bg.BackgroundTransparency=1
                Instance.new("UIListLayout", bg).SortOrder = Enum.SortOrder.LayoutOrder

                obj.nameLabel   = nil
                obj.distLabel   = nil
                obj.healthLabel = nil

                local function mkLbl(text, color, order)
                    local l = Instance.new("TextLabel", bg)
                    l.Size = UDim2.fromOffset(220, 18); l.BackgroundTransparency=1
                    l.Text=text; l.TextColor3=color; l.Font=Enum.Font.GothamBold
                    l.TextSize=13; l.TextStrokeTransparency=0.3; l.LayoutOrder=order
                    return l
                end

                if ESPNameEnabled then obj.nameLabel   = mkLbl(plr.Name, plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(255,255,255), 1) end
                if ESPDistLabel   then obj.distLabel   = mkLbl("", Color3.fromRGB(200,200,200), 2) end
                if ESPHealthEnabled then obj.healthLabel = mkLbl("", Color3.fromRGB(60,220,100), 3) end
            end

            -- Update dynamic labels
            if obj.distLabel and ESPDistEnabled then
                obj.distLabel.Text = "📏 " .. math.floor(dist) .. " studs"
            end
            if obj.healthLabel and ESPHealthEnabled then
                local hp = math.floor(hum.Health)
                local maxHp = math.floor(hum.MaxHealth)
                local ratio = hp / math.max(maxHp, 1)
                obj.healthLabel.Text = "❤️ " .. hp .. "/" .. maxHp
                obj.healthLabel.TextColor3 = Color3.fromRGB(
                    math.floor((1-ratio)*255), math.floor(ratio*200), 60
                )
            end
        elseif obj.billboard and obj.billboard.Parent then
            obj.billboard:Destroy(); obj.billboard = nil
        end

        -- Tracer
        if ESPTracerEnabled then
            if not obj.tracer then
                local line = Drawing.new("Line")
                line.Visible   = true
                line.Thickness = 1.5
                line.Color     = plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(0,200,255)
                line.Transparency = 1
                obj.tracer = line
            end
            local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
            if onScreen then
                obj.tracer.Visible = true
                obj.tracer.From    = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                obj.tracer.To      = Vector2.new(screenPos.X, screenPos.Y)
                obj.tracer.Color   = plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(0,200,255)
            else
                obj.tracer.Visible = false
            end
        elseif obj.tracer then
            obj.tracer:Remove(); obj.tracer = nil
        end
    end
end

RunService.Heartbeat:Connect(function()
    if ESPEnabled or ESPChamsEnabled or ESPNameEnabled or ESPDistEnabled or ESPHealthEnabled or ESPTracerEnabled then
        UpdateESP()
    end
end)

Players.PlayerRemoving:Connect(function(plr) ClearESP(plr) end)

-- ============================================================
-- MOVEMENT
-- ============================================================
local function ToggleFly()
    FlyEnabled = not FlyEnabled
    if FlyEnabled then
        Notify("✈️ Fly","Aktiviert! WASD + Space/Shift",3)
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Velocity = Vector3.zero
        bv.Parent = RootPart; FlyBV = bv
        RunService.Heartbeat:Connect(function()
            if not FlyEnabled or not FlyBV or not FlyBV.Parent then return end
            local d = Vector3.zero; local cam = Camera
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then d += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then d -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then d -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then d += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d -= Vector3.yAxis end
            FlyBV.Velocity = d.Magnitude>0 and d.Unit*60 or Vector3.zero
        end)
    else
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end
        FlyBV = nil; Notify("✈️ Fly","Deaktiviert.",2)
    end
end

local function ToggleNoclip()
    NoclipEnabled = not NoclipEnabled
    Notify("👻 NoClip", NoclipEnabled and "Aktiviert!" or "Deaktiviert.",2)
    if NoclipEnabled then
        RunService.Stepped:Connect(function()
            if not NoclipEnabled or not Character then return end
            for _,p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=false end
            end
        end)
    else
        if Character then
            for _,p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=true end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    if not Humanoid or not RootPart then return end
    if SpeedEnabled and Humanoid.MoveDirection.Magnitude > 0 then
        local v = Humanoid.MoveDirection * (16 * SpeedAmount)
        RootPart.Velocity = Vector3.new(v.X, RootPart.Velocity.Y, v.Z)
    end
    if GodMode then Humanoid.Health = Humanoid.MaxHealth end
end)

UserInputService.JumpRequest:Connect(function()
    if InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ============================================================
-- DEACTIVATE ALL
-- ============================================================
local function DeactivateAll()
    if FlyEnabled then ToggleFly() end
    NoclipEnabled=false; SpeedEnabled=false; GodMode=false; InfiniteJump=false
    AimbotEnabled=false; SilentAimEnabled=false
    FOVCircle.Visible=false
    ESPEnabled=false; ESPBoxEnabled=false; ESPNameEnabled=false; ESPDistEnabled=false
    ESPHealthEnabled=false; ESPChamsEnabled=false; ESPTracerEnabled=false
    for _,plr in pairs(Players:GetPlayers()) do ClearESP(plr) end
    if Humanoid then Humanoid.MaxHealth=100; Humanoid.Health=100 end
    if RootPart then
        for _,v in pairs(RootPart:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
        end
    end
    SpeedAmount=1
    Notify("🛑 NOTFALL","Alle Hacks deaktiviert!",4)
end

-- ============================================================
-- RAYFIELD UI
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "CeliHub | Universal 🌍",
    LoadingTitle    = "CeliHub",
    LoadingSubtitle = "Made by Celi 💫",
    ConfigurationSaving = {Enabled=true, FolderName="CeliHubUniversal"}
})

local AimbotTab  = Window:CreateTab("🎯 Aimbot",    4483362458)
local ESPTab     = Window:CreateTab("👁️ ESP",        4483362458)
local MovTab     = Window:CreateTab("🚀 Movement",   4483362458)
local PlayerTab  = Window:CreateTab("🧍 Player",     4483362458)
local MiscTab    = Window:CreateTab("⚙️ Misc",       4483362458)
local NotfallTab = Window:CreateTab("🚨 Notfall",    4483362458)

-- ============================================================
-- AIMBOT TAB
-- ============================================================
AimbotTab:CreateSection("🎯 Aimbot Einstellungen")

AimbotTab:CreateToggle({
    Name="🎯 Aimbot aktivieren", CurrentValue=false,
    Callback=function(v)
        AimbotEnabled=v
        FOVCircle.Visible=v
        Notify("🎯 Aimbot", v and "Aktiviert!" or "Deaktiviert.",2)
    end
})

AimbotTab:CreateSlider({
    Name="🔵 FOV Radius", Range={10,500}, Increment=5, CurrentValue=100,
    Callback=function(v)
        AimbotFOV=v; FOVCircle.Radius=v
    end
})

AimbotTab:CreateSlider({
    Name="🌊 Smoothing (0 = snap)", Range={0,10}, Increment=1, CurrentValue=0,
    Callback=function(v) AimbotSmoothing=v end
})

AimbotTab:CreateDropdown({
    Name="🎯 Ziel-Part",
    Options={"Head","HumanoidRootPart","UpperTorso","Torso"},
    CurrentOption={"Head"},
    Callback=function(v) AimbotTarget=v[1] or "Head" end
})

AimbotTab:CreateToggle({
    Name="✅ Team Check (eigenes Team ignorieren)", CurrentValue=true,
    Callback=function(v) AimbotTeamCheck=v end
})

AimbotTab:CreateToggle({
    Name="🧱 Wall Check", CurrentValue=false,
    Callback=function(v) AimbotWallCheck=v end
})

AimbotTab:CreateSection("ℹ️ Status")
AimbotTab:CreateButton({
    Name="🔍 Nächsten Spieler anzeigen",
    Callback=function()
        local t=GetNearestTarget()
        if t then
            local plr=Players:GetPlayerFromCharacter(t.Parent)
            local dist=math.floor((RootPart.Position-t.Position).Magnitude)
            Notify("🎯 Nächster",((plr and plr.Name) or "?").."\n📏 "..dist.." studs",5)
        else
            Notify("🔍","Kein Spieler in FOV!",3)
        end
    end
})

-- ============================================================
-- ESP TAB
-- ============================================================
ESPTab:CreateSection("👁️ ESP Optionen")

ESPTab:CreateToggle({
    Name="🟢 Chams (Körper hervorheben)", CurrentValue=false,
    Callback=function(v) ESPChamsEnabled=v; if not v then for _,p in pairs(Players:GetPlayers()) do ClearESP(p) end end end
})

ESPTab:CreateToggle({
    Name="🏷️ Namen anzeigen", CurrentValue=false,
    Callback=function(v) ESPNameEnabled=v; for _,p in pairs(Players:GetPlayers()) do ClearESP(p) end end
})

ESPTab:CreateToggle({
    Name="📏 Distanz anzeigen", CurrentValue=false,
    Callback=function(v) ESPDistEnabled=v; for _,p in pairs(Players:GetPlayers()) do ClearESP(p) end end
})

ESPTab:CreateToggle({
    Name="❤️ Health anzeigen", CurrentValue=false,
    Callback=function(v) ESPHealthEnabled=v; for _,p in pairs(Players:GetPlayers()) do ClearESP(p) end end
})

ESPTab:CreateToggle({
    Name="📡 Tracer Linien", CurrentValue=false,
    Callback=function(v) ESPTracerEnabled=v end
})

ESPTab:CreateToggle({
    Name="✅ Team Check", CurrentValue=false,
    Callback=function(v) ESPTeamCheck=v; for _,p in pairs(Players:GetPlayers()) do ClearESP(p) end end
})

ESPTab:CreateSlider({
    Name="📡 ESP Reichweite", Range={100,5000}, Increment=100, CurrentValue=2000,
    Callback=function(v) ESPRange=v end
})

ESPTab:CreateSection("🗑️ ESP Reset")
ESPTab:CreateButton({
    Name="🗑️ ESP komplett clearen",
    Callback=function()
        for _,p in pairs(Players:GetPlayers()) do ClearESP(p) end
        Notify("🗑️","ESP gecleart!",2)
    end
})

-- ============================================================
-- MOVEMENT TAB
-- ============================================================
MovTab:CreateSection("🚀 Bewegung")

MovTab:CreateToggle({
    Name="⚡ Speed Hack", CurrentValue=false,
    Callback=function(v) SpeedEnabled=v; Notify("⚡ Speed", v and "Aktiviert!" or "Deaktiviert.",2) end
})

MovTab:CreateSlider({
    Name="⚡ Speed Multiplikator", Range={1,20}, Increment=0.5, CurrentValue=1,
    Callback=function(v) SpeedAmount=v end
})

MovTab:CreateButton({Name="✈️ Toggle Fly (X)",     Callback=ToggleFly})
MovTab:CreateButton({Name="👻 Toggle NoClip (N)",  Callback=ToggleNoclip})
MovTab:CreateToggle({
    Name="∞ Infinite Jump", CurrentValue=false,
    Callback=function(v) InfiniteJump=v end
})

-- ============================================================
-- PLAYER TAB
-- ============================================================
PlayerTab:CreateSection("🧍 Spieler Mods")

PlayerTab:CreateToggle({
    Name="🛡️ God Mode", CurrentValue=false,
    Callback=function(v)
        GodMode=v
        if v then Humanoid.MaxHealth=math.huge; Humanoid.Health=math.huge
        else Humanoid.MaxHealth=100; Humanoid.Health=100 end
        Notify("🛡️",v and "God Mode AN!" or "God Mode aus.",2)
    end
})

PlayerTab:CreateButton({
    Name="📍 Position speichern (T)",
    Callback=function()
        _G.CeliPos=RootPart.CFrame; Notify("📍","Position gespeichert!",2)
    end
})

PlayerTab:CreateButton({
    Name="🔙 Zur Position (R)",
    Callback=function()
        if _G.CeliPos and RootPart then RootPart.CFrame=_G.CeliPos; Notify("🔙","Zurück!",2)
        else Notify("❌","Keine Position!",3) end
    end
})

PlayerTab:CreateSection("👥 Spieler Info")
PlayerTab:CreateButton({
    Name="📋 Alle Spieler anzeigen",
    Callback=function()
        for _,p in pairs(Players:GetPlayers()) do
            if p~=Player then
                local dist=math.floor((RootPart.Position-(p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart.Position or RootPart.Position)).Magnitude)
                Notify("👤 "..p.Name,"Team: "..(p.Team and p.Team.Name or "Kein Team").."\n📏 "..dist.." studs",4)
                task.wait(0.4)
            end
        end
    end
})

PlayerTab:CreateButton({
    Name="📍 Zum nächsten Spieler TP",
    Callback=function()
        local t=GetNearestTarget()
        if t and t.Parent then
            RootPart.CFrame=t.Parent:FindFirstChild("HumanoidRootPart") and
                CFrame.new(t.Parent.HumanoidRootPart.Position+Vector3.new(3,0,0)) or RootPart.CFrame
            local plr=Players:GetPlayerFromCharacter(t.Parent)
            Notify("📍","Zu "..(plr and plr.Name or "?"),2)
        end
    end
})

-- ============================================================
-- MISC TAB
-- ============================================================
MiscTab:CreateSection("⚙️ Sonstige Features")

MiscTab:CreateToggle({
    Name="🌈 Rainbow Character", CurrentValue=false,
    Callback=function(v)
        _G.CeliRainbow=v
        if v then
            task.spawn(function()
                local colors={Color3.fromRGB(255,0,0),Color3.fromRGB(255,127,0),Color3.fromRGB(255,255,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255),Color3.fromRGB(148,0,211)}
                local i=1
                while _G.CeliRainbow do
                    if Character then
                        for _,p in pairs(Character:GetDescendants()) do
                            if p:IsA("BasePart") then p.Color=colors[i] end
                        end
                    end
                    i=(i%#colors)+1; task.wait(0.3)
                end
            end)
        end
        Notify("🌈",v and "Rainbow AN!" or "Rainbow aus.",2)
    end
})

MiscTab:CreateButton({
    Name="💥 Fling (wenn in Fahrzeug / Seat)",
    Callback=function()
        if Humanoid and Humanoid.SeatPart then
            local m=Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
            if m and m.PrimaryPart then m.PrimaryPart.Velocity=Vector3.new(0,800,0); Notify("💥","Geflingt!",2); return end
        end
        if RootPart then RootPart.Velocity=Vector3.new(0,200,0) end
        Notify("💥","Fling!",2)
    end
})

MiscTab:CreateButton({
    Name="🔁 Charakter respawnen",
    Callback=function() Player:LoadCharacter(); Notify("🔁","Respawned!",2) end
})

MiscTab:CreateSection("🌐 Server")
MiscTab:CreateButton({
    Name="🌐 Server Info",
    Callback=function()
        local isP=game.PrivateServerId~=nil and game.PrivateServerId~=""
        Notify("🌐",isP and "🔒 Privater Server" or "🌐 Öffentlicher Server",3)
        task.wait(0.3); Notify("🎮","PlaceId: "..tostring(game.PlaceId),4)
        task.wait(0.3); Notify("👥","Spieler: "..#Players:GetPlayers().." online",3)
    end
})

MiscTab:CreateButton({
    Name="🔄 Rejoin",
    Callback=function()
        Notify("🔄","Rejoining...",2); task.wait(1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
    end
})

-- ============================================================
-- NOTFALL TAB
-- ============================================================
NotfallTab:CreateSection("🚨 Notfall Aktionen")
NotfallTab:CreateButton({Name="🛑 ALLE HACKS DEAKTIVIEREN", Callback=DeactivateAll})
NotfallTab:CreateButton({
    Name="🚪 Spiel verlassen",
    Callback=function() Notify("🚪","Verlasse...",2); task.wait(1); game:Shutdown() end
})

-- ============================================================
-- KEYBINDS
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.X then ToggleFly() end
    if input.KeyCode == Enum.KeyCode.N then ToggleNoclip() end
    if input.KeyCode == Enum.KeyCode.T then _G.CeliPos=RootPart.CFrame; Notify("📍","Gespeichert!",2) end
    if input.KeyCode == Enum.KeyCode.R then
        if _G.CeliPos then RootPart.CFrame=_G.CeliPos; Notify("🔙","Zurück!",2) end
    end
    if input.KeyCode == Enum.KeyCode.F5 then DeactivateAll() end
end)

Notify("🌍 CeliHub","Universal Edition geladen!\n✅ Bereit! F5 = Alles aus",5)
