-- ============================================================
-- CeliHub | c00lgui Edition 🟠
-- Made by Celi 💫
-- FIXED v2: Kein GetObjects, kein InsertService — alles lokal
-- ============================================================

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local SoundService     = game:GetService("SoundService")

local Player    = Players.LocalPlayer
local Camera    = workspace.CurrentCamera

local function GetChar()  return Player.Character end
local function GetHum()   local c=GetChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot()  local c=GetChar(); return c and c:FindFirstChild("HumanoidRootPart") end

-- ============================================================
-- States
-- ============================================================
local State = {
    God=false, Invis=false, Speed=false, Fly=false,
    Noclip=false, InfJump=false, Disco=false,
    MeshDisco=false, DiscoFog=false, AntiMon=false,
}
local SpeedVal = 50
local FlyBV    = nil

-- ============================================================
-- Rayfield laden
-- ============================================================
local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
end)
if not ok or not Rayfield then
    -- Fallback: einfaches GUI wenn Rayfield ned lädt
    warn("[CeliHub c00lgui] Rayfield Fehler: " .. tostring(Rayfield))
    return
end

local Window = Rayfield:CreateWindow({
    Name            = "CeliHub 🟠  |  c00lgui Edition",
    LoadingTitle    = "CeliHub c00lgui",
    LoadingSubtitle = "Made by Celi 💫",
    ConfigurationSaving = {Enabled = true, FolderName = "CeliHub_c00lgui"},
    KeySystem       = false,
})

local function N(t, c, d)
    pcall(function() Rayfield:Notify({Title=tostring(t), Content=tostring(c), Duration=d or 3}) end)
end

-- ============================================================
-- TABS
-- ============================================================
local TabSet   = Window:CreateTab("⚙️ Settings",    4483362458)
local TabPlay  = Window:CreateTab("🧍 Player",      4483362458)
local TabMove  = Window:CreateTab("🚀 Speed/Fly",   4483362458)
local TabServ  = Window:CreateTab("💥 Server",      4483362458)
local TabSky   = Window:CreateTab("🎵 Sky/Music",   4483362458)
local TabMisc  = Window:CreateTab("🔧 Misc",        4483362458)

-- ============================================================
-- SETTINGS TAB
-- ============================================================
TabSet:CreateSection("🆔 Werte einstellen")

local SkyboxID      = "158118263"
local MusicID       = "142930454"
local MusicPitch    = 1
local BBText        = "CeliHub"
local CustomName    = ""
local ChatSpamText  = ""
local AntiRange     = 20
local LeaderName    = ""
local LeaderAmount  = 0

TabSet:CreateInput({
    Name="🌌 Skybox/Decal ID", PlaceholderText="158118263",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) if v~="" then SkyboxID=v end end
})
TabSet:CreateInput({
    Name="🎵 Music ID", PlaceholderText="142930454",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) if v~="" then MusicID=v end end
})
TabSet:CreateSlider({
    Name="🎵 Music Pitch", Range={0,3}, Increment=0.1, CurrentValue=1,
    Callback=function(v) MusicPitch=v end
})
TabSet:CreateInput({
    Name="💬 Billboard Text", PlaceholderText="CeliHub",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) if v~="" then BBText=v end end
})
TabSet:CreateInput({
    Name="📛 Eigener Name (lokal)", PlaceholderText="Dein Name...",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) CustomName=v end
})
TabSet:CreateSlider({
    Name="🏃 Speed Wert", Range={1,500}, Increment=1, CurrentValue=50,
    Callback=function(v) SpeedVal=v end
})
TabSet:CreateSlider({
    Name="🛡️ Anti-Range (Studs)", Range={5,200}, Increment=5, CurrentValue=20,
    Callback=function(v) AntiRange=v end
})
TabSet:CreateInput({
    Name="💬 Chat Spam Text", PlaceholderText="Text...",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) ChatSpamText=v end
})
TabSet:CreateInput({
    Name="📊 Leaderstat Name", PlaceholderText="Cash",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) LeaderName=v end
})
TabSet:CreateInput({
    Name="📊 Leaderstat Betrag", PlaceholderText="1000",
    RemoveTextAfterFocusLost=false,
    Callback=function(v) LeaderAmount=tonumber(v) or 0 end
})

