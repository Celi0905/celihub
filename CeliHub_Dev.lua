-- CeliHub | DEV VERSION 🔧
-- Made by Celi 💫
-- Nur via CeliHub_DevLoader.lua — Kein Key benötigt

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Lighting         = game:GetService("Lighting")
local SoundService     = game:GetService("SoundService")
local Player           = Players.LocalPlayer
local PlayerGui        = Player:WaitForChild("PlayerGui")
local Camera           = workspace.CurrentCamera

local function GetChar()  return Player.Character end
local function GetHum()   local c=GetChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot()  local c=GetChar(); return c and c:FindFirstChild("HumanoidRootPart") end
local function tw(o,p,t,s,d) pcall(function() TweenService:Create(o,TweenInfo.new(t or .3,s or Enum.EasingStyle.Quart,d or Enum.EasingDirection.Out),p):Play() end) end

-- ============================================================
-- DEV SPLASH (grüner Screen, kein Key)
-- ============================================================
local function ShowDevSplash()
    local SGui = Instance.new("ScreenGui"); SGui.Name="CeliDevSplash"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui
    local BG = Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.45},0.4)

    local Card = Instance.new("Frame",BG); Card.Size=UDim2.fromOffset(460,270); Card.Position=UDim2.new(.5,-230,.5,-135); Card.BackgroundColor3=Color3.fromRGB(10,10,18); Card.BackgroundTransparency=1; Card.BorderSizePixel=0; Card.ZIndex=2
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,16)
    local CS = Instance.new("UIStroke",Card); CS.Color=Color3.fromRGB(0,220,100); CS.Thickness=2
    tw(Card,{BackgroundTransparency=0},0.5)

    task.spawn(function()
        while Card and Card.Parent do
            task.wait(1.2); if not(Card and Card.Parent) then break end
            tw(CS,{Transparency=0.05,Color=Color3.fromRGB(0,255,120)},1.2,Enum.EasingStyle.Sine)
            task.wait(1.2); if not(Card and Card.Parent) then break end
            tw(CS,{Transparency=0.65,Color=Color3.fromRGB(0,180,80)},1.2,Enum.EasingStyle.Sine)
        end
    end)

    local Top = Instance.new("Frame",Card); Top.Size=UDim2.new(1,0,0,3); Top.BackgroundColor3=Color3.fromRGB(0,220,100); Top.BorderSizePixel=0; Top.ZIndex=4
    Instance.new("UICorner",Top).CornerRadius=UDim.new(0,16)

    -- DEV Badge oben rechts
    local BadF = Instance.new("Frame",Card); BadF.Size=UDim2.fromOffset(96,24); BadF.Position=UDim2.fromOffset(350,12); BadF.BackgroundColor3=Color3.fromRGB(0,175,75); BadF.BorderSizePixel=0; BadF.ZIndex=5
    Instance.new("UICorner",BadF).CornerRadius=UDim.new(0,7)
    local BadL = Instance.new("TextLabel",BadF); BadL.Size=UDim2.fromScale(1,1); BadL.BackgroundTransparency=1; BadL.Text="🔧 DEV BUILD"; BadL.TextColor3=Color3.new(1,1,1); BadL.Font=Enum.Font.GothamBold; BadL.TextSize=11; BadL.ZIndex=6

    -- Titel
    local TL = Instance.new("TextLabel",Card); TL.Size=UDim2.fromOffset(460,50); TL.Position=UDim2.fromOffset(0,14); TL.BackgroundTransparency=1; TL.Text="🔧  CELIHUB  DEV"; TL.TextColor3=Color3.new(1,1,1); TL.Font=Enum.Font.GothamBold; TL.TextSize=30; TL.ZIndex=3
    local SL = Instance.new("TextLabel",Card); SL.Size=UDim2.fromOffset(460,20); SL.Position=UDim2.fromOffset(0,60); SL.BackgroundTransparency=1; SL.Text="Early Access  •  Made by Celi 💫  •  Kein Key!"; SL.TextColor3=Color3.fromRGB(0,200,100); SL.Font=Enum.Font.Gotham; SL.TextSize=13; SL.ZIndex=3

    -- Info Box
    local IB = Instance.new("Frame",Card); IB.Size=UDim2.fromOffset(418,80); IB.Position=UDim2.fromOffset(21,90); IB.BackgroundColor3=Color3.fromRGB(0,22,10); IB.BorderSizePixel=0; IB.ZIndex=3
    Instance.new("UICorner",IB).CornerRadius=UDim.new(0,10); Instance.new("UIStroke",IB).Color=Color3.fromRGB(0,90,45)
    local IL = Instance.new("TextLabel",IB); IL.Size=UDim2.fromOffset(400,72); IL.Position=UDim2.fromOffset(9,4); IL.BackgroundTransparency=1
    IL.Text="✅  Kein Key benötigt\n⚡  Early Access — Spielauswahl verfügbar\n🔧  Alle Features freigeschaltet (Aimbot, ESP, etc.)\n🔒  Nur für Early Access Tester!"; IL.TextColor3=Color3.fromRGB(0,220,100); IL.Font=Enum.Font.GothamBold; IL.TextSize=12; IL.TextWrapped=true; IL.ZIndex=4; IL.TextXAlignment=Enum.TextXAlignment.Left; IL.TextYAlignment=Enum.TextYAlignment.Top

    local VerL = Instance.new("TextLabel",Card); VerL.Size=UDim2.fromOffset(460,18); VerL.Position=UDim2.fromOffset(0,182); VerL.BackgroundTransparency=1; VerL.Text="DEV-2026.02  •  Build #007  •  Early Access"; VerL.TextColor3=Color3.fromRGB(0,110,50); VerL.Font=Enum.Font.Code; VerL.TextSize=11; VerL.ZIndex=3

    -- Start Button
    local BF = Instance.new("Frame",Card); BF.Size=UDim2.fromOffset(418,46); BF.Position=UDim2.fromOffset(21,208); BF.BackgroundColor3=Color3.fromRGB(0,160,70); BF.BorderSizePixel=0; BF.ZIndex=3
    Instance.new("UICorner",BF).CornerRadius=UDim.new(0,12)
    local BT = Instance.new("TextButton",BF); BT.Size=UDim2.fromScale(1,1); BT.BackgroundTransparency=1; BT.Text="🔧  SPIEL AUSWÄHLEN  →"; BT.TextColor3=Color3.new(1,1,1); BT.Font=Enum.Font.GothamBold; BT.TextSize=16; BT.ZIndex=4
    BT.MouseEnter:Connect(function() tw(BF,{BackgroundColor3=Color3.fromRGB(0,200,90)},0.12) end)
    BT.MouseLeave:Connect(function() tw(BF,{BackgroundColor3=Color3.fromRGB(0,160,70)},0.12) end)

    local done = false
    BT.MouseButton1Click:Connect(function()
        if done then return end; done=true; BT.Text="✅  Weiter..."
        tw(BF,{BackgroundColor3=Color3.fromRGB(30,200,80)},0.3); task.wait(0.7)
        tw(Card,{BackgroundTransparency=1},0.28); tw(BG,{BackgroundTransparency=1},0.33); task.wait(0.4); SGui:Destroy()
    end)
    repeat task.wait(0.1) until done or not SGui.Parent
