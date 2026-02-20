- ============================================================
-- CeliHub | DEV VERSION 🔧
-- Made by Celi 💫
-- ⚠️  NUR FÜR TESTER & EARLY ACCESS MITGLIEDER ⚠️
-- Kein Key benötigt!
-- ============================================================

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local InsertService    = game:GetService("InsertService")

local Player    = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ============================================================
-- DEV SPLASH SCREEN (kein Key, aber cooler Dev-Screen)
-- ============================================================
local function ShowDevSplash()
    local old = PlayerGui:FindFirstChild("CeliDevSplash")
    if old then old:Destroy() end

    local SGui = Instance.new("ScreenGui")
    SGui.Name="CeliDevSplash"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui

    local function tw(obj,props,t,s,d)
        pcall(function()
            TweenService:Create(obj,TweenInfo.new(t or 0.3,s or Enum.EasingStyle.Quart,d or Enum.EasingDirection.Out),props):Play()
        end)
    end

    local BG=Instance.new("Frame",SGui)
    BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0)
    BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.35},0.5)

    -- Grüne Partikel (Dev-Farbe)
    for i=1,16 do
        local dot=Instance.new("Frame",BG)
        dot.Size=UDim2.fromOffset(math.random(3,7),math.random(3,7))
        dot.Position=UDim2.fromScale(math.random()*0.95,math.random()*0.95)
        dot.BackgroundColor3=({
            Color3.fromRGB(0,220,100), Color3.fromRGB(255,140,0),
            Color3.fromRGB(0,180,255), Color3.fromRGB(200,0,255)
        })[math.random(1,4)]
        dot.BackgroundTransparency=math.random(40,75)/100
        dot.BorderSizePixel=0; dot.ZIndex=1
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                task.wait(math.random(2,6))
                if not(dot and dot.Parent) then break end
                tw(dot,{
                    Position=UDim2.fromScale(math.clamp(dot.Position.X.Scale+math.random(-12,12)/100,0.02,0.98), math.clamp(dot.Position.Y.Scale+math.random(-12,12)/100,0.02,0.98)),
                    BackgroundTransparency=math.random(30,80)/100
                },math.random(2,6),Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
            end
        end)
    end

    local Card=Instance.new("Frame",BG)
    Card.Size=UDim2.fromOffset(500,310)
    Card.Position=UDim2.new(0.5,-250,0.5,-155)
    Card.BackgroundColor3=Color3.fromRGB(10,10,18)
    Card.BackgroundTransparency=1; Card.BorderSizePixel=0; Card.ZIndex=2
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,20)

    local CS=Instance.new("UIStroke",Card)
    CS.Color=Color3.fromRGB(0,220,100); CS.Thickness=1.8; CS.Transparency=0.4

    tw(Card,{BackgroundTransparency=0},0.5)

    -- Pulsierender Dev-Glow
    task.spawn(function()
        while Card and Card.Parent do
            task.wait(1.2); if not(Card and Card.Parent) then break end
            tw(CS,{Transparency=0.05,Color=Color3.fromRGB(0,255,120)},1.2,Enum.EasingStyle.Sine)
            task.wait(1.2); if not(Card and Card.Parent) then break end
            tw(CS,{Transparency=0.6,Color=Color3.fromRGB(0,180,80)},1.2,Enum.EasingStyle.Sine)
        end
    end)

    -- Grüner Top-Balken
    local TopBar=Instance.new("Frame",Card)
    TopBar.Size=UDim2.new(0,0,0,3); TopBar.BackgroundColor3=Color3.fromRGB(0,220,100)
    TopBar.BorderSizePixel=0; TopBar.ZIndex=4
    Instance.new("UICorner",TopBar).CornerRadius=UDim.new(0,20)
    task.delay(0.15,function() tw(TopBar,{Size=UDim2.new(1,0,0,3)},0.6) end)

    -- DEV Badge oben rechts
    local Badge=Instance.new("Frame",Card)
    Badge.Size=UDim2.fromOffset(110,28); Badge.Position=UDim2.fromOffset(376,12)
    Badge.BackgroundColor3=Color3.fromRGB(0,180,80); Badge.BorderSizePixel=0; Badge.ZIndex=5
    Instance.new("UICorner",Badge).CornerRadius=UDim.new(0,8)
    local BadgeL=Instance.new("TextLabel",Badge)
    BadgeL.Size=UDim2.fromScale(1,1); BadgeL.BackgroundTransparency=1
    BadgeL.Text="🔧 DEV BUILD"; BadgeL.TextColor3=Color3.new(1,1,1)
    BadgeL.Font=Enum.Font.GothamBold; BadgeL.TextSize=11; BadgeL.ZIndex=6
    Badge.BackgroundTransparency=1; tw(Badge,{BackgroundTransparency=0},0.5)

    -- Titel
    local Title=Instance.new("TextLabel",Card)
    Title.Size=UDim2.fromOffset(500,50); Title.Position=UDim2.fromOffset(0,18)
    Title.BackgroundTransparency=1; Title.Text="🔧  CELIHUB  DEV"
    Title.TextColor3=Color3.new(1,1,1); Title.Font=Enum.Font.GothamBold; Title.TextSize=30
    Title.ZIndex=3; Title.TextTransparency=1
    task.delay(0.1,function() tw(Title,{TextTransparency=0},0.4) end)

    local Sub=Instance.new("TextLabel",Card)
    Sub.Size=UDim2.fromOffset(500,20); Sub.Position=UDim2.fromOffset(0,66)
    Sub.BackgroundTransparency=1; Sub.Text="Made by Celi 💫  •  Nur für Early Access Tester"
    Sub.TextColor3=Color3.fromRGB(80,200,120); Sub.Font=Enum.Font.Gotham; Sub.TextSize=13
    Sub.ZIndex=3; Sub.TextTransparency=1
    task.delay(0.15,function() tw(Sub,{TextTransparency=0},0.4) end)

    -- Divider
    local Div=Instance.new("Frame",Card); Div.Size=UDim2.new(0,0,0,1)
    Div.Position=UDim2.fromOffset(20,96); Div.BackgroundColor3=Color3.fromRGB(30,60,40)
    Div.BorderSizePixel=0; Div.ZIndex=3
    task.delay(0.2,function() tw(Div,{Size=UDim2.new(1,-40,0,1)},0.5) end)

    -- Early Access Info Box
    local InfoBG=Instance.new("Frame",Card)
    InfoBG.Size=UDim2.fromOffset(460,100); InfoBG.Position=UDim2.fromOffset(20,108)
    InfoBG.BackgroundColor3=Color3.fromRGB(0,30,15); InfoBG.BorderSizePixel=0; InfoBG.ZIndex=3
    Instance.new("UICorner",InfoBG).CornerRadius=UDim.new(0,12)
    Instance.new("UIStroke",InfoBG).Color=Color3.fromRGB(0,100,50)

    local InfoL=Instance.new("TextLabel",InfoBG)
    InfoL.Size=UDim2.fromOffset(440,90); InfoL.Position=UDim2.fromOffset(10,5)
    InfoL.BackgroundTransparency=1
    InfoL.Text="⚠️  DU BIST IN DER DEV VERSION\n\n✅  Kein Key benötigt\n🔧  Experimentelle Features\n⚡  Early Access — Bugs möglich\n🔒  Nicht weitergeben!"
    InfoL.TextColor3=Color3.fromRGB(0,220,100); InfoL.Font=Enum.Font.GothamBold
    InfoL.TextSize=13; InfoL.TextWrapped=true; InfoL.ZIndex=4
    InfoL.TextXAlignment=Enum.TextXAlignment.Left; InfoL.TextYAlignment=Enum.TextYAlignment.Top

    -- Version Label
    local VerL=Instance.new("TextLabel",Card)
    VerL.Size=UDim2.fromOffset(500,20); VerL.Position=UDim2.fromOffset(0,218)
    VerL.BackgroundTransparency=1; VerL.Text="Version: DEV-2026.02  •  Build #007  •  Early Access"
    VerL.TextColor3=Color3.fromRGB(40,140,70); VerL.Font=Enum.Font.Code; VerL.TextSize=12; VerL.ZIndex=3

    -- Start Button (grün)
    local BtnF=Instance.new("Frame",Card)
    BtnF.Size=UDim2.fromOffset(460,48); BtnF.Position=UDim2.fromOffset(20,248)
    BtnF.BackgroundColor3=Color3.fromRGB(0,160,70); BtnF.BorderSizePixel=0; BtnF.ZIndex=3
    Instance.new("UICorner",BtnF).CornerRadius=UDim.new(0,13)

    local BtnT=Instance.new("TextButton",BtnF)
    BtnT.Size=UDim2.fromScale(1,1); BtnT.BackgroundTransparency=1
    BtnT.Text="🔧  DEV VERSION STARTEN  →"
    BtnT.TextColor3=Color3.new(1,1,1); BtnT.Font=Enum.Font.GothamBold; BtnT.TextSize=16; BtnT.ZIndex=4

    BtnT.MouseEnter:Connect(function() tw(BtnF,{BackgroundColor3=Color3.fromRGB(0,200,90)},0.12) end)
    BtnT.MouseLeave:Connect(function() tw(BtnF,{BackgroundColor3=Color3.fromRGB(0,160,70)},0.12) end)

    local started=false
    BtnT.MouseButton1Click:Connect(function()
        if started then return end; started=true
        BtnT.Text="✅  Lade Dev Build..."
        tw(BtnF,{BackgroundColor3=Color3.fromRGB(30,180,80)},0.3)
        tw(CS,{Color=Color3.fromRGB(0,255,120),Transparency=0},0.3)
        task.wait(0.8)
        tw(Card,{BackgroundTransparency=1},0.3)
        tw(BG,{BackgroundTransparency=1},0.35)
        task.wait(0.4)
        SGui:Destroy()
    end)

    repeat task.wait(0.1) until started or not SGui.Parent
