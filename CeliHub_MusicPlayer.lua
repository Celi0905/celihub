-- 🎵 Celi Music Player
-- Made by Celi 💫
-- Eigenes GUI — kein Rayfield nötig

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player           = Players.LocalPlayer
local PlayerGui        = Player:WaitForChild("PlayerGui")

-- Altes GUI entfernen
local old = PlayerGui:FindFirstChild("CeliMusicPlayerGui")
if old then old:Destroy() end

-- ============================================================
-- STATE
-- ============================================================
local MusicVolume  = 0.7
local MusicPitch   = 1.0
local MusicLooped  = true
local Playlist     = {}
local PlaylistIdx  = 1
local CurrentSound = nil

local ACCENT   = Color3.fromRGB(220, 60, 180)   -- Pink
local ACCENT2  = Color3.fromRGB(255, 100, 220)
local BG_DARK  = Color3.fromRGB(10, 10, 18)
local BG_MID   = Color3.fromRGB(16, 16, 28)
local BG_BTN   = Color3.fromRGB(22, 22, 38)
local TXT_MAIN = Color3.new(1, 1, 1)
local TXT_SUB  = Color3.fromRGB(140, 140, 180)
local TXT_ACC  = Color3.fromRGB(220, 60, 180)

local function tw(obj, props, t, s, d)
    pcall(function()
        TweenService:Create(obj, TweenInfo.new(t or 0.2, s or Enum.EasingStyle.Quart, d or Enum.EasingDirection.Out), props):Play()
    end)
end

local function make(cls, parent, props)
    local o = Instance.new(cls)
    for k, v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end

local function corner(parent, r)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end

local function stroke(parent, col, thick)
    local s = Instance.new("UIStroke", parent)
    s.Color = col or Color3.fromRGB(40, 40, 70)
    s.Thickness = thick or 1.5
    return s
end

-- ============================================================
-- SOUND HELPERS
-- ============================================================
local function GetOrCreate()
    local s = workspace:FindFirstChild("CeliMusicSound")
    if s and s:IsA("Sound") then CurrentSound = s; return s end
    if CurrentSound and CurrentSound.Parent then CurrentSound:Destroy() end
    local ns = Instance.new("Sound", workspace)
    ns.Name = "CeliMusicSound"
    ns.Volume = MusicVolume
    ns.PlaybackSpeed = MusicPitch
    ns.Looped = MusicLooped
    CurrentSound = ns
    return ns
end

local function PlayID(id)
    id = tostring(id):gsub("[^%d]", "")
    if id == "" then return false end
    local s = GetOrCreate()
    s:Stop()
    s.SoundId = "rbxassetid://" .. id
    s.Volume = MusicVolume
    s.PlaybackSpeed = MusicPitch
    s.Looped = MusicLooped
    s:Play()
    return true
end

local function StopMusic()
    local s = workspace:FindFirstChild("CeliMusicSound")
    if s then s:Stop(); s:Destroy() end
    CurrentSound = nil
end