end

-- ============================================================
-- SPIEL AUSWAHL (Dev-Version — KEIN KEY, grünes Theme)
-- ============================================================
local EMDEN_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_EmdenEdition_v4.lua"
local HAMBURG_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Hamburg_Edition.lua"
local UNIVERSAL_URL = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Universal.lua"
local COOLGUI_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_c00lgui_Edition.lua"
local MUSIC_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_MusicPlayer.lua"
local DEV_SELF_URL  = nil -- Direkte Dev-Features, kein externes Script

local function ShowDevGameSelector()
    local old = PlayerGui:FindFirstChild("CeliDevSel"); if old then old:Destroy() end
    local SGui = Instance.new("ScreenGui"); SGui.Name="CeliDevSel"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui
    local BG = Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.42},0.4)

    -- Partikel
    for i=1,14 do
        local dot=Instance.new("Frame",BG); dot.Size=UDim2.fromOffset(math.random(2,5),math.random(2,5))
        dot.Position=UDim2.fromScale(math.random(2,98)/100,1.05)
        dot.BackgroundColor3=({Color3.fromRGB(0,220,100),Color3.fromRGB(0,255,140),Color3.fromRGB(30,180,80),Color3.fromRGB(255,140,0)})[math.random(1,4)]
        dot.BackgroundTransparency=math.random(30,65)/100; dot.BorderSizePixel=0; dot.ZIndex=1
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                task.wait(math.random(6,14))
                if not(dot and dot.Parent) then break end
                tw(dot,{Position=UDim2.fromScale(dot.Position.X.Scale,-0.05)},math.random(6,14),Enum.EasingStyle.Linear)
                task.wait(math.random(5,12))
                if not(dot and dot.Parent) then break end
                dot.Position=UDim2.fromScale(math.random(2,98)/100,1.05)
            end
        end)
    end

    -- 5 Karten: 4 normale + DEV FEATURES eigen
    local GAMES = {
        {icon="🚨", title="Emergency Emden",   desc="Speed • Fly • NoClip\nAimbot • Admin Check • ESP",    col=Color3.fromRGB(220,40,40),  glow=Color3.fromRGB(255,80,80),  key="emden"},
        {icon="🏙️", title="Emergency Hamburg", desc="Fahrzeug Mods • Waffen\nAuto Eat • Emden+",           col=Color3.fromRGB(40,110,220), glow=Color3.fromRGB(80,150,255), key="hamburg"},
        {icon="🌍", title="Universal",          desc="Aimbot • ESP • Tracer\nChams • Alle Spiele",          col=Color3.fromRGB(160,40,220), glow=Color3.fromRGB(200,90,255), key="universal"},
        {icon="🟠", title="c00lgui Edition",    desc="Speed/Fly • Skybox • Music\nServer Tools • Disco",    col=Color3.fromRGB(255,140,0),  glow=Color3.fromRGB(255,180,50), key="coolgui"},
        {icon="🎵", title="Celi Music Player", desc="Playlist • Presets • Pitch\nLautstärke • Loop • IDs",   col=Color3.fromRGB(220,60,180), glow=Color3.fromRGB(255,100,220), key="music"},
        {icon="🔧", title="Dev Features",       desc="Aimbot • ESP • Disco\nWorld Tools • Alles Frei",      col=Color3.fromRGB(0,200,80),  glow=Color3.fromRGB(0,255,120),  key="devself", badge="🔧 DEV"},
    }

    local WIN_W = 1260
    local Win = Instance.new("Frame",BG); Win.Size=UDim2.fromOffset(WIN_W,340); Win.Position=UDim2.new(.5,-WIN_W/2,.6,-170); Win.BackgroundColor3=Color3.fromRGB(10,10,18); Win.BackgroundTransparency=1; Win.BorderSizePixel=0; Win.ZIndex=2
    Instance.new("UICorner",Win).CornerRadius=UDim.new(0,20)
    local WSt = Instance.new("UIStroke",Win); WSt.Color=Color3.fromRGB(0,100,50); WSt.Thickness=1.5
    tw(Win,{BackgroundTransparency=0,Position=UDim2.new(.5,-WIN_W/2,.5,-170)},0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    -- Grüner Balken
    local TLine = Instance.new("Frame",Win); TLine.Size=UDim2.new(0,0,0,3); TLine.BackgroundColor3=Color3.fromRGB(0,220,100); TLine.BorderSizePixel=0; TLine.ZIndex=5
    Instance.new("UICorner",TLine).CornerRadius=UDim.new(0,20)
    task.delay(0.2,function() tw(TLine,{Size=UDim2.new(1,0,0,3)},0.6) end)

    local HF = Instance.new("Frame",Win); HF.Size=UDim2.new(1,0,0,76); HF.BackgroundColor3=Color3.fromRGB(8,18,12); HF.BorderSizePixel=0; HF.ZIndex=3
    Instance.new("UICorner",HF).CornerRadius=UDim.new(0,20)
    local HTL = Instance.new("TextLabel",HF); HTL.Size=UDim2.fromOffset(WIN_W,44); HTL.Position=UDim2.fromOffset(0,10); HTL.BackgroundTransparency=1; HTL.Text="🔧  CELIHUB DEV  —  SPIEL AUSWÄHLEN"; HTL.TextColor3=Color3.new(1,1,1); HTL.Font=Enum.Font.GothamBold; HTL.TextSize=23; HTL.ZIndex=4; HTL.TextTransparency=1
    task.delay(0.1,function() tw(HTL,{TextTransparency=0},0.4) end)
    local HSL = Instance.new("TextLabel",HF); HSL.Size=UDim2.fromOffset(WIN_W,24); HSL.Position=UDim2.fromOffset(0,52); HSL.BackgroundTransparency=1; HSL.Text="Kein Key benötigt ✅  —  Dev Early Access Build #007"; HSL.TextColor3=Color3.fromRGB(0,180,70); HSL.Font=Enum.Font.Gotham; HSL.TextSize=13; HSL.ZIndex=4; HSL.TextTransparency=1
    task.delay(0.18,function() tw(HSL,{TextTransparency=0},0.4) end)

    local chosen = nil
    local cardW  = 192

    for idx,g in ipairs(GAMES) do
        local xOff = 14+(idx-1)*(cardW+14); local gRef=g
        local GF = Instance.new("Frame",Win); GF.Size=UDim2.fromOffset(cardW,230); GF.Position=UDim2.fromOffset(xOff,90); GF.BackgroundColor3=Color3.fromRGB(16,16,27); GF.BackgroundTransparency=1; GF.BorderSizePixel=0; GF.ZIndex=3
        Instance.new("UICorner",GF).CornerRadius=UDim.new(0,15)
        local GSt = Instance.new("UIStroke",GF); GSt.Color=Color3.fromRGB(35,35,60); GSt.Thickness=1.5
        task.delay(0.08*idx,function() if GF and GF.Parent then tw(GF,{BackgroundTransparency=0},0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out) end end)

        local GTop = Instance.new("Frame",GF); GTop.Size=UDim2.new(1,0,0,3); GTop.BackgroundColor3=gRef.col; GTop.BorderSizePixel=0; GTop.ZIndex=4
        Instance.new("UICorner",GTop).CornerRadius=UDim.new(0,15)

        -- Dev Badge (nur für Dev-Karte)
        if gRef.badge then
            local BadF = Instance.new("Frame",GF); BadF.Size=UDim2.fromOffset(cardW-16,20); BadF.Position=UDim2.fromOffset(8,8); BadF.BackgroundColor3=gRef.col; BadF.BackgroundTransparency=0.3; BadF.BorderSizePixel=0; BadF.ZIndex=5
            Instance.new("UICorner",BadF).CornerRadius=UDim.new(0,6)
            local BL = Instance.new("TextLabel",BadF); BL.Size=UDim2.fromScale(1,1); BL.BackgroundTransparency=1; BL.Text=gRef.badge; BL.TextColor3=Color3.new(1,1,1); BL.Font=Enum.Font.GothamBold; BL.TextSize=11; BL.ZIndex=6
        end

        local badgeOff = gRef.badge and 22 or 0
        local ICir = Instance.new("Frame",GF); ICir.Size=UDim2.fromOffset(52,52); ICir.Position=UDim2.fromOffset(cardW/2-26,10+badgeOff); ICir.BackgroundColor3=gRef.col; ICir.BackgroundTransparency=0.7; ICir.BorderSizePixel=0; ICir.ZIndex=4
        Instance.new("UICorner",ICir).CornerRadius=UDim.new(1,0)
        local IL = Instance.new("TextLabel",ICir); IL.Size=UDim2.fromScale(1,1); IL.BackgroundTransparency=1; IL.Text=gRef.icon; IL.TextSize=28; IL.Font=Enum.Font.GothamBold; IL.ZIndex=5

        local TL2 = Instance.new("TextLabel",GF); TL2.Size=UDim2.fromOffset(cardW-14,32); TL2.Position=UDim2.fromOffset(7,74+badgeOff); TL2.BackgroundTransparency=1; TL2.Text=gRef.title; TL2.TextColor3=Color3.fromRGB(240,240,255); TL2.Font=Enum.Font.GothamBold; TL2.TextSize=12; TL2.TextWrapped=true; TL2.ZIndex=4
        local DL2 = Instance.new("TextLabel",GF); DL2.Size=UDim2.fromOffset(cardW-14,56); DL2.Position=UDim2.fromOffset(7,106+badgeOff); DL2.BackgroundTransparency=1; DL2.Text=gRef.desc; DL2.TextColor3=Color3.fromRGB(85,85,120); DL2.Font=Enum.Font.Gotham; DL2.TextSize=10.5; DL2.TextWrapped=true; DL2.ZIndex=4

        local BF2 = Instance.new("Frame",GF); BF2.Size=UDim2.fromOffset(cardW-18,38); BF2.Position=UDim2.fromOffset(9,184); BF2.BackgroundColor3=gRef.col; BF2.BorderSizePixel=0; BF2.ZIndex=4
        Instance.new("UICorner",BF2).CornerRadius=UDim.new(0,11)
        local BT2 = Instance.new("TextButton",BF2); BT2.Size=UDim2.fromScale(1,1); BT2.BackgroundTransparency=1; BT2.Text=gRef.key=="devself" and "🔧 STARTEN" or "▶  STARTEN"; BT2.TextColor3=Color3.new(1,1,1); BT2.Font=Enum.Font.GothamBold; BT2.TextSize=13; BT2.ZIndex=5

        local gF2,gS2,bF2 = GF,GSt,BF2
        BT2.MouseEnter:Connect(function() tw(gF2,{BackgroundColor3=Color3.fromRGB(22,22,40)},0.14); tw(gS2,{Color=gRef.col,Transparency=0.2},0.14); tw(bF2,{BackgroundColor3=gRef.glow},0.14) end)
        BT2.MouseLeave:Connect(function() tw(gF2,{BackgroundColor3=Color3.fromRGB(16,16,27)},0.14); tw(gS2,{Color=Color3.fromRGB(35,35,60),Transparency=0},0.14); tw(bF2,{BackgroundColor3=gRef.col},0.14) end)
        BT2.MouseButton1Click:Connect(function()
            if chosen then return end; chosen=gRef.key
            tw(gF2,{BackgroundColor3=gRef.col},0.1); task.wait(0.15)
            tw(Win,{BackgroundTransparency=1},0.28); tw(BG,{BackgroundTransparency=1},0.32); task.wait(0.35); SGui:Destroy()
        end)
    end

    local Foot = Instance.new("TextLabel",Win); Foot.Size=UDim2.fromOffset(WIN_W,22); Foot.Position=UDim2.fromOffset(0,316); Foot.BackgroundTransparency=1
    Foot.Text="CeliHub Dev  •  by Celi 💫  •  6 Optionen  •  Kein Key benötigt"; Foot.TextColor3=Color3.fromRGB(0,100,45); Foot.Font=Enum.Font.Gotham; Foot.TextSize=11; Foot.ZIndex=3

    repeat task.wait(0.1) until chosen~=nil or not SGui.Parent
    return chosen or "devself"
end

-- ============================================================
-- Rayfield laden mit Retry
-- ============================================================
local function LoadRayfield()
    local Rayfield
    for attempt=1,3 do
        local ok,result=pcall(function()
            return loadstring(game:HttpGet("https://sirius.menu/rayfield",true))()
        end)
        if ok and result then Rayfield=result; break end
        task.wait(1.5)
    end
    return Rayfield
end

-- ============================================================
-- SPLASH → SPIEL WÄHLEN
-- ============================================================
ShowDevSplash()
local choice = ShowDevGameSelector()

-- Externe Scripts starten (außer devself)
if choice ~= "devself" then
    local URLS = {
        emden=EMDEN_URL, hamburg=HAMBURG_URL,
        universal=UNIVERSAL_URL, coolgui=COOLGUI_URL, music=MUSIC_URL,
    }
    local url = URLS[choice]
    if url then
        local ok,err = pcall(function() loadstring(game:HttpGet(url,true))() end)
        if not ok then warn("[CeliHub Dev] Ladefehler: "..tostring(err)) end
    end
    return -- Externes Script hat seine eigene GUI
end

-- ============================================================
-- DEV FEATURES — nur wenn "devself" gewählt
-- Rayfield laden
-- ============================================================
local Rayfield = LoadRayfield()
if not Rayfield then warn("[CeliHub Dev] Rayfield konnte nicht geladen werden!"); return end

-- ============================================================
-- States & Config
-- ============================================================
local State={God=false,Speed=false,Fly=false,Noclip=false,InfJump=false,Disco=false,Rainbow=false,ESPChams=false,ESPNames=false,Aimbot=false,DiscoFog=false}
local SpeedVal=80; local FlyBV=nil; local SavedPos=nil; local AimbotFOV=150
local MusicPitch=1.0; local MusicVolume=0.6; local MusicLooped=true
local Playlist={}; local PlaylistIndex=1

-- ============================================================
-- Window (grün)
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "CeliHub 🔧  DEV VERSION",
    LoadingTitle    = "CeliHub DEV",
    LoadingSubtitle = "Early Access Build #007  •  Made by Celi 💫",
    ConfigurationSaving={Enabled=true,FolderName="CeliHub_Dev"},
    KeySystem=false,
})