end

-- ============================================================
-- STATE
-- ============================================================
local State = {
    GodMode=false, Fly=false, Noclip=false, Speed=false,
    InfJump=false, Disco=false, Rainbow=false, ESP=false,
    ESPChams=false, ESPNames=false, ESPTracers=false,
    Aimbot=false, AimbotFOV=120, AimbotSmooth=0,
}

local SpeedMult = 2
local FlyBV     = nil
local ESPObjs   = {}

local function GetChar()  return Player.Character end
local function GetRoot()  return GetChar() and GetChar():FindFirstChild("HumanoidRootPart") end
local function GetHum()   return GetChar() and GetChar():FindFirstChildOfClass("Humanoid") end
local Camera = workspace.CurrentCamera

-- ============================================================
-- Rayfield laden
-- ============================================================
ShowDevSplash()

local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
end)
if not ok or not Rayfield then warn("[CeliHub DEV] Rayfield Fehler!"); return end

local Window = Rayfield:CreateWindow({
    Name            = "CeliHub 🔧  DEV VERSION",
    LoadingTitle    = "CeliHub DEV",
    LoadingSubtitle = "Early Access Build  •  Made by Celi 💫",
    ConfigurationSaving = {Enabled=true, FolderName="CeliHub_Dev"},
    KeySystem       = false,
})

