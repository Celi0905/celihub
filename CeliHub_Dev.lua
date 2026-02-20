-- CeliHub | DEV VERSION 🔧
-- Made by Celi 💫
-- KEIN Rayfield — eigenes GUI, immer funktioniert
-- Kein Key benötigt! Early Access only.

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
-- DEV SPLASH SCREEN
-- ============================================================
local function ShowSplash()
    local SGui = Instance.new("ScreenGui")
    SGui.Name="CeliDevSplash"; SGui.ResetOnSpawn=false
    SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui

    local BG=Instance.new("Frame",SGui)
    BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0)
    BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    TweenService:Create(BG,TweenInfo.new(0.4),{BackgroundTransparency=0.45}):Play()

    local Card=Instance.new("Frame",BG)
    Card.Size=UDim2.fromOffset(440,260)
    Card.Position=UDim2.new(0.5,-220,0.5,-130)
    Card.BackgroundColor3=Color3.fromRGB(10,10,18)
    Card.BackgroundTransparency=1; Card.BorderSizePixel=0; Card.ZIndex=2
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,16)
    local CS=Instance.new("UIStroke",Card); CS.Color=Color3.fromRGB(0,220,100); CS.Thickness=2
    TweenService:Create(Card,TweenInfo.new(0.5),{BackgroundTransparency=0}):Play()

    local Top=Instance.new("Frame",Card); Top.Size=UDim2.new(1,0,0,3)
    Top.BackgroundColor3=Color3.fromRGB(0,220,100); Top.BorderSizePixel=0; Top.ZIndex=4
    Instance.new("UICorner",Top).CornerRadius=UDim.new(0,16)

    local Badge=Instance.new("Frame",Card); Badge.Size=UDim2.fromOffset(100,26)
    Badge.Position=UDim2.fromOffset(326,12); Badge.BackgroundColor3=Color3.fromRGB(0,180,80)
    Badge.BorderSizePixel=0; Badge.ZIndex=5
    Instance.new("UICorner",Badge).CornerRadius=UDim.new(0,7)
    local BL=Instance.new("TextLabel",Badge); BL.Size=UDim2.fromScale(1,1)
    BL.BackgroundTransparency=1; BL.Text="🔧 DEV BUILD"
    BL.TextColor3=Color3.new(1,1,1); BL.Font=Enum.Font.GothamBold; BL.TextSize=11; BL.ZIndex=6

    local TL=Instance.new("TextLabel",Card); TL.Size=UDim2.fromOffset(440,50)
    TL.Position=UDim2.fromOffset(0,16); TL.BackgroundTransparency=1
    TL.Text="🔧  CELIHUB  DEV"; TL.TextColor3=Color3.new(1,1,1)
    TL.Font=Enum.Font.GothamBold; TL.TextSize=30; TL.ZIndex=3

    local SL=Instance.new("TextLabel",Card); SL.Size=UDim2.fromOffset(440,20)
    SL.Position=UDim2.fromOffset(0,62); SL.BackgroundTransparency=1
    SL.Text="Early Access  •  Made by Celi 💫  •  Kein Key!"
    SL.TextColor3=Color3.fromRGB(0,200,100); SL.Font=Enum.Font.Gotham; SL.TextSize=13; SL.ZIndex=3

    local InfoBG=Instance.new("Frame",Card); InfoBG.Size=UDim2.fromOffset(400,90)
    InfoBG.Position=UDim2.fromOffset(20,94); InfoBG.BackgroundColor3=Color3.fromRGB(0,25,12)
    InfoBG.BorderSizePixel=0; InfoBG.ZIndex=3
    Instance.new("UICorner",InfoBG).CornerRadius=UDim.new(0,10)
    Instance.new("UIStroke",InfoBG).Color=Color3.fromRGB(0,100,50)
    local IL=Instance.new("TextLabel",InfoBG); IL.Size=UDim2.fromOffset(380,80)
    IL.Position=UDim2.fromOffset(10,5); IL.BackgroundTransparency=1
    IL.Text="✅  Kein Key benötigt\n⚡  Early Access — Bugs möglich\n🔧  Alle Features freigeschaltet\n🔒  Nicht weitergeben!"
    IL.TextColor3=Color3.fromRGB(0,220,100); IL.Font=Enum.Font.GothamBold; IL.TextSize=13
    IL.TextWrapped=true; IL.ZIndex=4; IL.TextXAlignment=Enum.TextXAlignment.Left
    IL.TextYAlignment=Enum.TextYAlignment.Top

    local BtnF=Instance.new("Frame",Card); BtnF.Size=UDim2.fromOffset(400,44)
    BtnF.Position=UDim2.fromOffset(20,200); BtnF.BackgroundColor3=Color3.fromRGB(0,160,70)
    BtnF.BorderSizePixel=0; BtnF.ZIndex=3
    Instance.new("UICorner",BtnF).CornerRadius=UDim.new(0,12)
    local BT=Instance.new("TextButton",BtnF); BT.Size=UDim2.fromScale(1,1)
    BT.BackgroundTransparency=1; BT.Text="🔧  DEV VERSION STARTEN  →"
    BT.TextColor3=Color3.new(1,1,1); BT.Font=Enum.Font.GothamBold; BT.TextSize=16; BT.ZIndex=4

    local started=false
    BT.MouseButton1Click:Connect(function()
        if started then return end; started=true
        BT.Text="✅  Lädt..."
        TweenService:Create(BtnF,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(30,200,80)}):Play()
        task.wait(0.8)
        TweenService:Create(Card,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        TweenService:Create(BG,TweenInfo.new(0.35),{BackgroundTransparency=1}):Play()
        task.wait(0.4); SGui:Destroy()
    end)

    repeat task.wait(0.1) until started or not SGui.Parent
