-- ============================================================
-- CeliHub | Launcher v1
-- Made by Celi 💫
-- ============================================================
-- ANLEITUNG:
-- 1. Lade alle 3 Dateien hoch (Launcher + Emden + Hamburg)
-- 2. Hoste Emden + Hamburg auf GitHub (als Raw-Link)
-- 3. Trage die Links unten bei EMDEN_URL und HAMBURG_URL ein
-- 4. Führe nur den Launcher aus
-- ============================================================

local coreGui = game:GetService("CoreGui")

local VALID_KEY   = "celi2026"
local KEY_WEBSITE = "key.celihub.site"

-- ▼▼▼ HIER DEINE GITHUB RAW-LINKS EINTRAGEN ▼▼▼
local EMDEN_URL   = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_EmdenEdition_v4.lua"
local HAMBURG_URL = "https://raw.githubusercontent.com/Celi0905/celihub/main/CeliHub_Hamburg_Edition.lua"
-- ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

-- ============================================================
-- // KEY SCREEN
-- ============================================================
local function ShowKeyScreen()
    local old = coreGui:FindFirstChild("CeliHubKeyScreen")
    if old then old:Destroy() end

    local SGui = Instance.new("ScreenGui")
    SGui.Name="CeliHubKeyScreen"; SGui.ResetOnSpawn=false
    SGui.DisplayOrder=999; SGui.Parent=coreGui

    local BG=Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1)
    BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=0.45; BG.BorderSizePixel=0

    local Card=Instance.new("Frame",BG); Card.Size=UDim2.fromOffset(440,310)
    Card.Position=UDim2.fromScale(0.5,0.5); Card.AnchorPoint=Vector2.new(0.5,0.5)
    Card.BackgroundColor3=Color3.fromRGB(15,15,24); Card.BorderSizePixel=0
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,16)

    local Acc=Instance.new("Frame",Card); Acc.Size=UDim2.new(1,0,0,4)
    Acc.BackgroundColor3=Color3.fromRGB(220,40,40); Acc.BorderSizePixel=0
    Instance.new("UICorner",Acc).CornerRadius=UDim.new(0,16)

    local function L(p,t,x,y,w,h,sz,fnt,col,ax)
        local l=Instance.new("TextLabel",p); l.Size=UDim2.fromOffset(w,h)
        l.Position=UDim2.fromOffset(x,y); l.BackgroundTransparency=1; l.Text=t
        l.TextColor3=col or Color3.fromRGB(220,220,220); l.Font=fnt or Enum.Font.Gotham
        l.TextSize=sz or 14; l.TextXAlignment=ax or Enum.TextXAlignment.Center; return l
    end

    L(Card,"🚨  CeliHub  —  Key System",0,14,440,36,20,Enum.Font.GothamBold,Color3.fromRGB(255,255,255))
    L(Card,"🔑  Key holen auf:",20,62,300,20,13,nil,Color3.fromRGB(140,140,200),Enum.TextXAlignment.Left)

    local CpBG=Instance.new("Frame",Card); CpBG.Size=UDim2.fromOffset(400,32); CpBG.Position=UDim2.fromOffset(20,84)
    CpBG.BackgroundColor3=Color3.fromRGB(30,30,50); CpBG.BorderSizePixel=0
    Instance.new("UICorner",CpBG).CornerRadius=UDim.new(0,8)

    local CpBtn=Instance.new("TextButton",CpBG); CpBtn.Size=UDim2.fromScale(1,1); CpBtn.BackgroundTransparency=1
    CpBtn.Text="📋  key.celihub.site  —  Klicken zum Kopieren"
    CpBtn.TextColor3=Color3.fromRGB(160,160,240); CpBtn.Font=Enum.Font.Code; CpBtn.TextSize=13
    CpBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(KEY_WEBSITE) end)
        CpBtn.Text="✅  Kopiert!"; CpBtn.TextColor3=Color3.fromRGB(80,220,120)
        task.wait(1.5); CpBtn.Text="📋  key.celihub.site  —  Klicken zum Kopieren"
        CpBtn.TextColor3=Color3.fromRGB(160,160,240)
    end)

    local Dv=Instance.new("Frame",Card); Dv.Size=UDim2.fromOffset(400,1); Dv.Position=UDim2.fromOffset(20,128)
    Dv.BackgroundColor3=Color3.fromRGB(40,40,60); Dv.BorderSizePixel=0

    L(Card,"Key eingeben:",20,138,200,20,12,nil,Color3.fromRGB(160,160,180),Enum.TextXAlignment.Left)

    local InBG=Instance.new("Frame",Card); InBG.Size=UDim2.fromOffset(400,42); InBG.Position=UDim2.fromOffset(20,160)
    InBG.BackgroundColor3=Color3.fromRGB(24,24,38); InBG.BorderSizePixel=0
    Instance.new("UICorner",InBG).CornerRadius=UDim.new(0,8)

    local InBox=Instance.new("TextBox",InBG); InBox.Size=UDim2.new(1,-16,1,0); InBox.Position=UDim2.fromOffset(8,0)
    InBox.BackgroundTransparency=1; InBox.PlaceholderText="Key eingeben..."
    InBox.PlaceholderColor3=Color3.fromRGB(80,80,110); InBox.Text=""
    InBox.TextColor3=Color3.fromRGB(230,230,230); InBox.Font=Enum.Font.Code
    InBox.TextSize=15; InBox.ClearTextOnFocus=false

    local StLbl=L(Card,"",20,208,400,20,13,nil,Color3.fromRGB(220,80,80),Enum.TextXAlignment.Left)

    local BtBG=Instance.new("Frame",Card); BtBG.Size=UDim2.fromOffset(400,44); BtBG.Position=UDim2.fromOffset(20,252)
    BtBG.BackgroundColor3=Color3.fromRGB(200,35,35); BtBG.BorderSizePixel=0
    Instance.new("UICorner",BtBG).CornerRadius=UDim.new(0,10)

    local BtLbl=Instance.new("TextButton",BtBG); BtLbl.Size=UDim2.fromScale(1,1); BtLbl.BackgroundTransparency=1
    BtLbl.Text="🔓  Einloggen"; BtLbl.TextColor3=Color3.fromRGB(255,255,255)
    BtLbl.Font=Enum.Font.GothamBold; BtLbl.TextSize=16

    local done=Instance.new("BindableEvent")

    local function DoVerify()
        local k=InBox.Text:lower():gsub("%s+","")
        if k=="" then StLbl.TextColor3=Color3.fromRGB(220,80,80); StLbl.Text="❌ Key eingeben!"; return end
        if k==VALID_KEY then
            StLbl.TextColor3=Color3.fromRGB(60,220,100); StLbl.Text="✅ Gültig! Weiter..."
            BtLbl.Text="✅ Zugang gewährt!"; BtBG.BackgroundColor3=Color3.fromRGB(30,160,80)
            task.wait(1); SGui:Destroy(); done:Fire()
        else
            StLbl.TextColor3=Color3.fromRGB(220,80,80); StLbl.Text="❌ Falscher Key! → "..KEY_WEBSITE
            InBox.Text=""; BtBG.BackgroundColor3=Color3.fromRGB(160,20,20)
            task.wait(0.3); BtBG.BackgroundColor3=Color3.fromRGB(200,35,35)
        end
    end

    BtLbl.MouseButton1Click:Connect(DoVerify)
    InBox.FocusLost:Connect(function(e) if e then DoVerify() end end)
    done.Event:Wait(); done:Destroy()
