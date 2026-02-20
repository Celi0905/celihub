-- ============================================================
-- CeliHub | c00lgui Edition 🟠
-- Made by Celi 💫
-- Original Script: c00lgui Reborn — komplett umgebaut & rebranded
-- ============================================================

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Players  = game:GetService("Players")
local Player   = Players.LocalPlayer

-- Farben (Orange Theme)
local ORANGE     = Color3.fromRGB(255, 140, 0)
local DARK_BG    = Color3.fromRGB(12, 12, 20)
local ELEMENT_BG = Color3.fromRGB(22, 22, 34)

-- Einstellungen (werden von Settings Seite gelesen)
local Settings_SkyboxID   = "158118263"
local Settings_PlaceID    = "149559312"
local Settings_MusicID    = "142930454"
local Settings_MusicPitch = 1
local Settings_BillboardText = "CeliHub"
local Settings_WalkspeedAmount = 16
local Settings_AntiRobloxianRange = 20
local Settings_ChatSpamText = ""
local Settings_LeaderstatName = ""
local Settings_LeaderstatAmount = 0
local Settings_NameBox = ""
local Settings_BillboardColor = {255, 140, 0}

local GodModeOn = false
local InvisOn   = false
local DiscoChar = false
local HeadShakeOn = false
local MeshDiscoOn = false
local DiscoFogOn  = false

-- ============================================================
-- WINDOW
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "CeliHub 🟠",
    LoadingTitle    = "CeliHub",
    LoadingSubtitle = "Made by Celi 💫",
    ConfigurationSaving = {Enabled = true, FolderName = "CeliHub_c00lgui"}
})

local function Notify(t, c, d) Rayfield:Notify({Title=t, Content=tostring(c), Duration=d or 3}) end

-- ============================================================
-- TABS
-- ============================================================
local SettingsTab      = Window:CreateTab("⚙️ Settings",    4483362458)
local PlayerTab        = Window:CreateTab("🧍 Player",       4483362458)
local WeaponsTab       = Window:CreateTab("⚔️ Weapons",      4483362458)
local ServerTab        = Window:CreateTab("💥 Server",       4483362458)
local AdminGuisTab     = Window:CreateTab("🛡️ Admin GUIs",   4483362458)
local SkyboxMusicTab   = Window:CreateTab("🎵 Skybox/Music", 4483362458)
local MiscTab          = Window:CreateTab("🔧 Misc",         4483362458)

-- ============================================================
-- SETTINGS TAB
-- ============================================================
SettingsTab:CreateSection("🆔 IDs & Werte")

SettingsTab:CreateInput({
    Name = "🌌 Skybox / Decal ID",
    PlaceholderText = "158118263",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v~="" then Settings_SkyboxID=v end end
})

SettingsTab:CreateInput({
    Name = "🎮 Place ID",
    PlaceholderText = "149559312",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v~="" then Settings_PlaceID=v end end
})

SettingsTab:CreateInput({
    Name = "🎵 Music ID",
    PlaceholderText = "142930454",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v~="" then Settings_MusicID=v end end
})

SettingsTab:CreateSlider({
    Name = "🎵 Music Pitch",
    Range = {0, 3}, Increment = 0.1, CurrentValue = 1,
    Callback = function(v) Settings_MusicPitch=v end
})

SettingsTab:CreateSection("💬 Billboard & Name")

SettingsTab:CreateInput({
    Name = "💬 Billboard GUI Text",
    PlaceholderText = "CeliHub",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v~="" then Settings_BillboardText=v end end
})

SettingsTab:CreateInput({
    Name = "📛 Name Box",
    PlaceholderText = "Dein Name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) Settings_NameBox=v end
})

SettingsTab:CreateSection("⚡ Speed & Anti")

SettingsTab:CreateSlider({
    Name = "🏃 Walkspeed Amount",
    Range = {1, 200}, Increment = 1, CurrentValue = 16,
    Callback = function(v) Settings_WalkspeedAmount=v end
})

SettingsTab:CreateSlider({
    Name = "🛡️ Anti-Robloxian Range",
    Range = {1, 100}, Increment = 1, CurrentValue = 20,
    Callback = function(v) Settings_AntiRobloxianRange=v end
})

SettingsTab:CreateSection("💬 Chat Spam")

SettingsTab:CreateInput({
    Name = "💬 Chat Spam Text",
    PlaceholderText = "Spam text...",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) Settings_ChatSpamText=v end
})