-- ============================================================
-- PLAYER TAB
-- ============================================================
TabPlay:CreateSection("🛡️ Basics")

TabPlay:CreateToggle({Name="🛡️ God Mode", CurrentValue=false, Callback=function(v)
    State.God=v
    if v then
        task.spawn(function()
            while State.God do
                pcall(function()
                    local h=GetHum(); if h then h.Health=h.MaxHealth end
                end)
                task.wait(0.08)
            end
        end)
    end
    N("🛡️ God Mode", v and "AN!" or "AUS.", 2)
end})

TabPlay:CreateToggle({Name="👻 Unsichtbar (lokal)", CurrentValue=false, Callback=function(v)
    State.Invis=v
    pcall(function()
        local c=GetChar(); if not c then return end
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
                p.LocalTransparencyModifier = v and 1 or 0
            end
        end
    end)
    N("👻 Unsichtbar", v and "AN!" or "AUS.", 2)
end})

TabPlay:CreateButton({Name="❤️ Heilen (voll)", Callback=function()
    pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end)
    N("❤️ Heal","HP voll!",2)
end})

TabPlay:CreateButton({Name="🔄 Respawnen", Callback=function()
    Player:LoadCharacter(); N("🔄","Respawned!",2)
end})

TabPlay:CreateSection("💬 Name & Billboard")

TabPlay:CreateButton({Name="💬 Billboard setzen", Callback=function()
    pcall(function()
        local head=GetChar() and GetChar():FindFirstChild("Head"); if not head then return end
        local old=head:FindFirstChild("CeliHubBB"); if old then old:Destroy() end
        local bb=Instance.new("BillboardGui", head)
        bb.Name="CeliHubBB"; bb.Size=UDim2.fromOffset(220,50)
        bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true
        local lbl=Instance.new("TextLabel",bb)
        lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1
        lbl.Text=BBText; lbl.TextColor3=Color3.fromRGB(255,140,0)
        lbl.Font=Enum.Font.GothamBold; lbl.TextSize=18; lbl.TextStrokeTransparency=0.3
    end)
    N("💬","Billboard: '"..BBText.."'",3)
end})

TabPlay:CreateButton({Name="📛 Name ändern (lokal)", Callback=function()
    if CustomName=="" then N("❌","Name in Settings eingeben!",3); return end
    pcall(function()
        local c=GetChar(); if not c then return end
        local head=c:FindFirstChild("Head"); if not head then return end
        local old=head:FindFirstChild("CeliNameTag"); if old then old:Destroy() end
        local hum=GetHum()
        if hum then hum.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None end
        local bb=Instance.new("BillboardGui",head)
        bb.Name="CeliNameTag"; bb.Size=UDim2.fromOffset(200,40)
        bb.StudsOffset=Vector3.new(0,2.5,0); bb.AlwaysOnTop=true
        local lbl=Instance.new("TextLabel",bb)
        lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1
        lbl.Text=CustomName; lbl.TextColor3=Color3.new(1,1,1)
        lbl.Font=Enum.Font.GothamBold; lbl.TextSize=16; lbl.TextStrokeTransparency=0.3
    end)
    N("📛","Name: '"..CustomName.."'",3)
end})

TabPlay:CreateSection("🎨 Charakter Effekte")

TabPlay:CreateToggle({Name="🌈 Disco Character", CurrentValue=false, Callback=function(v)
    State.Disco=v
    if v then
        task.spawn(function()
            while State.Disco do
                pcall(function()
                    local c=GetChar(); if not c then return end
                    for _, p in pairs(c:GetDescendants()) do
                        if p:IsA("BasePart") then
                            p.Color=Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                        end
                    end
                end)
                task.wait(0.15)
            end
        end)
    end
    N("🌈 Disco", v and "AN!" or "AUS.", 2)
end})

