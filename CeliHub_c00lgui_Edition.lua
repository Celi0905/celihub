-- CeliHub | c00lgui Edition 🟠
-- Made by Celi 💫
-- KEIN Rayfield, KEIN GetObjects, KEIN InsertService
-- Eigenes GUI — funktioniert immer

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")

local Player    = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera    = workspace.CurrentCamera

local function GetChar()  return Player.Character end
local function GetHum()   local c=GetChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot()  local c=GetChar(); return c and c:FindFirstChild("HumanoidRootPart") end

-- ============================================================
-- GUI ERSTELLEN
-- ============================================================
local old = PlayerGui:FindFirstChild("CeliHub_c00lgui")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CeliHub_c00lgui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Hauptfenster
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(340, 480)
Main.Position = UDim2.new(0, 10, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 140, 0)

-- Titelleiste
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

-- Ecken unten füllen
local TitleFix = Instance.new("Frame", TitleBar)
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
TitleFix.BorderSizePixel = 0

local TitleLbl = Instance.new("TextLabel", TitleBar)
TitleLbl.Size = UDim2.new(1, -50, 1, 0)
TitleLbl.Position = UDim2.fromOffset(12, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "🟠 CeliHub | c00lgui Edition"
TitleLbl.TextColor3 = Color3.new(1, 1, 1)
TitleLbl.Font = Enum.Font.GothamBold
TitleLbl.TextSize = 14
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Schließen Button
local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.fromOffset(30, 30)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Minimize Button
local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.fromOffset(30, 30)
MinBtn.Position = UDim2.new(1, -70, 0.5, -15)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.BorderSizePixel = 0
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(1, 0)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Main.Size = UDim2.fromOffset(340, 42)
    else
        Main.Size = UDim2.fromOffset(340, 480)
    end
end)

-- Content Frame
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -16, 1, -54)
Content.Position = UDim2.fromOffset(8, 50)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 6)

-- ============================================================
-- HELPER FUNCTIONS
-- ============================================================
local function MakeSection(parent, text)
    local F = Instance.new("Frame", parent)
    F.Size = UDim2.new(1, 0, 0, 24)
    F.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    F.BackgroundTransparency = 0.8
    F.BorderSizePixel = 0
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
    local L = Instance.new("TextLabel", F)
    L.Size = UDim2.fromScale(1, 1)
    L.BackgroundTransparency = 1
    L.Text = text
    L.TextColor3 = Color3.fromRGB(255, 180, 50)
    L.Font = Enum.Font.GothamBold
    L.TextSize = 12
    return F
end

local function MakeButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Btn.Text = text
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local St = Instance.new("UIStroke", Btn)
    St.Color = Color3.fromRGB(40, 40, 65)
    Btn.MouseEnter:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        St.Color = Color3.fromRGB(255, 140, 0)
    end)
    Btn.MouseLeave:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        St.Color = Color3.fromRGB(40, 40, 65)
    end)
    Btn.MouseButton1Click:Connect(function()
        Btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        task.wait(0.12)
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        pcall(callback)
    end)
    return Btn
end