end

ShowSplash()

-- ============================================================
-- GUI ERSTELLEN
-- ============================================================
local old = PlayerGui:FindFirstChild("CeliHub_Dev")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name="CeliHub_Dev"; ScreenGui.ResetOnSpawn=false
ScreenGui.IgnoreGuiInset=true; ScreenGui.Parent=PlayerGui

local Main=Instance.new("Frame",ScreenGui)
Main.Size=UDim2.fromOffset(340,500)
Main.Position=UDim2.new(0,10,0.5,-250)
Main.BackgroundColor3=Color3.fromRGB(10,10,18)
Main.BorderSizePixel=0; Main.Active=true; Main.Draggable=true
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,12)
local MainStroke=Instance.new("UIStroke",Main); MainStroke.Color=Color3.fromRGB(0,200,80); MainStroke.Thickness=1.5

local TitleBar=Instance.new("Frame",Main)
TitleBar.Size=UDim2.new(1,0,0,42); TitleBar.BackgroundColor3=Color3.fromRGB(0,160,70)
TitleBar.BorderSizePixel=0
Instance.new("UICorner",TitleBar).CornerRadius=UDim.new(0,12)
local TFix=Instance.new("Frame",TitleBar); TFix.Size=UDim2.new(1,0,0.5,0)
TFix.Position=UDim2.new(0,0,0.5,0); TFix.BackgroundColor3=Color3.fromRGB(0,160,70); TFix.BorderSizePixel=0

local TitleLbl=Instance.new("TextLabel",TitleBar)
TitleLbl.Size=UDim2.new(1,-110,1,0); TitleLbl.Position=UDim2.fromOffset(12,0)
TitleLbl.BackgroundTransparency=1; TitleLbl.Text="🔧 CeliHub  DEV VERSION"
TitleLbl.TextColor3=Color3.new(1,1,1); TitleLbl.Font=Enum.Font.GothamBold
TitleLbl.TextSize=13; TitleLbl.TextXAlignment=Enum.TextXAlignment.Left

local DevBadge=Instance.new("TextLabel",TitleBar)
DevBadge.Size=UDim2.fromOffset(60,22); DevBadge.Position=UDim2.new(1,-132,0.5,-11)
DevBadge.BackgroundColor3=Color3.fromRGB(0,100,40); DevBadge.BorderSizePixel=0
DevBadge.Text="DEV"; DevBadge.TextColor3=Color3.new(1,1,1)
DevBadge.Font=Enum.Font.GothamBold; DevBadge.TextSize=11
Instance.new("UICorner",DevBadge).CornerRadius=UDim.new(0,6)

