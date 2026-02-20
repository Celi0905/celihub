-- CeliHub | DEV VERSION 🔧
-- Made by Celi 💫
-- Nur via CeliHub_DevLoader.lua — Kein Key benötigt

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local Player           = Players.LocalPlayer
local PlayerGui        = Player:WaitForChild("PlayerGui")
local Camera           = workspace.CurrentCamera

local function GetChar()  return Player.Character end
local function GetHum()   local c=GetChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot()  local c=GetChar(); return c and c:FindFirstChild("HumanoidRootPart") end

-- ============================================================
-- Dev Splash Screen (kein Key, eigener grüner Screen)
-- ============================================================
local function ShowDevSplash()
    local SGui=Instance.new("ScreenGui"); SGui.Name="CeliDevSplash"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui
    local BG=Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    TweenService:Create(BG,TweenInfo.new(0.4),{BackgroundTransparency=0.45}):Play()

    local Card=Instance.new("Frame",BG); Card.Size=UDim2.fromOffset(440,260); Card.Position=UDim2.new(.5,-220,.5,-130); Card.BackgroundColor3=Color3.fromRGB(10,10,18); Card.BackgroundTransparency=1; Card.BorderSizePixel=0; Card.ZIndex=2
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,16)
    local CS=Instance.new("UIStroke",Card); CS.Color=Color3.fromRGB(0,220,100); CS.Thickness=2
    TweenService:Create(Card,TweenInfo.new(0.5),{BackgroundTransparency=0}):Play()

    task.spawn(function()
        while Card and Card.Parent do
            task.wait(1.2); if not(Card and Card.Parent) then break end
            TweenService:Create(CS,TweenInfo.new(1.2,Enum.EasingStyle.Sine),{Transparency=0.05,Color=Color3.fromRGB(0,255,120)}):Play()
            task.wait(1.2); if not(Card and Card.Parent) then break end
            TweenService:Create(CS,TweenInfo.new(1.2,Enum.EasingStyle.Sine),{Transparency=0.6,Color=Color3.fromRGB(0,180,80)}):Play()
        end
    end)

    local Top=Instance.new("Frame",Card); Top.Size=UDim2.new(1,0,0,3); Top.BackgroundColor3=Color3.fromRGB(0,220,100); Top.BorderSizePixel=0; Top.ZIndex=4
    Instance.new("UICorner",Top).CornerRadius=UDim.new(0,16)

    local Badge=Instance.new("Frame",Card); Badge.Size=UDim2.fromOffset(100,26); Badge.Position=UDim2.fromOffset(326,12); Badge.BackgroundColor3=Color3.fromRGB(0,180,80); Badge.BorderSizePixel=0; Badge.ZIndex=5
    Instance.new("UICorner",Badge).CornerRadius=UDim.new(0,7)
    local BL=Instance.new("TextLabel",Badge); BL.Size=UDim2.fromScale(1,1); BL.BackgroundTransparency=1; BL.Text="🔧 DEV BUILD"; BL.TextColor3=Color3.new(1,1,1); BL.Font=Enum.Font.GothamBold; BL.TextSize=11; BL.ZIndex=6

    local TL=Instance.new("TextLabel",Card); TL.Size=UDim2.fromOffset(440,50); TL.Position=UDim2.fromOffset(0,16); TL.BackgroundTransparency=1; TL.Text="🔧  CELIHUB  DEV"; TL.TextColor3=Color3.new(1,1,1); TL.Font=Enum.Font.GothamBold; TL.TextSize=30; TL.ZIndex=3
    local SL=Instance.new("TextLabel",Card); SL.Size=UDim2.fromOffset(440,20); SL.Position=UDim2.fromOffset(0,62); SL.BackgroundTransparency=1; SL.Text="Early Access  •  Made by Celi 💫  •  Kein Key!"; SL.TextColor3=Color3.fromRGB(0,200,100); SL.Font=Enum.Font.Gotham; SL.TextSize=13; SL.ZIndex=3

    local InfoBG=Instance.new("Frame",Card); InfoBG.Size=UDim2.fromOffset(400,88); InfoBG.Position=UDim2.fromOffset(20,94); InfoBG.BackgroundColor3=Color3.fromRGB(0,22,10); InfoBG.BorderSizePixel=0; InfoBG.ZIndex=3
    Instance.new("UICorner",InfoBG).CornerRadius=UDim.new(0,10); Instance.new("UIStroke",InfoBG).Color=Color3.fromRGB(0,100,50)
    local IL=Instance.new("TextLabel",InfoBG); IL.Size=UDim2.fromOffset(380,78); IL.Position=UDim2.fromOffset(10,5); IL.BackgroundTransparency=1; IL.Text="✅  Kein Key benötigt\n⚡  Early Access — Bugs möglich\n🔧  Alle Features freigeschaltet\n🔒  Nicht weitergeben!"; IL.TextColor3=Color3.fromRGB(0,220,100); IL.Font=Enum.Font.GothamBold; IL.TextSize=13; IL.TextWrapped=true; IL.ZIndex=4; IL.TextXAlignment=Enum.TextXAlignment.Left; IL.TextYAlignment=Enum.TextYAlignment.Top

    local VerL=Instance.new("TextLabel",Card); VerL.Size=UDim2.fromOffset(440,20); VerL.Position=UDim2.fromOffset(0,192); VerL.BackgroundTransparency=1; VerL.Text="DEV-2026.02  •  Build #007  •  Early Access"; VerL.TextColor3=Color3.fromRGB(0,120,50); VerL.Font=Enum.Font.Code; VerL.TextSize=12; VerL.ZIndex=3

    local BtnF=Instance.new("Frame",Card); BtnF.Size=UDim2.fromOffset(400,44); BtnF.Position=UDim2.fromOffset(20,210); BtnF.BackgroundColor3=Color3.fromRGB(0,160,70); BtnF.BorderSizePixel=0; BtnF.ZIndex=3
    Instance.new("UICorner",BtnF).CornerRadius=UDim.new(0,12)
    local BT=Instance.new("TextButton",BtnF); BT.Size=UDim2.fromScale(1,1); BT.BackgroundTransparency=1; BT.Text="🔧  DEV VERSION STARTEN  →"; BT.TextColor3=Color3.new(1,1,1); BT.Font=Enum.Font.GothamBold; BT.TextSize=16; BT.ZIndex=4
    BT.MouseEnter:Connect(function() TweenService:Create(BtnF,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(0,200,90)}):Play() end)
    BT.MouseLeave:Connect(function() TweenService:Create(BtnF,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(0,160,70)}):Play() end)

    local started=false
    BT.MouseButton1Click:Connect(function()
        if started then return end; started=true; BT.Text="✅  Lädt Rayfield..."
        TweenService:Create(BtnF,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(30,200,80)}):Play()
        task.wait(0.8)
        TweenService:Create(Card,TweenInfo.new(0.3),{BackgroundTransparency=1}):Play()
        TweenService:Create(BG,TweenInfo.new(0.35),{BackgroundTransparency=1}):Play()
        task.wait(0.4); SGui:Destroy()
    end)
    repeat task.wait(0.1) until started or not SGui.Parent