local toggleStates = {}
local function MakeToggle(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Btn.BorderSizePixel = 0
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local St = Instance.new("UIStroke", Btn)
    St.Color = Color3.fromRGB(40, 40, 65)
    toggleStates[Btn] = false
    local function UpdateLook()
        local on = toggleStates[Btn]
        Btn.Text = (on and "✅ " or "⬜ ") .. text
        Btn.BackgroundColor3 = on and Color3.fromRGB(30, 80, 30) or Color3.fromRGB(25, 25, 40)
        St.Color = on and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(40, 40, 65)
    end
    UpdateLook()
    Btn.MouseButton1Click:Connect(function()
        toggleStates[Btn] = not toggleStates[Btn]
        UpdateLook()
        pcall(callback, toggleStates[Btn])
    end)
    return Btn, function() return toggleStates[Btn] end
end

local function Notify(text, duration)
    local NGui = Instance.new("ScreenGui", PlayerGui)
    NGui.Name = "CeliNotif"; NGui.ResetOnSpawn = false; NGui.IgnoreGuiInset = true
    local NF = Instance.new("Frame", NGui)
    NF.Size = UDim2.fromOffset(280, 50)
    NF.Position = UDim2.new(1, -290, 1, -70)
    NF.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    NF.BorderSizePixel = 0
    NF.BackgroundTransparency = 1
    Instance.new("UICorner", NF).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", NF).Color = Color3.fromRGB(255, 140, 0)
    local NL = Instance.new("TextLabel", NF)
    NL.Size = UDim2.fromScale(1, 1); NL.BackgroundTransparency = 1
    NL.Text = text; NL.TextColor3 = Color3.new(1,1,1)
    NL.Font = Enum.Font.GothamBold; NL.TextSize = 14; NL.TextWrapped = true
    TweenService:Create(NF, TweenInfo.new(0.3), {BackgroundTransparency=0}):Play()
    task.delay(duration or 2, function()
        TweenService:Create(NF, TweenInfo.new(0.3), {BackgroundTransparency=1}):Play()
        task.wait(0.35); NGui:Destroy()
    end)
end

-- ============================================================
-- STATES
-- ============================================================
local State = {
    God=false, Speed=false, Fly=false,
    Noclip=false, InfJump=false, Disco=false,
    MeshDisco=false, DiscoFog=false,
}
local SpeedVal = 50
local FlyBV    = nil
local SavedPos = nil

-- ============================================================
-- SCROLL FRAME
-- ============================================================
local Scroll = Instance.new("ScrollingFrame", Content)
Scroll.Size = UDim2.fromScale(1, 1)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 140, 0)
Scroll.CanvasSize = UDim2.fromOffset(0, 0)

local ScrollLayout = Instance.new("UIListLayout", Scroll)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Padding = UDim.new(0, 5)

ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.fromOffset(0, ScrollLayout.AbsoluteContentSize.Y + 10)
end)

-- ============================================================
-- PLAYER SECTION
-- ============================================================
MakeSection(Scroll, "🧍 Player")

MakeToggle(Scroll, "God Mode", function(v)
    State.God = v
    if v then
        task.spawn(function()
            while State.God do
                pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end)
                task.wait(0.1)
            end
        end)
    end
    Notify(v and "🛡️ God Mode AN!" or "🛡️ God Mode AUS.")
end)

MakeButton(Scroll, "❤️ Heilen", function()
    local h=GetHum(); if h then h.Health=h.MaxHealth end
    Notify("❤️ HP voll!")
end)

MakeToggle(Scroll, "Speed Hack", function(v)
    State.Speed = v
    Notify(v and "⚡ Speed AN! ("..SpeedVal..")" or "⚡ Speed AUS.")
end)

MakeButton(Scroll, "🔄 Respawnen", function()
    Player:LoadCharacter(); Notify("🔄 Respawned!")
end)

MakeButton(Scroll, "🛸 Floating Pad", function()
    local root=GetRoot(); if not root then return end
    local p=Instance.new("Part",workspace); p.Size=Vector3.new(8,0.4,8)
    p.Anchored=true; p.CanCollide=true; p.Material=Enum.Material.Neon
    p.BrickColor=BrickColor.new("Bright orange")
    p.CFrame=root.CFrame*CFrame.new(0,-4,0)
    task.delay(30, function() pcall(function() p:Destroy() end) end)
    Notify("🛸 Floating Pad erstellt!")
end)

MakeButton(Scroll, "🌈 Disco Character AN/AUS", function()
    State.Disco = not State.Disco
    if State.Disco then
        task.spawn(function()
            while State.Disco do
                pcall(function()
                    local c=GetChar(); if not c then return end
                    for _,p in pairs(c:GetDescendants()) do
                        if p:IsA("BasePart") then
                            p.Color=Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                        end
                    end
                end)
                task.wait(0.15)
            end
        end)
    end
    Notify(State.Disco and "🌈 Disco AN!" or "🌈 Disco AUS.")
end)

