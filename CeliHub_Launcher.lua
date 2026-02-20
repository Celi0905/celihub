-- CeliHub Launcher v3 | Made by Celi 💫
-- NUR 4 Karten: Emden / Hamburg / Universal / c00lgui
-- Dev Version ist GESPERRT — nur über CeliHub_DevLoader.lua

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player           = Players.LocalPlayer
local PlayerGui        = Player:WaitForChild("PlayerGui")

local VALID_KEY     = "celi2026"
local KEY_WEBSITE   = "key.celihub.site"
local EMDEN_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_EmdenEdition_v4.lua"
local HAMBURG_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Hamburg_Edition.lua"
local UNIVERSAL_URL = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Universal.lua"
local COOLGUI_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_c00lgui_Edition.lua"
local MUSIC_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_MusicPlayer.lua"
-- DEV_URL existiert NICHT hier — Dev läuft nur über CeliHub_DevLoader.lua

local function tw(o,p,t,s,d)
    pcall(function()
        TweenService:Create(o,TweenInfo.new(t or .3,s or Enum.EasingStyle.Quart,d or Enum.EasingDirection.Out),p):Play()
    end)
end

-- ============================================================
-- KEY SCREEN
-- ============================================================
local function ShowKeyScreen()
    local old=PlayerGui:FindFirstChild("CeliHubKey"); if old then old:Destroy() end
    local SGui=Instance.new("ScreenGui"); SGui.Name="CeliHubKey"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui

    local BG=Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.45},0.5)

    for i=1,12 do
        local dot=Instance.new("Frame",BG); dot.Size=UDim2.fromOffset(math.random(3,6),math.random(3,6))
        dot.Position=UDim2.fromScale(math.random(5,95)/100,math.random(5,95)/100)
        dot.BackgroundColor3=Color3.fromRGB(255,140,0); dot.BackgroundTransparency=math.random(50,80)/100; dot.BorderSizePixel=0; dot.ZIndex=1
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                task.wait(math.random(3,7)); if not(dot and dot.Parent) then break end
                tw(dot,{Position=UDim2.fromScale(math.clamp(dot.Position.X.Scale+math.random(-10,10)/100,.02,.97),math.clamp(dot.Position.Y.Scale+math.random(-10,10)/100,.02,.97)),BackgroundTransparency=math.random(40,82)/100},math.random(3,7),Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
            end
        end)
    end

    local Card=Instance.new("Frame",BG); Card.Size=UDim2.fromOffset(460,300); Card.Position=UDim2.new(.5,-230,.5,-150); Card.BackgroundColor3=Color3.fromRGB(11,11,20); Card.BackgroundTransparency=1; Card.BorderSizePixel=0; Card.ZIndex=2
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,18)
    local CS=Instance.new("UIStroke",Card); CS.Color=Color3.fromRGB(255,140,0); CS.Thickness=1.5; CS.Transparency=0.6
    tw(Card,{BackgroundTransparency=0},0.5)

    task.spawn(function()
        while Card and Card.Parent do
            task.wait(1.3); if not(Card and Card.Parent) then break end
            tw(CS,{Transparency=0.08,Color=Color3.fromRGB(255,160,0)},1.2,Enum.EasingStyle.Sine)
            task.wait(1.3); if not(Card and Card.Parent) then break end
            tw(CS,{Transparency=0.7,Color=Color3.fromRGB(255,120,0)},1.2,Enum.EasingStyle.Sine)
        end
    end)

    local TopBar=Instance.new("Frame",Card); TopBar.Size=UDim2.new(0,0,0,3); TopBar.BackgroundColor3=Color3.fromRGB(255,140,0); TopBar.BorderSizePixel=0; TopBar.ZIndex=4
    Instance.new("UICorner",TopBar).CornerRadius=UDim.new(0,18)
    task.delay(0.2,function() tw(TopBar,{Size=UDim2.new(1,0,0,3)},0.55) end)

    local function Lbl(parent,size,pos,text,color,font,tsize,transp)
        local L=Instance.new("TextLabel",parent); L.Size=size; L.Position=pos; L.BackgroundTransparency=1; L.Text=text; L.TextColor3=color; L.Font=font; L.TextSize=tsize; L.ZIndex=3; L.TextTransparency=transp or 0; return L
    end

    local TL=Lbl(Card,UDim2.fromOffset(460,44),UDim2.fromOffset(0,14),"🟠  CELIHUB",Color3.new(1,1,1),Enum.Font.GothamBold,28,1)
    task.delay(0.1,function() tw(TL,{TextTransparency=0},0.4) end)
    local SL=Lbl(Card,UDim2.fromOffset(460,20),UDim2.fromOffset(0,58),"Made by Celi 💫  •  "..KEY_WEBSITE,Color3.fromRGB(100,100,130),Enum.Font.Gotham,13,1)
    task.delay(0.15,function() tw(SL,{TextTransparency=0},0.4) end)

    local Div=Instance.new("Frame",Card); Div.Position=UDim2.fromOffset(20,88); Div.Size=UDim2.new(0,0,0,1); Div.BackgroundColor3=Color3.fromRGB(35,35,58); Div.BorderSizePixel=0; Div.ZIndex=3
    task.delay(0.2,function() tw(Div,{Size=UDim2.new(1,-40,0,1)},0.5) end)

    local CpBG=Instance.new("Frame",Card); CpBG.Size=UDim2.fromOffset(420,36); CpBG.Position=UDim2.fromOffset(20,100); CpBG.BackgroundColor3=Color3.fromRGB(20,20,35); CpBG.BorderSizePixel=0; CpBG.ZIndex=3
    Instance.new("UICorner",CpBG).CornerRadius=UDim.new(0,9)
    local CpBtn=Instance.new("TextButton",CpBG); CpBtn.Size=UDim2.fromScale(1,1); CpBtn.BackgroundTransparency=1; CpBtn.Text="📋   "..KEY_WEBSITE.."  —  Klicken zum Kopieren"; CpBtn.TextColor3=Color3.fromRGB(200,120,0); CpBtn.Font=Enum.Font.Code; CpBtn.TextSize=13; CpBtn.ZIndex=4
    CpBtn.MouseButton1Click:Connect(function() pcall(function() setclipboard(KEY_WEBSITE) end); CpBtn.Text="✅  Kopiert!"; CpBtn.TextColor3=Color3.fromRGB(60,220,100); task.wait(1.5); CpBtn.Text="📋   "..KEY_WEBSITE.."  —  Klicken zum Kopieren"; CpBtn.TextColor3=Color3.fromRGB(200,120,0) end)

    local InLbl=Instance.new("TextLabel",Card); InLbl.Size=UDim2.fromOffset(420,18); InLbl.Position=UDim2.fromOffset(20,148); InLbl.BackgroundTransparency=1; InLbl.Text="KEY EINGEBEN"; InLbl.TextColor3=Color3.fromRGB(150,90,0); InLbl.Font=Enum.Font.GothamBold; InLbl.TextSize=11; InLbl.TextXAlignment=Enum.TextXAlignment.Left; InLbl.ZIndex=3

    local InBG=Instance.new("Frame",Card); InBG.Size=UDim2.fromOffset(420,48); InBG.Position=UDim2.fromOffset(20,168); InBG.BackgroundColor3=Color3.fromRGB(17,17,30); InBG.BorderSizePixel=0; InBG.ZIndex=3
    Instance.new("UICorner",InBG).CornerRadius=UDim.new(0,11)
    local ISt=Instance.new("UIStroke",InBG); ISt.Color=Color3.fromRGB(38,38,68); ISt.Thickness=1.5
    local InBox=Instance.new("TextBox",InBG); InBox.Size=UDim2.new(1,-20,1,0); InBox.Position=UDim2.fromOffset(10,0); InBox.BackgroundTransparency=1; InBox.PlaceholderText="Key eingeben..."; InBox.PlaceholderColor3=Color3.fromRGB(55,55,90); InBox.Text=""; InBox.TextColor3=Color3.new(1,1,1); InBox.Font=Enum.Font.Code; InBox.TextSize=18; InBox.ClearTextOnFocus=false; InBox.ZIndex=4
    InBox.Focused:Connect(function() tw(ISt,{Color=Color3.fromRGB(255,140,0),Thickness=2},0.2) end)
    InBox.FocusLost:Connect(function() tw(ISt,{Color=Color3.fromRGB(38,38,68),Thickness=1.5},0.2) end)

    local Stat=Instance.new("TextLabel",Card); Stat.Size=UDim2.fromOffset(420,22); Stat.Position=UDim2.fromOffset(20,222); Stat.BackgroundTransparency=1; Stat.Text=""; Stat.TextColor3=Color3.fromRGB(220,80,80); Stat.Font=Enum.Font.GothamBold; Stat.TextSize=13; Stat.TextXAlignment=Enum.TextXAlignment.Left; Stat.ZIndex=3

    local BtnF=Instance.new("Frame",Card); BtnF.Size=UDim2.fromOffset(420,50); BtnF.Position=UDim2.fromOffset(20,246); BtnF.BackgroundColor3=Color3.fromRGB(200,100,0); BtnF.BorderSizePixel=0; BtnF.ZIndex=3
    Instance.new("UICorner",BtnF).CornerRadius=UDim.new(0,13)
    local BtnT=Instance.new("TextButton",BtnF); BtnT.Size=UDim2.fromScale(1,1); BtnT.BackgroundTransparency=1; BtnT.Text="EINLOGGEN  →"; BtnT.TextColor3=Color3.new(1,1,1); BtnT.Font=Enum.Font.GothamBold; BtnT.TextSize=17; BtnT.ZIndex=4
    BtnT.MouseEnter:Connect(function() tw(BtnF,{BackgroundColor3=Color3.fromRGB(255,140,0)},0.12) end)
    BtnT.MouseLeave:Connect(function() tw(BtnF,{BackgroundColor3=Color3.fromRGB(200,100,0)},0.12) end)

    local function shake()
        for _=1,3 do tw(Card,{Position=UDim2.new(.5,-239,.5,-150)},0.04); task.wait(0.05); tw(Card,{Position=UDim2.new(.5,-221,.5,-150)},0.04); task.wait(0.05) end
        tw(Card,{Position=UDim2.new(.5,-230,.5,-150)},0.05)
    end

    local verified=false
    local function DoVerify()
        local k=InBox.Text:lower():gsub("%s+","")
        if k=="" then Stat.Text="❌  Key eingeben!"; shake(); return end
        if k==VALID_KEY then
            verified=true; Stat.TextColor3=Color3.fromRGB(60,220,100); Stat.Text="✅  Gültig — Weiter..."
            BtnT.Text="✅  ZUGANG GEWÄHRT"; tw(BtnF,{BackgroundColor3=Color3.fromRGB(30,165,80)},0.3); tw(CS,{Color=Color3.fromRGB(255,180,0),Transparency=0},0.4)
            task.wait(0.9); tw(Card,{BackgroundTransparency=1},0.3); tw(BG,{BackgroundTransparency=1},0.35); task.wait(0.4); SGui:Destroy()
        else
            Stat.TextColor3=Color3.fromRGB(220,80,80); Stat.Text="❌  Falscher Key!  →  "..KEY_WEBSITE; InBox.Text=""
            tw(BtnF,{BackgroundColor3=Color3.fromRGB(155,40,0)},0.1); task.wait(0.15); tw(BtnF,{BackgroundColor3=Color3.fromRGB(200,100,0)},0.2); shake()
        end
    end
    BtnT.MouseButton1Click:Connect(DoVerify)
    InBox.FocusLost:Connect(function(ep) if ep then DoVerify() end end)
    repeat task.wait(0.1) until verified or not SGui.Parent
    return verified