end

ShowDevSplash()

-- ============================================================
-- Rayfield mit Retry
-- ============================================================
local Rayfield
for attempt=1,3 do
    local ok,result=pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield",true))()
    end)
    if ok and result then Rayfield=result; break end
    task.wait(1.5)
end
if not Rayfield then warn("[CeliHub DEV] Rayfield nicht ladbar!"); return end

-- ============================================================
-- States
-- ============================================================
local State={God=false,Speed=false,Fly=false,Noclip=false,InfJump=false,Disco=false,Rainbow=false,ESPChams=false,ESPNames=false,Aimbot=false,DiscoFog=false}
local SpeedVal=80; local FlyBV=nil; local SavedPos=nil; local AimbotFOV=150

-- ============================================================
-- Window
-- ============================================================
local Window=Rayfield:CreateWindow({
    Name            = "CeliHub 🔧  DEV VERSION",
    LoadingTitle    = "CeliHub DEV",
    LoadingSubtitle = "Early Access Build #007  •  Made by Celi 💫",
    ConfigurationSaving={Enabled=true,FolderName="CeliHub_Dev"},
    KeySystem=false,
})

local function N(t,c,d) pcall(function() Rayfield:Notify({Title=tostring(t),Content=tostring(c),Duration=d or 3}) end) end

-- ============================================================
-- Tabs
-- ============================================================
local TabInfo   = Window:CreateTab("🔧 Dev Info",   4483362458)
local TabPlay   = Window:CreateTab("🧍 Player",     4483362458)
local TabMove   = Window:CreateTab("🚀 Movement",   4483362458)
local TabCombat = Window:CreateTab("🎯 Combat",     4483362458)
local TabESP    = Window:CreateTab("👁️ ESP",        4483362458)
local TabWorld  = Window:CreateTab("🌍 World",      4483362458)
local TabNotf   = Window:CreateTab("🚨 Notfall",    4483362458)