-- ============================================================
-- MOVEMENT SECTION
-- ============================================================
MakeSection(Scroll, "🚀 Bewegung  [X=Fly  N=NoClip]")

MakeButton(Scroll, "✈️ Fly AN/AUS  [X]", function()
    State.Fly = not State.Fly
    if State.Fly then
        local root=GetRoot(); if not root then State.Fly=false; return end
        if FlyBV then pcall(function() FlyBV:Destroy() end) end
        FlyBV=Instance.new("BodyVelocity",root)
        FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        Notify("✈️ Fly AN!")
    else
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        Notify("✈️ Fly AUS.")
    end
end)

MakeButton(Scroll, "👻 NoClip AN/AUS  [N]", function()
    State.Noclip = not State.Noclip
    Notify(State.Noclip and "👻 NoClip AN!" or "👻 NoClip AUS.")
end)

MakeToggle(Scroll, "∞ Infinite Jump", function(v)
    State.InfJump = v
    Notify(v and "∞ Jump AN!" or "∞ Jump AUS.")
end)

MakeButton(Scroll, "📍 Position speichern  [T]", function()
    SavedPos=GetRoot() and GetRoot().CFrame; Notify("📍 Gespeichert!")
end)

MakeButton(Scroll, "🔙 Zur Position  [R]", function()
    if SavedPos and GetRoot() then GetRoot().CFrame=SavedPos; Notify("🔙 Teleportiert!")
    else Notify("❌ Keine Position!") end
end)

-- ============================================================
-- SERVER SECTION
-- ============================================================
MakeSection(Scroll, "💥 Server Tools")

MakeButton(Scroll, "🌊 Flood", function()
    local root=GetRoot()
    local p=Instance.new("Part",workspace); p.Size=Vector3.new(4096,1,4096)
    p.Anchored=true; p.CanCollide=true; p.Material=Enum.Material.SmoothPlastic
    p.BrickColor=BrickColor.new("Cyan")
    p.CFrame=CFrame.new(0, root and root.Position.Y-5 or 0, 0)
    Notify("🌊 Flood aktiviert!")
end)

MakeButton(Scroll, "🔓 Unanchor All", function()
    local c=0
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Anchored then
            pcall(function() v.Anchored=false end); c=c+1
        end
    end
    Notify("🔓 "..c.." Parts deanchored!")
end)

MakeButton(Scroll, "🗑️ Clear Terrain", function()
    workspace.Terrain:Clear(); Notify("🗑️ Terrain weg!")
end)

MakeButton(Scroll, "💀 Kill All (lokal)", function()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player then
            pcall(function()
                local h=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if h then h.Health=0 end
            end)
        end
    end
    Notify("💀 Kill All!")
end)

MakeButton(Scroll, "💥 Explosion Spam", function()
    task.spawn(function()
        for _=1,25 do
            pcall(function()
                local e=Instance.new("Explosion",workspace)
                e.Position=Vector3.new(math.random(-200,200),0,math.random(-200,200))
                e.BlastRadius=15; e.BlastPressure=500000
            end)
            task.wait(0.08)
        end
    end)
    Notify("💥 Explosionen!")
end)

MakeButton(Scroll, "📍 Alle zu mir TP", function()
    local root=GetRoot(); if not root then return end
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player then
            pcall(function()
                local r=plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if r then r.CFrame=root.CFrame*CFrame.new(math.random(-4,4),0,math.random(-4,4)) end
            end)
        end
    end
    Notify("📍 Alle zu dir!")
end)

MakeButton(Scroll, "🏗️ Baseplate erstellen", function()
    local p=Instance.new("Part",workspace); p.Name="Baseplate"
    p.Size=Vector3.new(2048,1,2048); p.Anchored=true
    p.BrickColor=BrickColor.new("Medium green"); p.Material=Enum.Material.SmoothPlastic
    p.CFrame=CFrame.new(0,0,0); Notify("🏗️ Baseplate erstellt!")
end)

-- ============================================================
-- SKYBOX / MUSIK SECTION
-- ============================================================
MakeSection(Scroll, "🎵 Skybox / Musik")