local function N(t,c,d) pcall(function() Rayfield:Notify({Title=t,Content=tostring(c),Duration=d or 3}) end) end

-- ============================================================
-- TABS
-- ============================================================
local TabInfo    = Window:CreateTab("🔧 Dev Info",    4483362458)
local TabMove    = Window:CreateTab("🚀 Movement",    4483362458)
local TabCombat  = Window:CreateTab("🎯 Combat",      4483362458)
local TabESP     = Window:CreateTab("👁️ ESP",         4483362458)
local TabPlayer  = Window:CreateTab("🧍 Player",      4483362458)
local TabWorld   = Window:CreateTab("🌍 World",       4483362458)
local TabNotfall = Window:CreateTab("🚨 Notfall",     4483362458)

-- ============================================================
-- DEV INFO TAB
-- ============================================================
TabInfo:CreateSection("🔧 Build Information")
TabInfo:CreateParagraph({
    Title="CeliHub DEV VERSION",
    Content="Build: DEV-2026.02  •  #007\nStatus: Early Access\n\n✅ Kein Key benötigt\n🔧 Alle Features freigeschaltet\n⚡ Experimentelle Features aktiv\n🔒 Nicht weitergeben!\n\nMade by Celi 💫"
})

TabInfo:CreateSection("🌟 Early Access Features")
TabInfo:CreateParagraph({
    Title="Was ist neu in Dev?",
    Content="• Alle normalen Features\n• Dev-only: World Manipulation\n• Dev-only: ESP erweitert\n• Dev-only: No Clip verbessert\n• Dev-only: Aimbot unlocked\n• Früherer Zugriff auf neue Features\n• Bugs bitte reporten!"
})