-- ============================================================
-- DEV INFO
-- ============================================================
TabInfo:CreateSection("🔧 Build Info")
TabInfo:CreateParagraph({Title="CeliHub DEV VERSION",Content="Build: DEV-2026.02  •  #007\nStatus: Early Access\n\n✅ Kein Key benötigt\n🔧 Alle Features freigeschaltet\n⚡ Experimentell — Bugs möglich\n🔒 Nicht weitergeben!\n\nMade by Celi 💫"})
TabInfo:CreateParagraph({Title="⌨️ Keybinds",Content="X   →  Fly AN/AUS\nN   →  NoClip AN/AUS\nT   →  Position speichern\nR   →  Zur Position\nF5  →  ALLES AUS"})
TabInfo:CreateButton({Name="📋 Version kopieren",Callback=function() pcall(function() setclipboard("CeliHub DEV-2026.02 Build #007") end); N("📋","Kopiert!",2) end})

-- ============================================================
-- PLAYER
-- ============================================================
TabPlay:CreateSection("🧍 Player Mods")
TabPlay:CreateToggle({Name="🛡️ God Mode",CurrentValue=false,Callback=function(v)
    State.God=v
    if v then task.spawn(function() while State.God do pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end); task.wait(0.1) end end) end
    N("🛡️ God",v and "AN!" or "AUS.",2)
end})
TabPlay:CreateButton({Name="❤️ Heilen",Callback=function() pcall(function() local h=GetHum(); if h then h.Health=h.MaxHealth end end); N("❤️","HP voll!",2) end})
TabPlay:CreateButton({Name="🔄 Respawnen",Callback=function() Player:LoadCharacter(); N("🔄","Respawned!",2) end})
TabPlay:CreateSection("🎨 Effekte")
TabPlay:CreateToggle({Name="🌈 Disco Character",CurrentValue=false,Callback=function(v)
    State.Disco=v
    if v then task.spawn(function() while State.Disco do pcall(function() local c=GetChar(); if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Color=Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)) end end end end); task.wait(0.15) end end) end
    N("🌈 Disco",v and "AN!" or "AUS.",2)