local CloseBtn=Instance.new("TextButton",TitleBar)
CloseBtn.Size=UDim2.fromOffset(28,28); CloseBtn.Position=UDim2.new(1,-34,0.5,-14)
CloseBtn.BackgroundColor3=Color3.fromRGB(200,50,50); CloseBtn.Text="✕"
CloseBtn.TextColor3=Color3.new(1,1,1); CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.TextSize=13; CloseBtn.BorderSizePixel=0
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(1,0)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn=Instance.new("TextButton",TitleBar)
MinBtn.Size=UDim2.fromOffset(28,28); MinBtn.Position=UDim2.new(1,-66,0.5,-14)
MinBtn.BackgroundColor3=Color3.fromRGB(30,30,50); MinBtn.Text="—"
MinBtn.TextColor3=Color3.new(1,1,1); MinBtn.Font=Enum.Font.GothamBold; MinBtn.TextSize=13; MinBtn.BorderSizePixel=0
Instance.new("UICorner",MinBtn).CornerRadius=UDim.new(1,0)
local minimized=false
MinBtn.MouseButton1Click:Connect(function()
    minimized=not minimized
    Main.Size=minimized and UDim2.fromOffset(340,42) or UDim2.fromOffset(340,500)
end)

-- Scroll
local Scroll=Instance.new("ScrollingFrame",Main)
Scroll.Size=UDim2.new(1,-16,1,-54); Scroll.Position=UDim2.fromOffset(8,50)
Scroll.BackgroundTransparency=1; Scroll.BorderSizePixel=0
Scroll.ScrollBarThickness=3; Scroll.ScrollBarImageColor3=Color3.fromRGB(0,200,80)
Scroll.CanvasSize=UDim2.fromOffset(0,0)
local SL=Instance.new("UIListLayout",Scroll)
SL.SortOrder=Enum.SortOrder.LayoutOrder; SL.Padding=UDim.new(0,5)
SL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize=UDim2.fromOffset(0,SL.AbsoluteContentSize.Y+10)
end)

-- ============================================================
-- HELPERS
-- ============================================================
local ORANGE = Color3.fromRGB(0,200,80)

local function MakeSection(text)
    local F=Instance.new("Frame",Scroll); F.Size=UDim2.new(1,0,0,24)
    F.BackgroundColor3=Color3.fromRGB(0,180,70); F.BackgroundTransparency=0.82; F.BorderSizePixel=0
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)
    local L=Instance.new("TextLabel",F); L.Size=UDim2.fromScale(1,1); L.BackgroundTransparency=1
    L.Text=text; L.TextColor3=Color3.fromRGB(0,255,100); L.Font=Enum.Font.GothamBold; L.TextSize=12
    return F
end

local function MakeBtn(text, cb)
    local B=Instance.new("TextButton",Scroll); B.Size=UDim2.new(1,0,0,32)
    B.BackgroundColor3=Color3.fromRGB(18,18,30); B.Text=text
    B.TextColor3=Color3.new(1,1,1); B.Font=Enum.Font.GothamBold; B.TextSize=13; B.BorderSizePixel=0
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,8)
    local St=Instance.new("UIStroke",B); St.Color=Color3.fromRGB(35,35,55)
    B.MouseEnter:Connect(function() B.BackgroundColor3=Color3.fromRGB(28,28,44); St.Color=Color3.fromRGB(0,180,70) end)
    B.MouseLeave:Connect(function() B.BackgroundColor3=Color3.fromRGB(18,18,30); St.Color=Color3.fromRGB(35,35,55) end)
    B.MouseButton1Click:Connect(function()
        B.BackgroundColor3=Color3.fromRGB(0,160,60); task.wait(0.12)
        B.BackgroundColor3=Color3.fromRGB(18,18,30); pcall(cb)
    end)
    return B
end

local toggleStates={}
local function MakeToggle(text, cb)
    local B=Instance.new("TextButton",Scroll); B.Size=UDim2.new(1,0,0,32)
    B.BackgroundColor3=Color3.fromRGB(18,18,30); B.Font=Enum.Font.GothamBold
    B.TextSize=13; B.TextColor3=Color3.new(1,1,1); B.BorderSizePixel=0
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,8)
    local St=Instance.new("UIStroke",B); St.Color=Color3.fromRGB(35,35,55)
    toggleStates[B]=false
    local function Upd()
        local on=toggleStates[B]
        B.Text=(on and "✅ " or "⬜ ")..text
        B.BackgroundColor3=on and Color3.fromRGB(0,60,25) or Color3.fromRGB(18,18,30)
        St.Color=on and Color3.fromRGB(0,200,80) or Color3.fromRGB(35,35,55)
    end; Upd()
    B.MouseButton1Click:Connect(function()
        toggleStates[B]=not toggleStates[B]; Upd(); pcall(cb, toggleStates[B])
    end)
    return B