TabInfo:CreateSection("🚨 Wichtig")
TabInfo:CreateParagraph({
    Title="⚠️ Hinweis",
    Content="Diese Version ist EXPERIMENTELL.\nFeatures können kaputt sein oder Bugs haben.\nBitte reporten: discord.gg/celihub\n\nWeitergabe dieser Version ist VERBOTEN!"
})

TabInfo:CreateButton({Name="📋 Version kopieren", Callback=function()
    pcall(function() setclipboard("CeliHub DEV-2026.02 Build #007 Early Access") end)
    N("📋","Version in Clipboard!",2)
end})

-- ============================================================
-- MOVEMENT TAB
-- ============================================================
TabMove:CreateSection("🚀 Bewegung")

TabMove:CreateToggle({Name="⚡ Speed Hack", CurrentValue=false, Callback=function(v)
    State.Speed=v
    N("⚡ Speed", v and "AN! Mult: "..SpeedMult or "AUS.", 2)
end})

TabMove:CreateSlider({Name="⚡ Speed Multiplikator", Range={1,30}, Increment=0.5, CurrentValue=2,
    Callback=function(v) SpeedMult=v end})

TabMove:CreateButton({Name="✈️ Fly AN/AUS  [X]", Callback=function()
    State.Fly = not State.Fly
    if State.Fly then
        local root = GetRoot()
        if not root then State.Fly=false; return end
        if FlyBV then pcall(function() FlyBV:Destroy() end) end
        FlyBV = Instance.new("BodyVelocity", root)
        FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        N("✈️ Fly","AN! WASD + Space/Shift",3)
    else
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        N("✈️ Fly","AUS.",2)
    end
end})

TabMove:CreateButton({Name="👻 NoClip AN/AUS  [N]", Callback=function()
    State.Noclip = not State.Noclip
    N("👻 NoClip", State.Noclip and "AN!" or "AUS.", 2)
end})

TabMove:CreateToggle({Name="∞ Infinite Jump", CurrentValue=false, Callback=function(v)
    State.InfJump=v; N("∞ Jump", v and "AN!" or "AUS.", 2)
end})

-- Keybinds
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
    if inp.KeyCode==Enum.KeyCode.F5 then
        State.Fly=false; State.Noclip=false; State.Speed=false
        State.Aimbot=false; State.InfJump=false; State.GodMode=false
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        N("🛑 NOTFALL","Alles AUS! (F5)",4)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump then
        local h=GetHum()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Speed + Fly + Noclip Loop