end})
TabPlay:CreateToggle({Name="🌈 Rainbow (6 Farben)",CurrentValue=false,Callback=function(v)
    State.Rainbow=v
    if v then
        local cols={Color3.fromRGB(255,0,0),Color3.fromRGB(255,140,0),Color3.fromRGB(255,255,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,100,255),Color3.fromRGB(160,0,255)}
        task.spawn(function() local i=1; while State.Rainbow do pcall(function() local c=GetChar(); if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Color=cols[i] end end end end); i=i%#cols+1; task.wait(0.25) end end)
    end
    N("🌈 Rainbow",v and "AN!" or "AUS.",2)
end})
TabPlay:CreateButton({Name="📍 Position speichern  [T]",Callback=function() SavedPos=GetRoot() and GetRoot().CFrame; N("📍","Gespeichert!",2) end})
TabPlay:CreateButton({Name="🔙 Zur Position  [R]",Callback=function()
    if SavedPos and GetRoot() then GetRoot().CFrame=SavedPos; N("🔙","Teleportiert!",2) else N("❌","Keine Position!",3) end
end})

-- ============================================================
-- MOVEMENT
-- ============================================================
TabMove:CreateSection("🚀 Bewegung")
TabMove:CreateToggle({Name="⚡ Speed Hack",CurrentValue=false,Callback=function(v) State.Speed=v; N("⚡ Speed",v and "AN! ("..SpeedVal..")" or "AUS.",2) end})
TabMove:CreateSlider({Name="⚡ Speed Wert",Range={1,500},Increment=1,CurrentValue=80,Callback=function(v) SpeedVal=v end})
TabMove:CreateButton({Name="✈️ Fly AN/AUS  [X]",Callback=function()
    State.Fly=not State.Fly
    if State.Fly then
        local root=GetRoot(); if not root then State.Fly=false; return end
        if FlyBV then pcall(function() FlyBV:Destroy() end) end
        FlyBV=Instance.new("BodyVelocity",root); FlyBV.MaxForce=Vector3.new(1e5,1e5,1e5); FlyBV.Velocity=Vector3.zero
        N("✈️ Fly","AN! WASD+Space/Shift",3)
    else if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil; N("✈️ Fly","AUS.",2) end
end})
TabMove:CreateButton({Name="👻 NoClip AN/AUS  [N]",Callback=function() State.Noclip=not State.Noclip; N("👻 NoClip",State.Noclip and "AN!" or "AUS.",2) end})
TabMove:CreateToggle({Name="∞ Infinite Jump",CurrentValue=false,Callback=function(v) State.InfJump=v; N("∞ Jump",v and "AN!" or "AUS.",2) end})

-- ============================================================
-- COMBAT
-- ============================================================
TabCombat:CreateSection("🎯 Aimbot  [DEV ONLY]")
TabCombat:CreateToggle({Name="🎯 Aimbot",CurrentValue=false,Callback=function(v) State.Aimbot=v; N("🎯 Aimbot",v and "AN!" or "AUS.",2) end})
TabCombat:CreateSlider({Name="🔵 FOV",Range={10,500},Increment=5,CurrentValue=150,Callback=function(v) AimbotFOV=v end})
TabCombat:CreateButton({Name="📍 Zum nächsten Spieler TP",Callback=function()
    local root=GetRoot(); if not root then return end
    local nearest,minD=nil,math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player and plr.Character then
            local r=plr.Character:FindFirstChild("HumanoidRootPart")
            if r then local d=(root.Position-r.Position).Magnitude; if d<minD then minD=d; nearest=r end end
        end
    end
    if nearest then root.CFrame=CFrame.new(nearest.Position+Vector3.new(3,0,3)); N("📍","Teleportiert! "..math.floor(minD).."m",3)
    else N("❌","Kein Spieler!",3) end
end})

-- ============================================================
-- ESP
-- ============================================================
TabESP:CreateSection("👁️ ESP  [DEV ONLY]")
TabESP:CreateToggle({Name="🟢 Chams (Highlight)",CurrentValue=false,Callback=function(v)
    State.ESPChams=v
    if not v then for _,plr in pairs(Players:GetPlayers()) do pcall(function() if plr.Character then local h=plr.Character:FindFirstChild("CeliESP_H"); if h then h:Destroy() end end end) end end
    N("🟢 Chams",v and "AN!" or "AUS.",2)
end})
TabESP:CreateToggle({Name="🏷️ Namen & Distanz",CurrentValue=false,Callback=function(v)
    State.ESPNames=v
    if not v then for _,plr in pairs(Players:GetPlayers()) do pcall(function() if plr.Character then local head=plr.Character:FindFirstChild("Head"); if head then local t=head:FindFirstChild("CeliESP_Tag"); if t then t:Destroy() end end end end) end end
    N("🏷️ Namen",v and "AN!" or "AUS.",2)
end})

-- ============================================================
-- WORLD
-- ============================================================
TabWorld:CreateSection("🌍 World  [DEV ONLY]")
TabWorld:CreateButton({Name="🌊 Flood",Callback=function()
    pcall(function() local root=GetRoot(); local p=Instance.new("Part",workspace); p.Size=Vector3.new(4096,1,4096); p.Anchored=true; p.CanCollide=true; p.Material=Enum.Material.SmoothPlastic; p.BrickColor=BrickColor.new("Cyan"); p.CFrame=CFrame.new(0,root and root.Position.Y-5 or 0,0) end); N("🌊","Flood!",3)
end})
TabWorld:CreateButton({Name="🔓 Unanchor All",Callback=function()
    local c=0; for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and v.Anchored then pcall(function() v.Anchored=false end); c=c+1 end end; N("🔓",c.." Parts!",3)
end})
TabWorld:CreateButton({Name="💀 Kill All",Callback=function()
    for _,plr in pairs(Players:GetPlayers()) do if plr~=Player then pcall(function() local h=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid"); if h then h.Health=0 end end) end end; N("💀","Kill All!",3)
end})
TabWorld:CreateToggle({Name="🌈 Disco Fog",CurrentValue=false,Callback=function(v)
    State.DiscoFog=v
    if v then task.spawn(function() while State.DiscoFog do pcall(function() Lighting.FogColor=Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)); Lighting.FogEnd=math.random(40,180) end); task.wait(0.2) end end)
    else pcall(function() Lighting.FogEnd=100000 end) end
    N("🌈 Disco Fog",v and "AN!" or "AUS.",2)
end})
TabWorld:CreateButton({Name="🌅 Mitternacht",Callback=function() pcall(function() Lighting.TimeOfDay="00:00:00" end); N("🌅","Mitternacht!",2) end})
TabWorld:CreateButton({Name="☀️ Mittag",Callback=function() pcall(function() Lighting.TimeOfDay="12:00:00" end); N("☀️","Mittag!",2) end})
TabWorld:CreateButton({Name="🏗️ Baseplate",Callback=function()
    local p=Instance.new("Part",workspace); p.Name="Baseplate"; p.Size=Vector3.new(2048,1,2048); p.Anchored=true; p.BrickColor=BrickColor.new("Medium green"); p.Material=Enum.Material.SmoothPlastic; p.CFrame=CFrame.new(0,0,0); N("🏗️","Baseplate!",3)
end})

