-- ============================================================
-- CeliHub | Launcher v2
-- Made by Celi 💫
-- ============================================================

local TweenService = game:GetService("TweenService")
local coreGui      = game:GetService("CoreGui")

local VALID_KEY     = "celi2026"
local KEY_WEBSITE   = "key.celihub.site"
local EMDEN_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_EmdenEdition_v4.lua"
local HAMBURG_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Hamburg_Edition.lua"
local UNIVERSAL_URL = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Universal.lua"
local COOLGUI_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_c00lgui_Edition.lua"

local function tw(obj, props, t, style, dir)
    TweenService:Create(obj, TweenInfo.new(t or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end

-- ============================================================
-- KEY SCREEN
-- ============================================================
local function ShowKeyScreen()
    local old = coreGui:FindFirstChild("CeliHubKey"); if old then old:Destroy() end

    local SGui = Instance.new("ScreenGui")
    SGui.Name = "CeliHubKey"; SGui.ResetOnSpawn = false; SGui.DisplayOrder = 999; SGui.Parent = coreGui

    local BG = Instance.new("Frame", SGui)
    BG.Size = UDim2.fromScale(1,1); BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
    BG.BackgroundTransparency = 1; BG.BorderSizePixel = 0
    tw(BG, {BackgroundTransparency=0.42}, 0.5)

    for i = 1, 14 do
        local dot = Instance.new("Frame", BG)
        dot.Size = UDim2.fromOffset(math.random(3,6),math.random(3,6))
        dot.Position = UDim2.fromScale(math.random()/1, math.random()/1)
        dot.BackgroundColor3 = Color3.fromRGB(255,140,0)
        dot.BackgroundTransparency = math.random(50,80)/100
        dot.BorderSizePixel = 0; dot.ZIndex = 1
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                tw(dot, {
                    Position = UDim2.fromScale(dot.Position.X.Scale + math.random(-15,15)/100, dot.Position.Y.Scale + math.random(-15,15)/100),
                    BackgroundTransparency = math.random(40,85)/100
                }, math.random(3,8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                task.wait(math.random(3,8))
            end
        end)
    end

    local Card = Instance.new("Frame", BG)
    Card.Size = UDim2.fromOffset(460,326)
    Card.Position = UDim2.fromScale(0.5,0.55); Card.AnchorPoint = Vector2.new(0.5,0.5)
    Card.BackgroundColor3 = Color3.fromRGB(11,11,20); Card.BorderSizePixel = 0; Card.ZIndex = 2
    Card.BackgroundTransparency = 1
    Instance.new("UICorner",Card).CornerRadius = UDim.new(0,18)

    local CardStroke = Instance.new("UIStroke",Card)
    CardStroke.Color = Color3.fromRGB(255,140,0); CardStroke.Thickness = 1.5; CardStroke.Transparency = 0.6

    tw(Card,{BackgroundTransparency=0,Position=UDim2.fromScale(0.5,0.5)},0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    task.spawn(function()
        while Card and Card.Parent do
            tw(CardStroke,{Transparency=0.1},1.4,Enum.EasingStyle.Sine); task.wait(1.4)
            tw(CardStroke,{Transparency=0.7},1.4,Enum.EasingStyle.Sine); task.wait(1.4)
        end
    end)

    local TopBar = Instance.new("Frame",Card)
    TopBar.Size = UDim2.new(0,0,0,3); TopBar.BackgroundColor3 = Color3.fromRGB(255,140,0)
    TopBar.BorderSizePixel = 0; TopBar.ZIndex = 4
    Instance.new("UICorner",TopBar).CornerRadius = UDim.new(0,18)
    task.wait(0.2); tw(TopBar,{Size=UDim2.new(1,0,0,3)},0.55,Enum.EasingStyle.Quart)

    local function FadeLbl(parent,text,x,y,w,h,sz,fnt,col,ax,delay)
        local l=Instance.new("TextLabel",parent); l.Size=UDim2.fromOffset(w,h)
        l.Position=UDim2.fromOffset(x,y); l.BackgroundTransparency=1; l.Text=text
        l.TextColor3=col; l.Font=fnt; l.TextSize=sz; l.ZIndex=3
        l.TextXAlignment=ax or Enum.TextXAlignment.Center; l.TextTransparency=1
        task.delay(delay or 0, function() if l and l.Parent then tw(l,{TextTransparency=0},0.4) end end)
        return l
    end

    FadeLbl(Card,"🟠  CELIHUB",0,16,460,42,28,Enum.Font.GothamBold,Color3.fromRGB(255,255,255),nil,0.1)
    FadeLbl(Card,"Made by Celi  •  key.celihub.site",0,58,460,20,13,Enum.Font.Gotham,Color3.fromRGB(100,100,140),nil,0.15)

    local Div=Instance.new("Frame",Card); Div.Size=UDim2.new(0,0,0,1); Div.Position=UDim2.fromOffset(20,90)
    Div.BackgroundColor3=Color3.fromRGB(35,35,58); Div.BorderSizePixel=0; Div.ZIndex=3
    task.wait(0.2); tw(Div,{Size=UDim2.new(1,-40,0,1)},0.5)

    local CpBG=Instance.new("Frame",Card); CpBG.Size=UDim2.fromOffset(420,36); CpBG.Position=UDim2.fromOffset(20,104)
    CpBG.BackgroundColor3=Color3.fromRGB(20,20,35); CpBG.BorderSizePixel=0; CpBG.ZIndex=3
    Instance.new("UICorner",CpBG).CornerRadius=UDim.new(0,9)

    local CpBtn=Instance.new("TextButton",CpBG); CpBtn.Size=UDim2.fromScale(1,1); CpBtn.BackgroundTransparency=1
    CpBtn.Text="📋   key.celihub.site  —  Klicken zum Kopieren"
    CpBtn.TextColor3=Color3.fromRGB(200,120,0); CpBtn.Font=Enum.Font.Code; CpBtn.TextSize=13; CpBtn.ZIndex=4
    CpBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(KEY_WEBSITE) end)
        CpBtn.Text="✅  Kopiert!"; CpBtn.TextColor3=Color3.fromRGB(60,220,100)
        task.wait(1.5); CpBtn.Text="📋   key.celihub.site  —  Klicken zum Kopieren"
        CpBtn.TextColor3=Color3.fromRGB(200,120,0)
    end)

    FadeLbl(Card,"KEY EINGEBEN",20,152,200,18,11,Enum.Font.GothamBold,Color3.fromRGB(150,90,0),Enum.TextXAlignment.Left,0.2)

    local InBG=Instance.new("Frame",Card); InBG.Size=UDim2.fromOffset(420,48); InBG.Position=UDim2.fromOffset(20,172)
    InBG.BackgroundColor3=Color3.fromRGB(17,17,30); InBG.BorderSizePixel=0; InBG.ZIndex=3
    Instance.new("UICorner",InBG).CornerRadius=UDim.new(0,11)

    local InStroke=Instance.new("UIStroke",InBG)
    InStroke.Color=Color3.fromRGB(38,38,68); InStroke.Thickness=1.5

    local InBox=Instance.new("TextBox",InBG); InBox.Size=UDim2.new(1,-20,1,0); InBox.Position=UDim2.fromOffset(10,0)
    InBox.BackgroundTransparency=1; InBox.PlaceholderText="Key eingeben..."
    InBox.PlaceholderColor3=Color3.fromRGB(55,55,90); InBox.Text=""
    InBox.TextColor3=Color3.fromRGB(230,230,230); InBox.Font=Enum.Font.Code
    InBox.TextSize=17; InBox.ClearTextOnFocus=false; InBox.ZIndex=4

    InBox.Focused:Connect(function() tw(InStroke,{Color=Color3.fromRGB(255,140,0),Thickness=2},0.2) end)
    InBox.FocusLost:Connect(function() tw(InStroke,{Color=Color3.fromRGB(38,38,68),Thickness=1.5},0.2) end)

    local StatusLbl=Instance.new("TextLabel",Card); StatusLbl.Size=UDim2.fromOffset(420,22); StatusLbl.Position=UDim2.fromOffset(20,228)
    StatusLbl.BackgroundTransparency=1; StatusLbl.Text=""; StatusLbl.TextColor3=Color3.fromRGB(220,80,80)
    StatusLbl.Font=Enum.Font.GothamBold; StatusLbl.TextSize=13; StatusLbl.TextXAlignment=Enum.TextXAlignment.Left; StatusLbl.ZIndex=3

    local BtnBG=Instance.new("Frame",Card); BtnBG.Size=UDim2.fromOffset(420,50); BtnBG.Position=UDim2.fromOffset(20,262)
    BtnBG.BackgroundColor3=Color3.fromRGB(200,100,0); BtnBG.BorderSizePixel=0; BtnBG.ZIndex=3
    Instance.new("UICorner",BtnBG).CornerRadius=UDim.new(0,13)
    BtnBG.BackgroundTransparency=1; task.wait(0.3); tw(BtnBG,{BackgroundTransparency=0},0.4)

    local BtnLbl=Instance.new("TextButton",BtnBG); BtnLbl.Size=UDim2.fromScale(1,1); BtnLbl.BackgroundTransparency=1
    BtnLbl.Text="EINLOGGEN  →"; BtnLbl.TextColor3=Color3.fromRGB(255,255,255)
    BtnLbl.Font=Enum.Font.GothamBold; BtnLbl.TextSize=17; BtnLbl.ZIndex=4

    BtnLbl.MouseEnter:Connect(function() tw(BtnBG,{BackgroundColor3=Color3.fromRGB(255,140,0)},0.12) end)
    BtnLbl.MouseLeave:Connect(function() tw(BtnBG,{BackgroundColor3=Color3.fromRGB(200,100,0)},0.12) end)

    local done=Instance.new("BindableEvent")

    local function shake()
        for _=1,3 do
            tw(Card,{Position=UDim2.new(0.5,-9,0.5,0)},0.04); task.wait(0.04)
            tw(Card,{Position=UDim2.new(0.5,9,0.5,0)},0.04); task.wait(0.04)
        end; tw(Card,{Position=UDim2.fromScale(0.5,0.5)},0.05)
    end

    local function DoVerify()
        local k=InBox.Text:lower():gsub("%s+","")
        if k=="" then StatusLbl.Text="❌  Key eingeben!"; shake(); return end
        if k==VALID_KEY then
            StatusLbl.TextColor3=Color3.fromRGB(60,220,100); StatusLbl.Text="✅  Gültig — Lade CeliHub..."
            BtnLbl.Text="✅  ZUGANG GEWÄHRT"
            tw(BtnBG,{BackgroundColor3=Color3.fromRGB(30,165,80)},0.3)
            tw(CardStroke,{Color=Color3.fromRGB(255,180,0),Transparency=0},0.4)
            task.wait(1); tw(BG,{BackgroundTransparency=1},0.35); task.wait(0.35)
            SGui:Destroy(); done:Fire()
        else
            StatusLbl.TextColor3=Color3.fromRGB(220,80,80); StatusLbl.Text="❌  Falscher Key!  →  "..KEY_WEBSITE
            InBox.Text=""; tw(BtnBG,{BackgroundColor3=Color3.fromRGB(155,40,0)},0.1)
            task.wait(0.15); tw(BtnBG,{BackgroundColor3=Color3.fromRGB(200,100,0)},0.2); shake()
        end
    end

    BtnLbl.MouseButton1Click:Connect(DoVerify)
    InBox.FocusLost:Connect(function(e) if e then DoVerify() end end)
    done.Event:Wait(); done:Destroy()
end

-- ============================================================
-- ANIMATED GAME SELECTOR (4 Karten)
-- ============================================================
local function ShowGameSelector()
    local old=coreGui:FindFirstChild("CeliHubSel"); if old then old:Destroy() end

    local SGui=Instance.new("ScreenGui")
    SGui.Name="CeliHubSel"; SGui.ResetOnSpawn=false; SGui.DisplayOrder=999; SGui.Parent=coreGui

    local BG=Instance.new("Frame",SGui)
    BG.Size=UDim2.fromScale(1,1); BG.BackgroundColor3=Color3.fromRGB(0,0,0)
    BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.38},0.5)

    for i=1,20 do
        local dot=Instance.new("Frame",BG); local sz=math.random(2,5)
        dot.Size=UDim2.fromOffset(sz,sz)
        dot.Position=UDim2.fromScale(math.random()/1,1.05)
        dot.BackgroundColor3=({
            Color3.fromRGB(255,140,0), Color3.fromRGB(220,40,40),
            Color3.fromRGB(40,110,220), Color3.fromRGB(160,40,220)
        })[math.random(1,4)]
        dot.BackgroundTransparency=math.random(30,70)/100
        dot.BorderSizePixel=0; dot.ZIndex=1
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                tw(dot,{Position=UDim2.fromScale(dot.Position.X.Scale,-0.05)},math.random(7,16),Enum.EasingStyle.Linear)
                task.wait(math.random(7,16)); dot.Position=UDim2.fromScale(math.random()/1,1.05)
            end
        end)
    end

    -- 4 Karten → breiteres Fenster
    local Win=Instance.new("Frame",BG)
    Win.Size=UDim2.fromOffset(860,340); Win.Position=UDim2.fromScale(0.5,0.58)
    Win.AnchorPoint=Vector2.new(0.5,0.5); Win.BackgroundColor3=Color3.fromRGB(10,10,18)
    Win.BorderSizePixel=0; Win.ZIndex=2; Win.BackgroundTransparency=1
    Instance.new("UICorner",Win).CornerRadius=UDim.new(0,20)
    local WinStroke=Instance.new("UIStroke",Win)
    WinStroke.Color=Color3.fromRGB(50,50,80); WinStroke.Thickness=1.5
    tw(Win,{BackgroundTransparency=0,Position=UDim2.fromScale(0.5,0.5)},0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    local TopLine=Instance.new("Frame",Win)
    TopLine.Size=UDim2.new(0,0,0,3); TopLine.BackgroundColor3=Color3.fromRGB(255,140,0)
    TopLine.BorderSizePixel=0; TopLine.ZIndex=5
    Instance.new("UICorner",TopLine).CornerRadius=UDim.new(0,20)
    task.wait(0.2); tw(TopLine,{Size=UDim2.new(1,0,0,3)},0.6,Enum.EasingStyle.Quart)

    local TitleF=Instance.new("Frame",Win)
    TitleF.Size=UDim2.new(1,0,0,76); TitleF.BackgroundColor3=Color3.fromRGB(14,14,24)
    TitleF.BorderSizePixel=0; TitleF.ZIndex=3
    Instance.new("UICorner",TitleF).CornerRadius=UDim.new(0,20)

    local TLabel=Instance.new("TextLabel",TitleF)
    TLabel.Size=UDim2.fromOffset(860,48); TLabel.Position=UDim2.fromOffset(0,10)
    TLabel.BackgroundTransparency=1; TLabel.Text="🟠  CELIHUB  —  SPIEL AUSWÄHLEN"
    TLabel.TextColor3=Color3.fromRGB(255,255,255); TLabel.Font=Enum.Font.GothamBold; TLabel.TextSize=23; TLabel.ZIndex=4; TLabel.TextTransparency=1
    task.wait(0.1); tw(TLabel,{TextTransparency=0},0.45)

    local SLabel=Instance.new("TextLabel",TitleF)
    SLabel.Size=UDim2.fromOffset(860,24); SLabel.Position=UDim2.fromOffset(0,52)
    SLabel.BackgroundTransparency=1; SLabel.Text="Wähle dein Spiel — Key wurde bestätigt ✅"
    SLabel.TextColor3=Color3.fromRGB(90,90,120); SLabel.Font=Enum.Font.Gotham; SLabel.TextSize=13; SLabel.ZIndex=4; SLabel.TextTransparency=1
    task.wait(0.18); tw(SLabel,{TextTransparency=0},0.4)

    local GAMES = {
        {icon="🚨", title="Emergency Emden",     desc="Speed • Fly • NoClip\nAimbot • Admin Check • ESP",        col=Color3.fromRGB(220,40,40),  glow=Color3.fromRGB(255,70,70),  key="emden"},
        {icon="🏙️", title="Emergency Hamburg",    desc="Fahrzeug Mods • Waffen\nAuto Eat • Alles aus Emden",       col=Color3.fromRGB(40,110,220), glow=Color3.fromRGB(70,150,255), key="hamburg"},
        {icon="🌍", title="Universal",            desc="Aimbot • Silent Aim\nESP • Tracer • Alle Spiele",          col=Color3.fromRGB(160,40,220), glow=Color3.fromRGB(200,80,255), key="universal"},
        {icon="🟠", title="c00lgui Edition",      desc="Gear • Admin GUIs • Skybox\nMusic • Server Tools • Mehr!", col=Color3.fromRGB(255,140,0),  glow=Color3.fromRGB(255,180,50), key="coolgui"},
    }

    local done=Instance.new("BindableEvent"); local choice="emden"
    local cardW=190

    for idx,g in ipairs(GAMES) do
        local xOff=16+(idx-1)*(cardW+16)

        local GF=Instance.new("Frame",Win)
        GF.Size=UDim2.fromOffset(cardW,224); GF.Position=UDim2.fromOffset(xOff,88)
        GF.BackgroundColor3=Color3.fromRGB(16,16,27); GF.BorderSizePixel=0; GF.ZIndex=3; GF.BackgroundTransparency=1
        Instance.new("UICorner",GF).CornerRadius=UDim.new(0,15)

        local GStroke=Instance.new("UIStroke",GF)
        GStroke.Color=Color3.fromRGB(35,35,60); GStroke.Thickness=1.5

        task.delay(0.08*idx,function()
            if GF and GF.Parent then tw(GF,{BackgroundTransparency=0},0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out) end
        end)

        local GTop=Instance.new("Frame",GF); GTop.Size=UDim2.new(1,0,0,3)
        GTop.BackgroundColor3=g.col; GTop.BorderSizePixel=0; GTop.ZIndex=4
        Instance.new("UICorner",GTop).CornerRadius=UDim.new(0,15)

        local ICir=Instance.new("Frame",GF)
        ICir.Size=UDim2.fromOffset(54,54); ICir.Position=UDim2.fromOffset(cardW/2-27,14)
        ICir.BackgroundColor3=g.col; ICir.BorderSizePixel=0; ICir.ZIndex=4; ICir.BackgroundTransparency=0.75
        Instance.new("UICorner",ICir).CornerRadius=UDim.new(1,0)

        local IL=Instance.new("TextLabel",ICir); IL.Size=UDim2.fromScale(1,1); IL.BackgroundTransparency=1
        IL.Text=g.icon; IL.TextSize=30; IL.Font=Enum.Font.GothamBold; IL.ZIndex=5

        local TL=Instance.new("TextLabel",GF); TL.Size=UDim2.fromOffset(cardW-14,30)
        TL.Position=UDim2.fromOffset(7,78); TL.BackgroundTransparency=1; TL.Text=g.title
        TL.TextColor3=Color3.fromRGB(240,240,255); TL.Font=Enum.Font.GothamBold; TL.TextSize=13
        TL.TextWrapped=true; TL.ZIndex=4

        local DL=Instance.new("TextLabel",GF); DL.Size=UDim2.fromOffset(cardW-14,60)
        DL.Position=UDim2.fromOffset(7,110); DL.BackgroundTransparency=1; DL.Text=g.desc
        DL.TextColor3=Color3.fromRGB(90,90,125); DL.Font=Enum.Font.Gotham; DL.TextSize=11
        DL.TextWrapped=true; DL.ZIndex=4

        local BF=Instance.new("Frame",GF); BF.Size=UDim2.fromOffset(cardW-18,40)
        BF.Position=UDim2.fromOffset(9,178); BF.BackgroundColor3=g.col; BF.BorderSizePixel=0; BF.ZIndex=4
        Instance.new("UICorner",BF).CornerRadius=UDim.new(0,11)

        local BT=Instance.new("TextButton",BF); BT.Size=UDim2.fromScale(1,1); BT.BackgroundTransparency=1
        BT.Text="▶  STARTEN"; BT.TextColor3=Color3.fromRGB(255,255,255)
        BT.Font=Enum.Font.GothamBold; BT.TextSize=14; BT.ZIndex=5

        local gRef,gFRef,gStRef,bFRef=g,GF,GStroke,BF
        BT.MouseEnter:Connect(function()
            tw(gFRef,{BackgroundColor3=Color3.fromRGB(22,22,40)},0.14)
            tw(gStRef,{Color=gRef.col,Transparency=0.2},0.14)
            tw(bFRef,{BackgroundColor3=gRef.glow},0.14)
        end)
        BT.MouseLeave:Connect(function()
            tw(gFRef,{BackgroundColor3=Color3.fromRGB(16,16,27)},0.14)
            tw(gStRef,{Color=Color3.fromRGB(35,35,60),Transparency=0},0.14)
            tw(bFRef,{BackgroundColor3=gRef.col},0.14)
        end)

        BT.MouseButton1Click:Connect(function()
            choice=gRef.key
            tw(gFRef,{BackgroundColor3=gRef.col},0.1); task.wait(0.12)
            tw(Win,{BackgroundTransparency=1,Position=UDim2.fromScale(0.5,0.55)},0.3)
            tw(BG,{BackgroundTransparency=1},0.3); task.wait(0.35)
            SGui:Destroy(); done:Fire()
        end)
    end

    local Footer=Instance.new("TextLabel",Win)
    Footer.Size=UDim2.fromOffset(860,22); Footer.Position=UDim2.fromOffset(0,312)
    Footer.BackgroundTransparency=1; Footer.Text="CeliHub v2  •  by Celi  •  4 Scripts verfügbar"
    Footer.TextColor3=Color3.fromRGB(45,45,70); Footer.Font=Enum.Font.Gotham; Footer.TextSize=11; Footer.ZIndex=3

    done.Event:Wait(); done:Destroy()
    return choice
end

-- ============================================================
-- LAUNCH
-- ============================================================
ShowKeyScreen()
local gameChoice = ShowGameSelector()

if     gameChoice=="emden"     then loadstring(game:HttpGet(EMDEN_URL))()
elseif gameChoice=="hamburg"   then loadstring(game:HttpGet(HAMBURG_URL))()
elseif gameChoice=="universal" then loadstring(game:HttpGet(UNIVERSAL_URL))()
elseif gameChoice=="coolgui"   then loadstring(game:HttpGet(COOLGUI_URL))()
end