RunService.Heartbeat:Connect(function()
    pcall(function()
        local root=GetRoot(); local hum=GetHum()
        if not root then return end

        -- Speed
        if State.Speed and hum and hum.MoveDirection.Magnitude>0 then
            local v=hum.MoveDirection*(16*SpeedMult)
            root.Velocity=Vector3.new(v.X, root.Velocity.Y, v.Z)
        end

        -- Fly
        if State.Fly and FlyBV and FlyBV.Parent then
            local d=Vector3.zero; local cam=Camera
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then d+=cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then d-=cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then d-=cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then d+=cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d+=Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d-=Vector3.yAxis end
            FlyBV.Velocity = d.Magnitude>0 and d.Unit*65 or Vector3.zero
        end

        -- NoClip
        if State.Noclip and GetChar() then
            for _, p in pairs(GetChar():GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide=false end
            end
        end

        -- GodMode
        if State.GodMode and hum then hum.Health=hum.MaxHealth end
    end)
end)

-- ============================================================
-- COMBAT TAB
-- ============================================================
TabCombat:CreateSection("🎯 Aimbot")

TabCombat:CreateToggle({Name="🎯 Aimbot", CurrentValue=false, Callback=function(v)
    State.Aimbot=v; N("🎯 Aimbot", v and "AN!" or "AUS.", 2)
end})

TabCombat:CreateSlider({Name="🔵 FOV Radius", Range={10,500}, Increment=5, CurrentValue=120,
    Callback=function(v) State.AimbotFOV=v end})

TabCombat:CreateSlider({Name="🌊 Smoothing", Range={0,10}, Increment=1, CurrentValue=0,
    Callback=function(v) State.AimbotSmooth=v end})

TabCombat:CreateSection("👥 Spieler")
TabCombat:CreateButton({Name="📍 Zum nächsten Spieler TP", Callback=function()
    local root=GetRoot(); if not root then return end
    local nearest,minD=nil,math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player and plr.Character then
            local r=plr.Character:FindFirstChild("HumanoidRootPart")
            if r then
                local d=(root.Position-r.Position).Magnitude
                if d<minD then minD=d; nearest=r end
            end
        end
    end
    if nearest then
        root.CFrame=CFrame.new(nearest.Position+Vector3.new(3,0,3))
        N("📍","Teleportiert! ("..math.floor(minD).." studs)",3)
    else N("❌","Kein Spieler gefunden!",3) end
end})

-- Aimbot Render
RunService.RenderStepped:Connect(function()
    if not State.Aimbot then return end
    pcall(function()
        local center=Camera.ViewportSize/2
        local nearest,minD=nil,math.huge
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player and plr.Character then
                local hum=plr.Character:FindFirstChildOfClass("Humanoid")
                if not hum or hum.Health<=0 then continue end
                local head=plr.Character:FindFirstChild("Head"); if not head then continue end
                local sp,onS=Camera:WorldToViewportPoint(head.Position)
                if not onS then continue end
                local d=(Vector2.new(sp.X,sp.Y)-center).Magnitude
                if d<minD and d<State.AimbotFOV then minD=d; nearest=head end
            end
        end
        if nearest then
            if State.AimbotSmooth==0 then
                Camera.CFrame=CFrame.new(Camera.CFrame.Position,nearest.Position)
            else
                Camera.CFrame=Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position,nearest.Position),1/(State.AimbotSmooth*2))
            end
        end
    end)
end)

-- ============================================================
-- ESP TAB
-- ============================================================
TabESP:CreateSection("👁️ ESP Optionen")

TabESP:CreateToggle({Name="🟢 Chams (Highlight)", CurrentValue=false, Callback=function(v)
    State.ESPChams=v
    if not v then
        for _,plr in pairs(Players:GetPlayers()) do
            pcall(function()
                if plr.Character then
                    local h=plr.Character:FindFirstChild("CeliESP_H"); if h then h:Destroy() end
                end
            end)
        end
    end
    N("🟢 Chams", v and "AN!" or "AUS.", 2)
end})

TabESP:CreateToggle({Name="🏷️ Namen", CurrentValue=false, Callback=function(v)
    State.ESPNames=v; N("🏷️ Namen", v and "AN!" or "AUS.", 2)
end})

TabESP:CreateSlider({Name="📡 ESP Reichweite", Range={100,5000}, Increment=100, CurrentValue=2000,
    Callback=function(v) State.ESPRange=v end})

State.ESPRange=2000