SettingsTab:CreateSection("📊 Leaderstat")

SettingsTab:CreateInput({
    Name = "📊 Leaderstat Name",
    PlaceholderText = "Cash",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) Settings_LeaderstatName=v end
})

SettingsTab:CreateInput({
    Name = "📊 Leaderstat Amount",
    PlaceholderText = "1000",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) Settings_LeaderstatAmount=tonumber(v) or 0 end
})

-- ============================================================
-- PLAYER TAB
-- ============================================================
PlayerTab:CreateSection("🧍 LocalPlayer")

PlayerTab:CreateToggle({
    Name = "🛡️ God Mode",
    CurrentValue = false,
    Callback = function(v)
        GodModeOn = v
        if v then
            task.spawn(function()
                while GodModeOn do
                    pcall(function()
                        Player.Character.Humanoid.Health = Player.Character.Humanoid.MaxHealth
                    end)
                    task.wait(0.1)
                end
            end)
            Notify("🛡️ God Mode","Aktiviert!",3)
        else
            Notify("🛡️ God Mode","Deaktiviert.",2)
        end
    end
})

PlayerTab:CreateToggle({
    Name = "👻 Invisibility",
    CurrentValue = false,
    Callback = function(v)
        InvisOn = v
        pcall(function()
            local char = Player.Character
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = v and 1 or 0
                end
            end
        end)
        Notify("👻 Invisibility", v and "Du bist unsichtbar!" or "Sichtbar.",2)
    end
})

PlayerTab:CreateButton({
    Name = "❤️ Heal",
    Callback = function()
        pcall(function()
            Player.Character.Humanoid.Health = Player.Character.Humanoid.MaxHealth
        end)
        Notify("❤️ Heal","HP aufgefüllt!",2)
    end
})

PlayerTab:CreateButton({
    Name = "🏃 Set Walkspeed",
    Callback = function()
        pcall(function()
            Player.Character.Humanoid.WalkSpeed = Settings_WalkspeedAmount
        end)
        Notify("🏃 Speed","Speed auf "..Settings_WalkspeedAmount.." gesetzt!",3)
    end
})

PlayerTab:CreateButton({
    Name = "💬 Billboard GUI anzeigen",
    Callback = function()
        pcall(function()
            local char = Player.Character
            local head = char:FindFirstChild("Head")
            if head then
                local old = head:FindFirstChild("CeliHubBB")
                if old then old:Destroy() end
                local bb = Instance.new("BillboardGui", head)
                bb.Name = "CeliHubBB"
                bb.Size = UDim2.new(0, 200, 0, 50)
                bb.StudsOffset = Vector3.new(0, 3, 0)
                bb.AlwaysOnTop = true
                local lbl = Instance.new("TextLabel", bb)
                lbl.Size = UDim2.fromScale(1,1)
                lbl.BackgroundTransparency = 1
                lbl.Text = Settings_BillboardText
                lbl.TextColor3 = ORANGE
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 18
                lbl.TextStrokeTransparency = 0.3
                Notify("💬 Billboard","'"..Settings_BillboardText.."' gesetzt!",3)
            end
        end)
    end
})

PlayerTab:CreateButton({
    Name = "📛 Change Name (lokal)",
    Callback = function()
        if Settings_NameBox == "" then Notify("❌","Kein Name in Settings eingegeben!",3); return end
        pcall(function()
            local char = Player.Character
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
            local head = char:FindFirstChild("Head")
            if head then
                local old = head:FindFirstChild("CeliNameTag")
                if old then old:Destroy() end
                local bb = Instance.new("BillboardGui", head)
                bb.Name = "CeliNameTag"
                bb.Size = UDim2.new(0, 200, 0, 40)
                bb.StudsOffset = Vector3.new(0, 2, 0)
                bb.AlwaysOnTop = true
                local lbl = Instance.new("TextLabel", bb)
                lbl.Size = UDim2.fromScale(1,1)
                lbl.BackgroundTransparency = 1
                lbl.Text = Settings_NameBox
                lbl.TextColor3 = Color3.fromRGB(255,255,255)
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 16
                lbl.TextStrokeTransparency = 0.3
                Notify("📛","Name geändert zu: "..Settings_NameBox,3)
            end
        end)
    end
})

PlayerTab:CreateSection("🎨 Charakter Effekte")

