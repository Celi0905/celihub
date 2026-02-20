-- Celi Music Player 🎵
-- Made by Celi 💫
-- Standalone Script — läuft in jedem Spiel

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player           = Players.LocalPlayer

-- ============================================================
-- Rayfield laden mit Retry
-- ============================================================
local Rayfield
for attempt = 1, 3 do
    local ok, result = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
    end)
    if ok and result then Rayfield = result; break end
    task.wait(1.5)
end
if not Rayfield then warn("[Celi Music] Rayfield nicht ladbar!"); return end

-- ============================================================
-- State
-- ============================================================
local MusicVolume  = 0.7
local MusicPitch   = 1.0
local MusicLooped  = true
local Playlist     = {}
local PlaylistIdx  = 1
local CurrentID    = ""

local function GetOrCreate()
    local s = workspace:FindFirstChild("CeliMusicPlayer")
    if s and s:IsA("Sound") then return s end
    local ns = Instance.new("Sound", workspace)
    ns.Name       = "CeliMusicPlayer"
    ns.Volume     = MusicVolume
    ns.PlaybackSpeed = MusicPitch
    ns.Looped     = MusicLooped
    return ns
end

local function PlayID(id)
    id = tostring(id):gsub("%D","")
    if id == "" then return end
    CurrentID = id
    local s = GetOrCreate()
    s.SoundId        = "rbxassetid://" .. id
    s.Volume         = MusicVolume
    s.PlaybackSpeed  = MusicPitch
    s.Looped         = MusicLooped
    s:Play()
end

-- ============================================================
-- Window
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "🎵  Celi Music Player",
    LoadingTitle    = "Celi Music Player",
    LoadingSubtitle = "by Celi 💫  •  Standalone",
    ConfigurationSaving = { Enabled = true, FolderName = "CeliMusicPlayer" },
    KeySystem       = false,
})

local function N(t, c, d)
    pcall(function() Rayfield:Notify({ Title=tostring(t), Content=tostring(c), Duration=d or 3 }) end)
end

-- ============================================================
-- Tabs
-- ============================================================
local TabPlayer   = Window:CreateTab("🎵 Player",    4483362458)
local TabPlaylist = Window:CreateTab("📋 Playlist",  4483362458)
local TabPresets  = Window:CreateTab("⭐ Presets",   4483362458)
local TabSettings = Window:CreateTab("⚙️ Settings",  4483362458)

-- ============================================================
-- PLAYER TAB
-- ============================================================
TabPlayer:CreateSection("🎵 Song laden")
TabPlayer:CreateInput({
    Name = "🔢 Sound ID eingeben",
    PlaceholderText = "z.B. 142930454",
    RemoveTextAfterFocusLost = false,
    Callback = function(v)
        local id = v:gsub("%D","")
        if id == "" then N("❌","Ungültige ID!",3); return end
        PlayID(id)
        N("🎵 Celi Music","Spielt ID: " .. id, 4)
    end
})