end

local function Notify(text, dur)
    local NG=Instance.new("ScreenGui",PlayerGui); NG.Name="CeliNotifDev"
    NG.ResetOnSpawn=false; NG.IgnoreGuiInset=true
    local NF=Instance.new("Frame",NG); NF.Size=UDim2.fromOffset(280,50)
    NF.Position=UDim2.new(1,-290,1,-70); NF.BackgroundColor3=Color3.fromRGB(10,20,14)
    NF.BorderSizePixel=0; NF.BackgroundTransparency=1
    Instance.new("UICorner",NF).CornerRadius=UDim.new(0,10)
    Instance.new("UIStroke",NF).Color=Color3.fromRGB(0,200,80)
    local NL=Instance.new("TextLabel",NF); NL.Size=UDim2.fromScale(1,1); NL.BackgroundTransparency=1
    NL.Text=text; NL.TextColor3=Color3.new(1,1,1)
    NL.Font=Enum.Font.GothamBold; NL.TextSize=14; NL.TextWrapped=true
    TweenService:Create(NF,TweenInfo.new(0.3),{BackgroundTransparency=0}):Play()
    task.delay(dur or 2,function()
        TweenService:Create(NF,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        task.wait(0.35); NG:Destroy()
    end)
end

-- ============================================================
-- STATES
-- ============================================================
local State={God=false,Speed=false,Fly=false,Noclip=false,InfJump=false,Disco=false,Rainbow=false,ESPChams=false,ESPNames=false,Aimbot=false}
local SpeedVal=50; local FlyBV=nil; local SavedPos=nil
local AimbotFOV=150; local AimbotSmooth=0

-- ============================================================
-- BUTTONS
-- ============================================================
MakeSection("🔧 DEV INFO")
MakeBtn("📋 Version: DEV-2026.02 Build #007", function()
    pcall(function() setclipboard("CeliHub DEV-2026.02") end)
    Notify("📋 Kopiert!")
end)

MakeSection("🧍 Player  [F5=Alles AUS]")
MakeToggle("🛡️ God Mode", function(v)
    State.God=v
    if v then task.spawn(function() while State.God do pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end); task.wait(0.1) end end) end
    Notify(v and "🛡️ God AN!" or "🛡️ God AUS.")
end)
MakeBtn("❤️ Heilen", function()
    pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end); Notify("❤️ HP voll!")
end)
MakeBtn("🔄 Respawnen", function() Player:LoadCharacter(); Notify("🔄 Respawned!") end)
MakeToggle("🌈 Disco Character", function(v)
    State.Disco=v
    if v then task.spawn(function() while State.Disco do pcall(function() local c=GetChar(); if not c then return end; for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)) end end end); task.wait(0.15) end end) end
    Notify(v and "🌈 Disco AN!" or "🌈 Disco AUS.")