-- ============================================================
-- NOTFALL
-- ============================================================
TabNotf:CreateSection("🚨 Notfall")
TabNotf:CreateButton({Name="🛑 ALLES AUS  [F5]",Callback=function()
    State.God=false; State.Speed=false; State.Fly=false; State.Noclip=false
    State.InfJump=false; State.Disco=false; State.Rainbow=false; State.Aimbot=false
    State.ESPChams=false; State.ESPNames=false; State.DiscoFog=false
    if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
    pcall(function() Lighting.FogEnd=100000 end)
    for _,plr in pairs(Players:GetPlayers()) do pcall(function() if plr.Character then local h=plr.Character:FindFirstChild("CeliESP_H"); if h then h:Destroy() end end end) end
    N("🛑","Alles deaktiviert!",4)
end})
TabNotf:CreateButton({Name="🔄 Rejoin",Callback=function() N("🔄","Rejoining...",2); task.wait(1); pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,Player) end) end})

-- ============================================================
-- LOOPS
-- ============================================================
RunService.Heartbeat:Connect(function()
    pcall(function()
        local root=GetRoot(); local hum=GetHum(); if not root then return end
        if State.Speed and hum and hum.MoveDirection.Magnitude>0 then local v=hum.MoveDirection*SpeedVal; root.Velocity=Vector3.new(v.X,root.Velocity.Y,v.Z) end
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
        -- ESP
        if State.ESPChams or State.ESPNames then
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=Player and plr.Character then
                    local char=plr.Character
                    if State.ESPChams and not char:FindFirstChild("CeliESP_H") then
                        local h=Instance.new("Highlight",char); h.Name="CeliESP_H"; h.FillColor=Color3.fromRGB(0,220,100); h.OutlineColor=Color3.new(1,1,1); h.FillTransparency=0.5
                    end
                    if not State.ESPChams then local h=char:FindFirstChild("CeliESP_H"); if h then h:Destroy() end end
                    if State.ESPNames then
                        local head=char:FindFirstChild("Head"); if head then
                            if not head:FindFirstChild("CeliESP_Tag") then
                                local bb=Instance.new("BillboardGui",head); bb.Name="CeliESP_Tag"; bb.Size=UDim2.fromOffset(180,40); bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true
                                local lbl=Instance.new("TextLabel",bb); lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=13; lbl.TextColor3=Color3.fromRGB(0,220,100); lbl.TextStrokeTransparency=0.3; lbl.Name="Lbl"
                            end
                            local lbl=head.CeliESP_Tag and head.CeliESP_Tag:FindFirstChild("Lbl")
                            if lbl and GetRoot() then lbl.Text=plr.Name.."\n"..math.floor((GetRoot().Position-head.Position).Magnitude).."m" end
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
                local hum=plr.Character:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health<=0 then continue end
                local head=plr.Character:FindFirstChild("Head"); if not head then continue end
                local sp,onS=Camera:WorldToViewportPoint(head.Position); if not onS then continue end
                local d=(Vector2.new(sp.X,sp.Y)-center).Magnitude
                if d<minD and d<AimbotFOV then minD=d; nearest=head end
            end
        end
        if nearest then Camera.CFrame=CFrame.new(Camera.CFrame.Position,nearest.Position) end
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
        State.ESPChams=false; State.ESPNames=false; State.DiscoFog=false
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end; FlyBV=nil
        pcall(function() Lighting.FogEnd=100000 end)
        N("🛑","ALLES AUS! [F5]",3)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if State.InfJump then local h=GetHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end
end)

N("🔧 CeliHub DEV","Early Access geladen! ✅  Kein Key benötigt",6)