PlayerTab:CreateToggle({
    Name = "🌈 Disco Character",
    CurrentValue = false,
    Callback = function(v)
        DiscoChar = v
        if v then
            task.spawn(function()
                while DiscoChar do
                    pcall(function()
                        for _, p in pairs(Player.Character:GetDescendants()) do
                            if p:IsA("BasePart") then
                                p.Color = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                            end
                        end
                    end)
                    task.wait(0.15)
                end
            end)
        end
        Notify("🌈 Disco",v and "ON!" or "OFF.",2)
    end
})

PlayerTab:CreateToggle({
    Name = "🐔 Chicken Arms",
    CurrentValue = false,
    Callback = function(v)
        pcall(function()
            local char = Player.Character
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("SpecialMesh") and (p.Parent.Name=="Left Arm" or p.Parent.Name=="Right Arm") then
                    if v then
                        p.Scale = Vector3.new(0.2,1,0.2)
                    else
                        p.Scale = Vector3.new(1,1,1)
                    end
                end
            end
        end)
        Notify("🐔 Chicken Arms",v and "ON!" or "OFF.",2)
    end
})

PlayerTab:CreateToggle({
    Name = "🔆 Mesh Disco",
    CurrentValue = false,
    Callback = function(v)
        MeshDiscoOn = v
        if v then
            task.spawn(function()
                while MeshDiscoOn do
                    pcall(function()
                        for _, p in pairs(Player.Character:GetDescendants()) do
                            if p:IsA("SpecialMesh") then
                                p.Scale = Vector3.new(math.random(8,15)/10, math.random(8,15)/10, math.random(8,15)/10)
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
        Notify("🔆 Mesh Disco",v and "ON!" or "OFF.",2)
    end
})

PlayerTab:CreateToggle({
    Name = "🤯 Head Shake",
    CurrentValue = false,
    Callback = function(v)
        HeadShakeOn = v
        if v then
            task.spawn(function()
                while HeadShakeOn do
                    pcall(function()
                        local neck = Player.Character.HumanoidRootPart:FindFirstChild("RootJoint")
                            or Player.Character:FindFirstChild("Head") and Player.Character.Head:FindFirstChild("Neck")
                        if neck then neck.C0 = neck.C0 * CFrame.Angles(0, math.rad(math.random(-20,20)), 0) end
                    end)
                    task.wait(0.05)
                end
            end)
        end
        Notify("🤯 Head Shake",v and "ON!" or "OFF.",2)
    end
})

PlayerTab:CreateButton({
    Name = "🌌 Dominus Ghost",
    Callback = function()
        pcall(function()
            local char = Player.Character
            local head = char:FindFirstChild("Head")
            if head then
                local acc = Instance.new("Accessory")
                local h = Instance.new("Part", acc)
                h.Name = "Handle"; h.CanCollide = false
                local mesh = Instance.new("SpecialMesh", h)
                mesh.MeshId = "rbxassetid://1082471"; mesh.Scale = Vector3.new(1.3,1.3,1.3)
                local w = Instance.new("Weld", h)
                w.Part0 = h; w.Part1 = head
                w.C1 = CFrame.new(0,-0.5,0)
                acc.Parent = char
                Notify("🌌","Dominus Ghost ausgerüstet!",3)
            end
        end)
    end
})

PlayerTab:CreateButton({
    Name = "🛸 Floating Pad",
    Callback = function()
        pcall(function()
            local pad = Instance.new("Part", workspace)
            pad.Size = Vector3.new(6,0.5,6)
            pad.Anchored = false; pad.CanCollide = true
            pad.BrickColor = BrickColor.new("Bright orange")
            pad.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0)
            local bv = Instance.new("BodyPosition", pad)
            bv.Position = pad.Position + Vector3.new(0,5,0)
            bv.MaxForce = Vector3.new(1e5,1e5,1e5)
            Notify("🛸 Floating Pad","Erstellt!",3)
        end)
    end
})

PlayerTab:CreateSection("🛡️ Anti Hacks")

PlayerTab:CreateButton({
    Name = "🛡️ Anti-Robloxian aktivieren",
    Callback = function()
        task.spawn(function()
            while true do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= Player and plr.Character then
                        local root = plr.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            local dist = (Player.Character.HumanoidRootPart.Position - root.Position).Magnitude
                            if dist < Settings_AntiRobloxianRange then
                                Notify("⚠️ Anti-Robloxian",plr.Name.." zu nah! ("..math.floor(dist).." studs)",5)
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
        Notify("🛡️","Anti-Robloxian gestartet! Range: "..Settings_AntiRobloxianRange,4)
    end
})

-- ============================================================
-- WEAPONS TAB (Gear / Weapon Scripts)
-- ============================================================
WeaponsTab:CreateSection("⚔️ Weapon Scripts")

local weaponScripts = {
    {name="🏹 xBow",            id="74596840"},
    {name="🐉 Drage",           id="95991687"},
    {name="👁️ Eye Laser",       id="18430788"},
    {name="🪄 Wand",            id="12345678"},
    {name="⚔️ Dual Blades",     id="17778891"},
    {name="🔪 Knife",           id="17040741"},
    {name="💡 Lightsaber",      id="17940874"},
    {name="🤜 Master Hand",     id="18628254"},
    {name="🪄 Staff",           id="11838255"},
    {name="🤖 Techno Gauntlet", id="76080196"},
    {name="✈️ Plane",           id="17475049"},
    {name="❄️ Snowball",        id="17627743"},
    {name="💣 Suicide Vest",    id="21000179"},
    {name="🏇 Lance",           id="13166616"},
}

for _, w in ipairs(weaponScripts) do
    local wRef = w
    WeaponsTab:CreateButton({
        Name = wRef.name,
        Callback = function()
            pcall(function()
                local tool = game:GetObjects("rbxassetid://"..wRef.id)[1]
                if tool then
                    tool.Parent = Player.Backpack
                    Notify("⚔️",wRef.name.." ausgerüstet!",3)
                end
            end)
        end
    })
end

WeaponsTab:CreateSection("🎒 Gear Tools")

local gearTools = {
    {name="🛠️ Custom Gear",    action="custom"},
    {name="🔨 Stamper Tools",  id="19887862"},
    {name="🧲 Tool Stealer",   id="14579824"},
    {name="📥 Insert Tool",    id="24267014"},
    {name="🔫 Minigun",        id="19049383"},
    {name="🔫 Laser Rifle",    id="22126696"},
    {name="✏️ Draw Tool",      id="21089788"},
}

for _, g in ipairs(gearTools) do
    local gRef = g
    WeaponsTab:CreateButton({
        Name = gRef.name,
        Callback = function()
            if gRef.action == "custom" then
                pcall(function()
                    local tool = game:GetObjects("rbxassetid://"..Settings_SkyboxID)[1]
                    if tool then tool.Parent=Player.Backpack; Notify("🛠️","Custom Gear geladen!",3) end
                end)
            else
                pcall(function()
                    local tool = game:GetObjects("rbxassetid://"..gRef.id)[1]
                    if tool then tool.Parent=Player.Backpack; Notify("🎒",gRef.name.." geladen!",3) end
                end)
            end
        end
    })
end

WeaponsTab:CreateSection("🎯 Preset Gear IDs")

local presetGear = {
    {name="💥 Airstrike",          id="33566191"},
    {name="🌀 Gravity Coil",       id="19717767"},
    {name="⚔️ Linked Sword",       id="1082242"},
    {name="❄️ Ice Dagger",         id="18430145"},
    {name="💀 Dual Darkhearts",    id="19166887"},
    {name="🐍 Dual Venomshanks",   id="19252370"},
    {name="🔥 Ghostfire Sword",    id="19252400"},
    {name="🏍️ Hyperbike",          id="19726775"},
}

for _, pg in ipairs(presetGear) do
    local pgRef = pg
    WeaponsTab:CreateButton({
        Name = pgRef.name,
        Callback = function()
            pcall(function()
                local tool = game:GetObjects("rbxassetid://"..pgRef.id)[1]
                if tool then tool.Parent=Player.Backpack; Notify("🎯",pgRef.name.." geladen!",3) end
            end)
        end
    })
end

-- ============================================================
-- SERVER TAB (Destruction)
-- ============================================================
ServerTab:CreateSection("💥 Server Destruction")

ServerTab:CreateButton({
    Name = "🌊 Flood",
    Callback = function()
        pcall(function()
            local p = Instance.new("Part", workspace)
            p.Size = Vector3.new(2048,1,2048)
            p.Anchored = true; p.CanCollide = true
            p.BrickColor = BrickColor.new("Cyan"); p.Material = Enum.Material.SmoothPlastic
            p.CFrame = CFrame.new(0, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y - 5, 0)
            Notify("🌊 Flood","Flut aktiviert!",3)
        end)
    end
})

ServerTab:CreateButton({
    Name = "🔓 Unanchor All",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then pcall(function() v.Anchored=false end) end
        end
        Notify("🔓","Alles deanchored!",3)
    end
})

ServerTab:CreateButton({
    Name = "🗑️ Clear Terrain",
    Callback = function()
        workspace.Terrain:Clear()
        Notify("🗑️","Terrain gecleart!",3)
    end
})

ServerTab:CreateButton({
    Name = "🌌 Set Skybox",
    Callback = function()
        pcall(function()
            local sky = workspace.CurrentCamera:FindFirstChildOfClass("Sky") or Instance.new("Sky", workspace.CurrentCamera)
            for _, face in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
                sky[face] = "rbxassetid://"..Settings_SkyboxID
            end
            Notify("🌌 Skybox","ID "..Settings_SkyboxID.." gesetzt!",3)
        end)
    end
})

ServerTab:CreateButton({
    Name = "🖼️ Decal Spam",
    Callback = function()
        task.spawn(function()
            for _ = 1, 30 do
                pcall(function()
                    local p = Instance.new("Part", workspace)
                    p.Size = Vector3.new(20,20,1); p.Anchored = true; p.CanCollide = false
                    p.CFrame = CFrame.new(math.random(-500,500), math.random(5,50), math.random(-500,500))
                    local d = Instance.new("Decal", p); d.Texture = "rbxassetid://"..Settings_SkyboxID
                end)
                task.wait(0.05)
            end
        end)
        Notify("🖼️ Decal Spam","30 Decals gespawnt!",3)
    end
})

ServerTab:CreateButton({
    Name = "📍 Force Teleport (alle zu dir)",
    Callback = function()
        pcall(function()
            local myPos = Player.Character.HumanoidRootPart.CFrame
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    plr.Character.HumanoidRootPart.CFrame = myPos
                end
            end
        end)
        Notify("📍","Alle zu dir teleportiert!",3)
    end
})

ServerTab:CreateButton({
    Name = "💀 Kill All",
    Callback = function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                pcall(function() plr.Character.Humanoid.Health = 0 end)
            end
        end
        Notify("💀 Kill All","Alle getötet!",3)
    end
})

ServerTab:CreateButton({
    Name = "🔴 Apoc Troll (Explosion Spam)",
    Callback = function()
        task.spawn(function()
            for _ = 1, 20 do
                pcall(function()
                    local e = Instance.new("Explosion", workspace)
                    e.Position = Vector3.new(math.random(-200,200), 0, math.random(-200,200))
                    e.BlastRadius = 20; e.BlastPressure = 500000
                end)
                task.wait(0.1)
            end
        end)
        Notify("🔴 Apoc Troll","Explosionen!",3)
    end
})

ServerTab:CreateButton({
    Name = "🔥 Clear Workspace",
    Callback = function()
        for _, v in pairs(workspace:GetChildren()) do
            if not v:IsA("Camera") and v ~= Players.LocalPlayer.Character then
                pcall(function() v:Destroy() end)
            end
        end
        Notify("🔥","Workspace gecleart!",3)
    end
})

ServerTab:CreateButton({
    Name = "🏗️ Create Baseplate",
    Callback = function()
        local p = Instance.new("Part", workspace)
        p.Size = Vector3.new(2048,1,2048); p.Anchored = true
        p.CFrame = CFrame.new(0,0,0)
        p.BrickColor = BrickColor.new("Medium green")
        p.Material = Enum.Material.SmoothPlastic
        p.Name = "Baseplate"
        Notify("🏗️","Baseplate erstellt!",3)
    end
})

ServerTab:CreateButton({
    Name = "😰 Intimidation (Explosion um dich)",
    Callback = function()
        task.spawn(function()
            for _ = 1, 10 do
                pcall(function()
                    local e = Instance.new("Explosion", workspace)
                    local myPos = Player.Character.HumanoidRootPart.Position
                    e.Position = myPos + Vector3.new(math.random(-5,5), 0, math.random(-5,5))
                    e.BlastRadius = 2; e.BlastPressure = 0
                end)
                task.wait(0.05)
            end
        end)
        Notify("😰 Intimidation","Einschüchterung!",2)
    end
})

-- ============================================================
-- ADMIN GUIs TAB
-- ============================================================
AdminGuisTab:CreateSection("🛡️ Admin Scripts laden")

local adminScripts = {
    {name="🔵 iOrb Admin",          url="https://pastebin.com/raw/jFgBzPub"},
    {name="🟠 Kohls Admin",         url="https://pastebin.com/raw/kdEjsW0p"},
    {name="🟣 NexPluvia Admin",     url="https://pastebin.com/raw/YwkB4ubm"},
    {name="🔴 RpeD33k Admin",       url="https://pastebin.com/raw/LRD8JBfk"},
    {name="☠️ Kill Gui",            url="https://pastebin.com/raw/6u9bHRDm"},
    {name="🤫 Silent Executor",     url="https://pastebin.com/raw/hQ2BQZPH"},
    {name="❌ Nilizer",             url="https://pastebin.com/raw/7y1cA9Ek"},
    {name="🔧 Remso Admin",         url="https://pastebin.com/raw/Qq7DQPuM"},
    {name="⚡ X Admin",             url="https://pastebin.com/raw/bGRiGCpX"},
    {name="💤 Lag Gui",             url="https://pastebin.com/raw/rJu3CKFz"},
    {name="📢 Global Message Gui",  url="https://pastebin.com/raw/wFsPdLyX"},
    {name="🎯 Quickscope Gui",      url="https://pastebin.com/raw/AJ58ZwRC"},
    {name="📦 DZR Spawn Item Gui",  url="https://pastebin.com/raw/Xwmcq5fF"},
}

for _, a in ipairs(adminScripts) do
    local aRef = a
    AdminGuisTab:CreateButton({
        Name = aRef.name,
        Callback = function()
            Notify("🛡️ Laden",aRef.name.." wird geladen...",3)
            pcall(function() loadstring(game:HttpGet(aRef.url))() end)
        end
    })
end

-- ============================================================
-- SKYBOX / MUSIC TAB
-- ============================================================
SkyboxMusicTab:CreateSection("🎵 Musik")

SkyboxMusicTab:CreateButton({
    Name = "▶️ Play Music",
    Callback = function()
        pcall(function()
            local old = workspace:FindFirstChild("CeliHubMusic")
            if old then old:Destroy() end
            local sound = Instance.new("Sound", workspace)
            sound.Name = "CeliHubMusic"
            sound.SoundId = "rbxassetid://"..Settings_MusicID
            sound.Pitch = Settings_MusicPitch
            sound.Volume = 0.5
            sound:Play()
            Notify("🎵 Music","Spielt ID "..Settings_MusicID,4)
        end)
    end
})

SkyboxMusicTab:CreateButton({
    Name = "⏹️ Stop Music",
    Callback = function()
        pcall(function()
            local sound = workspace:FindFirstChild("CeliHubMusic")
            if sound then sound:Stop(); sound:Destroy() end
        end)
        Notify("⏹️ Music","Gestoppt.",2)
    end
})

SkyboxMusicTab:CreateSection("🌌 Preset Skyboxes")

local presetSkyboxes = {
    {name="🟠 CeliHub Logo",  id="8560915232"},
    {name="🟠 CeliHub Logo 2",id="8560915232"},
    {name="🚂 Thomas",        id="1081367"},
    {name="😎 c00lkidd",      id="48294733"},
}

for _, s in ipairs(presetSkyboxes) do
    local sRef = s
    SkyboxMusicTab:CreateButton({
        Name = sRef.name,
        Callback = function()
            pcall(function()
                local sky = workspace.CurrentCamera:FindFirstChildOfClass("Sky") or Instance.new("Sky", workspace.CurrentCamera)
                for _, face in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp"}) do
                    sky[face] = "rbxassetid://"..sRef.id
                end
            end)
            Notify("🌌",sRef.name.." Skybox gesetzt!",3)
        end
    })
end

SkyboxMusicTab:CreateButton({
    Name = "🔄 Skybox wiederherstellen",
    Callback = function()
        pcall(function()
            local sky = workspace.CurrentCamera:FindFirstChildOfClass("Sky")
            if sky then sky:Destroy() end
        end)
        Notify("🔄 Skybox","Wiederhergestellt.",2)
    end
})

SkyboxMusicTab:CreateSection("🎵 Preset Music IDs")

local presetMusic = {
    {name="🎵 Electro Sp00k",  id="142930454"},
    {name="🎵 Wonga",          id="130768996"},
    {name="🎵 Chop Suey",      id="143666548"},
    {name="😱 Scream",         id="26120219"},
}

for _, m in ipairs(presetMusic) do
    local mRef = m
    SkyboxMusicTab:CreateButton({
        Name = mRef.name,
        Callback = function()
            pcall(function()
                local old = workspace:FindFirstChild("CeliHubMusic")
                if old then old:Destroy() end
                local sound = Instance.new("Sound", workspace)
                sound.Name = "CeliHubMusic"
                sound.SoundId = "rbxassetid://"..mRef.id
                sound.Pitch = Settings_MusicPitch
                sound.Volume = 0.5
                sound:Play()
            end)
            Notify("🎵",mRef.name.." spielt!",3)
        end
    })
end

-- ============================================================
-- MISC TAB
-- ============================================================
MiscTab:CreateSection("🔧 Verschiedenes")

MiscTab:CreateToggle({
    Name = "🌈 Disco Fog",
    CurrentValue = false,
    Callback = function(v)
        DiscoFogOn = v
        if v then
            task.spawn(function()
                local lighting = game:GetService("Lighting")
                while DiscoFogOn do
                    pcall(function()
                        lighting.FogColor = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                        lighting.FogEnd = math.random(50,200)
                        lighting.FogStart = 0
                    end)
                    task.wait(0.2)
                end
            end)
        else
            pcall(function()
                local l = game:GetService("Lighting")
                l.FogEnd = 100000; l.FogStart = 0
            end)
        end
        Notify("🌈 Disco Fog",v and "ON!" or "OFF.",2)
    end
})

MiscTab:CreateButton({
    Name = "💬 Chat Spam starten",
    Callback = function()
        if Settings_ChatSpamText=="" then Notify("❌","Chat Spam Text in Settings eingeben!",3); return end
        task.spawn(function()
            for _ = 1, 10 do
                pcall(function()
                    game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
                        and game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Settings_ChatSpamText,"All")
                end)
                task.wait(0.5)
            end
        end)
        Notify("💬 Spam","'"..Settings_ChatSpamText.."' 10x gespammt!",3)
    end
})

MiscTab:CreateButton({
    Name = "📊 Leaderstat hinzufügen",
    Callback = function()
        if Settings_LeaderstatName=="" then Notify("❌","Leaderstat Name eingeben!",3); return end
        pcall(function()
            local ls = Player:FindFirstChild("leaderstats") or Instance.new("Folder", Player)
            ls.Name = "leaderstats"
            local stat = ls:FindFirstChild(Settings_LeaderstatName) or Instance.new("IntValue", ls)
            stat.Name = Settings_LeaderstatName
            stat.Value = stat.Value + Settings_LeaderstatAmount
        end)
        Notify("📊 Leaderstat","+"..Settings_LeaderstatAmount.." zu "..Settings_LeaderstatName,3)
    end
})

MiscTab:CreateButton({
    Name = "📊 Leaderstat ändern",
    Callback = function()
        if Settings_LeaderstatName=="" then Notify("❌","Leaderstat Name eingeben!",3); return end
        pcall(function()
            local ls = Player:FindFirstChild("leaderstats")
            if ls then
                local stat = ls:FindFirstChild(Settings_LeaderstatName)
                if stat then stat.Value = Settings_LeaderstatAmount end
            end
        end)
        Notify("📊 Leaderstat","'"..Settings_LeaderstatName.."' auf "..Settings_LeaderstatAmount.." gesetzt!",3)
    end
})

MiscTab:CreateButton({
    Name = "👑 Become Owner (Personal Server)",
    Callback = function()
        pcall(function()
            if game.PrivateServerId ~= "" then
                local rs = game:GetService("ReplicatedStorage")
                Notify("👑","Versuche Owner zu werden...",3)
            else
                Notify("❌","Kein Private Server!",3)
            end
        end)
    end
})

MiscTab:CreateSection("ℹ️ Info")
MiscTab:CreateParagraph({
    Title = "CeliHub | c00lgui Edition",
    Content = "Basiert auf c00lgui Reborn\nKomplett umgebaut von Celi 💫\nOrange Theme • Rayfield UI\n\nKey: celi2026"
})

Notify("🟠 CeliHub","c00lgui Edition geladen!\nMade by Celi 💫",5)
