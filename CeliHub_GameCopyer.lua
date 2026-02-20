-- 📋 Celi Game Copyer
-- Made by Celi 💫
-- Speichert das aktuelle Spiel als .rbxl Datei

local Players   = game:GetService("Players")
local Player    = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

-- Altes GUI entfernen
local old = PlayerGui:FindFirstChild("CeliGameCopyerGui")
if old then old:Destroy() end

local function tw(o,p,t) pcall(function() TweenService:Create(o,TweenInfo.new(t or 0.2),p):Play() end) end

-- ============================================================
-- GUI
-- ============================================================
local SGui = Instance.new("ScreenGui")
SGui.Name = "CeliGameCopyerGui"
SGui.ResetOnSpawn = false
SGui.IgnoreGuiInset = true
SGui.Parent = PlayerGui

local ACCENT  = Color3.fromRGB(50,160,220)
local ACCENT2 = Color3.fromRGB(80,200,255)
local BG      = Color3.fromRGB(10,10,18)
local BG2     = Color3.fromRGB(18,18,32)
local BTN     = Color3.fromRGB(22,22,38)

local Main = Instance.new("Frame", SGui)
Main.Size = UDim2.fromOffset(380, 320)
Main.Position = UDim2.new(0.5,-190,0.5,-160)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,14)
local MSt = Instance.new("UIStroke",Main); MSt.Color=ACCENT; MSt.Thickness=1.5

-- Pulsieren
task.spawn(function()
    while Main and Main.Parent do
        task.wait(1.4); if not(Main and Main.Parent) then break end
        tw(MSt,{Color=ACCENT2,Transparency=0.1},1.2)
        task.wait(1.4); if not(Main and Main.Parent) then break end
        tw(MSt,{Color=ACCENT,Transparency=0.5},1.2)
    end
end)

-- TopBar
local Top = Instance.new("Frame",Main); Top.Size=UDim2.new(1,0,0,3); Top.BackgroundColor3=ACCENT; Top.BorderSizePixel=0
Instance.new("UICorner",Top).CornerRadius=UDim.new(0,14)

-- Schließen
local CloseBtn = Instance.new("TextButton",Main)
CloseBtn.Size=UDim2.fromOffset(28,28); CloseBtn.Position=UDim2.new(1,-36,0,10)
CloseBtn.BackgroundColor3=Color3.fromRGB(180,40,40); CloseBtn.Text="✕"
CloseBtn.TextColor3=Color3.new(1,1,1); CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.TextSize=14; CloseBtn.BorderSizePixel=0
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,7)
CloseBtn.MouseButton1Click:Connect(function() SGui:Destroy() end)
CloseBtn.MouseEnter:Connect(function() tw(CloseBtn,{BackgroundColor3=Color3.fromRGB(220,60,60)},0.1) end)
CloseBtn.MouseLeave:Connect(function() tw(CloseBtn,{BackgroundColor3=Color3.fromRGB(180,40,40)},0.1) end)

-- Titel
local TL = Instance.new("TextLabel",Main)
TL.Size=UDim2.fromOffset(380,44); TL.Position=UDim2.fromOffset(0,10)
TL.BackgroundTransparency=1; TL.Text="📋  Celi Game Copyer"
TL.TextColor3=Color3.new(1,1,1); TL.Font=Enum.Font.GothamBold; TL.TextSize=22

local SL = Instance.new("TextLabel",Main)
SL.Size=UDim2.fromOffset(380,18); SL.Position=UDim2.fromOffset(0,52)
SL.BackgroundTransparency=1; SL.Text="by Celi 💫  •  SynSaveInstance"
SL.TextColor3=ACCENT; SL.Font=Enum.Font.Gotham; SL.TextSize=12

-- Trennlinie
local Div=Instance.new("Frame",Main); Div.Size=UDim2.new(1,-30,0,1); Div.Position=UDim2.fromOffset(15,74); Div.BackgroundColor3=Color3.fromRGB(35,35,60); Div.BorderSizePixel=0

-- Info Box
local InfoBG=Instance.new("Frame",Main); InfoBG.Size=UDim2.fromOffset(344,86); InfoBG.Position=UDim2.fromOffset(18,84); InfoBG.BackgroundColor3=BG2; InfoBG.BorderSizePixel=0
Instance.new("UICorner",InfoBG).CornerRadius=UDim.new(0,10)
Instance.new("UIStroke",InfoBG).Color=Color3.fromRGB(35,35,60)
local InfoL=Instance.new("TextLabel",InfoBG); InfoL.Size=UDim2.fromOffset(326,78); InfoL.Position=UDim2.fromOffset(9,4)
InfoL.BackgroundTransparency=1; InfoL.TextColor3=Color3.fromRGB(160,160,200); InfoL.Font=Enum.Font.Gotham; InfoL.TextSize=12; InfoL.TextWrapped=true; InfoL.TextXAlignment=Enum.TextXAlignment.Left; InfoL.TextYAlignment=Enum.TextYAlignment.Top
InfoL.Text="ℹ️  Kopiert das gesamte Spiel als .rbxl Datei.\n\nDie Datei wird in deinen Roblox-Exploit-Ordner gespeichert. Je nach Spielgröße kann es einige Sekunden dauern."

