-- ============================================================
-- CeliHub | Launcher v2
-- Made by Celi 💫
-- ============================================================

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local coreGui          = game:GetService("CoreGui")

local VALID_KEY     = "celi2026"
local KEY_WEBSITE   = "key.celihub.site"
local EMDEN_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_EmdenEdition_v4.lua"
local HAMBURG_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Hamburg_Edition.lua"
local UNIVERSAL_URL = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Universal.lua"

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
    tw(BG, {BackgroundTransparency = 0.42}, 0.5)

    -- Floating particles
    for i = 1, 14 do
        local dot = Instance.new("Frame", BG)
        dot.Size = UDim2.fromOffset(math.random(3,6),math.random(3,6))
        dot.Position = UDim2.fromScale(math.random()/1, math.random()/1)
        dot.BackgroundColor3 = Color3.fromRGB(220,40,40)
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
    Card.Size = UDim2.fromOffset(460, 326)
    Card.Position = UDim2.fromScale(0.5, 0.55); Card.AnchorPoint = Vector2.new(0.5,0.5)
    Card.BackgroundColor3 = Color3.fromRGB(11,11,20); Card.BorderSizePixel = 0; Card.ZIndex = 2
    Card.BackgroundTransparency = 1
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0,18)

    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Color = Color3.fromRGB(220,40,40); CardStroke.Thickness = 1.5; CardStroke.Transparency = 0.6

    tw(Card, {BackgroundTransparency = 0, Position = UDim2.fromScale(0.5,0.5)}, 0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    -- Pulse glow
    task.spawn(function()
        while Card and Card.Parent do
            tw(CardStroke, {Transparency = 0.15}, 1.4, Enum.EasingStyle.Sine); task.wait(1.4)
            tw(CardStroke, {Transparency = 0.7}, 1.4, Enum.EasingStyle.Sine); task.wait(1.4)
        end
    end)

    -- Top red bar
    local TopBar = Instance.new("Frame", Card)
    TopBar.Size = UDim2.new(0,0,0,3); TopBar.BackgroundColor3 = Color3.fromRGB(220,40,40)
    TopBar.BorderSizePixel = 0; TopBar.ZIndex = 4
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0,18)
    task.wait(0.2); tw(TopBar, {Size = UDim2.new(1,0,0,3)}, 0.55, Enum.EasingStyle.Quart)

    local function FadeLbl(parent, text, x, y, w, h, sz, font, col, ax, delay)
        local l = Instance.new("TextLabel", parent)
        l.Size = UDim2.fromOffset(w,h); l.Position = UDim2.fromOffset(x,y)
        l.BackgroundTransparency = 1; l.Text = text; l.TextColor3 = col
        l.Font = font; l.TextSize = sz; l.ZIndex = 3
        l.TextXAlignment = ax or Enum.TextXAlignment.Center
        l.TextTransparency = 1
        task.delay(delay or 0, function() if l and l.Parent then tw(l, {TextTransparency=0}, 0.4) end end)
        return l
    end

    FadeLbl(Card,"🚨  CELIHUB", 0,16,460,42,28,Enum.Font.GothamBold,Color3.fromRGB(255,255,255),nil,0.1)
    FadeLbl(Card,"Made by Celi  •  key.celihub.site", 0,58,460,20,13,Enum.Font.Gotham,Color3.fromRGB(100,100,140),nil,0.15)

    local Div = Instance.new("Frame", Card)
    Div.Size = UDim2.new(0,0,0,1); Div.Position = UDim2.fromOffset(20,90)
    Div.BackgroundColor3 = Color3.fromRGB(35,35,58); Div.BorderSizePixel = 0; Div.ZIndex = 3
    task.wait(0.2); tw(Div, {Size = UDim2.new(1,-40,0,1)}, 0.5)

    -- Copy website btn
    local CpBG = Instance.new("Frame", Card)
    CpBG.Size = UDim2.fromOffset(420,36); CpBG.Position = UDim2.fromOffset(20,104)
    CpBG.BackgroundColor3 = Color3.fromRGB(20,20,35); CpBG.BorderSizePixel = 0; CpBG.ZIndex = 3
    Instance.new("UICorner", CpBG).CornerRadius = UDim.new(0,9)

    local CpBtn = Instance.new("TextButton", CpBG)
    CpBtn.Size = UDim2.fromScale(1,1); CpBtn.BackgroundTransparency = 1
    CpBtn.Text = "📋   key.celihub.site  —  Klicken zum Kopieren"
    CpBtn.TextColor3 = Color3.fromRGB(130,130,200); CpBtn.Font = Enum.Font.Code; CpBtn.TextSize = 13; CpBtn.ZIndex = 4
    CpBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(KEY_WEBSITE) end)
        CpBtn.Text = "✅  Kopiert!"; CpBtn.TextColor3 = Color3.fromRGB(60,220,100)
        task.wait(1.5)
        CpBtn.Text = "📋   key.celihub.site  —  Klicken zum Kopieren"
        CpBtn.TextColor3 = Color3.fromRGB(130,130,200)
    end)

    FadeLbl(Card,"KEY EINGEBEN",20,152,200,18,11,Enum.Font.GothamBold,Color3.fromRGB(90,90,120),Enum.TextXAlignment.Left,0.2)

    local InBG = Instance.new("Frame", Card)
    InBG.Size = UDim2.fromOffset(420,48); InBG.Position = UDim2.fromOffset(20,172)
    InBG.BackgroundColor3 = Color3.fromRGB(17,17,30); InBG.BorderSizePixel = 0; InBG.ZIndex = 3
    Instance.new("UICorner", InBG).CornerRadius = UDim.new(0,11)

    local InStroke = Instance.new("UIStroke", InBG)
    InStroke.Color = Color3.fromRGB(38,38,68); InStroke.Thickness = 1.5

    local InBox = Instance.new("TextBox", InBG)
    InBox.Size = UDim2.new(1,-20,1,0); InBox.Position = UDim2.fromOffset(10,0)
    InBox.BackgroundTransparency = 1; InBox.PlaceholderText = "Key eingeben..."
    InBox.PlaceholderColor3 = Color3.fromRGB(55,55,90); InBox.Text = ""
    InBox.TextColor3 = Color3.fromRGB(230,230,230); InBox.Font = Enum.Font.Code
    InBox.TextSize = 17; InBox.ClearTextOnFocus = false; InBox.ZIndex = 4

    InBox.Focused:Connect(function() tw(InStroke, {Color=Color3.fromRGB(220,40,40), Thickness=2}, 0.2) end)
    InBox.FocusLost:Connect(function() tw(InStroke, {Color=Color3.fromRGB(38,38,68), Thickness=1.5}, 0.2) end)

    local StatusLbl = Instance.new("TextLabel", Card)
    StatusLbl.Size = UDim2.fromOffset(420,22); StatusLbl.Position = UDim2.fromOffset(20,228)
    StatusLbl.BackgroundTransparency = 1; StatusLbl.Text = ""
    StatusLbl.TextColor3 = Color3.fromRGB(220,80,80); StatusLbl.Font = Enum.Font.GothamBold
    StatusLbl.TextSize = 13; StatusLbl.TextXAlignment = Enum.TextXAlignment.Left; StatusLbl.ZIndex = 3

    local BtnBG = Instance.new("Frame", Card)
    BtnBG.Size = UDim2.fromOffset(420,50); BtnBG.Position = UDim2.fromOffset(20,262)
    BtnBG.BackgroundColor3 = Color3.fromRGB(200,35,35); BtnBG.BorderSizePixel = 0; BtnBG.ZIndex = 3
    Instance.new("UICorner", BtnBG).CornerRadius = UDim.new(0,13)
    BtnBG.BackgroundTransparency = 1; task.wait(0.3); tw(BtnBG, {BackgroundTransparency=0}, 0.4)

    local BtnLbl = Instance.new("TextButton", BtnBG)
    BtnLbl.Size = UDim2.fromScale(1,1); BtnLbl.BackgroundTransparency = 1
    BtnLbl.Text = "EINLOGGEN  →"; BtnLbl.TextColor3 = Color3.fromRGB(255,255,255)
    BtnLbl.Font = Enum.Font.GothamBold; BtnLbl.TextSize = 17; BtnLbl.ZIndex = 4

    BtnLbl.MouseEnter:Connect(function() tw(BtnBG,{BackgroundColor3=Color3.fromRGB(240,55,55)},0.12) end)
    BtnLbl.MouseLeave:Connect(function() tw(BtnBG,{BackgroundColor3=Color3.fromRGB(200,35,35)},0.12) end)

    local done = Instance.new("BindableEvent")

    local function shake()
        for _=1,3 do
            tw(Card,{Position=UDim2.new(0.5,-9,0.5,0)},0.04); task.wait(0.04)
            tw(Card,{Position=UDim2.new(0.5,9,0.5,0)},0.04); task.wait(0.04)
        end
        tw(Card,{Position=UDim2.fromScale(0.5,0.5)},0.05)
    end

    local function DoVerify()
        local k = InBox.Text:lower():gsub("%s+","")
        if k=="" then StatusLbl.Text="❌  Key eingeben!"; shake(); return end
        if k==VALID_KEY then
            StatusLbl.TextColor3=Color3.fromRGB(60,220,100); StatusLbl.Text="✅  Gültig — Weiter..."
            BtnLbl.Text="✅  ZUGANG GEWÄHRT"
            tw(BtnBG,{BackgroundColor3=Color3.fromRGB(30,165,80)},0.3)
            tw(CardStroke,{Color=Color3.fromRGB(30,200,80),Transparency=0},0.4)
            task.wait(1); tw(BG,{BackgroundTransparency=1},0.35); task.wait(0.35)
            SGui:Destroy(); done:Fire()
        else
            StatusLbl.Text="❌  Falscher Key!  →  "..KEY_WEBSITE; InBox.Text=""
            tw(BtnBG,{BackgroundColor3=Color3.fromRGB(155,20,20)},0.1); task.wait(0.15)
            tw(BtnBG,{BackgroundColor3=Color3.fromRGB(200,35,35)},0.2); shake()
        end
    end

    BtnLbl.MouseButton1Click:Connect(DoVerify)
    InBox.FocusLost:Connect(function(e) if e then DoVerify() end end)
    done.Event:Wait(); done:Destroy()