TabPlayer:CreateSection("⏯️ Steuerung")
TabPlayer:CreateButton({ Name = "▶️  Play", Callback = function()
    local s = GetOrCreate()
    if s.SoundId == "" then N("❌","Zuerst eine ID eingeben!",3); return end
    s:Play(); N("▶️ Play","Musik spielt!",2)
end})
TabPlayer:CreateButton({ Name = "⏸️  Pause / Resume", Callback = function()
    local s = workspace:FindFirstChild("CeliMusicPlayer")
    if not s then N("❌","Kein Song geladen!",3); return end
    if s.IsPlaying then s:Pause(); N("⏸️ Pause","Pausiert.",2)
    else s:Resume(); N("▶️ Resume","Weiter.",2) end
end})
TabPlayer:CreateButton({ Name = "⏹️  Stop", Callback = function()
    local s = workspace:FindFirstChild("CeliMusicPlayer")
    if s then s:Stop(); s:Destroy() end
    N("⏹️ Stop","Gestoppt & entfernt.",2)
end})
TabPlayer:CreateButton({ Name = "🔀  Zufällig aus Playlist", Callback = function()
    if #Playlist == 0 then N("❌","Playlist leer!",3); return end
    local idx = math.random(1, #Playlist)
    PlaylistIdx = idx
    PlayID(Playlist[idx])
    N("🔀 Zufall","Song " .. idx .. "/" .. #Playlist .. "  •  ID " .. Playlist[idx], 4)
end})
TabPlayer:CreateButton({ Name = "⏮️  Vorheriger (Playlist)", Callback = function()
    if #Playlist == 0 then N("❌","Playlist leer!",3); return end
    PlaylistIdx = ((PlaylistIdx - 2) % #Playlist) + 1
    PlayID(Playlist[PlaylistIdx])
    N("⏮️ Zurück","Song " .. PlaylistIdx .. "/" .. #Playlist .. "  •  ID " .. Playlist[PlaylistIdx], 4)
end})
TabPlayer:CreateButton({ Name = "⏭️  Nächster (Playlist)", Callback = function()
    if #Playlist == 0 then N("❌","Playlist leer!",3); return end
    PlaylistIdx = PlaylistIdx % #Playlist + 1
    PlayID(Playlist[PlaylistIdx])
    N("⏭️ Weiter","Song " .. PlaylistIdx .. "/" .. #Playlist .. "  •  ID " .. Playlist[PlaylistIdx], 4)
end})

TabPlayer:CreateSection("ℹ️ Info")
TabPlayer:CreateButton({ Name = "📊 Aktuellen Song anzeigen", Callback = function()
    local s = workspace:FindFirstChild("CeliMusicPlayer")
    if s and s.SoundId ~= "" then
        local id = s.SoundId:gsub("rbxassetid://","")
        local status = s.IsPlaying and "▶️ Spielt" or (s.IsPaused and "⏸️ Pausiert" or "⏹️ Gestoppt")
        N("🎵 Aktuell","ID: " .. id .. "\n" .. status .. "\nVol: " .. math.floor(MusicVolume*100) .. "%  Pitch: " .. MusicPitch, 6)
    else
        N("ℹ️","Kein Song geladen.",3)
    end
end})

-- ============================================================
-- PLAYLIST TAB
-- ============================================================
TabPlaylist:CreateSection("➕ Song hinzufügen")
TabPlaylist:CreateInput({
    Name = "➕ Sound ID zur Playlist",
    PlaceholderText = "Sound ID...",
    RemoveTextAfterFocusLost = true,
    Callback = function(v)
        local id = v:gsub("%D","")
        if id == "" then return end
        table.insert(Playlist, id)
        N("➕ Playlist","Song " .. #Playlist .. " hinzugefügt!\nID: " .. id, 3)
    end
})

TabPlaylist:CreateSection("📋 Verwaltung")
TabPlaylist:CreateButton({ Name = "📋 Playlist anzeigen", Callback = function()
    if #Playlist == 0 then N("📋","Playlist ist leer!",3); return end
    local txt = ""
    for i, id in ipairs(Playlist) do
        txt = txt .. (i == PlaylistIdx and "▶ " or "   ") .. i .. ".  " .. id .. "\n"
    end
    N("📋 Playlist  (" .. #Playlist .. " Songs)", txt:sub(1,220), 7)
end})
TabPlaylist:CreateButton({ Name = "▶️ Playlist starten (von vorne)", Callback = function()
    if #Playlist == 0 then N("❌","Playlist leer!",3); return end
    PlaylistIdx = 1; PlayID(Playlist[1])
    N("▶️ Playlist","Startet Song 1/" .. #Playlist,4)
end})
TabPlaylist:CreateButton({ Name = "🗑️ Letzten Song entfernen", Callback = function()
    if #Playlist == 0 then N("❌","Playlist leer!",3); return end
    local removed = table.remove(Playlist)
    if PlaylistIdx > #Playlist then PlaylistIdx = math.max(1, #Playlist) end
    N("🗑️ Entfernt","ID " .. removed .. " entfernt.\nNoch " .. #Playlist .. " Songs.",3)
end})
TabPlaylist:CreateButton({ Name = "🗑️ Playlist komplett leeren", Callback = function()
    Playlist = {}; PlaylistIdx = 1
    N("🗑️","Playlist geleert!",2)
end})

-- ============================================================
-- PRESETS TAB
-- ============================================================
local PRESETS = {
    { "🎵 Electro Sp00k",    "142930454"  },
    { "🎵 Wonga",            "130768996"  },
    { "🎵 Chop Suey",        "143666548"  },
    { "😱 Scream",           "26120219"   },
    { "🎵 Never Gonna Give", "130860862"  },
    { "🎵 Megalovania",      "585015180"  },
    { "🎵 Among Drip",       "6823767794" },
    { "🎵 Troll Song",       "144455674"  },
    { "🎵 Astronomia",       "1836306189" },
    { "🎵 Coffin Dance",     "5904610425" },
    { "🎵 Bad Apple",        "240701787"  },
    { "🎵 Gangnam Style",    "153759260"  },
    { "🎵 Thomas Theme",     "1081367"    },
    { "🎵 Darude Sandstorm", "144435136"  },
    { "🎵 Final Countdown",  "144555866"  },
    { "🎵 Eye of the Tiger", "189315105"  },
}

TabPresets:CreateSection("⭐ Preset Songs  —  Klicken zum Spielen")
for _, m in ipairs(PRESETS) do
    local lbl, id = m[1], m[2]
    TabPresets:CreateButton({ Name = lbl, Callback = function()
        PlayID(id)
        N("🎵 Celi Music", lbl .. " spielt!", 4)
    end})
end

TabPresets:CreateSection("➕ Zu Playlist hinzufügen")
for _, m in ipairs(PRESETS) do
    local lbl, id = m[1], m[2]
    TabPresets:CreateButton({ Name = "➕ " .. lbl, Callback = function()
        table.insert(Playlist, id)
        N("➕ Playlist", lbl .. " hinzugefügt!\nSong " .. #Playlist, 3)
    end})
end

-- ============================================================
-- SETTINGS TAB
-- ============================================================
TabSettings:CreateSection("🔊 Audio Einstellungen")
TabSettings:CreateSlider({
    Name = "🔊 Lautstärke",
    Range = {0, 2}, Increment = 0.05, CurrentValue = 0.7,
    Callback = function(v)
        MusicVolume = v
        local s = workspace:FindFirstChild("CeliMusicPlayer")
        if s then s.Volume = v end
    end
})
TabSettings:CreateSlider({
    Name = "🎚️ Pitch / Geschwindigkeit",
    Range = {0.1, 3}, Increment = 0.05, CurrentValue = 1.0,
    Callback = function(v)
        MusicPitch = v
        local s = workspace:FindFirstChild("CeliMusicPlayer")
        if s then s.PlaybackSpeed = v end
    end
})
TabSettings:CreateToggle({
    Name = "🔁 Loop",
    CurrentValue = true,
    Callback = function(v)
        MusicLooped = v
        local s = workspace:FindFirstChild("CeliMusicPlayer")
        if s then s.Looped = v end
        N("🔁 Loop", v and "AN — Song wiederholt sich" or "AUS — einmalig", 2)
    end
})

TabSettings:CreateSection("⚙️ Sonstiges")
TabSettings:CreateButton({ Name = "🔄 Einstellungen auf Song anwenden", Callback = function()
    local s = workspace:FindFirstChild("CeliMusicPlayer")
    if s then s.Volume=MusicVolume; s.PlaybackSpeed=MusicPitch; s.Looped=MusicLooped end
    N("🔄","Einstellungen angewendet!",3)
end})
TabSettings:CreateButton({ Name = "🗑️ Alles stoppen & aufräumen", Callback = function()
    local s = workspace:FindFirstChild("CeliMusicPlayer"); if s then s:Stop(); s:Destroy() end
    Playlist={}; PlaylistIdx=1; CurrentID=""
    N("🗑️","Alles gestoppt & geleert.",3)
end})
TabSettings:CreateParagraph({
    Title  = "⌨️ Über Celi Music Player",
    Content = "Version: 1.0  •  Made by Celi 💫\n\nFeatures:\n• ID-Eingabe & sofort spielen\n• Play / Pause / Stop / Resume\n• Playlist (hinzufügen, entfernen, zufällig)\n• 16 Preset Songs\n• Lautstärke & Pitch Slider\n• Loop Toggle"
})

N("🎵 Celi Music Player","Bereit! ID eingeben oder Preset wählen 🎶", 5)