TabPlay:CreateToggle({Name="🔆 Mesh Disco", CurrentValue=false, Callback=function(v)
    State.MeshDisco=v
    if v then
        task.spawn(function()
            while State.MeshDisco do
                pcall(function()
                    local c=GetChar(); if not c then return end
                    for _, p in pairs(c:GetDescendants()) do
                        if p:IsA("SpecialMesh") then
                            p.Scale=Vector3.new(math.random(80,130)/100, math.random(80,130)/100, math.random(80,130)/100)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
    N("🔆 Mesh Disco", v and "AN!" or "AUS.", 2)
end})

TabPlay:CreateButton({Name="🟠 Farbe Orange machen", Callback=function()
    pcall(function()
        local c=GetChar(); if not c then return end
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.Color=Color3.fromRGB(255,140,0) end
        end
    end)
    N("🟠","Charakter orange!",2)
end})

TabPlay:CreateButton({Name="🔵 Farbe zurücksetzen", Callback=function()
    pcall(function() Player:LoadCharacter() end)
    N("🔵","Reset...",2)
end})

TabPlay:CreateButton({Name="🛸 Floating Pad", Callback=function()
    pcall(function()
        local root=GetRoot(); if not root then return end
        local pad=Instance.new("Part",workspace)
        pad.Size=Vector3.new(8,0.4,8); pad.Anchored=true; pad.CanCollide=true
        pad.BrickColor=BrickColor.new("Bright orange"); pad.Material=Enum.Material.Neon
        pad.CFrame=root.CFrame*CFrame.new(0,-4,0)
        task.delay(30, function() pcall(function() pad:Destroy() end) end)
    end)
    N("🛸","Floating Pad erstellt! (30s)",3)
end})

TabPlay:CreateSection("🛡️ Anti-Robloxian")

TabPlay:CreateToggle({Name="🛡️ Anti-Robloxian Monitor", CurrentValue=false, Callback=function(v)
    State.AntiMon=v
    if v then
        task.spawn(function()
            while State.AntiMon do
                pcall(function()
                    local root=GetRoot(); if not root then return end
                    for _, plr in pairs(Players:GetPlayers()) do
                        if plr~=Player and plr.Character then
                            local r=plr.Character:FindFirstChild("HumanoidRootPart")
                            if r then
                                local d=(root.Position-r.Position).Magnitude
                                if d<AntiRange then
                                    N("⚠️ Anti", plr.Name.." zu nah! "..math.floor(d).."m", 2)
                                end
                            end
                        end
                    end
                end)
                task.wait(1.5)
            end
        end)
    end
    N("🛡️ Anti-Mon", v and "AN! Range: "..AntiRange or "AUS.", 3)
end})

-- ============================================================
-- SPEED / FLY TAB
-- ============================================================
TabMove:CreateSection("🏃 Speed & Fly")

TabMove:CreateToggle({Name="⚡ Speed Hack", CurrentValue=false, Callback=function(v)
    State.Speed=v; N("⚡ Speed", v and "AN! Wert: "..SpeedVal or "AUS.", 2)
end})

TabMove:CreateButton({Name="✈️ Fly AN/AUS  [X]", Callback=function()
    State.Fly=not State.Fly
    if State.Fly then
        local root=GetRoot()
        if not root then State.Fly=false; return end
        if FlyBV then pcall(function() FlyBV:Destroy() end) end
        FlyBV=Instance.new("BodyVelocity",root)
        FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        N("✈️ Fly","AN! WASD + Space/Shift",3)
    else
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        N("✈️ Fly","AUS.",2)
    end
end})

TabMove:CreateButton({Name="👻 NoClip AN/AUS  [N]", Callback=function()
    State.Noclip=not State.Noclip
    N("👻 NoClip", State.Noclip and "AN!" or "AUS.", 2)
end})

TabMove:CreateToggle({Name="∞ Infinite Jump", CurrentValue=false, Callback=function(v)
    State.InfJump=v; N("∞ Jump", v and "AN!" or "AUS.", 2)
end})

TabMove:CreateSection("⌨️ Keybinds")
TabMove:CreateParagraph({Title="Keybinds", Content="X  →  Fly AN/AUS\nN  →  NoClip AN/AUS\nT  →  Position speichern\nR  →  Zur Position\nF5 →  ALLES AUS"})

-- Position speichern
local SavedPos = nil
TabMove:CreateButton({Name="📍 Position speichern  [T]", Callback=function()
    SavedPos=GetRoot() and GetRoot().CFrame; N("📍","Gespeichert!",2)
end})
TabMove:CreateButton({Name="🔙 Zur Position  [R]", Callback=function()
    if SavedPos and GetRoot() then GetRoot().CFrame=SavedPos; N("🔙","Teleportiert!",2)
    else N("❌","Nichts gespeichert!",3) end
end})

-- ============================================================
-- Heartbeat: Speed / Fly / NoClip / God
-- ============================================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        local root=GetRoot(); local hum=GetHum(); if not root then return end
        if State.Speed and hum and hum.MoveDirection.Magnitude>0 then
            local v=hum.MoveDirection*(SpeedVal)
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
            FlyBV.Velocity=d.Magnitude>0 and d.Unit*60 or Vector3.zero
        end
        if State.Noclip and GetChar() then
            for _, p in pairs(GetChar():GetDescendants()) do
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
            local root=GetRoot()
            if not root then State.Fly=false; return end
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
        State.God=false; State.Fly=false; State.Noclip=false
        State.Speed=false; State.InfJump=false; State.Disco=false
        State.MeshDisco=false; State.DiscoFog=false
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        pcall(function() Lighting.FogEnd=100000 end)
        N("🛑 NOTFALL","Alles AUS!",4)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump then
        local h=GetHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ============================================================
-- SERVER TAB
-- ============================================================
TabServ:CreateSection("💥 Server Tools")

TabServ:CreateButton({Name="🌊 Flood", Callback=function()
    pcall(function()
        local root=GetRoot()
        local p=Instance.new("Part",workspace)
        p.Size=Vector3.new(4096,1,4096); p.Anchored=true; p.CanCollide=true
        p.Material=Enum.Material.SmoothPlastic; p.BrickColor=BrickColor.new("Cyan")
        p.CFrame=CFrame.new(0, root and root.Position.Y-5 or 0, 0)
    end)
    N("🌊 Flood","Aktiviert!",3)
end})

TabServ:CreateButton({Name="🔓 Unanchor All", Callback=function()
    local c=0
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Anchored then
            pcall(function() v.Anchored=false end); c=c+1
        end
    end
    N("🔓","Deanchored: "..c.." Parts",3)
end})

TabServ:CreateButton({Name="🗑️ Clear Terrain", Callback=function()
    workspace.Terrain:Clear(); N("🗑️","Terrain weg!",3)
end})

TabServ:CreateButton({Name="🌌 Skybox setzen", Callback=function()
    pcall(function()
        local li=Lighting
        local sky=li:FindFirstChildOfClass("Sky") or Instance.new("Sky",li)
        for _,f in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
            sky[f]="rbxassetid://"..SkyboxID
        end
    end)
    N("🌌","Skybox ID "..SkyboxID,3)
end})

TabServ:CreateButton({Name="🔄 Skybox zurücksetzen", Callback=function()
    pcall(function()
        local sky=Lighting:FindFirstChildOfClass("Sky"); if sky then sky:Destroy() end
    end)
    N("🔄","Skybox reset.",2)
end})

TabServ:CreateButton({Name="🖼️ Decal Spam (20)", Callback=function()
    task.spawn(function()
        for _=1,20 do
            pcall(function()
                local p=Instance.new("Part",workspace); p.Anchored=true; p.CanCollide=false
                p.Size=Vector3.new(20,20,1)
                p.CFrame=CFrame.new(math.random(-300,300),math.random(5,40),math.random(-300,300))
                Instance.new("Decal",p).Texture="rbxassetid://"..SkyboxID
            end)
            task.wait(0.05)
        end
    end)
    N("🖼️","20 Decals!",3)
end})

TabServ:CreateButton({Name="💀 Kill All (lokal)", Callback=function()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player then
            pcall(function()
                local h=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
                if h then h.Health=0 end
            end)
        end
    end
    N("💀","Kill All!",3)
end})

TabServ:CreateButton({Name="💥 Explosion Spam", Callback=function()
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
    N("💥","Explosionen!",3)
end})

TabServ:CreateButton({Name="📍 Alle zu mir TP", Callback=function()
    local root=GetRoot(); if not root then return end
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player then
            pcall(function()
                local r=plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if r then r.CFrame=root.CFrame*CFrame.new(math.random(-4,4),0,math.random(-4,4)) end
            end)
        end
    end
    N("📍","Alle zu dir!",3)
end})

TabServ:CreateButton({Name="🏗️ Baseplate", Callback=function()
    local p=Instance.new("Part",workspace); p.Name="Baseplate"
    p.Size=Vector3.new(2048,1,2048); p.Anchored=true
    p.BrickColor=BrickColor.new("Medium green"); p.Material=Enum.Material.SmoothPlastic
    p.CFrame=CFrame.new(0,0,0); N("🏗️","Baseplate erstellt!",3)
end})

TabServ:CreateButton({Name="🌐 Server Info", Callback=function()
    N("👥 Spieler", #Players:GetPlayers().." online", 3)
    task.wait(0.3)
    N("🎮 PlaceId", tostring(game.PlaceId), 4)
    task.wait(0.3)
    local priv=game.PrivateServerId~=nil and game.PrivateServerId~=""
    N("🔒 Server", priv and "Privat" or "Öffentlich", 3)
end})

-- ============================================================
-- SKYBOX / MUSIC TAB
-- ============================================================
TabSky:CreateSection("🎵 Musik")

TabSky:CreateButton({Name="▶️ Musik starten", Callback=function()
    pcall(function()
        local old=workspace:FindFirstChild("CeliHubMusic"); if old then old:Destroy() end
        local s=Instance.new("Sound",workspace)
        s.Name="CeliHubMusic"; s.SoundId="rbxassetid://"..MusicID
        s.PlaybackSpeed=MusicPitch; s.Volume=0.6; s.Looped=true; s:Play()
    end)
    N("🎵","Spielt ID "..MusicID,4)
end})

TabSky:CreateButton({Name="⏹️ Musik stoppen", Callback=function()
    pcall(function()
        local s=workspace:FindFirstChild("CeliHubMusic"); if s then s:Stop(); s:Destroy() end
    end)
    N("⏹️","Gestoppt.",2)
end})

TabSky:CreateSection("🎵 Preset Songs")
local SONGS = {
    {"🎵 Electro Sp00k","142930454"},
    {"🎵 Wonga",        "130768996"},
    {"🎵 Chop Suey",    "143666548"},
    {"😱 Scream",       "26120219"},
    {"🎵 Never Gonna",  "130860862"},
}
for _,m in ipairs(SONGS) do
    local lbl,id=m[1],m[2]
    TabSky:CreateButton({Name=lbl, Callback=function()
        pcall(function()
            local old=workspace:FindFirstChild("CeliHubMusic"); if old then old:Destroy() end
            local s=Instance.new("Sound",workspace)
            s.Name="CeliHubMusic"; s.SoundId="rbxassetid://"..id
            s.PlaybackSpeed=MusicPitch; s.Volume=0.6; s.Looped=true; s:Play()
        end)
        N("🎵",lbl.." spielt!",3)
    end})
end

TabSky:CreateSection("🌌 Preset Skyboxes")
local SKYBOXES = {
    {"🚂 Thomas",   "1081367"},
    {"😎 c00lkidd", "48294733"},
    {"🌅 Sunset",   "159754040"},
    {"🌌 Night",    "159908636"},
}
for _,s in ipairs(SKYBOXES) do
    local lbl,id=s[1],s[2]
    TabSky:CreateButton({Name=lbl, Callback=function()
        pcall(function()
            local sky=Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky",Lighting)
            for _,f in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
                sky[f]="rbxassetid://"..id
            end
        end)
        N("🌌",lbl.." gesetzt!",3)
    end})
end

-- ============================================================
-- MISC TAB
-- ============================================================
TabMisc:CreateSection("🔧 Misc")

TabMisc:CreateToggle({Name="🌈 Disco Fog", CurrentValue=false, Callback=function(v)
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
    N("🌈 Disco Fog", v and "AN!" or "AUS.", 2)
end})

TabMisc:CreateButton({Name="🌅 Mitternacht", Callback=function()
    pcall(function() Lighting.TimeOfDay="00:00:00" end); N("🌅","Mitternacht!",2)
end})
TabMisc:CreateButton({Name="☀️ Mittag", Callback=function()
    pcall(function() Lighting.TimeOfDay="12:00:00" end); N("☀️","Mittag!",2)
end})

TabMisc:CreateButton({Name="💬 Chat Spam (10x)", Callback=function()
    if ChatSpamText=="" then N("❌","Chat Spam Text eingeben!",3); return end
    task.spawn(function()
        for _=1,10 do
            pcall(function()
                local rs=game:GetService("ReplicatedStorage")
                local ch=rs:FindFirstChild("DefaultChatSystemChatEvents")
                if ch then
                    local say=ch:FindFirstChild("SayMessageRequest")
                    if say then say:FireServer(ChatSpamText,"All") end
                end
            end)
            task.wait(0.6)
        end
    end)
    N("💬","'"..ChatSpamText.."' gespammt!",3)
end})

TabMisc:CreateButton({Name="📊 Leaderstat +", Callback=function()
    if LeaderName=="" then N("❌","Leaderstat Name eingeben!",3); return end
    pcall(function()
        local ls=Player:FindFirstChild("leaderstats") or Instance.new("Folder",Player)
        ls.Name="leaderstats"
        local stat=ls:FindFirstChild(LeaderName) or Instance.new("IntValue",ls)
        stat.Name=LeaderName; stat.Value=(stat.Value or 0)+LeaderAmount
    end)
    N("📊","+"..LeaderAmount.." "..LeaderName,3)
end})

TabMisc:CreateButton({Name="📊 Leaderstat setzen", Callback=function()
    if LeaderName=="" then N("❌","Leaderstat Name eingeben!",3); return end
    pcall(function()
        local ls=Player:FindFirstChild("leaderstats")
        if ls then
            local stat=ls:FindFirstChild(LeaderName)
            if stat then stat.Value=LeaderAmount end
        end
    end)
    N("📊",LeaderName.." = "..LeaderAmount,3)
end})

TabMisc:CreateButton({Name="🔄 Rejoin", Callback=function()
    N("🔄","Rejoining...",2); task.wait(1)
    pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, Player) end)
end})

TabMisc:CreateButton({Name="🛑 ALLES AUS  [F5]", Callback=function()
    State.God=false; State.Fly=false; State.Noclip=false
    State.Speed=false; State.InfJump=false; State.Disco=false
    State.MeshDisco=false; State.DiscoFog=false; State.AntiMon=false
    if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
    pcall(function() Lighting.FogEnd=100000 end)
    N("🛑","Alles deaktiviert!",4)
end})

TabMisc:CreateParagraph({
    Title="🟠 CeliHub | c00lgui Edition",
    Content="Basiert auf c00lgui Reborn\nKomplett neu gebaut — alle Bugs gefixt\nMade by Celi 💫\n\nFixes:\n✅ Kein GetObjects mehr\n✅ Kein InsertService\n✅ Skybox in Lighting\n✅ Fly/Speed/NoClip funktionieren\n✅ F5 Notfall-Stop"
})

N("🟠 CeliHub","c00lgui Edition geladen! ✅",5)