-- Skybox Input
local SkyboxID = "158118263"
local SkyInBG = Instance.new("Frame", Scroll)
SkyInBG.Size=UDim2.new(1,0,0,32); SkyInBG.BackgroundColor3=Color3.fromRGB(20,20,35); SkyInBG.BorderSizePixel=0
Instance.new("UICorner",SkyInBG).CornerRadius=UDim.new(0,8)
local SkyBox = Instance.new("TextBox", SkyInBG)
SkyBox.Size=UDim2.fromScale(1,1); SkyBox.BackgroundTransparency=1
SkyBox.PlaceholderText="Skybox/Decal ID (z.B. 158118263)"
SkyBox.PlaceholderColor3=Color3.fromRGB(80,80,110)
SkyBox.Text=""; SkyBox.TextColor3=Color3.new(1,1,1)
SkyBox.Font=Enum.Font.Code; SkyBox.TextSize=13
SkyBox.FocusLost:Connect(function() if SkyBox.Text~="" then SkyboxID=SkyBox.Text end end)

MakeButton(Scroll, "🌌 Skybox setzen", function()
    local sky=Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky",Lighting)
    for _,f in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
        sky[f]="rbxassetid://"..SkyboxID
    end
    Notify("🌌 Skybox ID "..SkyboxID)
end)

MakeButton(Scroll, "🔄 Skybox zurücksetzen", function()
    local sky=Lighting:FindFirstChildOfClass("Sky"); if sky then sky:Destroy() end
    Notify("🔄 Skybox reset.")
end)

-- Musik Input
local MusicID = "142930454"
local MusInBG = Instance.new("Frame", Scroll)
MusInBG.Size=UDim2.new(1,0,0,32); MusInBG.BackgroundColor3=Color3.fromRGB(20,20,35); MusInBG.BorderSizePixel=0
Instance.new("UICorner",MusInBG).CornerRadius=UDim.new(0,8)
local MusBox = Instance.new("TextBox", MusInBG)
MusBox.Size=UDim2.fromScale(1,1); MusBox.BackgroundTransparency=1
MusBox.PlaceholderText="Music ID (z.B. 142930454)"
MusBox.PlaceholderColor3=Color3.fromRGB(80,80,110)
MusBox.Text=""; MusBox.TextColor3=Color3.new(1,1,1)
MusBox.Font=Enum.Font.Code; MusBox.TextSize=13
MusBox.FocusLost:Connect(function() if MusBox.Text~="" then MusicID=MusBox.Text end end)

MakeButton(Scroll, "▶️ Musik starten", function()
    local old=workspace:FindFirstChild("CeliHubMusic"); if old then old:Destroy() end
    local s=Instance.new("Sound",workspace)
    s.Name="CeliHubMusic"; s.SoundId="rbxassetid://"..MusicID
    s.Volume=0.6; s.Looped=true; s:Play()
    Notify("🎵 Musik läuft! ID "..MusicID)
end)

MakeButton(Scroll, "⏹️ Musik stoppen", function()
    local s=workspace:FindFirstChild("CeliHubMusic"); if s then s:Stop(); s:Destroy() end
    Notify("⏹️ Musik gestoppt.")
end)

-- Preset Songs
MakeButton(Scroll, "🎵 Electro Sp00k", function()
    local old=workspace:FindFirstChild("CeliHubMusic"); if old then old:Destroy() end
    local s=Instance.new("Sound",workspace); s.Name="CeliHubMusic"
    s.SoundId="rbxassetid://142930454"; s.Volume=0.6; s.Looped=true; s:Play()
    Notify("🎵 Electro Sp00k läuft!")
end)

MakeButton(Scroll, "🎵 Wonga", function()
    local old=workspace:FindFirstChild("CeliHubMusic"); if old then old:Destroy() end
    local s=Instance.new("Sound",workspace); s.Name="CeliHubMusic"
    s.SoundId="rbxassetid://130768996"; s.Volume=0.6; s.Looped=true; s:Play()
    Notify("🎵 Wonga läuft!")
end)

