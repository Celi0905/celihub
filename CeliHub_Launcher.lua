-- CeliHub Launcher v2 | Made by Celi
-- SICHER - kein CoreGui Problem, kein BindableEvent Deadlock

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player    = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local VALID_KEY     = "celi2026"
local KEY_WEBSITE   = "key.celihub.site"
local EMDEN_URL     = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_EmdenEdition_v4.lua"
local HAMBURG_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Hamburg_Edition.lua"
local UNIVERSAL_URL = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Universal.lua"
local COOLGUI_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_c00lgui_Edition.lua"

local function tw(obj, props, t, style, dir)
    local ok, tween = pcall(function()
        return TweenService:Create(
            obj,
            TweenInfo.new(t or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out),
            props
        )
    end)
    if ok and tween then tween:Play() end
end

-- Farben
local C_ORANGE = Color3.fromRGB(255, 140, 0)
local C_BG     = Color3.fromRGB(11, 11, 20)
local C_EL     = Color3.fromRGB(17, 17, 30)
local C_WHITE  = Color3.fromRGB(255, 255, 255)
local C_GRAY   = Color3.fromRGB(100, 100, 130)

-- ============================================================
-- KEY SCREEN  (gibt true zurück wenn Key korrekt)
-- ============================================================
local function ShowKeyScreen()
    local old = PlayerGui:FindFirstChild("CeliHubKey")
    if old then old:Destroy() end

    local SGui = Instance.new("ScreenGui")
    SGui.Name            = "CeliHubKey"
    SGui.ResetOnSpawn    = false
    SGui.IgnoreGuiInset  = true
    SGui.Parent          = PlayerGui

    -- Dimm-BG
    local BG = Instance.new("Frame", SGui)
    BG.Size                 = UDim2.fromScale(1, 1)
    BG.BackgroundColor3     = Color3.fromRGB(0, 0, 0)
    BG.BackgroundTransparency = 1
    BG.BorderSizePixel      = 0
    tw(BG, {BackgroundTransparency = 0.45}, 0.5)

    -- Partikel
    for i = 1, 12 do
        local dot = Instance.new("Frame", BG)
        dot.Size                 = UDim2.fromOffset(math.random(3, 6), math.random(3, 6))
        dot.Position             = UDim2.fromScale(math.random() * 0.9 + 0.05, math.random() * 0.9 + 0.05)
        dot.BackgroundColor3     = C_ORANGE
        dot.BackgroundTransparency = math.random(50, 80) / 100
        dot.BorderSizePixel      = 0
        dot.ZIndex               = 1
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        task.spawn(function()
            while dot and dot.Parent do
                task.wait(math.random(3, 8))
                if not (dot and dot.Parent) then break end
                local newX = math.clamp(dot.Position.X.Scale + math.random(-10, 10) / 100, 0.02, 0.98)
                local newY = math.clamp(dot.Position.Y.Scale + math.random(-10, 10) / 100, 0.02, 0.98)
                tw(dot, {Position = UDim2.fromScale(newX, newY), BackgroundTransparency = math.random(40, 85) / 100}, math.random(3, 8), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            end
        end)
    end

    -- Card
    local Card = Instance.new("Frame", BG)
    Card.Size                 = UDim2.fromOffset(460, 300)
    Card.Position             = UDim2.new(0.5, -230, 0.5, -150)
    Card.BackgroundColor3     = C_BG
    Card.BackgroundTransparency = 1
    Card.BorderSizePixel      = 0
    Card.ZIndex               = 2
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 18)

    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Color       = C_ORANGE
    CardStroke.Thickness   = 1.5
    CardStroke.Transparency = 0.6

    -- Card einblenden
    tw(Card, {BackgroundTransparency = 0}, 0.5)

    -- Glow pulsieren
    task.spawn(function()
        while Card and Card.Parent do
            task.wait(1.4)
            if not (Card and Card.Parent) then break end
            tw(CardStroke, {Transparency = 0.1}, 1.2, Enum.EasingStyle.Sine)
            task.wait(1.4)
            if not (Card and Card.Parent) then break end
            tw(CardStroke, {Transparency = 0.7}, 1.2, Enum.EasingStyle.Sine)
        end
    end)

    -- Top-Bar animiert
    local TopBar = Instance.new("Frame", Card)
    TopBar.Size             = UDim2.new(0, 0, 0, 3)
    TopBar.BackgroundColor3 = C_ORANGE
    TopBar.BorderSizePixel  = 0
    TopBar.ZIndex           = 4
    Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 18)
    task.delay(0.2, function() tw(TopBar, {Size = UDim2.new(1, 0, 0, 3)}, 0.5) end)

    -- Titel
    local TitleLbl = Instance.new("TextLabel", Card)
    TitleLbl.Size                 = UDim2.fromOffset(460, 44)
    TitleLbl.Position             = UDim2.fromOffset(0, 14)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text                 = "🟠  CELIHUB"
    TitleLbl.TextColor3           = C_WHITE
    TitleLbl.Font                 = Enum.Font.GothamBold
    TitleLbl.TextSize             = 28
    TitleLbl.ZIndex               = 3
    TitleLbl.TextTransparency     = 1
    task.delay(0.1, function() tw(TitleLbl, {TextTransparency = 0}, 0.4) end)

    local SubLbl = Instance.new("TextLabel", Card)
    SubLbl.Size                 = UDim2.fromOffset(460, 20)
    SubLbl.Position             = UDim2.fromOffset(0, 58)
    SubLbl.BackgroundTransparency = 1
    SubLbl.Text                 = "Made by Celi  •  key.celihub.site"
    SubLbl.TextColor3           = C_GRAY
    SubLbl.Font                 = Enum.Font.Gotham
    SubLbl.TextSize             = 13
    SubLbl.ZIndex               = 3
    SubLbl.TextTransparency     = 1
    task.delay(0.15, function() tw(SubLbl, {TextTransparency = 0}, 0.4) end)

    -- Divider
    local Div = Instance.new("Frame", Card)
    Div.Position             = UDim2.fromOffset(20, 88)
    Div.Size                 = UDim2.new(0, 0, 0, 1)
    Div.BackgroundColor3     = Color3.fromRGB(35, 35, 58)
    Div.BorderSizePixel      = 0
    Div.ZIndex               = 3
    task.delay(0.2, function() tw(Div, {Size = UDim2.new(1, -40, 0, 1)}, 0.5) end)

    -- Copy Button
    local CpBG = Instance.new("Frame", Card)
    CpBG.Size             = UDim2.fromOffset(420, 36)
    CpBG.Position         = UDim2.fromOffset(20, 100)
    CpBG.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    CpBG.BorderSizePixel  = 0
    CpBG.ZIndex           = 3
    Instance.new("UICorner", CpBG).CornerRadius = UDim.new(0, 9)

    local CpBtn = Instance.new("TextButton", CpBG)
    CpBtn.Size                 = UDim2.fromScale(1, 1)
    CpBtn.BackgroundTransparency = 1
    CpBtn.Text                 = "📋   key.celihub.site  —  Klicken zum Kopieren"
    CpBtn.TextColor3           = Color3.fromRGB(200, 120, 0)
    CpBtn.Font                 = Enum.Font.Code
    CpBtn.TextSize             = 13
    CpBtn.ZIndex               = 4
    CpBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(KEY_WEBSITE) end)
        CpBtn.Text      = "✅  Kopiert!"
        CpBtn.TextColor3 = Color3.fromRGB(60, 220, 100)
        task.wait(1.5)
        CpBtn.Text      = "📋   key.celihub.site  —  Klicken zum Kopieren"
        CpBtn.TextColor3 = Color3.fromRGB(200, 120, 0)
    end)

    -- Label "KEY EINGEBEN"
    local InLabel = Instance.new("TextLabel", Card)
    InLabel.Size                 = UDim2.fromOffset(420, 18)
    InLabel.Position             = UDim2.fromOffset(20, 148)
    InLabel.BackgroundTransparency = 1
    InLabel.Text                 = "KEY EINGEBEN"
    InLabel.TextColor3           = Color3.fromRGB(150, 90, 0)
    InLabel.Font                 = Enum.Font.GothamBold
    InLabel.TextSize             = 11
    InLabel.TextXAlignment       = Enum.TextXAlignment.Left
    InLabel.ZIndex               = 3

    -- Input
    local InBG = Instance.new("Frame", Card)
    InBG.Size             = UDim2.fromOffset(420, 48)
    InBG.Position         = UDim2.fromOffset(20, 168)
    InBG.BackgroundColor3 = C_EL
    InBG.BorderSizePixel  = 0
    InBG.ZIndex           = 3
    Instance.new("UICorner", InBG).CornerRadius = UDim.new(0, 11)

    local InStroke = Instance.new("UIStroke", InBG)
    InStroke.Color     = Color3.fromRGB(38, 38, 68)
    InStroke.Thickness = 1.5

    local InBox = Instance.new("TextBox", InBG)
    InBox.Size                 = UDim2.new(1, -20, 1, 0)
    InBox.Position             = UDim2.fromOffset(10, 0)
    InBox.BackgroundTransparency = 1
    InBox.PlaceholderText      = "Key eingeben..."
    InBox.PlaceholderColor3    = Color3.fromRGB(55, 55, 90)
    InBox.Text                 = ""
    InBox.TextColor3           = C_WHITE
    InBox.Font                 = Enum.Font.Code
    InBox.TextSize             = 18
    InBox.ClearTextOnFocus     = false
    InBox.ZIndex               = 4

    InBox.Focused:Connect(function()
        tw(InStroke, {Color = C_ORANGE, Thickness = 2}, 0.2)
    end)
    InBox.FocusLost:Connect(function()
        tw(InStroke, {Color = Color3.fromRGB(38, 38, 68), Thickness = 1.5}, 0.2)
    end)

    -- Status
    local StatusLbl = Instance.new("TextLabel", Card)
    StatusLbl.Size                 = UDim2.fromOffset(420, 22)
    StatusLbl.Position             = UDim2.fromOffset(20, 222)
    StatusLbl.BackgroundTransparency = 1
    StatusLbl.Text                 = ""
    StatusLbl.TextColor3           = Color3.fromRGB(220, 80, 80)
    StatusLbl.Font                 = Enum.Font.GothamBold
    StatusLbl.TextSize             = 13
    StatusLbl.TextXAlignment       = Enum.TextXAlignment.Left
    StatusLbl.ZIndex               = 3

    -- Login Button
    local BtnBG = Instance.new("Frame", Card)
    BtnBG.Size             = UDim2.fromOffset(420, 50)
    BtnBG.Position         = UDim2.fromOffset(20, 246)
    BtnBG.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    BtnBG.BorderSizePixel  = 0
    BtnBG.ZIndex           = 3
    Instance.new("UICorner", BtnBG).CornerRadius = UDim.new(0, 13)

    local BtnLbl = Instance.new("TextButton", BtnBG)
    BtnLbl.Size                 = UDim2.fromScale(1, 1)
    BtnLbl.BackgroundTransparency = 1
    BtnLbl.Text                 = "EINLOGGEN  →"
    BtnLbl.TextColor3           = C_WHITE
    BtnLbl.Font                 = Enum.Font.GothamBold
    BtnLbl.TextSize             = 17
    BtnLbl.ZIndex               = 4

    BtnLbl.MouseEnter:Connect(function() tw(BtnBG, {BackgroundColor3 = Color3.fromRGB(255, 140, 0)}, 0.12) end)
    BtnLbl.MouseLeave:Connect(function() tw(BtnBG, {BackgroundColor3 = Color3.fromRGB(200, 100, 0)}, 0.12) end)

    -- Shake helper
    local function shake()
        local origPos = UDim2.new(0.5, -230, 0.5, -150)
        for _ = 1, 3 do
            tw(Card, {Position = UDim2.new(0.5, -239, 0.5, -150)}, 0.04)
            task.wait(0.05)
            tw(Card, {Position = UDim2.new(0.5, -221, 0.5, -150)}, 0.04)
            task.wait(0.05)
        end
        tw(Card, {Position = origPos}, 0.05)
    end

    -- Verify Logic — returns true wenn OK
    local verified = false

    local function DoVerify()
        local k = InBox.Text:lower():gsub("%s+", "")
        if k == "" then
            StatusLbl.TextColor3 = Color3.fromRGB(220, 80, 80)
            StatusLbl.Text       = "❌  Key eingeben!"
            shake(); return
        end
        if k == VALID_KEY then
            verified = true
            StatusLbl.TextColor3 = Color3.fromRGB(60, 220, 100)
            StatusLbl.Text       = "✅  Gültig — Weiter..."
            BtnLbl.Text          = "✅  ZUGANG GEWÄHRT"
            tw(BtnBG,     {BackgroundColor3 = Color3.fromRGB(30, 165, 80)}, 0.3)
            tw(CardStroke, {Color = Color3.fromRGB(255, 180, 0), Transparency = 0}, 0.4)
            task.wait(0.9)
            tw(Card, {BackgroundTransparency = 1}, 0.3)
            tw(BG,   {BackgroundTransparency = 1}, 0.35)
            task.wait(0.4)
            SGui:Destroy()
        else
            StatusLbl.TextColor3 = Color3.fromRGB(220, 80, 80)
            StatusLbl.Text       = "❌  Falscher Key!  →  " .. KEY_WEBSITE
            InBox.Text           = ""
            tw(BtnBG, {BackgroundColor3 = Color3.fromRGB(155, 40, 0)}, 0.1)
            task.wait(0.15)
            tw(BtnBG, {BackgroundColor3 = Color3.fromRGB(200, 100, 0)}, 0.2)
            shake()
        end
    end

    BtnLbl.MouseButton1Click:Connect(function() DoVerify() end)
    InBox.FocusLost:Connect(function(enterPressed) if enterPressed then DoVerify() end end)

    -- Warten bis verified OHNE BindableEvent
    repeat task.wait(0.1) until verified or (not SGui.Parent)
    return verified