local function N(t,c,d) pcall(function() Rayfield:Notify({Title=tostring(t),Content=tostring(c),Duration=d or 3}) end) end

-- ============================================================
-- TABS
-- ============================================================
local TabInfo   = Window:CreateTab("🔧 Dev Info",      4483362458)
local TabPlay   = Window:CreateTab("🧍 Player",        4483362458)
local TabMove   = Window:CreateTab("🚀 Movement",      4483362458)
local TabCombat = Window:CreateTab("🎯 Combat",        4483362458)
local TabESP    = Window:CreateTab("👁️ ESP",           4483362458)
local TabMusic  = Window:CreateTab("🎵 Celi Music",    4483362458)
local TabWorld  = Window:CreateTab("🌍 World",         4483362458)
local TabNotf   = Window:CreateTab("🚨 Notfall",       4483362458)

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
TabPlay:CreateSection("🧍 Basics")
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
TabPlay:CreateButton({Name="📍 Pos speichern  [T]",Callback=function() SavedPos=GetRoot() and GetRoot().CFrame; N("📍","Gespeichert!",2) end})
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
TabCombat:CreateSlider({Name="🔵 FOV Radius",Range={10,500},Increment=5,CurrentValue=150,Callback=function(v) AimbotFOV=v end})
TabCombat:CreateButton({Name="📍 TP zum nächsten Spieler",Callback=function()
    local root=GetRoot(); if not root then return end
    local nearest,minD=nil,math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player and plr.Character then
            local r=plr.Character:FindFirstChild("HumanoidRootPart")
            if r then local d=(root.Position-r.Position).Magnitude; if d<minD then minD=d; nearest=r end end
        end
    end
    if nearest then root.CFrame=CFrame.new(nearest.Position+Vector3.new(3,0,3)); N("📍","Teleportiert! "..math.floor(minD).."m",3)
    else N("❌","Kein Spieler gefunden!",3) end
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
    if not v then
        for _,plr in pairs(Players:GetPlayers()) do pcall(function()
            if plr.Character then local head=plr.Character:FindFirstChild("Head"); if head then local t=head:FindFirstChild("CeliESP_Tag"); if t then t:Destroy() end end end
        end) end
    end
    N("🏷️ Namen",v and "AN!" or "AUS.",2)
end})