end

-- ============================================================
-- // SPIEL AUSWAHL
-- ============================================================
local function ShowGameSelector()
    local old=coreGui:FindFirstChild("CeliHubSelector"); if old then old:Destroy() end

    local SGui=Instance.new("ScreenGui"); SGui.Name="CeliHubSelector"
    SGui.ResetOnSpawn=false; SGui.DisplayOrder=999; SGui.Parent=coreGui

    local BG=Instance.new("Frame",SGui); BG.Size=UDim2.fromScale(1,1)
    BG.BackgroundColor3=Color3.fromRGB(0,0,0); BG.BackgroundTransparency=0.45; BG.BorderSizePixel=0

    local Card=Instance.new("Frame",BG); Card.Size=UDim2.fromOffset(500,300)
    Card.Position=UDim2.fromScale(0.5,0.5); Card.AnchorPoint=Vector2.new(0.5,0.5)
    Card.BackgroundColor3=Color3.fromRGB(15,15,24); Card.BorderSizePixel=0
    Instance.new("UICorner",Card).CornerRadius=UDim.new(0,16)

    local Acc=Instance.new("Frame",Card); Acc.Size=UDim2.new(1,0,0,4)
    Acc.BackgroundColor3=Color3.fromRGB(220,40,40); Acc.BorderSizePixel=0
    Instance.new("UICorner",Acc).CornerRadius=UDim.new(0,16)

    local TL=Instance.new("TextLabel",Card); TL.Size=UDim2.fromOffset(500,42); TL.Position=UDim2.fromOffset(0,14)
    TL.BackgroundTransparency=1; TL.Text="🚨  CeliHub  —  Spiel auswählen"
    TL.TextColor3=Color3.fromRGB(255,255,255); TL.Font=Enum.Font.GothamBold; TL.TextSize=20

    local SL=Instance.new("TextLabel",Card); SL.Size=UDim2.fromOffset(500,24); SL.Position=UDim2.fromOffset(0,60)
    SL.BackgroundTransparency=1; SL.Text="Für welches Spiel möchtest du CeliHub laden?"
    SL.TextColor3=Color3.fromRGB(160,160,180); SL.Font=Enum.Font.Gotham; SL.TextSize=14

    local function GameCard(xOff, icon, name, sub, col)
        local F=Instance.new("Frame",Card); F.Size=UDim2.fromOffset(210,150)
        F.Position=UDim2.fromOffset(xOff,96); F.BackgroundColor3=Color3.fromRGB(22,22,35)
        F.BorderSizePixel=0; Instance.new("UICorner",F).CornerRadius=UDim.new(0,12)

        local Bar=Instance.new("Frame",F); Bar.Size=UDim2.new(1,0,0,3)
        Bar.BackgroundColor3=col; Bar.BorderSizePixel=0
        Instance.new("UICorner",Bar).CornerRadius=UDim.new(0,12)

        local function tl(t,y,sz,fnt,c)
            local l=Instance.new("TextLabel",F); l.Size=UDim2.fromOffset(210,sz+4)
            l.Position=UDim2.fromOffset(0,y); l.BackgroundTransparency=1; l.Text=t
            l.TextSize=sz; l.Font=fnt or Enum.Font.GothamBold; l.TextColor3=c or Color3.fromRGB(255,255,255)
        end
        tl(icon, 14, 40, Enum.Font.GothamBold)
        tl(name, 62, 16, Enum.Font.GothamBold)
        tl(sub,  86, 12, Enum.Font.Gotham, Color3.fromRGB(140,140,160))

        local Btn=Instance.new("TextButton",F); Btn.Size=UDim2.fromOffset(210,38)
        Btn.Position=UDim2.fromOffset(0,112); Btn.BackgroundColor3=col
        Btn.BorderSizePixel=0; Btn.Text="▶  Starten"
        Btn.TextColor3=Color3.fromRGB(255,255,255); Btn.Font=Enum.Font.GothamBold; Btn.TextSize=14
        Instance.new("UICorner",Btn).CornerRadius=UDim.new(0,8)
        return Btn
    end

    local EmdenBtn   = GameCard(20,  "🚨","Emergency Emden",   "Emden Edition",   Color3.fromRGB(220,40,40))
    local HamburgBtn = GameCard(268, "🏙️","Emergency Hamburg", "Hamburg Edition", Color3.fromRGB(40,120,220))

    local done=Instance.new("BindableEvent"); local choice="emden"
    EmdenBtn.MouseButton1Click:Connect(function()   choice="emden";   SGui:Destroy(); done:Fire() end)
    HamburgBtn.MouseButton1Click:Connect(function() choice="hamburg"; SGui:Destroy(); done:Fire() end)
    done.Event:Wait(); done:Destroy()
    return choice
end

-- ============================================================
-- // STARTE
-- ============================================================
ShowKeyScreen()
local gameChoice = ShowGameSelector()

if gameChoice == "emden" then
    loadstring(game:HttpGet(EMDEN_URL))()
elseif gameChoice == "hamburg" then
    loadstring(game:HttpGet(HAMBURG_URL))()
end