end)
MakeToggle("🌈 Rainbow (6 Farben)", function(v)
    State.Rainbow=v
    if v then
        local cols={Color3.fromRGB(255,0,0),Color3.fromRGB(255,140,0),Color3.fromRGB(255,255,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,100,255),Color3.fromRGB(160,0,255)}
        task.spawn(function() local i=1; while State.Rainbow do pcall(function() local c=GetChar(); if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Color=cols[i] end end end end); i=i%#cols+1; task.wait(0.25) end end)
    end
    Notify(v and "🌈 Rainbow AN!" or "🌈 Rainbow AUS.")
end)
MakeBtn("📍 Position speichern [T]", function() SavedPos=GetRoot() and GetRoot().CFrame; Notify("📍 Gespeichert!") end)
MakeBtn("🔙 Zur Position [R]", function()
    if SavedPos and GetRoot() then GetRoot().CFrame=SavedPos; Notify("🔙 Teleportiert!")
    else Notify("❌ Keine Position!") end
end)

MakeSection("🚀 Movement  [X=Fly  N=Noclip]")
MakeToggle("⚡ Speed Hack", function(v) State.Speed=v; Notify(v and "⚡ Speed AN!" or "⚡ Speed AUS.") end)
MakeBtn("✈️ Fly AN/AUS [X]", function()
    State.Fly=not State.Fly
    if State.Fly then
        local root=GetRoot(); if not root then State.Fly=false; return end
        if FlyBV then pcall(function() FlyBV:Destroy() end) end
        FlyBV=Instance.new("BodyVelocity",root); FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        Notify("✈️ Fly AN!")
    else
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil; Notify("✈️ Fly AUS.")
    end
end)
MakeBtn("👻 NoClip AN/AUS [N]", function() State.Noclip=not State.Noclip; Notify(State.Noclip and "👻 NoClip AN!" or "👻 NoClip AUS.") end)
MakeToggle("∞ Infinite Jump", function(v) State.InfJump=v; Notify(v and "∞ Jump AN!" or "∞ Jump AUS.") end)

MakeSection("🎯 Aimbot  [DEV ONLY]")
MakeToggle("🎯 Aimbot AN/AUS", function(v) State.Aimbot=v; Notify(v and "🎯 Aimbot AN!" or "🎯 Aimbot AUS.") end)

MakeSection("👁️ ESP  [DEV ONLY]")
MakeToggle("🟢 Chams (Highlight)", function(v)
    State.ESPChams=v
    if not v then
        for _,plr in pairs(Players:GetPlayers()) do
            pcall(function() if plr.Character then local h=plr.Character:FindFirstChild("CeliESP_H"); if h then h:Destroy() end end end)
        end
    end
    Notify(v and "🟢 Chams AN!" or "🟢 Chams AUS.")
end)
MakeToggle("🏷️ Namen & Distanz", function(v)
    State.ESPNames=v
    if not v then
        for _,plr in pairs(Players:GetPlayers()) do
            pcall(function() if plr.Character then local head=plr.Character:FindFirstChild("Head"); if head then local t=head:FindFirstChild("CeliESP_Tag"); if t then t:Destroy() end end end end)
        end
    end
    Notify(v and "🏷️ Namen AN!" or "🏷️ Namen AUS.")
end)

MakeSection("💥 Server")
MakeBtn("🌊 Flood", function()
    local root=GetRoot(); local p=Instance.new("Part",workspace)
    p.Size=Vector3.new(4096,1,4096); p.Anchored=true; p.CanCollide=true
    p.Material=Enum.Material.SmoothPlastic; p.BrickColor=BrickColor.new("Cyan")
    p.CFrame=CFrame.new(0,root and root.Position.Y-5 or 0,0); Notify("🌊 Flood!")
end)
MakeBtn("🔓 Unanchor All", function()
    local c=0; for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and v.Anchored then pcall(function() v.Anchored=false end); c=c+1 end end; Notify("🔓 "..c.." Parts!")
end)
MakeBtn("💀 Kill All", function()
    for _,plr in pairs(Players:GetPlayers()) do if plr~=Player then pcall(function() local h=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid"); if h then h.Health=0 end end) end end; Notify("💀 Kill All!")
end)
MakeBtn("💥 Explosion Spam", function()
    task.spawn(function() for _=1,25 do pcall(function() local e=Instance.new("Explosion",workspace); e.Position=Vector3.new(math.random(-200,200),0,math.random(-200,200)); e.BlastRadius=15; e.BlastPressure=500000 end); task.wait(0.08) end end); Notify("💥 Explosionen!")
end)
MakeBtn("🌌 Skybox (Neon)", function()
    pcall(function() local sky=Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky",Lighting); for _,f in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do sky[f]="rbxassetid://159908636" end end); Notify("🌌 Skybox gesetzt!")
end)

MakeSection("🚨 Notfall")
MakeBtn("🛑 ALLES AUS  [F5]", function()
    State.God=false; State.Speed=false; State.Fly=false; State.Noclip=false
    State.InfJump=false; State.Disco=false; State.Rainbow=false; State.Aimbot=false
    State.ESPChams=false; State.ESPNames=false
    if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
    for _,plr in pairs(Players:GetPlayers()) do pcall(function() if plr.Character then local h=plr.Character:FindFirstChild("CeliESP_H"); if h then h:Destroy() end end end) end
    Notify("🛑 Alles deaktiviert!")
end)
MakeBtn("🔄 Rejoin", function() Notify("🔄 Rejoining..."); task.wait(1); pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,Player) end) end)

-- ============================================================
-- GAME LOOPS
-- ============================================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        local root=GetRoot(); local hum=GetHum(); if not root then return end
        if State.Speed and hum and hum.MoveDirection.Magnitude>0 then
            local v=hum.MoveDirection*SpeedVal; root.Velocity=Vector3.new(v.X,root.Velocity.Y,v.Z)
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
        if State.Noclip and GetChar() then for _,p in pairs(GetChar():GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
        if State.God and hum then hum.Health=hum.MaxHealth end
        -- ESP Chams/Namen
        if State.ESPChams or State.ESPNames then
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=Player and plr.Character then
                    local char=plr.Character
                    if State.ESPChams and not char:FindFirstChild("CeliESP_H") then
                        local h=Instance.new("Highlight",char); h.Name="CeliESP_H"
                        h.FillColor=Color3.fromRGB(0,220,100); h.OutlineColor=Color3.new(1,1,1); h.FillTransparency=0.5
                    end
                    if not State.ESPChams then local h=char:FindFirstChild("CeliESP_H"); if h then h:Destroy() end end
                    if State.ESPNames then
                        local head=char:FindFirstChild("Head"); if head and not head:FindFirstChild("CeliESP_Tag") then
                            local bb=Instance.new("BillboardGui",head); bb.Name="CeliESP_Tag"
                            bb.Size=UDim2.fromOffset(180,40); bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true
                            local lbl=Instance.new("TextLabel",bb); lbl.Size=UDim2.fromScale(1,1)
                            lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=13
                            lbl.TextColor3=Color3.fromRGB(0,220,100); lbl.TextStrokeTransparency=0.3; lbl.Name="Lbl"
                        end
                        if head then
                            local tag=head:FindFirstChild("CeliESP_Tag"); if tag then
                                local lbl=tag:FindFirstChild("Lbl")
                                if lbl and root then lbl.Text=plr.Name.."\n"..math.floor((GetRoot().Position-head.Position).Magnitude).."m" end
                            end
                        end
                    else
                        local head=char:FindFirstChild("Head"); if head then local t=head:FindFirstChild("CeliESP_Tag"); if t then t:Destroy() end end
                    end
                end
            end
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    if not State.Aimbot then return end
    pcall(function()
        local center=Camera.ViewportSize/2; local nearest,minD=nil,math.huge
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player and plr.Character then
                local h=plr.Character:FindFirstChildOfClass("Humanoid"); if not h or h.Health<=0 then continue end
                local head=plr.Character:FindFirstChild("Head"); if not head then continue end
                local sp,onS=Camera:WorldToViewportPoint(head.Position); if not onS then continue end
                local d=(Vector2.new(sp.X,sp.Y)-center).Magnitude
                if d<minD and d<AimbotFOV then minD=d; nearest=head end
            end
        end
        if nearest then Camera.CFrame=Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position,nearest.Position), AimbotSmooth==0 and 1 or 1/(AimbotSmooth*2)) end
    end)
end)

UserInputService.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    if inp.KeyCode==Enum.KeyCode.X then
        State.Fly=not State.Fly
        if State.Fly then
            local root=GetRoot(); if not root then State.Fly=false; return end
            if FlyBV then pcall(function() FlyBV:Destroy() end) end
            FlyBV=Instance.new("BodyVelocity",root); FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        else if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil end
    end
    if inp.KeyCode==Enum.KeyCode.N then State.Noclip=not State.Noclip end
    if inp.KeyCode==Enum.KeyCode.T then SavedPos=GetRoot() and GetRoot().CFrame end
    if inp.KeyCode==Enum.KeyCode.R and SavedPos and GetRoot() then GetRoot().CFrame=SavedPos end
    if inp.KeyCode==Enum.KeyCode.F5 then
        State.God=false; State.Speed=false; State.Fly=false; State.Noclip=false
        State.InfJump=false; State.Disco=false; State.Rainbow=false; State.Aimbot=false
        State.ESPChams=false; State.ESPNames=false
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        Notify("🛑 ALLES AUS! [F5]")
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump then local h=GetHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)

Notify("🔧 CeliHub DEV geladen! ✅  Kein Key!", 5)