-- ============================================================
-- 🎵 CELI MUSIC PLAYER
-- ============================================================
local function GetOrCreateMusic()
    local existing = workspace:FindFirstChild("CeliMusicPlayer")
    if existing and existing:IsA("Sound") then return existing end
    local s = Instance.new("Sound",workspace); s.Name="CeliMusicPlayer"; s.Volume=MusicVolume; s.PlaybackSpeed=MusicPitch; s.Looped=MusicLooped; return s
end

TabMusic:CreateSection("🎵 Celi Music Player")
TabMusic:CreateInput({Name="🎵 Sound ID eingeben",PlaceholderText="z.B. 142930454",RemoveTextAfterFocusLost=false,Callback=function(v)
    local id = v:gsub("%D","")
    if id=="" then return end
    local s=GetOrCreateMusic(); s.SoundId="rbxassetid://"..id; s.Volume=MusicVolume; s.PlaybackSpeed=MusicPitch; s.Looped=MusicLooped; s:Play()
    N("🎵 Celi Music","Spielt ID: "..id,4)
end})

TabMusic:CreateSection("⏯️ Steuerung")
TabMusic:CreateButton({Name="▶️ Play",Callback=function()
    local s=GetOrCreateMusic(); if s.SoundId~="" then s:Play(); N("▶️ Play","Musik spielt!",2) else N("❌","Zuerst eine ID eingeben!",3) end
end})
TabMusic:CreateButton({Name="⏸️ Pause",Callback=function()
    local s=workspace:FindFirstChild("CeliMusicPlayer"); if s then s:Pause(); N("⏸️ Pause","Pausiert.",2) end
end})
TabMusic:CreateButton({Name="⏹️ Stop",Callback=function()
    local s=workspace:FindFirstChild("CeliMusicPlayer"); if s then s:Stop(); s:Destroy(); N("⏹️ Stop","Gestoppt.",2) end
end})
TabMusic:CreateButton({Name="⏭️ Nächster Song (Playlist)",Callback=function()
    if #Playlist==0 then N("❌","Playlist leer!",3); return end
    PlaylistIndex=PlaylistIndex%#Playlist+1
    local id=Playlist[PlaylistIndex]; local s=GetOrCreateMusic(); s.SoundId="rbxassetid://"..id; s:Play(); N("⏭️ Weiter","Song "..PlaylistIndex.."/"..#Playlist.."  •  ID "..id,3)
end})

TabMusic:CreateSection("🔊 Einstellungen")
TabMusic:CreateSlider({Name="🔊 Lautstärke",Range={0,2},Increment=0.05,CurrentValue=0.6,Callback=function(v)
    MusicVolume=v; local s=workspace:FindFirstChild("CeliMusicPlayer"); if s then s.Volume=v end
end})
TabMusic:CreateSlider({Name="🎚️ Pitch",Range={0.1,3},Increment=0.05,CurrentValue=1,Callback=function(v)
    MusicPitch=v; local s=workspace:FindFirstChild("CeliMusicPlayer"); if s then s.PlaybackSpeed=v end
end})
TabMusic:CreateToggle({Name="🔁 Loop",CurrentValue=true,Callback=function(v)
    MusicLooped=v; local s=workspace:FindFirstChild("CeliMusicPlayer"); if s then s.Looped=v end
    N("🔁 Loop",v and "AN!" or "AUS.",2)
end})

TabMusic:CreateSection("📋 Playlist")
TabMusic:CreateInput({Name="➕ Song zur Playlist (ID)",PlaceholderText="Sound ID...",RemoveTextAfterFocusLost=true,Callback=function(v)
    local id=v:gsub("%D",""); if id=="" then return end
    table.insert(Playlist,id); N("➕ Playlist","Song "..#Playlist.." hinzugefügt: "..id,3)
end})
TabMusic:CreateButton({Name="📋 Playlist anzeigen",Callback=function()
    if #Playlist==0 then N("📋 Playlist","Leer! Füge Songs hinzu.",3); return end
    local txt=""; for i,id in ipairs(Playlist) do txt=txt..i..".  "..id.."\n" end
    N("📋 Playlist ("..#Playlist..")",txt:sub(1,200),5)
end})
TabMusic:CreateButton({Name="🗑️ Playlist leeren",Callback=function()
    Playlist={}; PlaylistIndex=1; N("🗑️","Playlist geleert.",2)
end})

TabMusic:CreateSection("🎵 Preset Songs")
local PRESET_SONGS={
    {"🎵 Electro Sp00k",     "142930454"},
    {"🎵 Wonga",             "130768996"},
    {"🎵 Chop Suey",         "143666548"},
    {"😱 Scream",            "26120219"},
    {"🎵 Never Gonna Give",  "130860862"},
    {"🎵 Megalovania",       "585015180"},
    {"🎵 Among Drip",        "6823767794"},
    {"🎵 Troll Song",        "144455674"},
}
for _,m in ipairs(PRESET_SONGS) do
    local lbl,id=m[1],m[2]
    TabMusic:CreateButton({Name=lbl,Callback=function()
        local s=GetOrCreateMusic(); s.SoundId="rbxassetid://"..id; s.Volume=MusicVolume; s.PlaybackSpeed=MusicPitch; s.Looped=MusicLooped; s:Play(); N("🎵 Celi Music",lbl.." spielt!",4)
    end})
end

-- ============================================================
-- WORLD
-- ============================================================
TabWorld:CreateSection("🌍 World Tools")
TabWorld:CreateButton({Name="🌊 Flood",Callback=function()
    pcall(function() local root=GetRoot(); local p=Instance.new("Part",workspace); p.Size=Vector3.new(4096,1,4096); p.Anchored=true; p.CanCollide=true; p.Material=Enum.Material.SmoothPlastic; p.BrickColor=BrickColor.new("Cyan"); p.CFrame=CFrame.new(0,root and root.Position.Y-5 or 0,0) end); N("🌊","Flood!",3)
end})
TabWorld:CreateButton({Name="🔓 Unanchor All",Callback=function()
    local c=0; for _,v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and v.Anchored then pcall(function() v.Anchored=false end); c=c+1 end end; N("🔓",c.." Parts!",3)
end})
TabWorld:CreateButton({Name="💀 Kill All",Callback=function()
    for _,plr in pairs(Players:GetPlayers()) do if plr~=Player then pcall(function() local h=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid"); if h then h.Health=0 end end) end end; N("💀","Kill All!",3)
end})
TabWorld:CreateButton({Name="💥 Explosion Spam",Callback=function()
    task.spawn(function() for _=1,25 do pcall(function() local e=Instance.new("Explosion",workspace); e.Position=Vector3.new(math.random(-200,200),0,math.random(-200,200)); e.BlastRadius=15; e.BlastPressure=500000 end); task.wait(0.08) end end); N("💥","Explosionen!",3)
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
TabWorld:CreateButton({Name="🏗️ Clear Terrain",Callback=function() workspace.Terrain:Clear(); N("🏗️","Terrain weg!",3) end})

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
-- MAIN LOOPS
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
                            local lbl=head:FindFirstChild("CeliESP_Tag") and head.CeliESP_Tag:FindFirstChild("Lbl")
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

N("🔧 CeliHub DEV","Early Access geladen! Kein Key benötigt ✅",6)