end

-- ============================================================
-- GAME SELECTOR  (gibt key-string zurück)
-- ============================================================
local function ShowGameSelector()
    local old = PlayerGui:FindFirstChild("CeliHubSel")
    if old then old:Destroy() end

    local SGui = Instance.new("ScreenGui")
    SGui.Name           = "CeliHubSel"
    SGui.ResetOnSpawn   = false
    SGui.IgnoreGuiInset = true
    SGui.Parent         = PlayerGui

    local BG = Instance.new("Frame", SGui)
    BG.Size                   = UDim2.fromScale(1, 1)
    BG.BackgroundColor3       = Color3.fromRGB(0, 0, 0)
    BG.BackgroundTransparency = 1
    BG.BorderSizePixel        = 0
    tw(BG, {BackgroundTransparency = 0.40}, 0.5)

    -- Partikel
    for i = 1, 18 do
        local dot = Instance.new("Frame", BG)
        local sz  = math.random(2, 5)
        dot.Size                   = UDim2.fromOffset(sz, sz)
        dot.Position               = UDim2.fromScale(math.random() * 0.95, 1.05)
        dot.BackgroundColor3       = ({C_ORANGE, Color3.fromRGB(220,40,40), Color3.fromRGB(40,110,220), Color3.fromRGB(160,40,220)})[math.random(1,4)]
        dot.BackgroundTransparency = math.random(30, 70) / 100
        dot.BorderSizePixel        = 0
        dot.ZIndex                 = 1
        Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
        task.spawn(function()
            while dot and dot.Parent do
                task.wait(math.random(7, 16))
                if not (dot and dot.Parent) then break end
                tw(dot, {Position = UDim2.fromScale(dot.Position.X.Scale, -0.05)}, math.random(7, 16), Enum.EasingStyle.Linear)
                task.wait(math.random(7, 16))
                if not (dot and dot.Parent) then break end
                dot.Position = UDim2.fromScale(math.random() * 0.95, 1.05)
            end
        end)
    end

    -- Haupt-Window (4 Karten → 868px breit)
    local Win = Instance.new("Frame", BG)
    Win.Size                   = UDim2.fromOffset(868, 340)
    Win.Position               = UDim2.new(0.5, -434, 0.6, -170)
    Win.BackgroundColor3       = Color3.fromRGB(10, 10, 18)
    Win.BackgroundTransparency = 1
    Win.BorderSizePixel        = 0
    Win.ZIndex                 = 2
    Instance.new("UICorner", Win).CornerRadius = UDim.new(0, 20)
    Instance.new("UIStroke",  Win).Color       = Color3.fromRGB(42, 42, 70)

    tw(Win, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -434, 0.5, -170)}, 0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    -- Oranger Top-Balken
    local TopLine = Instance.new("Frame", Win)
    TopLine.Size             = UDim2.new(0, 0, 0, 3)
    TopLine.BackgroundColor3 = C_ORANGE
    TopLine.BorderSizePixel  = 0
    TopLine.ZIndex           = 5
    Instance.new("UICorner", TopLine).CornerRadius = UDim.new(0, 20)
    task.delay(0.2, function() tw(TopLine, {Size = UDim2.new(1, 0, 0, 3)}, 0.6) end)

    -- Header
    local HdrF = Instance.new("Frame", Win)
    HdrF.Size             = UDim2.new(1, 0, 0, 76)
    HdrF.BackgroundColor3 = Color3.fromRGB(14, 14, 24)
    HdrF.BorderSizePixel  = 0
    HdrF.ZIndex           = 3
    Instance.new("UICorner", HdrF).CornerRadius = UDim.new(0, 20)

    local HdrTitle = Instance.new("TextLabel", HdrF)
    HdrTitle.Size                   = UDim2.fromOffset(868, 46)
    HdrTitle.Position               = UDim2.fromOffset(0, 10)
    HdrTitle.BackgroundTransparency = 1
    HdrTitle.Text                   = "🟠  CELIHUB  —  SPIEL AUSWÄHLEN"
    HdrTitle.TextColor3             = C_WHITE
    HdrTitle.Font                   = Enum.Font.GothamBold
    HdrTitle.TextSize               = 23
    HdrTitle.ZIndex                 = 4
    HdrTitle.TextTransparency       = 1
    task.delay(0.1, function() tw(HdrTitle, {TextTransparency = 0}, 0.4) end)

    local HdrSub = Instance.new("TextLabel", HdrF)
    HdrSub.Size                   = UDim2.fromOffset(868, 24)
    HdrSub.Position               = UDim2.fromOffset(0, 52)
    HdrSub.BackgroundTransparency = 1
    HdrSub.Text                   = "Key akzeptiert ✅  —  Wähle dein Spiel"
    HdrSub.TextColor3             = C_GRAY
    HdrSub.Font                   = Enum.Font.Gotham
    HdrSub.TextSize               = 13
    HdrSub.ZIndex                 = 4
    HdrSub.TextTransparency       = 1
    task.delay(0.18, function() tw(HdrSub, {TextTransparency = 0}, 0.4) end)

    -- Karten-Daten
    local GAMES = {
        {icon = "🚨", title = "Emergency Emden",   desc = "Speed • Fly • NoClip\nAimbot • Admin Check • ESP",       col = Color3.fromRGB(220,40,40),  glow = Color3.fromRGB(255,70,70),  key = "emden"},
        {icon = "🏙️", title = "Emergency Hamburg", desc = "Fahrzeug Mods • Waffen\nAuto Eat • Alles aus Emden+",    col = Color3.fromRGB(40,110,220), glow = Color3.fromRGB(70,150,255), key = "hamburg"},
        {icon = "🌍", title = "Universal",          desc = "Aimbot • ESP • Tracer\nChams • Alle Spiele",             col = Color3.fromRGB(160,40,220), glow = Color3.fromRGB(200,80,255), key = "universal"},
        {icon = "🟠", title = "c00lgui Edition",    desc = "Gear • Admin GUIs • Skybox\nMusic • Server Tools • Mehr", col = C_ORANGE,                  glow = Color3.fromRGB(255,180,50), key = "coolgui"},
    }

    local chosen  = nil
    local cardW   = 192

    for idx, g in ipairs(GAMES) do
        local xOff = 14 + (idx - 1) * (cardW + 14)
        local gRef = g

        local GF = Instance.new("Frame", Win)
        GF.Size                   = UDim2.fromOffset(cardW, 222)
        GF.Position               = UDim2.fromOffset(xOff, 90)
        GF.BackgroundColor3       = Color3.fromRGB(16, 16, 27)
        GF.BorderSizePixel        = 0
        GF.ZIndex                 = 3
        GF.BackgroundTransparency = 1
        Instance.new("UICorner", GF).CornerRadius = UDim.new(0, 15)

        local GSt = Instance.new("UIStroke", GF)
        GSt.Color       = Color3.fromRGB(35, 35, 60)
        GSt.Thickness   = 1.5

        task.delay(0.08 * idx, function()
            if GF and GF.Parent then
                tw(GF, {BackgroundTransparency = 0}, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            end
        end)

        -- Farbiger Streifen oben
        local GTop = Instance.new("Frame", GF)
        GTop.Size             = UDim2.new(1, 0, 0, 3)
        GTop.BackgroundColor3 = gRef.col
        GTop.BorderSizePixel  = 0
        GTop.ZIndex           = 4
        Instance.new("UICorner", GTop).CornerRadius = UDim.new(0, 15)

        -- Icon-Kreis
        local ICir = Instance.new("Frame", GF)
        ICir.Size                   = UDim2.fromOffset(54, 54)
        ICir.Position               = UDim2.fromOffset(cardW / 2 - 27, 14)
        ICir.BackgroundColor3       = gRef.col
        ICir.BackgroundTransparency = 0.75
        ICir.BorderSizePixel        = 0
        ICir.ZIndex                 = 4
        Instance.new("UICorner", ICir).CornerRadius = UDim.new(1, 0)

        local IL = Instance.new("TextLabel", ICir)
        IL.Size                   = UDim2.fromScale(1, 1)
        IL.BackgroundTransparency = 1
        IL.Text                   = gRef.icon
        IL.TextSize               = 30
        IL.Font                   = Enum.Font.GothamBold
        IL.ZIndex                 = 5

        -- Titel
        local TL = Instance.new("TextLabel", GF)
        TL.Size                   = UDim2.fromOffset(cardW - 14, 32)
        TL.Position               = UDim2.fromOffset(7, 78)
        TL.BackgroundTransparency = 1
        TL.Text                   = gRef.title
        TL.TextColor3             = Color3.fromRGB(240, 240, 255)
        TL.Font                   = Enum.Font.GothamBold
        TL.TextSize               = 13
        TL.TextWrapped            = true
        TL.ZIndex                 = 4

        -- Beschreibung
        local DL = Instance.new("TextLabel", GF)
        DL.Size                   = UDim2.fromOffset(cardW - 14, 58)
        DL.Position               = UDim2.fromOffset(7, 110)
        DL.BackgroundTransparency = 1
        DL.Text                   = gRef.desc
        DL.TextColor3             = Color3.fromRGB(90, 90, 125)
        DL.Font                   = Enum.Font.Gotham
        DL.TextSize               = 11
        DL.TextWrapped            = true
        DL.ZIndex                 = 4

        -- Start-Button
        local BF = Instance.new("Frame", GF)
        BF.Size             = UDim2.fromOffset(cardW - 18, 40)
        BF.Position         = UDim2.fromOffset(9, 176)
        BF.BackgroundColor3 = gRef.col
        BF.BorderSizePixel  = 0
        BF.ZIndex           = 4
        Instance.new("UICorner", BF).CornerRadius = UDim.new(0, 11)

        local BT = Instance.new("TextButton", BF)
        BT.Size                   = UDim2.fromScale(1, 1)
        BT.BackgroundTransparency = 1
        BT.Text                   = "▶  STARTEN"
        BT.TextColor3             = C_WHITE
        BT.Font                   = Enum.Font.GothamBold
        BT.TextSize               = 14
        BT.ZIndex                 = 5

        local gF2, gS2, bF2 = GF, GSt, BF
        BT.MouseEnter:Connect(function()
            tw(gF2, {BackgroundColor3 = Color3.fromRGB(22, 22, 40)}, 0.14)
            tw(gS2, {Color = gRef.col, Transparency = 0.2},          0.14)
            tw(bF2, {BackgroundColor3 = gRef.glow},                   0.14)
        end)
        BT.MouseLeave:Connect(function()
            tw(gF2, {BackgroundColor3 = Color3.fromRGB(16, 16, 27)},  0.14)
            tw(gS2, {Color = Color3.fromRGB(35, 35, 60), Transparency = 0}, 0.14)
            tw(bF2, {BackgroundColor3 = gRef.col},                    0.14)
        end)

        BT.MouseButton1Click:Connect(function()
            if chosen then return end  -- Doppelklick verhindern
            chosen = gRef.key
            tw(gF2, {BackgroundColor3 = gRef.col}, 0.1)
            task.wait(0.15)
            tw(Win, {BackgroundTransparency = 1}, 0.28)
            tw(BG,  {BackgroundTransparency = 1}, 0.32)
            task.wait(0.35)
            SGui:Destroy()
        end)
    end

    -- Footer
    local Foot = Instance.new("TextLabel", Win)
    Foot.Size                   = UDim2.fromOffset(868, 22)
    Foot.Position               = UDim2.fromOffset(0, 314)
    Foot.BackgroundTransparency = 1
    Foot.Text                   = "CeliHub v2  •  by Celi  •  4 Scripts verfügbar"
    Foot.TextColor3             = Color3.fromRGB(45, 45, 70)
    Foot.Font                   = Enum.Font.Gotham
    Foot.TextSize               = 11
    Foot.ZIndex                 = 3

    -- Warten bis Karte geklickt OHNE BindableEvent
    repeat task.wait(0.1) until chosen ~= nil or (not SGui.Parent)
    return chosen or "emden"
end

-- ============================================================
-- MAIN
-- ============================================================
local keyOk = ShowKeyScreen()

if keyOk then
    local choice = ShowGameSelector()

    local urls = {
        emden     = EMDEN_URL,
        hamburg   = HAMBURG_URL,
        universal = UNIVERSAL_URL,
        coolgui   = COOLGUI_URL,
    }

    local url = urls[choice]
    if url then
        local ok, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        if not ok then
            warn("[CeliHub] Fehler beim Laden: " .. tostring(err))
        end
    end
end