RunService.Heartbeat:Connect(function()
    if not (State.ESPChams or State.ESPNames) then return end
    pcall(function()
        local root=GetRoot(); if not root then return end
        for _,plr in pairs(Players:GetPlayers()) do
            if plr==Player or not plr.Character then continue end
            local char=plr.Character
            local r=char:FindFirstChild("HumanoidRootPart"); if not r then continue end
            local dist=(root.Position-r.Position).Magnitude
            if dist>State.ESPRange then
                if char:FindFirstChild("CeliESP_H") then char.CeliESP_H:Destroy() end
                continue
            end

            if State.ESPChams then
                if not char:FindFirstChild("CeliESP_H") then
                    local h=Instance.new("Highlight",char); h.Name="CeliESP_H"
                    h.FillColor=plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(0,220,100)
                    h.OutlineColor=Color3.new(1,1,1); h.FillTransparency=0.5
                end
            else
                if char:FindFirstChild("CeliESP_H") then char.CeliESP_H:Destroy() end
            end

            if State.ESPNames then
                local head=char:FindFirstChild("Head"); if not head then continue end
                if not head:FindFirstChild("CeliESP_Tag") then
                    local bb=Instance.new("BillboardGui",head); bb.Name="CeliESP_Tag"
                    bb.Size=UDim2.fromOffset(200,50); bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true
                    local lbl=Instance.new("TextLabel",bb); lbl.Size=UDim2.fromScale(1,1)
                    lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=14
                    lbl.TextStrokeTransparency=0.3; lbl.Name="CeliESP_Lbl"
                    lbl.TextColor3=plr.TeamColor and plr.TeamColor.Color or Color3.fromRGB(0,220,100)
                end
                local lbl=head:FindFirstChild("CeliESP_Tag") and head.CeliESP_Tag:FindFirstChild("CeliESP_Lbl")
                if lbl then lbl.Text=plr.Name.."\n📏 "..math.floor(dist).."m" end
            else
                local head=char:FindFirstChild("Head")
                if head and head:FindFirstChild("CeliESP_Tag") then head.CeliESP_Tag:Destroy() end
            end
        end
    end)
end)

-- ============================================================
-- PLAYER TAB
-- ============================================================
TabPlayer:CreateSection("🧍 Player Mods")

TabPlayer:CreateToggle({Name="🛡️ God Mode", CurrentValue=false, Callback=function(v)
    State.GodMode=v; N("🛡️ God", v and "AN!" or "AUS.", 2)
end})

TabPlayer:CreateButton({Name="❤️ Heilen", Callback=function()
    pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end); N("❤️","HP voll!",2)
end})

TabPlayer:CreateButton({Name="📍 Position speichern  [T]", Callback=function()
    _G.CeliDevPos=GetRoot() and GetRoot().CFrame; N("📍","Gespeichert!",2)
end})
TabPlayer:CreateButton({Name="🔙 Zur Position  [R]", Callback=function()
    if _G.CeliDevPos and GetRoot() then GetRoot().CFrame=_G.CeliDevPos; N("🔙","Zurück!",2)
    else N("❌","Keine Position!",3) end
end})

UserInputService.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.T then _G.CeliDevPos=GetRoot() and GetRoot().CFrame end
    if inp.KeyCode==Enum.KeyCode.R and _G.CeliDevPos and GetRoot() then GetRoot().CFrame=_G.CeliDevPos end
end)