end

-- ============================================================
-- ANIMATED GAME SELECTOR
-- ============================================================
local function ShowGameSelector()
    local old = coreGui:FindFirstChild("CeliHubSel"); if old then old:Destroy() end

    local SGui = Instance.new("ScreenGui")
    SGui.Name = "CeliHubSel"; SGui.ResetOnSpawn=false; SGui.DisplayOrder=999; SGui.Parent=coreGui

    local BG = Instance.new("Frame", SGui)
    BG.Size = UDim2.fromScale(1,1); BG.BackgroundColor3 = Color3.fromRGB(0,0,0)
    BG.BackgroundTransparency=1; BG.BorderSizePixel=0
    tw(BG,{BackgroundTransparency=0.38},0.5)

    -- Rising particles
    for i=1,20 do
        local dot=Instance.new("Frame",BG); local sz=math.random(2,5)
        dot.Size=UDim2.fromOffset(sz,sz)
        dot.Position=UDim2.fromScale(math.random()/1,1.05)
        dot.BackgroundColor3=({
            Color3.fromRGB(220,40,40), Color3.fromRGB(40,110,220),
            Color3.fromRGB(160,40,220), Color3.fromRGB(255,255,255)
        })[math.random(1,4)]
        dot.BackgroundTransparency=math.random(30,70)/100
        dot.BorderSizePixel=0; dot.ZIndex=1
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            while dot and dot.Parent do
                tw(dot,{Position=UDim2.fromScale(dot.Position.X.Scale,-0.05)},math.random(7,16),Enum.EasingStyle.Linear)
                task.wait(math.random(7,16))
                dot.Position=UDim2.fromScale(math.random()/1,1.05)
            end
        end)
    end

    -- Main window
    local Win = Instance.new("Frame", BG)
    Win.Size = UDim2.fromOffset(660,360); Win.Position=UDim2.fromScale(0.5,0.58)
    Win.AnchorPoint=Vector2.new(0.5,0.5); Win.BackgroundColor3=Color3.fromRGB(10,10,18)
    Win.BorderSizePixel=0; Win.ZIndex=2; Win.BackgroundTransparency=1
    Instance.new("UICorner",Win).CornerRadius=UDim.new(0,20)

    local WinStroke=Instance.new("UIStroke",Win)
    WinStroke.Color=Color3.fromRGB(42,42,70); WinStroke.Thickness=1.5

    tw(Win,{BackgroundTransparency=0,Position=UDim2.fromScale(0.5,0.5)},0.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out)

    -- Top bar animation
    local TopLine=Instance.new("Frame",Win)
    TopLine.Size=UDim2.new(0,0,0,3); TopLine.BackgroundColor3=Color3.fromRGB(220,40,40)
    TopLine.BorderSizePixel=0; TopLine.ZIndex=5
    Instance.new("UICorner",TopLine).CornerRadius=UDim.new(0,20)
    task.wait(0.2); tw(TopLine,{Size=UDim2.new(1,0,0,3)},0.6,Enum.EasingStyle.Quart)

    -- Header
    local TitleF=Instance.new("Frame",Win)
    TitleF.Size=UDim2.new(1,0,0,76); TitleF.BackgroundColor3=Color3.fromRGB(14,14,24)
    TitleF.BorderSizePixel=0; TitleF.ZIndex=3
    Instance.new("UICorner",TitleF).CornerRadius=UDim.new(0,20)

    local TLabel=Instance.new("TextLabel",TitleF)
    TLabel.Size=UDim2.fromOffset(660,48); TLabel.Position=UDim2.fromOffset(0,10)
    TLabel.BackgroundTransparency=1; TLabel.Text="🚨  CELIHUB  —  SPIEL AUSWÄHLEN"
    TLabel.TextColor3=Color3.fromRGB(255,255,255); TLabel.Font=Enum.Font.GothamBold
    TLabel.TextSize=23; TLabel.ZIndex=4; TLabel.TextTransparency=1
    task.wait(0.1); tw(TLabel,{TextTransparency=0},0.45)

    local SLabel=Instance.new("TextLabel",TitleF)
    SLabel.Size=UDim2.fromOffset(660,24); SLabel.Position=UDim2.fromOffset(0,52)
    SLabel.BackgroundTransparency=1; SLabel.Text="Wähle dein Spiel — Key wurde bestätigt ✅"
    SLabel.TextColor3=Color3.fromRGB(90,90,120); SLabel.Font=Enum.Font.Gotham
    SLabel.TextSize=13; SLabel.ZIndex=4; SLabel.TextTransparency=1
    task.wait(0.18); tw(SLabel,{TextTransparency=0},0.4)

    -- Game cards
    local GAMES = {
        {icon="🚨", title="Emergency Emden",   desc="Speed • Fly • NoClip • Aimbot\nAdmin Check • Teleport • ESP",                           col=Color3.fromRGB(220,40,40),  glow=Color3.fromRGB(255,70,70),  key="emden"},
        {icon="🏙️", title="Emergency Hamburg",  desc="Fahrzeug Mods • Waffen • Auto Eat\nAlles aus Emden + Mehr",                              col=Color3.fromRGB(40,110,220), glow=Color3.fromRGB(70,150,255), key="hamburg"},
        {icon="🌍", title="Universal",          desc="Aimbot • Silent Aim • ESP\nTracers • Chams • Alle Spiele",                               col=Color3.fromRGB(160,40,220), glow=Color3.fromRGB(200,80,255), key="universal"},
    }

    local done=Instance.new("BindableEvent"); local choice="emden"
    local cardW=182

    for idx, g in ipairs(GAMES) do
        local xOff = 18 + (idx-1)*(cardW+16)

        local GF=Instance.new("Frame",Win)
        GF.Size=UDim2.fromOffset(cardW,224); GF.Position=UDim2.fromOffset(xOff,88)
        GF.BackgroundColor3=Color3.fromRGB(16,16,27); GF.BorderSizePixel=0; GF.ZIndex=3
        GF.BackgroundTransparency=1
        Instance.new("UICorner",GF).CornerRadius=UDim.new(0,15)

        local GStroke=Instance.new("UIStroke",GF)
        GStroke.Color=Color3.fromRGB(35,35,60); GStroke.Thickness=1.5

        task.delay(0.08*idx, function()
            if GF and GF.Parent then
                tw(GF,{BackgroundTransparency=0,Position=UDim2.fromOffset(xOff,88)},0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
            end
        end)

        -- Colored top
        local GTop=Instance.new("Frame",GF)
        GTop.Size=UDim2.new(1,0,0,3); GTop.BackgroundColor3=g.col
        GTop.BorderSizePixel=0; GTop.ZIndex=4
        Instance.new("UICorner",GTop).CornerRadius=UDim.new(0,15)

        -- Icon circle bg
        local IconCircle=Instance.new("Frame",GF)
        IconCircle.Size=UDim2.fromOffset(56,56); IconCircle.Position=UDim2.fromOffset(cardW/2-28, 16)
        IconCircle.BackgroundColor3=g.col; IconCircle.BorderSizePixel=0; IconCircle.ZIndex=4
        IconCircle.BackgroundTransparency=0.75
        Instance.new("UICorner",IconCircle).CornerRadius=UDim.new(1,0)

        local IconLbl=Instance.new("TextLabel",IconCircle)
        IconLbl.Size=UDim2.fromScale(1,1); IconLbl.BackgroundTransparency=1
        IconLbl.Text=g.icon; IconLbl.TextSize=30; IconLbl.Font=Enum.Font.GothamBold; IconLbl.ZIndex=5

        local GTitleL=Instance.new("TextLabel",GF)
        GTitleL.Size=UDim2.fromOffset(cardW-16,30); GTitleL.Position=UDim2.fromOffset(8,80)
        GTitleL.BackgroundTransparency=1; GTitleL.Text=g.title
        GTitleL.TextColor3=Color3.fromRGB(240,240,255); GTitleL.Font=Enum.Font.GothamBold
        GTitleL.TextSize=14; GTitleL.TextWrapped=true; GTitleL.ZIndex=4

        local GDescL=Instance.new("TextLabel",GF)
        GDescL.Size=UDim2.fromOffset(cardW-16,64); GDescL.Position=UDim2.fromOffset(8,112)
        GDescL.BackgroundTransparency=1; GDescL.Text=g.desc
        GDescL.TextColor3=Color3.fromRGB(95,95,125); GDescL.Font=Enum.Font.Gotham
        GDescL.TextSize=11; GDescL.TextWrapped=true; GDescL.ZIndex=4

        -- Animated start button
        local BtnF=Instance.new("Frame",GF)
        BtnF.Size=UDim2.fromOffset(cardW-20,40); BtnF.Position=UDim2.fromOffset(10,176)
        BtnF.BackgroundColor3=g.col; BtnF.BorderSizePixel=0; BtnF.ZIndex=4
        Instance.new("UICorner",BtnF).CornerRadius=UDim.new(0,11)

        local BtnT=Instance.new("TextButton",BtnF)
        BtnT.Size=UDim2.fromScale(1,1); BtnT.BackgroundTransparency=1
        BtnT.Text="▶  STARTEN"; BtnT.TextColor3=Color3.fromRGB(255,255,255)
        BtnT.Font=Enum.Font.GothamBold; BtnT.TextSize=14; BtnT.ZIndex=5

        local gRef,gFRef,gStRef,bFRef=g,GF,GStroke,BtnF

        BtnT.MouseEnter:Connect(function()
            tw(gFRef,{BackgroundColor3=Color3.fromRGB(22,22,38)},0.14)
            tw(gStRef,{Color=gRef.col,Transparency=0.2},0.14)
            tw(bFRef,{BackgroundColor3=gRef.glow},0.14)
        end)
        BtnT.MouseLeave:Connect(function()
            tw(gFRef,{BackgroundColor3=Color3.fromRGB(16,16,27)},0.14)
            tw(gStRef,{Color=Color3.fromRGB(35,35,60),Transparency=0},0.14)
            tw(bFRef,{BackgroundColor3=gRef.col},0.14)
        end)

        BtnT.MouseButton1Click:Connect(function()
            choice=gRef.key
            tw(gFRef,{BackgroundColor3=gRef.col},0.1); task.wait(0.12)
            tw(Win,{BackgroundTransparency=1,Position=UDim2.fromScale(0.5,0.55)},0.3)
            tw(BG,{BackgroundTransparency=1},0.3); task.wait(0.35)
            SGui:Destroy(); done:Fire()
        end)
    end

    -- Footer
    local Footer=Instance.new("TextLabel",Win)
    Footer.Size=UDim2.fromOffset(660,22); Footer.Position=UDim2.fromOffset(0,332)
    Footer.BackgroundTransparency=1; Footer.Text="CeliHub v2  •  by Celi  •  discord.gg/celihub"
    Footer.TextColor3=Color3.fromRGB(45,45,70); Footer.Font=Enum.Font.Gotham
    Footer.TextSize=11; Footer.ZIndex=3

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
end