-- ============================================================
-- MAIN GUI
-- ============================================================
local SGui = make("ScreenGui", PlayerGui, {
    Name = "CeliMusicPlayerGui",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

-- Hintergrund-Blur-Overlay (leicht)
local Overlay = make("Frame", SGui, {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(0,0,0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
})

-- Haupt-Fenster
local Main = make("Frame", SGui, {
    Size = UDim2.fromOffset(420, 560),
    Position = UDim2.new(0.5, -210, 0.5, -280),
    BackgroundColor3 = BG_DARK,
    BorderSizePixel = 0,
    Active = true,
    Draggable = true,
})
corner(Main, 16)
local MSt = stroke(Main, ACCENT, 1.5)

-- Pulsieren
task.spawn(function()
    while Main and Main.Parent do
        task.wait(1.5)
        if not(Main and Main.Parent) then break end
        tw(MSt, {Color=ACCENT2, Transparency=0.1}, 1.2, Enum.EasingStyle.Sine)
        task.wait(1.5)
        if not(Main and Main.Parent) then break end
        tw(MSt, {Color=ACCENT, Transparency=0.5}, 1.2, Enum.EasingStyle.Sine)
    end
end)

-- Oberer farbiger Streifen
local TopBar = make("Frame", Main, {
    Size = UDim2.new(1, 0, 0, 3),
    BackgroundColor3 = ACCENT,
    BorderSizePixel = 0,
})
corner(TopBar, 16)

-- Titel
local TitleLbl = make("TextLabel", Main, {
    Size = UDim2.fromOffset(420, 44),
    Position = UDim2.fromOffset(0, 10),
    BackgroundTransparency = 1,
    Text = "🎵  Celi Music Player",
    TextColor3 = TXT_MAIN,
    Font = Enum.Font.GothamBold,
    TextSize = 22,
})
local SubLbl = make("TextLabel", Main, {
    Size = UDim2.fromOffset(420, 18),
    Position = UDim2.fromOffset(0, 52),
    BackgroundTransparency = 1,
    Text = "by Celi 💫",
    TextColor3 = TXT_ACC,
    Font = Enum.Font.Gotham,
    TextSize = 12,
})

-- Trennlinie
local Div = make("Frame", Main, {
    Size = UDim2.new(1, -30, 0, 1),
    Position = UDim2.fromOffset(15, 74),
    BackgroundColor3 = Color3.fromRGB(35, 35, 60),
    BorderSizePixel = 0,
})

-- Schließen-Button
local CloseBtn = make("TextButton", Main, {
    Size = UDim2.fromOffset(28, 28),
    Position = UDim2.new(1, -36, 0, 10),
    BackgroundColor3 = Color3.fromRGB(180, 40, 40),
    Text = "✕",
    TextColor3 = TXT_MAIN,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    BorderSizePixel = 0,
})
corner(CloseBtn, 7)
CloseBtn.MouseButton1Click:Connect(function() SGui:Destroy() end)
CloseBtn.MouseEnter:Connect(function() tw(CloseBtn, {BackgroundColor3=Color3.fromRGB(220,60,60)}, 0.12) end)
CloseBtn.MouseLeave:Connect(function() tw(CloseBtn, {BackgroundColor3=Color3.fromRGB(180,40,40)}, 0.12) end)

-- Status Label
local StatusLbl = make("TextLabel", Main, {
    Size = UDim2.new(1, -30, 0, 20),
    Position = UDim2.fromOffset(15, 82),
    BackgroundTransparency = 1,
    Text = "⏹  Kein Song geladen",
    TextColor3 = TXT_SUB,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
})

local function SetStatus(txt, col)
    StatusLbl.Text = txt
    StatusLbl.TextColor3 = col or TXT_SUB
end

-- ============================================================
-- TAB SYSTEM
-- ============================================================
local TabBar = make("Frame", Main, {
    Size = UDim2.new(1, -24, 0, 34),
    Position = UDim2.fromOffset(12, 108),
    BackgroundColor3 = BG_MID,
    BorderSizePixel = 0,
})
corner(TabBar, 10)

local TABS = {"🎵 Player", "🔍 Suche", "📋 Playlist", "⭐ Presets"}
local TabBtns = {}
local ActiveTab = 1

local function MakeTabBtn(idx, lbl)
    local w = (420 - 24) / #TABS
    local btn = make("TextButton", TabBar, {
        Size = UDim2.fromOffset(w - 4, 26),
        Position = UDim2.fromOffset(2 + (idx-1)*w, 4),
        BackgroundColor3 = idx == 1 and ACCENT or BG_BTN,
        Text = lbl,
        TextColor3 = idx == 1 and TXT_MAIN or TXT_SUB,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        BorderSizePixel = 0,
    })
    corner(btn, 7)
    TabBtns[idx] = btn
    return btn
end

for i, lbl in ipairs(TABS) do MakeTabBtn(i, lbl) end

-- Content Area
local Content = make("Frame", Main, {
    Size = UDim2.new(1, -24, 1, -160),
    Position = UDim2.fromOffset(12, 148),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClipsDescendants = true,
})

-- ============================================================
-- HELPER: Button erstellen
-- ============================================================
local function MakeBtn(parent, text, yPos, w, accent)
    local col = accent or BG_BTN
    local btn = make("TextButton", parent, {
        Size = UDim2.fromOffset(w or 370, 34),
        Position = UDim2.fromOffset(0, yPos),
        BackgroundColor3 = col,
        Text = text,
        TextColor3 = TXT_MAIN,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        BorderSizePixel = 0,
    })
    corner(btn, 8)
    btn.MouseEnter:Connect(function()
        tw(btn, {BackgroundColor3=Color3.new(
            math.min(col.R+0.06,1), math.min(col.G+0.06,1), math.min(col.B+0.12,1)
        )}, 0.1)
    end)
    btn.MouseLeave:Connect(function() tw(btn, {BackgroundColor3=col}, 0.1) end)
    return btn
end

local function MakeInput(parent, placeholder, yPos, w)
    local bg = make("Frame", parent, {
        Size = UDim2.fromOffset(w or 370, 34),
        Position = UDim2.fromOffset(0, yPos),
        BackgroundColor3 = BG_BTN,
        BorderSizePixel = 0,
    })
    corner(bg, 8)
    local ist = stroke(bg, Color3.fromRGB(40,40,70), 1.5)
    local inp = make("TextBox", bg, {
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        PlaceholderText = placeholder,
        PlaceholderColor3 = Color3.fromRGB(70,70,100),
        Text = "",
        TextColor3 = TXT_MAIN,
        Font = Enum.Font.Code,
        TextSize = 14,
        ClearTextOnFocus = false,
    })
    inp.Focused:Connect(function() tw(ist,{Color=ACCENT,Thickness=2},0.15) end)
    inp.FocusLost:Connect(function() tw(ist,{Color=Color3.fromRGB(40,40,70),Thickness=1.5},0.15) end)
    return inp, bg
end

local function MakeSectionLabel(parent, text, yPos)
    return make("TextLabel", parent, {
        Size = UDim2.fromOffset(370, 18),
        Position = UDim2.fromOffset(0, yPos),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = ACCENT,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
end

-- ============================================================
-- TAB 1: PLAYER
-- ============================================================
local T1 = make("Frame", Content, {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, BorderSizePixel=0})

MakeSectionLabel(T1, "  SONG ID EINGEBEN", 0)
local IdInput, _ = MakeInput(T1, "Roblox Sound ID  z.B. 142930454", 22)

local PlayIdBtn = MakeBtn(T1, "▶  Song laden & spielen", 64, 370, ACCENT)
PlayIdBtn.MouseButton1Click:Connect(function()
    local id = IdInput.Text:gsub("[^%d]","")
    if id == "" then SetStatus("❌  Keine gültige ID!", Color3.fromRGB(220,80,80)); return end
    if PlayID(id) then
        SetStatus("▶  Spielt: ID " .. id, Color3.fromRGB(80,220,120))
        IdInput.Text = ""
    end
end)

MakeSectionLabel(T1, "  STEUERUNG", 108)
local PlayBtn  = MakeBtn(T1, "▶  Play",      130, 118, Color3.fromRGB(30,160,70))
local PauseBtn = MakeBtn(T1, "⏸  Pause",     130, 118, Color3.fromRGB(160,130,20))
local StopBtn  = MakeBtn(T1, "⏹  Stop",      130, 118, Color3.fromRGB(160,40,40))

PlayBtn.Position  = UDim2.fromOffset(0, 130)
PauseBtn.Position = UDim2.fromOffset(126, 130)
StopBtn.Position  = UDim2.fromOffset(252, 130)

PlayBtn.MouseButton1Click:Connect(function()
    local s = GetOrCreate()
    if s.SoundId == "" then SetStatus("❌  Erst ID eingeben!", Color3.fromRGB(220,80,80)); return end
    s:Play(); SetStatus("▶  Spielt!", Color3.fromRGB(80,220,120))
end)
PauseBtn.MouseButton1Click:Connect(function()
    local s = workspace:FindFirstChild("CeliMusicSound")
    if not s then return end
    if s.IsPlaying then s:Pause(); SetStatus("⏸  Pausiert.", TXT_SUB)
    else s:Resume(); SetStatus("▶  Weiter.", Color3.fromRGB(80,220,120)) end
end)
StopBtn.MouseButton1Click:Connect(function()
    StopMusic(); SetStatus("⏹  Gestoppt.", TXT_SUB)
end)

MakeSectionLabel(T1, "  LAUTSTÄRKE & PITCH", 178)
-- Volume Slider
local function MakeSlider(parent, yPos, minV, maxV, defV, labelFn)
    local sliderBG = make("Frame", parent, {
        Size = UDim2.fromOffset(370, 28),
        Position = UDim2.fromOffset(0, yPos),
        BackgroundColor3 = BG_BTN,
        BorderSizePixel = 0,
    })
    corner(sliderBG, 6)
    local fill = make("Frame", sliderBG, {
        Size = UDim2.fromScale((defV-minV)/(maxV-minV), 1),
        BackgroundColor3 = ACCENT,
        BorderSizePixel = 0,
    })
    corner(fill, 6)
    local lbl = make("TextLabel", sliderBG, {
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        Text = labelFn(defV),
        TextColor3 = TXT_MAIN,
        Font = Enum.Font.GothamBold,
        TextSize = 11,
    })
    local value = defV
    local dragging = false
    sliderBG.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    sliderBG.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = (inp.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X
            rel = math.clamp(rel, 0, 1)
            value = minV + rel*(maxV-minV)
            value = math.floor(value*20+0.5)/20
            fill.Size = UDim2.fromScale(rel, 1)
            lbl.Text = labelFn(value)
        end
    end)
    return sliderBG, function() return value end
end

local VolSlider, GetVol = MakeSlider(T1, 200, 0, 2, 0.7, function(v) return string.format("🔊  Lautstärke: %.0f%%", v*100) end)
local PitchSlider, GetPitch = MakeSlider(T1, 236, 0.1, 3, 1.0, function(v) return string.format("🎚  Pitch: %.2fx", v) end)

-- Update loop für Slider
task.spawn(function()
    while SGui and SGui.Parent do
        task.wait(0.1)
        local v = GetVol(); local p = GetPitch()
        if math.abs(v - MusicVolume) > 0.01 then
            MusicVolume = v
            local s = workspace:FindFirstChild("CeliMusicSound"); if s then s.Volume = v end
        end
        if math.abs(p - MusicPitch) > 0.01 then
            MusicPitch = p
            local s = workspace:FindFirstChild("CeliMusicSound"); if s then s.PlaybackSpeed = p end
        end
    end
end)

-- Loop Toggle
local LoopOn = true
local LoopBtn = MakeBtn(T1, "🔁  Loop: AN", 276, 370, Color3.fromRGB(30,100,50))
LoopBtn.MouseButton1Click:Connect(function()
    LoopOn = not LoopOn
    MusicLooped = LoopOn
    local s = workspace:FindFirstChild("CeliMusicSound"); if s then s.Looped = LoopOn end
    LoopBtn.Text = LoopOn and "🔁  Loop: AN" or "➡️  Loop: AUS"
    tw(LoopBtn, {BackgroundColor3 = LoopOn and Color3.fromRGB(30,100,50) or Color3.fromRGB(80,40,40)}, 0.15)
end)

-- Playlist Prev/Next
local PrevBtn = MakeBtn(T1, "⏮  Vorheriger", 320, 182, BG_BTN)
local NextBtn = MakeBtn(T1, "⏭  Nächster",  320, 182, BG_BTN)
PrevBtn.Position = UDim2.fromOffset(0, 320)
NextBtn.Position = UDim2.fromOffset(188, 320)

PrevBtn.MouseButton1Click:Connect(function()
    if #Playlist == 0 then SetStatus("❌  Playlist leer!", Color3.fromRGB(220,80,80)); return end
    PlaylistIdx = ((PlaylistIdx-2)%#Playlist)+1
    PlayID(Playlist[PlaylistIdx])
    SetStatus("⏮  Song "..PlaylistIdx.."/"..#Playlist.."  ID: "..Playlist[PlaylistIdx], Color3.fromRGB(80,220,120))
end)
NextBtn.MouseButton1Click:Connect(function()
    if #Playlist == 0 then SetStatus("❌  Playlist leer!", Color3.fromRGB(220,80,80)); return end
    PlaylistIdx = PlaylistIdx%#Playlist+1
    PlayID(Playlist[PlaylistIdx])
    SetStatus("⏭  Song "..PlaylistIdx.."/"..#Playlist.."  ID: "..Playlist[PlaylistIdx], Color3.fromRGB(80,220,120))
end)

-- ============================================================
-- TAB 2: SUCHE
-- ============================================================
local T2 = make("Frame", Content, {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, BorderSizePixel=0, Visible=false})

MakeSectionLabel(T2, "  NACH SONG-NAME SUCHEN", 0)
local SearchInput, _ = MakeInput(T2, "Song-Name eingeben...", 22)
local SearchBtn = MakeBtn(T2, "🔍  Suchen", 64, 370, ACCENT)

local SearchResultsFrame = make("Frame", T2, {
    Size = UDim2.fromOffset(370, 310),
    Position = UDim2.fromOffset(0, 106),
    BackgroundColor3 = BG_MID,
    BorderSizePixel = 0,
    ClipsDescendants = true,
})
corner(SearchResultsFrame, 10)
stroke(SearchResultsFrame, Color3.fromRGB(35,35,60))

local SearchStatusLbl = make("TextLabel", SearchResultsFrame, {
    Size = UDim2.fromScale(1,1),
    BackgroundTransparency = 1,
    Text = "Gib einen Song-Namen ein und drücke Suchen.\n\nEs wird nach passenden Roblox Sound IDs\nin der Preset-Liste gesucht.\n\nFür spezifische IDs → Tab 'Player' nutzen.",
    TextColor3 = TXT_SUB,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
})
make("UIPadding", SearchStatusLbl, {
    PaddingLeft = UDim.new(0,10), PaddingTop = UDim.new(0,10),
    PaddingRight = UDim.new(0,10)
})

-- Such-Datenbank
local SEARCH_DB = {
    -- Classics
    {"Electro Sp00k",         "142930454"},
    {"Wonga",                 "130768996"},
    {"Chop Suey",             "143666548"},
    {"Scream",                "26120219"},
    {"Never Gonna Give You Up","130860862"},
    {"Megalovania",           "585015180"},
    {"Among Drip",            "6823767794"},
    {"Troll Song",            "144455674"},
    {"Astronomia Coffin Dance","1836306189"},
    {"Coffin Dance",          "5904610425"},
    {"Bad Apple",             "240701787"},
    {"Gangnam Style",         "153759260"},
    {"Thomas The Tank Engine", "1081367"},
    {"Darude Sandstorm",      "144435136"},
    {"Final Countdown",       "144555866"},
    {"Eye of the Tiger",      "189315105"},
    {"Tetris Theme",          "1845687358"},
    {"Imperial March",        "228690171"},
    {"Mario Theme",           "139361285"},
    {"Minecraft Sweden",      "1843290484"},
    {"Nyan Cat",              "144465498"},
    {"Dramatic Chipmunk",     "26120258"},
    {"All Star Smash Mouth",  "148979031"},
    {"We Are Number One",     "573536888"},
    {"Bohemian Rhapsody",     "149318136"},
    {"7 Nation Army",         "188503890"},
    {"Take On Me",            "144974098"},
    {"Toxic Britney",         "149327507"},
    {"Careless Whisper",      "145804016"},
    {"Wonderwall",            "148982869"},
}

local SearchResultBtns = {}

local function DoSearch(query)
    -- Alte Ergebnisse entfernen
    for _, btn in ipairs(SearchResultBtns) do pcall(function() btn:Destroy() end) end
    SearchResultBtns = {}
    SearchStatusLbl.Visible = false

    query = query:lower():gsub("%s+", " "):match("^%s*(.-)%s*$")
    if query == "" then
        SearchStatusLbl.Visible = true
        SearchStatusLbl.Text = "❌  Bitte einen Suchbegriff eingeben!"
        return
    end

    local results = {}
    for _, entry in ipairs(SEARCH_DB) do
        local name, id = entry[1], entry[2]
        if name:lower():find(query, 1, true) then
            table.insert(results, {name=name, id=id})
        end
    end

    if #results == 0 then
        SearchStatusLbl.Visible = true
        SearchStatusLbl.Text = "🔍  Keine Ergebnisse für:\n\"" .. query .. "\"\n\nTipp: Probiere kürzere Begriffe.\nOder gib die ID direkt im Player-Tab ein."
        return
    end

    local yOff = 8
    for _, res in ipairs(results) do
        local row = make("Frame", SearchResultsFrame, {
            Size = UDim2.fromOffset(350, 42),
            Position = UDim2.fromOffset(10, yOff),
            BackgroundColor3 = BG_BTN,
            BorderSizePixel = 0,
        })
        corner(row, 8)
        make("TextLabel", row, {
            Size = UDim2.fromOffset(240, 20),
            Position = UDim2.fromOffset(10, 3),
            BackgroundTransparency = 1,
            Text = res.name,
            TextColor3 = TXT_MAIN,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        make("TextLabel", row, {
            Size = UDim2.fromOffset(240, 16),
            Position = UDim2.fromOffset(10, 23),
            BackgroundTransparency = 1,
            Text = "ID: " .. res.id,
            TextColor3 = TXT_SUB,
            Font = Enum.Font.Code,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        local playRowBtn = make("TextButton", row, {
            Size = UDim2.fromOffset(90, 32),
            Position = UDim2.fromOffset(252, 5),
            BackgroundColor3 = ACCENT,
            Text = "▶ Spielen",
            TextColor3 = TXT_MAIN,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            BorderSizePixel = 0,
        })
        corner(playRowBtn, 7)
        local capturedId, capturedName = res.id, res.name
        playRowBtn.MouseButton1Click:Connect(function()
            PlayID(capturedId)
            SetStatus("▶  " .. capturedName .. "  (ID: " .. capturedId .. ")", Color3.fromRGB(80,220,120))
        end)
        playRowBtn.MouseEnter:Connect(function() tw(playRowBtn,{BackgroundColor3=ACCENT2},0.1) end)
        playRowBtn.MouseLeave:Connect(function() tw(playRowBtn,{BackgroundColor3=ACCENT},0.1) end)
        table.insert(SearchResultBtns, row)
        yOff = yOff + 50
    end

    -- Scrollbar (simulated via CanvasSize)
    SearchResultsFrame.CanvasSize = UDim2.fromOffset(0, yOff + 8)
end

SearchBtn.MouseButton1Click:Connect(function() DoSearch(SearchInput.Text) end)
SearchInput.FocusLost:Connect(function(ep) if ep then DoSearch(SearchInput.Text) end end)

-- ScrollingFrame upgrade
local SF = make("ScrollingFrame", T2, {
    Size = UDim2.fromOffset(370, 310),
    Position = UDim2.fromOffset(0, 106),
    BackgroundColor3 = BG_MID,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = ACCENT,
    CanvasSize = UDim2.fromOffset(0, 0),
    ClipsDescendants = true,
})
corner(SF, 10)
SearchResultsFrame:Destroy()
SearchResultsFrame = SF
SearchStatusLbl = make("TextLabel", SF, {
    Size = UDim2.fromOffset(350, 200),
    Position = UDim2.fromOffset(10, 10),
    BackgroundTransparency = 1,
    Text = "Gib einen Song-Namen ein und drücke Suchen.\n\nAuch Teile des Namens funktionieren:\nz.B. 'electro', 'thomas', 'mario'\n\nFür spezifische IDs → Tab 'Player' nutzen.",
    TextColor3 = TXT_SUB,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
})

-- DoSearch neu definieren mit ScrollingFrame
local function DoSearchReal(query)
    for _, btn in ipairs(SearchResultBtns) do pcall(function() btn:Destroy() end) end
    SearchResultBtns = {}
    SearchStatusLbl.Visible = false

    query = (query or ""):lower():gsub("%s+", " "):match("^%s*(.-)%s*$")
    if query == "" then
        SearchStatusLbl.Visible = true
        SearchStatusLbl.Text = "❌  Bitte einen Suchbegriff eingeben!"
        SF.CanvasSize = UDim2.fromOffset(0, 0)
        return
    end

    local results = {}
    for _, entry in ipairs(SEARCH_DB) do
        if entry[1]:lower():find(query, 1, true) then
            table.insert(results, {name=entry[1], id=entry[2]})
        end
    end

    if #results == 0 then
        SearchStatusLbl.Visible = true
        SearchStatusLbl.Text = '🔍  Keine Ergebnisse für "'..query..'".\n\nTipp: Kürzere Begriffe probieren\noder ID direkt im Player-Tab eingeben.'
        SF.CanvasSize = UDim2.fromOffset(0, 0)
        return
    end

    local yOff = 8
    for _, res in ipairs(results) do
        local row = make("Frame", SF, {
            Size = UDim2.fromOffset(352, 42),
            Position = UDim2.fromOffset(5, yOff),
            BackgroundColor3 = BG_BTN,
            BorderSizePixel = 0,
        })
        corner(row, 8)
        make("TextLabel", row, {
            Size = UDim2.fromOffset(242, 20),
            Position = UDim2.fromOffset(8, 3),
            BackgroundTransparency = 1,
            Text = res.name,
            TextColor3 = TXT_MAIN,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        make("TextLabel", row, {
            Size = UDim2.fromOffset(242, 16),
            Position = UDim2.fromOffset(8, 23),
            BackgroundTransparency = 1,
            Text = "ID: "..res.id,
            TextColor3 = TXT_SUB,
            Font = Enum.Font.Code,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        local pb = make("TextButton", row, {
            Size = UDim2.fromOffset(88, 32),
            Position = UDim2.fromOffset(256, 5),
            BackgroundColor3 = ACCENT,
            Text = "▶ Spielen",
            TextColor3 = TXT_MAIN,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            BorderSizePixel = 0,
        })
        corner(pb, 7)
        local cId, cName = res.id, res.name
        pb.MouseButton1Click:Connect(function()
            PlayID(cId)
            SetStatus("▶  "..cName.."  (ID: "..cId..")", Color3.fromRGB(80,220,120))
        end)
        pb.MouseEnter:Connect(function() tw(pb,{BackgroundColor3=ACCENT2},0.1) end)
        pb.MouseLeave:Connect(function() tw(pb,{BackgroundColor3=ACCENT},0.1) end)
        table.insert(SearchResultBtns, row)
        yOff = yOff + 50
    end
    SF.CanvasSize = UDim2.fromOffset(0, yOff + 8)
end

SearchBtn.MouseButton1Click:Connect(function() DoSearchReal(SearchInput.Text) end)
SearchInput.FocusLost:Connect(function(ep) if ep then DoSearchReal(SearchInput.Text) end end)

-- ============================================================
-- TAB 3: PLAYLIST
-- ============================================================
local T3 = make("Frame", Content, {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, BorderSizePixel=0, Visible=false})

MakeSectionLabel(T3, "  SONG ZUR PLAYLIST HINZUFÜGEN", 0)
local PLInput, _ = MakeInput(T3, "Sound ID eingeben...", 22)
local PLAddBtn = MakeBtn(T3, "➕  Hinzufügen", 64, 370, Color3.fromRGB(30,120,60))
PLAddBtn.MouseButton1Click:Connect(function()
    local id = PLInput.Text:gsub("[^%d]","")
    if id == "" then return end
    table.insert(Playlist, id)
    PLInput.Text = ""
    SetStatus("➕  Song "..#Playlist.." hinzugefügt: ID "..id, Color3.fromRGB(80,220,120))
end)

MakeSectionLabel(T3, "  PLAYLIST AKTIONEN", 108)
local PLStartBtn  = MakeBtn(T3, "▶  Von vorne starten", 128, 370, Color3.fromRGB(30,120,60))
local PLShuffleBtn= MakeBtn(T3, "🔀  Zufälligen Song",  170, 180, BG_BTN)
local PLRemoveBtn = MakeBtn(T3, "🗑  Letzten entfernen",170, 184, Color3.fromRGB(100,30,30))
PLShuffleBtn.Position = UDim2.fromOffset(0, 170)
PLRemoveBtn.Position  = UDim2.fromOffset(186, 170)
local PLClearBtn  = MakeBtn(T3, "🗑  Playlist leeren", 212, 370, Color3.fromRGB(120,30,30))

PLStartBtn.MouseButton1Click:Connect(function()
    if #Playlist==0 then SetStatus("❌  Playlist leer!", Color3.fromRGB(220,80,80)); return end
    PlaylistIdx=1; PlayID(Playlist[1])
    SetStatus("▶  Playlist gestartet: Song 1/"..#Playlist, Color3.fromRGB(80,220,120))
end)
PLShuffleBtn.MouseButton1Click:Connect(function()
    if #Playlist==0 then SetStatus("❌  Leer!", Color3.fromRGB(220,80,80)); return end
    PlaylistIdx=math.random(1,#Playlist); PlayID(Playlist[PlaylistIdx])
    SetStatus("🔀  Song "..PlaylistIdx.."/"..#Playlist, Color3.fromRGB(80,220,120))
end)
PLRemoveBtn.MouseButton1Click:Connect(function()
    if #Playlist==0 then return end
    local rem=table.remove(Playlist)
    if PlaylistIdx>#Playlist then PlaylistIdx=math.max(1,#Playlist) end
    SetStatus("🗑  Entfernt: "..rem.."  Noch: "..#Playlist, TXT_SUB)
end)
PLClearBtn.MouseButton1Click:Connect(function()
    Playlist={}; PlaylistIdx=1; SetStatus("🗑  Playlist geleert.", TXT_SUB)
end)

-- Playlist anzeigen (ScrollingFrame)
MakeSectionLabel(T3, "  AKTUELLE PLAYLIST", 256)
local PLListFrame = make("ScrollingFrame", T3, {
    Size = UDim2.fromOffset(370, 140),
    Position = UDim2.fromOffset(0, 276),
    BackgroundColor3 = BG_MID,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = ACCENT,
    CanvasSize = UDim2.fromOffset(0, 0),
})
corner(PLListFrame, 8)

local PLEmptyLbl = make("TextLabel", PLListFrame, {
    Size = UDim2.fromOffset(350, 80),
    Position = UDim2.fromOffset(10,10),
    BackgroundTransparency=1,
    Text="Playlist ist leer.\nFüge Songs mit der ID oben hinzu.",
    TextColor3=TXT_SUB, Font=Enum.Font.Gotham, TextSize=12, TextWrapped=true,
    TextYAlignment=Enum.TextYAlignment.Top,
})

local PLItems = {}
local function RefreshPLList()
    for _, o in ipairs(PLItems) do pcall(function() o:Destroy() end) end
    PLItems = {}
    PLEmptyLbl.Visible = #Playlist == 0
    local yy = 6
    for i, id in ipairs(Playlist) do
        local row = make("Frame", PLListFrame, {
            Size=UDim2.fromOffset(352,26), Position=UDim2.fromOffset(5,yy),
            BackgroundColor3=BG_BTN, BorderSizePixel=0,
        })
        corner(row,6)
        local marker = i==PlaylistIdx and "▶ " or "   "
        make("TextLabel",row,{
            Size=UDim2.fromOffset(300,26), Position=UDim2.fromOffset(6,0),
            BackgroundTransparency=1, Text=marker..i..".  "..id,
            TextColor3=i==PlaylistIdx and ACCENT or TXT_MAIN,
            Font=Enum.Font.Code, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left,
        })
        table.insert(PLItems, row)
        yy = yy+30
    end
    PLListFrame.CanvasSize = UDim2.fromOffset(0, yy+6)
end

-- Auto-refresh Playlist Anzeige
task.spawn(function()
    while SGui and SGui.Parent do
        task.wait(0.5)
        if T3.Visible then RefreshPLList() end
    end
end)

-- ============================================================
-- TAB 4: PRESETS
-- ============================================================
local T4 = make("Frame", Content, {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, BorderSizePixel=0, Visible=false})
local T4SF = make("ScrollingFrame", T4, {
    Size = UDim2.fromScale(1,1),
    BackgroundTransparency=1, BorderSizePixel=0,
    ScrollBarThickness=4, ScrollBarImageColor3=ACCENT,
    CanvasSize=UDim2.fromOffset(0,0),
})

local PRESETS = {
    {"🎵 Electro Sp00k",       "142930454"},
    {"🎵 Wonga",                "130768996"},
    {"🎵 Chop Suey",            "143666548"},
    {"😱 Scream",               "26120219"},
    {"🎵 Never Gonna Give You", "130860862"},
    {"🎵 Megalovania",          "585015180"},
    {"🎵 Among Drip",           "6823767794"},
    {"🎵 Troll Song",           "144455674"},
    {"🎵 Astronomia",           "1836306189"},
    {"🎵 Coffin Dance",         "5904610425"},
    {"🎵 Bad Apple",            "240701787"},
    {"🎵 Gangnam Style",        "153759260"},
    {"🎵 Thomas Theme",         "1081367"},
    {"🎵 Darude Sandstorm",     "144435136"},
    {"🎵 Final Countdown",      "144555866"},
    {"🎵 Eye of the Tiger",     "189315105"},
    {"🎵 Tetris",               "1845687358"},
    {"🎵 Imperial March",       "228690171"},
    {"🎵 Mario Theme",          "139361285"},
    {"🎵 Minecraft Sweden",     "1843290484"},
    {"🎵 Nyan Cat",             "144465498"},
    {"🎵 All Star",             "148979031"},
    {"🎵 We Are Number One",    "573536888"},
    {"🎵 Bohemian Rhapsody",    "149318136"},
    {"🎵 7 Nation Army",        "188503890"},
}

local yOff4 = 4
for _, m in ipairs(PRESETS) do
    local lbl, id = m[1], m[2]
    local row = make("Frame", T4SF, {
        Size=UDim2.fromOffset(370,38), Position=UDim2.fromOffset(0,yOff4),
        BackgroundColor3=BG_BTN, BorderSizePixel=0,
    })
    corner(row,8)
    make("TextLabel", row, {
        Size=UDim2.fromOffset(240,38), Position=UDim2.fromOffset(8,0),
        BackgroundTransparency=1, Text=lbl,
        TextColor3=TXT_MAIN, Font=Enum.Font.GothamBold, TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Left,
    })
    local playB = make("TextButton", row, {
        Size=UDim2.fromOffset(58,28), Position=UDim2.fromOffset(248,5),
        BackgroundColor3=ACCENT, Text="▶", TextColor3=TXT_MAIN,
        Font=Enum.Font.GothamBold, TextSize=14, BorderSizePixel=0,
    })
    corner(playB,7)
    local addB = make("TextButton", row, {
        Size=UDim2.fromOffset(58,28), Position=UDim2.fromOffset(310,5),
        BackgroundColor3=Color3.fromRGB(30,100,60), Text="➕", TextColor3=TXT_MAIN,
        Font=Enum.Font.GothamBold, TextSize=14, BorderSizePixel=0,
    })
    corner(addB,7)
    local cId,cName = id,lbl
    playB.MouseButton1Click:Connect(function()
        PlayID(cId); SetStatus("▶  "..cName, Color3.fromRGB(80,220,120))
    end)
    addB.MouseButton1Click:Connect(function()
        table.insert(Playlist,cId); SetStatus("➕  "..cName.." in Playlist ("..#Playlist..")", Color3.fromRGB(80,220,120))
    end)
    playB.MouseEnter:Connect(function() tw(playB,{BackgroundColor3=ACCENT2},0.1) end)
    playB.MouseLeave:Connect(function() tw(playB,{BackgroundColor3=ACCENT},0.1) end)
    yOff4 = yOff4 + 44
end
T4SF.CanvasSize = UDim2.fromOffset(0, yOff4+8)

-- ============================================================
-- TAB SWITCHING
-- ============================================================
local Tabs = {T1, T2, T3, T4}
local function SwitchTab(idx)
    for i, t in ipairs(Tabs) do t.Visible = (i == idx) end
    for i, btn in ipairs(TabBtns) do
        tw(btn, {
            BackgroundColor3 = i==idx and ACCENT or BG_BTN,
            TextColor3 = i==idx and TXT_MAIN or TXT_SUB,
        }, 0.15)
    end
    ActiveTab = idx
end

for i, btn in ipairs(TabBtns) do
    btn.MouseButton1Click:Connect(function() SwitchTab(i) end)
end

-- ============================================================
-- STATUS UPDATE LOOP
-- ============================================================
task.spawn(function()
    while SGui and SGui.Parent do
        task.wait(0.5)
        local s = workspace:FindFirstChild("CeliMusicSound")
        if s and s.IsPlaying then
            local id = s.SoundId:gsub("rbxassetid://","")
            -- find name in PRESETS
            local name = "ID "..id
            for _, p in ipairs(PRESETS) do if p[2]==id then name=p[1]; break end end
            StatusLbl.Text = "▶  Spielt: "..name
            StatusLbl.TextColor3 = Color3.fromRGB(80,220,120)
        elseif s and s.IsPaused then
            StatusLbl.TextColor3 = TXT_SUB
        end
    end
end)

-- Einblenden
Main.BackgroundTransparency = 1
tw(Main, {BackgroundTransparency=0}, 0.4, Enum.EasingStyle.Quart)