TabPlayer:CreateToggle({Name="🌈 Rainbow Character", CurrentValue=false, Callback=function(v)
    State.Rainbow=v
    if v then
        local colors={Color3.fromRGB(255,0,0),Color3.fromRGB(255,140,0),Color3.fromRGB(255,255,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,100,255),Color3.fromRGB(160,0,255)}
        task.spawn(function()
            local i=1
            while State.Rainbow do
                pcall(function()
                    if GetChar() then
                        for _,p in pairs(GetChar():GetDescendants()) do
                            if p:IsA("BasePart") then p.Color=colors[i] end
                        end
                    end
                end)
                i=(i%#colors)+1; task.wait(0.25)
            end
        end)
    end
    N("🌈 Rainbow", v and "AN!" or "AUS.", 2)
end})

TabPlayer:CreateButton({Name="🔄 Respawnen", Callback=function()
    Player:LoadCharacter(); N("🔄","Respawned!",2)
end})

-- ============================================================
-- WORLD TAB (DEV ONLY)
-- ============================================================
TabWorld:CreateSection("🌍 World Tools  [DEV]")

TabWorld:CreateButton({Name="🌌 Skybox ändern", Callback=function()
    pcall(function()
        local li=game:GetService("Lighting")
        local sky=li:FindFirstChildOfClass("Sky") or Instance.new("Sky",li)
        for _,f in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
            sky[f]="rbxassetid://159754040"
        end
    end)
    N("🌌","Skybox gesetzt!",3)
end})

TabWorld:CreateToggle({Name="🌈 Disco Fog", CurrentValue=false, Callback=function(v)
    _G.CeliDevFog=v
    if v then
        task.spawn(function()
            while _G.CeliDevFog do
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

TabWorld:CreateButton({Name="🌅 Tageszeit ändern (Mitternacht)", Callback=function()
    pcall(function() Lighting.TimeOfDay="00:00:00" end); N("🌅","Mitternacht!",2)
end})
TabWorld:CreateButton({Name="☀️ Tageszeit (Mittag)", Callback=function()
    pcall(function() Lighting.TimeOfDay="12:00:00" end); N("☀️","Mittag!",2)
end})

TabWorld:CreateButton({Name="🔓 Unanchor All", Callback=function()
    local c=0
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Anchored then pcall(function() v.Anchored=false end); c=c+1 end
    end
    N("🔓","Deanchored: "..c,3)
end})

TabWorld:CreateButton({Name="🏗️ Baseplate erstellen", Callback=function()
    local p=Instance.new("Part",workspace); p.Name="Baseplate"
    p.Size=Vector3.new(2048,1,2048); p.Anchored=true
    p.BrickColor=BrickColor.new("Medium green"); p.Material=Enum.Material.SmoothPlastic
    p.CFrame=CFrame.new(0,0,0); N("🏗️","Baseplate da!",3)
end})

TabWorld:CreateButton({Name="💥 Explosion Spam", Callback=function()
    task.spawn(function()
        for _=1,15 do
            pcall(function()
                local e=Instance.new("Explosion",workspace)
                e.Position=Vector3.new(math.random(-200,200),0,math.random(-200,200))
                e.BlastRadius=12; e.BlastPressure=300000
            end)
            task.wait(0.1)
        end
    end)
    N("💥","Explosionen!",3)
end})

-- ============================================================
-- NOTFALL TAB
-- ============================================================
TabNotfall:CreateSection("🚨 Notfall")

TabNotfall:CreateButton({Name="🛑 ALLES AUS  [F5]", Callback=function()
    State.Fly=false; State.Noclip=false; State.Speed=false
    State.Aimbot=false; State.InfJump=false; State.GodMode=false
    State.ESPChams=false; State.ESPNames=false; State.Rainbow=false
    _G.CeliDevFog=false
    if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
    pcall(function() Lighting.FogEnd=100000 end)
    for _,plr in pairs(Players:GetPlayers()) do
        pcall(function()
            if plr.Character then
                local h=plr.Character:FindFirstChild("CeliESP_H"); if h then h:Destroy() end
            end
        end)
    end
    N("🛑 NOTFALL","Alles deaktiviert!",4)
end})

TabNotfall:CreateButton({Name="🔄 Rejoin", Callback=function()
    N("🔄","Rejoining...",2); task.wait(1)
    pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,Player) end)
end})

TabNotfall:CreateButton({Name="🚪 Spiel verlassen", Callback=function()
    N("🚪","Bye!",1); task.wait(1)
    game:Shutdown()
end})

N("🔧 CeliHub DEV","Early Access Build geladen!\n✅ Kein Key • F5 = Alles AUS",6)