end

-- ============================================================
-- GAME SELECTOR  — KEINE DEV KARTE
-- ============================================================
local function ShowGameSelector()
    local old=PlayerGui:FindFirstChild("CeliHubSel"); if old then old:Destroy() end
    local SGui=Instance.new("ScreenGui"); SGui.Name="CeliHubSel"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true; SGui.Parent=PlayerGui

    local BG=Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.40},0.5)

    for i=1,16 do
        local dot=Instance.new("Frame",BG); local sz=math.random(2,5); dot.Size=UDim2.fromOffset(sz,sz)
        dot.Position=UDim2.fromScale(math.random(2,98)/100,1.05)
        dot.BackgroundColor3=({Color3.fromRGB(255,140,0),Color3.fromRGB(220,40,40),Color3.fromRGB(40,110,220),Color3.fromRGB(160,40,220)})[math.random(1,4)]
        dot.BackgroundTransparency=math.random(30,70)/100; dot.BorderSizePixel=0; dot.ZIndex=1
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                task.wait(math.random(7,16)); if not(dot and dot.Parent) then break end
                tw(dot,{Position=UDim2.fromScale(dot.Position.X.Scale,-0.05)},math.random(7,16),Enum.EasingStyle.Linear)
                task.wait(math.random(7,16)); if not(dot and dot.Parent) then break end
                dot.Position=UDim2.fromScale(math.random(2,98)/100,1.05)
            end
        end)
    end

    local WIN_W=1062
    local Win=Instance.new("Frame",BG); Win.Size=UDim2.fromOffset(WIN_W,340); Win.Position=UDim2.new(.5,-WIN_W/2,.6,-170); Win.BackgroundColor3=Color3.fromRGB(10,10,18); Win.BackgroundTransparency=1; Win.BorderSizePixel=0; Win.ZIndex=2
    Instance.new("UICorner",Win).CornerRadius=UDim.new(0,20); Instance.new("UIStroke",Win).Color=Color3.fromRGB(42,42,70)
    tw(Win,{BackgroundTransparency=0,Position=UDim2.new(.5,-WIN_W/2,.5,-170)},0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    local TLine=Instance.new("Frame",Win); TLine.Size=UDim2.new(0,0,0,3); TLine.BackgroundColor3=Color3.fromRGB(255,140,0); TLine.BorderSizePixel=0; TLine.ZIndex=5
    Instance.new("UICorner",TLine).CornerRadius=UDim.new(0,20)
    task.delay(0.2,function() tw(TLine,{Size=UDim2.new(1,0,0,3)},0.6) end)

    local HF=Instance.new("Frame",Win); HF.Size=UDim2.new(1,0,0,76); HF.BackgroundColor3=Color3.fromRGB(14,14,24); HF.BorderSizePixel=0; HF.ZIndex=3
    Instance.new("UICorner",HF).CornerRadius=UDim.new(0,20)
    local HTL=Instance.new("TextLabel",HF); HTL.Size=UDim2.fromOffset(WIN_W,46); HTL.Position=UDim2.fromOffset(0,10); HTL.BackgroundTransparency=1; HTL.Text="🟠  CELIHUB  —  SPIEL AUSWÄHLEN"; HTL.TextColor3=Color3.new(1,1,1); HTL.Font=Enum.Font.GothamBold; HTL.TextSize=23; HTL.ZIndex=4; HTL.TextTransparency=1
    task.delay(0.1,function() tw(HTL,{TextTransparency=0},0.4) end)
    local HSL=Instance.new("TextLabel",HF); HSL.Size=UDim2.fromOffset(WIN_W,24); HSL.Position=UDim2.fromOffset(0,52); HSL.BackgroundTransparency=1; HSL.Text="Key akzeptiert ✅  —  Wähle dein Spiel"; HSL.TextColor3=Color3.fromRGB(90,90,120); HSL.Font=Enum.Font.Gotham; HSL.TextSize=13; HSL.ZIndex=4; HSL.TextTransparency=1
    task.delay(0.18,function() tw(HSL,{TextTransparency=0},0.4) end)

    -- *** GENAU 4 KARTEN — KEIN DEV ***
    local GAMES = {
        {icon="🚨", title="Emergency Emden",   desc="Speed • Fly • NoClip\nAimbot • Admin Check • ESP",       col=Color3.fromRGB(220,40,40),  glow=Color3.fromRGB(255,80,80),  key="emden"},
        {icon="🏙️", title="Emergency Hamburg", desc="Fahrzeug Mods • Waffen\nAuto Eat • Alles aus Emden+",    col=Color3.fromRGB(40,110,220), glow=Color3.fromRGB(80,150,255), key="hamburg"},
        {icon="🌍", title="Universal",          desc="Aimbot • ESP • Tracer\nChams • Alle Spiele",             col=Color3.fromRGB(160,40,220), glow=Color3.fromRGB(200,90,255), key="universal"},
        {icon="🟠", title="c00lgui Edition",    desc="Speed/Fly • Skybox • Music\nServer Tools • Disco",       col=Color3.fromRGB(255,140,0),  glow=Color3.fromRGB(255,180,50), key="coolgui"},
        {icon="🎵", title="Celi Music Player", desc="Playlist • Presets • Pitch\nLautstärke • Loop • IDs",       col=Color3.fromRGB(220,60,180), glow=Color3.fromRGB(255,100,220), key="music"},
    }

    local chosen=nil; local cardW=192

    for idx,g in ipairs(GAMES) do
        local xOff=14+(idx-1)*(cardW+14); local gRef=g
        local GF=Instance.new("Frame",Win); GF.Size=UDim2.fromOffset(cardW,222); GF.Position=UDim2.fromOffset(xOff,90); GF.BackgroundColor3=Color3.fromRGB(16,16,27); GF.BackgroundTransparency=1; GF.BorderSizePixel=0; GF.ZIndex=3
        Instance.new("UICorner",GF).CornerRadius=UDim.new(0,15)
        local GSt=Instance.new("UIStroke",GF); GSt.Color=Color3.fromRGB(35,35,60); GSt.Thickness=1.5
        task.delay(0.08*idx,function() if GF and GF.Parent then tw(GF,{BackgroundTransparency=0},0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out) end end)

        local GTop=Instance.new("Frame",GF); GTop.Size=UDim2.new(1,0,0,3); GTop.BackgroundColor3=gRef.col; GTop.BorderSizePixel=0; GTop.ZIndex=4
        Instance.new("UICorner",GTop).CornerRadius=UDim.new(0,15)

        local ICir=Instance.new("Frame",GF); ICir.Size=UDim2.fromOffset(54,54); ICir.Position=UDim2.fromOffset(cardW/2-27,12); ICir.BackgroundColor3=gRef.col; ICir.BackgroundTransparency=0.72; ICir.BorderSizePixel=0; ICir.ZIndex=4
        Instance.new("UICorner",ICir).CornerRadius=UDim.new(1,0)
        local IL=Instance.new("TextLabel",ICir); IL.Size=UDim2.fromScale(1,1); IL.BackgroundTransparency=1; IL.Text=gRef.icon; IL.TextSize=30; IL.Font=Enum.Font.GothamBold; IL.ZIndex=5

        local TL2=Instance.new("TextLabel",GF); TL2.Size=UDim2.fromOffset(cardW-14,32); TL2.Position=UDim2.fromOffset(7,76); TL2.BackgroundTransparency=1; TL2.Text=gRef.title; TL2.TextColor3=Color3.fromRGB(240,240,255); TL2.Font=Enum.Font.GothamBold; TL2.TextSize=13; TL2.TextWrapped=true; TL2.ZIndex=4
        local DL2=Instance.new("TextLabel",GF); DL2.Size=UDim2.fromOffset(cardW-14,58); DL2.Position=UDim2.fromOffset(7,108); DL2.BackgroundTransparency=1; DL2.Text=gRef.desc; DL2.TextColor3=Color3.fromRGB(90,90,125); DL2.Font=Enum.Font.Gotham; DL2.TextSize=11; DL2.TextWrapped=true; DL2.ZIndex=4

        local BF2=Instance.new("Frame",GF); BF2.Size=UDim2.fromOffset(cardW-18,40); BF2.Position=UDim2.fromOffset(9,174); BF2.BackgroundColor3=gRef.col; BF2.BorderSizePixel=0; BF2.ZIndex=4
        Instance.new("UICorner",BF2).CornerRadius=UDim.new(0,11)
        local BT2=Instance.new("TextButton",BF2); BT2.Size=UDim2.fromScale(1,1); BT2.BackgroundTransparency=1; BT2.Text="▶  STARTEN"; BT2.TextColor3=Color3.new(1,1,1); BT2.Font=Enum.Font.GothamBold; BT2.TextSize=14; BT2.ZIndex=5

        local gF2,gS2,bF2=GF,GSt,BF2
        BT2.MouseEnter:Connect(function() tw(gF2,{BackgroundColor3=Color3.fromRGB(22,22,40)},0.14); tw(gS2,{Color=gRef.col,Transparency=0.2},0.14); tw(bF2,{BackgroundColor3=gRef.glow},0.14) end)
        BT2.MouseLeave:Connect(function() tw(gF2,{BackgroundColor3=Color3.fromRGB(16,16,27)},0.14); tw(gS2,{Color=Color3.fromRGB(35,35,60),Transparency=0},0.14); tw(bF2,{BackgroundColor3=gRef.col},0.14) end)
        BT2.MouseButton1Click:Connect(function()
            if chosen then return end; chosen=gRef.key
            tw(gF2,{BackgroundColor3=gRef.col},0.1); task.wait(0.15)
            tw(Win,{BackgroundTransparency=1},0.28); tw(BG,{BackgroundTransparency=1},0.32); task.wait(0.35); SGui:Destroy()
        end)
    end

    local Foot=Instance.new("TextLabel",Win); Foot.Size=UDim2.fromOffset(WIN_W,22); Foot.Position=UDim2.fromOffset(0,314); Foot.BackgroundTransparency=1
    Foot.Text="CeliHub v3  •  by Celi 💫  •  5 Scripts  •  Dev = nur via DevLoader"
    Foot.TextColor3=Color3.fromRGB(45,45,70); Foot.Font=Enum.Font.Gotham; Foot.TextSize=11; Foot.ZIndex=3

    repeat task.wait(0.1) until chosen~=nil or not SGui.Parent
    return chosen or "emden"
end

-- ============================================================
-- MAIN
-- ============================================================
local keyOk = ShowKeyScreen()
if not keyOk then return end

local choice = ShowGameSelector()

local URLS = {
    emden     = EMDEN_URL,
    hamburg   = HAMBURG_URL,
    universal = UNIVERSAL_URL,
    coolgui   = COOLGUI_URL,
    music     = MUSIC_URL,
    -- DEV NICHT HIER
}

local url = URLS[choice]
if url then
    local ok, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)
    if not ok then warn("[CeliHub] Ladefehler: "..tostring(err)) end
end