MakeButton(Scroll, "😱 Scream", function()
    local old=workspace:FindFirstChild("CeliHubMusic"); if old then old:Destroy() end
    local s=Instance.new("Sound",workspace); s.Name="CeliHubMusic"
    s.SoundId="rbxassetid://26120219"; s.Volume=0.6; s.Looped=true; s:Play()
    Notify("😱 Scream läuft!")
end)

-- ============================================================
-- MISC SECTION
-- ============================================================
MakeSection(Scroll, "🔧 Misc")

MakeToggle(Scroll, "🌈 Disco Fog", function(v)
    State.DiscoFog=v
    if v then
        task.spawn(function()
            while State.DiscoFog do
                pcall(function()
                    Lighting.FogColor=Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                    Lighting.FogEnd=math.random(40,180); Lighting.FogStart=0
                end)
                task.wait(0.2)
            end
        end)
    else pcall(function() Lighting.FogEnd=100000 end) end
    Notify(v and "🌈 Disco Fog AN!" or "🌈 Disco Fog AUS.")
end)

MakeButton(Scroll, "🌅 Mitternacht", function()
    pcall(function() Lighting.TimeOfDay="00:00:00" end); Notify("🌅 Mitternacht!")
end)
MakeButton(Scroll, "☀️ Mittag", function()
    pcall(function() Lighting.TimeOfDay="12:00:00" end); Notify("☀️ Mittag!")
end)

MakeButton(Scroll, "🔄 Rejoin", function()
    Notify("🔄 Rejoining..."); task.wait(1)
    pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, Player) end)
end)

MakeButton(Scroll, "🛑 ALLES AUS  [F5]", function()
    State.God=false; State.Speed=false; State.Fly=false
    State.Noclip=false; State.InfJump=false; State.Disco=false
    State.MeshDisco=false; State.DiscoFog=false
    if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
    pcall(function() Lighting.FogEnd=100000 end)
    Notify("🛑 Alles deaktiviert!")
end)

-- ============================================================
-- GAME LOOPS
-- ============================================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        local root=GetRoot(); local hum=GetHum(); if not root then return end
        if State.Speed and hum and hum.MoveDirection.Magnitude>0 then
            local v=hum.MoveDirection*SpeedVal
            root.Velocity=Vector3.new(v.X, root.Velocity.Y, v.Z)
        end
        if State.Fly and FlyBV and FlyBV.Parent then
            local d=Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then d+=Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then d-=Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then d-=Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then d+=Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then d+=Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d-=Vector3.yAxis end
            FlyBV.Velocity = d.Magnitude>0 and d.Unit*60 or Vector3.zero
        end
        if State.Noclip and GetChar() then
            for _,p in pairs(GetChar():GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=false end
            end
        end
        if State.God and hum then hum.Health=hum.MaxHealth end
    end)
end)

UserInputService.InputBegan:Connect(function(inp, gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.X then
        State.Fly=not State.Fly
        if State.Fly then
            local root=GetRoot(); if not root then State.Fly=false; return end
            if FlyBV then pcall(function() FlyBV:Destroy() end) end
            FlyBV=Instance.new("BodyVelocity",root)
            FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        else
            if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        end
    end
    if inp.KeyCode==Enum.KeyCode.N then State.Noclip=not State.Noclip end
    if inp.KeyCode==Enum.KeyCode.T then SavedPos=GetRoot() and GetRoot().CFrame end
    if inp.KeyCode==Enum.KeyCode.R and SavedPos and GetRoot() then GetRoot().CFrame=SavedPos end
    if inp.KeyCode==Enum.KeyCode.F5 then
        State.God=false; State.Speed=false; State.Fly=false
        State.Noclip=false; State.InfJump=false; State.Disco=false
        State.MeshDisco=false; State.DiscoFog=false
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        pcall(function() Lighting.FogEnd=100000 end)
        Notify("🛑 ALLES AUS! (F5)")
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump then
        local h=GetHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

Notify("🟠 CeliHub c00lgui Edition geladen! ✅", 4)