-- Status Label
local StatL=Instance.new("TextLabel",Main); StatL.Size=UDim2.fromOffset(344,20); StatL.Position=UDim2.fromOffset(18,178)
StatL.BackgroundTransparency=1; StatL.Text="⏳  Bereit zum Kopieren"; StatL.TextColor3=Color3.fromRGB(120,120,160)
StatL.Font=Enum.Font.GothamBold; StatL.TextSize=13; StatL.TextXAlignment=Enum.TextXAlignment.Left

-- Progress Bar
local ProgBG=Instance.new("Frame",Main); ProgBG.Size=UDim2.fromOffset(344,8); ProgBG.Position=UDim2.fromOffset(18,202); ProgBG.BackgroundColor3=BTN; ProgBG.BorderSizePixel=0
Instance.new("UICorner",ProgBG).CornerRadius=UDim.new(0,4)
local ProgFill=Instance.new("Frame",ProgBG); ProgFill.Size=UDim2.fromScale(0,1); ProgFill.BackgroundColor3=ACCENT; ProgFill.BorderSizePixel=0
Instance.new("UICorner",ProgFill).CornerRadius=UDim.new(0,4)

local function SetProgress(pct, text, col)
    tw(ProgFill,{Size=UDim2.fromScale(pct,1)},0.3)
    StatL.Text = text
    StatL.TextColor3 = col or Color3.fromRGB(120,120,160)
end

-- Start Button
local StartBtn=Instance.new("TextButton",Main)
StartBtn.Size=UDim2.fromOffset(344,46); StartBtn.Position=UDim2.fromOffset(18,222)
StartBtn.BackgroundColor3=ACCENT; StartBtn.Text="📋  Spiel jetzt kopieren"
StartBtn.TextColor3=Color3.new(1,1,1); StartBtn.Font=Enum.Font.GothamBold; StartBtn.TextSize=16; StartBtn.BorderSizePixel=0
Instance.new("UICorner",StartBtn).CornerRadius=UDim.new(0,12)
StartBtn.MouseEnter:Connect(function() tw(StartBtn,{BackgroundColor3=ACCENT2},0.1) end)
StartBtn.MouseLeave:Connect(function() tw(StartBtn,{BackgroundColor3=ACCENT},0.1) end)

-- Game Info
local GameL=Instance.new("TextLabel",Main); GameL.Size=UDim2.fromOffset(344,36); GameL.Position=UDim2.fromOffset(18,278)
GameL.BackgroundTransparency=1; GameL.TextColor3=Color3.fromRGB(70,70,100); GameL.Font=Enum.Font.Code; GameL.TextSize=11; GameL.TextWrapped=true; GameL.TextXAlignment=Enum.TextXAlignment.Left
GameL.Text="🎮  "..game.Name.."  •  PlaceID: "..game.PlaceId.."\n📁  Wird in Exploit-Ordner gespeichert"

-- Button Logik
local running = false
StartBtn.MouseButton1Click:Connect(function()
    if running then return end
    running = true
    StartBtn.Text = "⏳  Lädt SynSaveInstance..."
    StartBtn.BackgroundColor3 = Color3.fromRGB(80,80,40)
    SetProgress(0.1, "⏳  Lade SynSaveInstance...", Color3.fromRGB(220,180,40))

    task.spawn(function()
        local ok, err = pcall(function()
            SetProgress(0.3, "📥  SynSaveInstance wird geladen...", Color3.fromRGB(220,180,40))

            local Params = {
                RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
                SSI = "saveinstance",
            }
            local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

            SetProgress(0.6, "📋  Kopiere Spiel... bitte warten", Color3.fromRGB(220,180,40))

            local Options = {}
            synsaveinstance(Options)

            SetProgress(1.0, "✅  Erfolgreich gespeichert!", Color3.fromRGB(60,220,100))
            StartBtn.Text = "✅  Gespeichert!"
            StartBtn.BackgroundColor3 = Color3.fromRGB(30,140,60)
        end)

        if not ok then
            SetProgress(0, "❌  Fehler: " .. tostring(err):sub(1,60), Color3.fromRGB(220,60,60))
            StartBtn.Text = "❌  Fehler — nochmal versuchen"
            StartBtn.BackgroundColor3 = Color3.fromRGB(160,40,40)
            task.wait(3)
            StartBtn.Text = "📋  Spiel jetzt kopieren"
            StartBtn.BackgroundColor3 = ACCENT
            running = false
            SetProgress(0, "⏳  Bereit zum Kopieren", Color3.fromRGB(120,120,160))
        end
    end)
end)

-- Einblenden
Main.BackgroundTransparency = 1
tw(Main, {BackgroundTransparency=0}, 0.4)
