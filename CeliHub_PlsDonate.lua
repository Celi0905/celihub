-- 💰 Celi PLS DONATE Tool
-- Made by Celi 💫
-- Fake Donate, Stand Setup, Auto Collect & mehr

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Player           = Players.LocalPlayer

local function GetChar()  return Player.Character end
local function GetHum()   local c=GetChar(); return c and c:FindFirstChildOfClass("Humanoid") end
local function GetRoot()  local c=GetChar(); return c and c:FindFirstChild("HumanoidRootPart") end

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
if not Rayfield then warn("[CeliHub PLS DONATE] Rayfield nicht ladbar!"); return end

-- ============================================================
-- State
-- ============================================================
local State = {
    AutoCollect  = false,
    AutoDonate   = false,
    SpamDonate   = false,
    AutoTP       = false,
    ShowESP      = false,
}
local Cfg = {
    FakeName      = "CeliHub 💫",
    FakeAmount    = 100,
    FakeGoal      = 1000,
    FakeDesc      = "pls donate 🙏 i need robux",
    SpamInterval  = 2.0,
    AutoTPRange   = 30,
    DonateMsg     = "thx for donating! 💰",
}

-- ============================================================
-- Window
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "💰  Celi PLS DONATE Tool",
    LoadingTitle    = "Celi PLS DONATE",
    LoadingSubtitle = "by Celi 💫  •  Fake Donate & mehr",
    ConfigurationSaving = { Enabled = true, FolderName = "CeliHub_PlsDonate" },
    KeySystem = false,
})

local function N(t, c, d)
    pcall(function() Rayfield:Notify({ Title=tostring(t), Content=tostring(c), Duration=d or 3 }) end)
end

-- ============================================================
-- TABS
-- ============================================================
local TabFake    = Window:CreateTab("💸 Fake Donate",  4483362458)
local TabStand   = Window:CreateTab("🪑 Stand",        4483362458)
local TabAuto    = Window:CreateTab("🤖 Auto Tools",   4483362458)
local TabPlayers = Window:CreateTab("👥 Spieler",      4483362458)
local TabMisc    = Window:CreateTab("🔧 Misc",         4483362458)

-- ============================================================
-- 💸 FAKE DONATE TAB
-- ============================================================
TabFake:CreateSection("💸 Fake Donation Setup")
TabFake:CreateInput({
    Name = "📛 Dein Anzeigename",
    PlaceholderText = "CeliHub 💫",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v ~= "" then Cfg.FakeName = v end end
})
TabFake:CreateInput({
    Name = "💰 Betrag (Robux)",
    PlaceholderText = "100",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) Cfg.FakeAmount = tonumber(v) or Cfg.FakeAmount end
})
TabFake:CreateInput({
    Name = "🎯 Ziel (Goal Robux)",
    PlaceholderText = "1000",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) Cfg.FakeGoal = tonumber(v) or Cfg.FakeGoal end
})
TabFake:CreateInput({
    Name = "📝 Stand-Beschreibung",
    PlaceholderText = "pls donate 🙏 i need robux",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v ~= "" then Cfg.FakeDesc = v end end
})
TabFake:CreateInput({
    Name = "💬 Auto-Antwort nach Donation",
    PlaceholderText = "thx for donating! 💰",
    RemoveTextAfterFocusLost = false,
    Callback = function(v) if v ~= "" then Cfg.DonateMsg = v end end
})

TabFake:CreateSection("💸 Fake Donation senden")
TabFake:CreateButton({ Name = "💸 Fake Donation JETZT senden", Callback = function()
    pcall(function()
        -- Donation Notification für alle sichtbar (lokal)
        local PlayerGui = Player:WaitForChild("PlayerGui")
        local oldNotif = PlayerGui:FindFirstChild("CeliFakeDonation")
        if oldNotif then oldNotif:Destroy() end

        local SGui = Instance.new("ScreenGui", PlayerGui)
        SGui.Name = "CeliFakeDonation"
        SGui.ResetOnSpawn = false
        SGui.IgnoreGuiInset = true

        local Card = Instance.new("Frame", SGui)
        Card.Size = UDim2.fromOffset(340, 80)
        Card.Position = UDim2.new(0.5, -170, 0, -90)
        Card.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
        Card.BorderSizePixel = 0
        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 12)
        local CS = Instance.new("UIStroke", Card); CS.Color = Color3.fromRGB(255, 215, 0); CS.Thickness = 2

        local Icon = Instance.new("TextLabel", Card)
        Icon.Size = UDim2.fromOffset(60, 80); Icon.Position = UDim2.fromOffset(0, 0)
        Icon.BackgroundColor3 = Color3.fromRGB(255, 185, 0); Icon.BorderSizePixel = 0
        Icon.Text = "💰"; Icon.TextSize = 30
        Instance.new("UICorner", Icon).CornerRadius = UDim.new(0, 12)

        local TL = Instance.new("TextLabel", Card)
        TL.Size = UDim2.fromOffset(268, 24); TL.Position = UDim2.fromOffset(66, 8)
        TL.BackgroundTransparency = 1; TL.Text = Cfg.FakeName .. " hat gespendet!"
        TL.TextColor3 = Color3.fromRGB(255, 215, 0); TL.Font = Enum.Font.GothamBold; TL.TextSize = 14
        TL.TextXAlignment = Enum.TextXAlignment.Left

        local AL = Instance.new("TextLabel", Card)
        AL.Size = UDim2.fromOffset(268, 22); AL.Position = UDim2.fromOffset(66, 32)
        AL.BackgroundTransparency = 1; AL.Text = "R$ " .. Cfg.FakeAmount .. " Robux"
        AL.TextColor3 = Color3.new(1,1,1); AL.Font = Enum.Font.GothamBold; AL.TextSize = 20
        AL.TextXAlignment = Enum.TextXAlignment.Left

        local ML = Instance.new("TextLabel", Card)
        ML.Size = UDim2.fromOffset(268, 18); ML.Position = UDim2.fromOffset(66, 54)
        ML.BackgroundTransparency = 1; ML.Text = "\"" .. Cfg.DonateMsg .. "\""
        ML.TextColor3 = Color3.fromRGB(160,160,200); ML.Font = Enum.Font.Gotham; ML.TextSize = 11
        ML.TextXAlignment = Enum.TextXAlignment.Left; ML.TextWrapped = true

        -- Slide in
        TweenService:Create(Card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, -170, 0, 20)}):Play()

        task.wait(4)
        TweenService:Create(Card, TweenInfo.new(0.4), {Position = UDim2.new(0.5, -170, 0, -90)}):Play()
        task.wait(0.5); SGui:Destroy()
    end)
    N("💸 Fake Donate", Cfg.FakeName .. " → R$" .. Cfg.FakeAmount, 4)
end})

TabFake:CreateButton({ Name = "🔁 Fake Donation Spam (5x)", Callback = function()
    task.spawn(function()
        local amounts = {1, 5, 10, 25, 50, 100, 200, 500}
        for i = 1, 5 do
            local fakeAmt = amounts[math.random(1, #amounts)]
            local fakeNames = {"Player"..math.random(1000,9999), "xX_"..Cfg.FakeName.."_Xx", "c00lgui_fan", "Roblox_User"..math.random(100,999), Cfg.FakeName}
            local fakeName = fakeNames[math.random(1,#fakeNames)]

            pcall(function()
                local PlayerGui = Player:WaitForChild("PlayerGui")
                local SGui = Instance.new("ScreenGui", PlayerGui)
                SGui.ResetOnSpawn = false; SGui.IgnoreGuiInset = true

                local Card = Instance.new("Frame", SGui)
                Card.Size = UDim2.fromOffset(300, 60)
                Card.Position = UDim2.new(0.5, -150+(math.random(-30,30)), 0, -70)
                Card.BackgroundColor3 = Color3.fromRGB(25,30,45); Card.BorderSizePixel=0
                Instance.new("UICorner",Card).CornerRadius=UDim.new(0,10)
                Instance.new("UIStroke",Card).Color=Color3.fromRGB(255,215,0)

                local TL=Instance.new("TextLabel",Card); TL.Size=UDim2.fromScale(1,0.5); TL.BackgroundTransparency=1
                TL.Text="💰 "..fakeName.." → R$"..fakeAmt; TL.TextColor3=Color3.fromRGB(255,215,0)
                TL.Font=Enum.Font.GothamBold; TL.TextSize=13

                local SL=Instance.new("TextLabel",Card); SL.Size=UDim2.fromScale(1,0.5); SL.Position=UDim2.fromScale(0,0.5)
                SL.BackgroundTransparency=1; SL.Text=Cfg.DonateMsg
                SL.TextColor3=Color3.fromRGB(160,160,200); SL.Font=Enum.Font.Gotham; SL.TextSize=11

                TweenService:Create(Card,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-150,0,20+(i-1)*10)}):Play()
                task.wait(3); TweenService:Create(Card,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-150,0,-70)}):Play()
                task.wait(0.4); SGui:Destroy()
            end)
            task.wait(0.8)
        end
    end)
    N("🔁 Spam","5 Fake Donations gesendet!",4)
end})

TabFake:CreateButton({ Name = "📊 Fake Leaderboard anzeigen", Callback = function()
    pcall(function()
        local PlayerGui = Player:WaitForChild("PlayerGui")
        local old = PlayerGui:FindFirstChild("CeliFakeLeaderboard"); if old then old:Destroy(); N("📊","Leaderboard entfernt.",2); return end

        local SGui = Instance.new("ScreenGui", PlayerGui)
        SGui.Name = "CeliFakeLeaderboard"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true

        local Frame = Instance.new("Frame",SGui)
        Frame.Size=UDim2.fromOffset(220,240); Frame.Position=UDim2.new(1,-230,0.5,-120)
        Frame.BackgroundColor3=Color3.fromRGB(18,22,35); Frame.BorderSizePixel=0; Frame.Active=true; Frame.Draggable=true
        Instance.new("UICorner",Frame).CornerRadius=UDim.new(0,12)
        Instance.new("UIStroke",Frame).Color=Color3.fromRGB(255,215,0)

        local Title=Instance.new("TextLabel",Frame); Title.Size=UDim2.fromOffset(220,36); Title.BackgroundColor3=Color3.fromRGB(255,185,0); Title.BorderSizePixel=0
        Instance.new("UICorner",Title).CornerRadius=UDim.new(0,12)
        Title.Text="💰 Top Donators"; Title.TextColor3=Color3.fromRGB(20,15,5); Title.Font=Enum.Font.GothamBold; Title.TextSize=14

        local fakeData = {
            {Cfg.FakeName,    Cfg.FakeAmount * math.random(5,12)},
            {"xX_Robloxian",  math.random(300,900)},
            {"ProDonator99",  math.random(200,600)},
            {"CoolPlayer123", math.random(100,400)},
            {"Guest_"..math.random(1000,9999), math.random(50,200)},
        }
        table.sort(fakeData, function(a,b) return a[2]>b[2] end)

        local medals = {"🥇","🥈","🥉","4️⃣","5️⃣"}
        for i, d in ipairs(fakeData) do
            local row=Instance.new("Frame",Frame); row.Size=UDim2.fromOffset(200,30); row.Position=UDim2.fromOffset(10,32+i*34); row.BackgroundColor3=Color3.fromRGB(25,30,45); row.BorderSizePixel=0
            Instance.new("UICorner",row).CornerRadius=UDim.new(0,7)
            local lbl=Instance.new("TextLabel",row); lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1
            lbl.Text=medals[i].." "..d[1].."  R$"..d[2]; lbl.TextColor3=i==1 and Color3.fromRGB(255,215,0) or Color3.new(1,1,1)
            lbl.Font=Enum.Font.GothamBold; lbl.TextSize=11; lbl.TextXAlignment=Enum.TextXAlignment.Left
            local pad=Instance.new("UIPadding",lbl); pad.PaddingLeft=UDim.new(0,8)
        end

        local CloseB=Instance.new("TextButton",Frame); CloseB.Size=UDim2.fromOffset(200,26); CloseB.Position=UDim2.fromOffset(10,208)
        CloseB.BackgroundColor3=Color3.fromRGB(160,40,40); CloseB.Text="✕ Schließen"; CloseB.TextColor3=Color3.new(1,1,1); CloseB.Font=Enum.Font.GothamBold; CloseB.TextSize=12; CloseB.BorderSizePixel=0
        Instance.new("UICorner",CloseB).CornerRadius=UDim.new(0,7)
        CloseB.MouseButton1Click:Connect(function() SGui:Destroy() end)
    end)
    N("📊","Leaderboard geöffnet! (draggable)",3)
end})

-- ============================================================
-- 🪑 STAND TAB
-- ============================================================
TabStand:CreateSection("🪑 Stand Tools")
TabStand:CreateButton({ Name = "🪑 Fake Stand erstellen (Billboard)", Callback = function()
    pcall(function()
        local root=GetRoot(); if not root then return end
        local stand=Instance.new("Part",workspace)
        stand.Name="CeliDonateStand"; stand.Size=Vector3.new(6,0.5,3); stand.Anchored=true
        stand.BrickColor=BrickColor.new("Bright blue"); stand.Material=Enum.Material.SmoothPlastic
        stand.CFrame=root.CFrame*CFrame.new(0,-3,5)

        local sign=Instance.new("Part",workspace)
        sign.Name="CeliDonateSign"; sign.Size=Vector3.new(6,3,0.2); sign.Anchored=true
        sign.BrickColor=BrickColor.new("Medium blue"); sign.Material=Enum.Material.SmoothPlastic
        sign.CFrame=root.CFrame*CFrame.new(0,-1.25,8)

        local bb=Instance.new("BillboardGui",sign)
        bb.Size=UDim2.fromOffset(300,150); bb.StudsOffset=Vector3.new(0,0,0.2); bb.AlwaysOnTop=false

        local bg=Instance.new("Frame",bb); bg.Size=UDim2.fromScale(1,1); bg.BackgroundColor3=Color3.fromRGB(15,20,35); bg.BackgroundTransparency=0.15; bg.BorderSizePixel=0
        Instance.new("UICorner",bg).CornerRadius=UDim.new(0,12)
        Instance.new("UIStroke",bg).Color=Color3.fromRGB(255,215,0)

        local topBar=Instance.new("Frame",bg); topBar.Size=UDim2.new(1,0,0,36); topBar.BackgroundColor3=Color3.fromRGB(255,185,0); topBar.BorderSizePixel=0
        Instance.new("UICorner",topBar).CornerRadius=UDim.new(0,12)
        local topL=Instance.new("TextLabel",topBar); topL.Size=UDim2.fromScale(1,1); topL.BackgroundTransparency=1
        topL.Text="💰 "..Cfg.FakeName; topL.TextColor3=Color3.fromRGB(20,15,5); topL.Font=Enum.Font.GothamBold; topL.TextSize=16

        local descL=Instance.new("TextLabel",bg); descL.Size=UDim2.fromOffset(280,40); descL.Position=UDim2.fromOffset(10,42)
        descL.BackgroundTransparency=1; descL.Text=Cfg.FakeDesc; descL.TextColor3=Color3.new(1,1,1); descL.Font=Enum.Font.Gotham; descL.TextSize=13; descL.TextWrapped=true

        local goalBG=Instance.new("Frame",bg); goalBG.Size=UDim2.fromOffset(280,20); goalBG.Position=UDim2.fromOffset(10,88); goalBG.BackgroundColor3=Color3.fromRGB(30,30,50); goalBG.BorderSizePixel=0
        Instance.new("UICorner",goalBG).CornerRadius=UDim.new(0,6)
        local goalFill=Instance.new("Frame",goalBG); goalFill.Size=UDim2.fromScale(math.clamp(Cfg.FakeAmount/Cfg.FakeGoal,0,1),1); goalFill.BackgroundColor3=Color3.fromRGB(255,185,0); goalFill.BorderSizePixel=0
        Instance.new("UICorner",goalFill).CornerRadius=UDim.new(0,6)

        local goalL=Instance.new("TextLabel",bg); goalL.Size=UDim2.fromOffset(280,20); goalL.Position=UDim2.fromOffset(10,112)
        goalL.BackgroundTransparency=1; goalL.Text="Goal: R$"..Cfg.FakeAmount.." / R$"..Cfg.FakeGoal; goalL.TextColor3=Color3.fromRGB(200,200,200); goalL.Font=Enum.Font.GothamBold; goalL.TextSize=11
    end)
    N("🪑 Stand","Fake Stand erstellt!",4)
end})

TabStand:CreateButton({ Name = "🗑️ Stand entfernen", Callback = function()
    local c=0
    for _,v in pairs(workspace:GetChildren()) do
        if v.Name=="CeliDonateStand" or v.Name=="CeliDonateSign" then v:Destroy(); c=c+1 end
    end
    N("🗑️ Stand",c.." Teile entfernt.",3)
end})

TabStand:CreateButton({ Name = "💬 Fake Chat-Spam (Donate Werbung)", Callback = function()
    local msgs = {
        "pls donate 🙏 i need robux!!",
        "donate 1 robux = 1 prayer 🙏",
        "💰 "..Cfg.FakeName.." is accepting donations!",
        "my stand: donate "..Cfg.FakeAmount.." robux pls",
        "[PLS DONATE] Goal: R$"..Cfg.FakeGoal.." 💸",
    }
    task.spawn(function()
        for _,msg in ipairs(msgs) do
            pcall(function()
                local rs=game:GetService("ReplicatedStorage")
                local ch=rs:FindFirstChild("DefaultChatSystemChatEvents")
                if ch then local say=ch:FindFirstChild("SayMessageRequest"); if say then say:FireServer(msg,"All") end end
            end)
            task.wait(1.2)
        end
    end)
    N("💬 Chat","Donation-Spam gesendet!",4)
end})

TabStand:CreateParagraph({Title="💡 Stand Tipps",Content="• Stand erstellen → Banner erscheint vor dir\n• Name & Betrag in 'Fake Donate' anpassen\n• Billboard zeigt Goal-Progress-Bar\n• Stand ist lokal sichtbar"})

-- ============================================================
-- 🤖 AUTO TOOLS TAB
-- ============================================================
TabAuto:CreateSection("🤖 Auto Tools")
TabAuto:CreateToggle({ Name="🔄 Auto-Collect (Robux einsammeln)", CurrentValue=false, Callback=function(v)
    State.AutoCollect=v
    if v then
        task.spawn(function()
            while State.AutoCollect do
                pcall(function()
                    local root=GetRoot(); if not root then return end
                    for _,obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") or obj:IsA("Model") then
                            local name=obj.Name:lower()
                            if name:find("donate") or name:find("collect") or name:find("robux") or name:find("coin") then
                                local pos=obj:IsA("BasePart") and obj.Position or (obj.PrimaryPart and obj.PrimaryPart.Position)
                                if pos and (root.Position-pos).Magnitude < Cfg.AutoTPRange then
                                    root.CFrame=CFrame.new(pos+Vector3.new(0,3,0))
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
    end
    N("🔄 Auto-Collect",v and "AN! Range: "..Cfg.AutoTPRange or "AUS.",3)
end})

TabAuto:CreateSlider({ Name="📍 Auto-Collect Range",Range={5,200},Increment=5,CurrentValue=30,Callback=function(v) Cfg.AutoTPRange=v end})

TabAuto:CreateToggle({ Name="🎯 Auto-Donate (alle 5s)", CurrentValue=false, Callback=function(v)
    State.AutoDonate=v
    if v then
        task.spawn(function()
            while State.AutoDonate do
                pcall(function()
                    for _,plr in pairs(Players:GetPlayers()) do
                        if plr~=Player then
                            local stand=plr.Character and plr.Character:FindFirstChild("CeliDonateStand")
                            local root=GetRoot()
                            if root and stand and (root.Position-stand.Position).Magnitude<50 then
                                N("🎯","Auto-Donated an "..plr.Name,2)
                            end
                        end
                    end
                end)
                task.wait(5)
            end
        end)
    end
    N("🎯 Auto-Donate",v and "AN!" or "AUS.",2)
end})

TabAuto:CreateToggle({ Name="📣 Auto Notification Spam", CurrentValue=false, Callback=function(v)
    State.SpamDonate=v
    if v then
        task.spawn(function()
            local i=0
            while State.SpamDonate do
                i=i+1
                local fakeAmounts={1,5,10,25,50,100,200}
                local amt=fakeAmounts[math.random(1,#fakeAmounts)]
                N("💰 Donation","Player"..math.random(1000,9999).." → R$"..amt,2)
                task.wait(Cfg.SpamInterval)
            end
        end)
    end
    N("📣 Spam",v and "AN!" or "AUS.",2)
end})

TabAuto:CreateSlider({ Name="⏱️ Notification Interval (s)",Range={0.5,10},Increment=0.5,CurrentValue=2,Callback=function(v) Cfg.SpamInterval=v end})

-- ============================================================
-- 👥 SPIELER TAB
-- ============================================================
TabPlayers:CreateSection("👥 Spieler Tools")
TabPlayers:CreateButton({ Name="💰 Alle Spieler 'Donation' anzeigen", Callback=function()
    task.spawn(function()
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player then
                task.wait(0.3)
                N("💰 Donation",plr.Name.." → R$"..math.random(1,500),3)
            end
        end
    end)
    N("👥","Alle Donations angezeigt!",3)
end})

TabPlayers:CreateButton({ Name="📍 Zum nächsten Stand TP", Callback=function()
    local root=GetRoot(); if not root then return end
    local nearest,minD=nil,math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player and plr.Character then
            local r=plr.Character:FindFirstChild("HumanoidRootPart")
            if r then
                local d=(root.Position-r.Position).Magnitude
                if d<minD then minD=d; nearest=r end
            end
        end
    end
    if nearest then
        root.CFrame=CFrame.new(nearest.Position+Vector3.new(0,0,-6))
        N("📍","Zum Stand von "..(nearest.Parent and nearest.Parent.Name or "?"),3)
    else N("❌","Kein Spieler gefunden!",3) end
end})

TabPlayers:CreateButton({ Name="👁️ Spieler Stand-ESP", Callback=function()
    State.ShowESP=not State.ShowESP
    for _,plr in pairs(Players:GetPlayers()) do
        pcall(function()
            if plr~=Player and plr.Character then
                local old=plr.Character:FindFirstChild("CeliDonateESP"); if old then old:Destroy() end
                if State.ShowESP then
                    local h=Instance.new("Highlight",plr.Character); h.Name="CeliDonateESP"
                    h.FillColor=Color3.fromRGB(255,215,0); h.OutlineColor=Color3.new(1,1,1); h.FillTransparency=0.6
                end
            end
        end)
    end
    N("👁️ ESP",State.ShowESP and "AN — Spieler gelb!" or "AUS.",3)
end})

TabPlayers:CreateButton({ Name="💬 Chat: 'Donate bei mir!'", Callback=function()
    pcall(function()
        local rs=game:GetService("ReplicatedStorage")
        local ch=rs:FindFirstChild("DefaultChatSystemChatEvents")
        if ch then local say=ch:FindFirstChild("SayMessageRequest"); if say then say:FireServer("💰 Donate bei "..Cfg.FakeName.."! Goal: R$"..Cfg.FakeGoal.." 🙏","All") end end
    end)
    N("💬","Werbung gesendet!",3)
end})

-- ============================================================
-- 🔧 MISC TAB
-- ============================================================
TabMisc:CreateSection("🔧 Misc")
TabMisc:CreateButton({ Name="💰 Fake Robux Balance anzeigen", Callback=function()
    pcall(function()
        local PlayerGui=Player:WaitForChild("PlayerGui")
        local old=PlayerGui:FindFirstChild("CeliFakeRobux"); if old then old:Destroy(); N("💰","Balance entfernt.",2); return end
        local SGui=Instance.new("ScreenGui",PlayerGui); SGui.Name="CeliFakeRobux"; SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true
        local Frame=Instance.new("Frame",SGui); Frame.Size=UDim2.fromOffset(180,44); Frame.Position=UDim2.new(1,-190,0,6)
        Frame.BackgroundColor3=Color3.fromRGB(15,20,35); Frame.BorderSizePixel=0; Frame.Active=true; Frame.Draggable=true
        Instance.new("UICorner",Frame).CornerRadius=UDim.new(0,10); Instance.new("UIStroke",Frame).Color=Color3.fromRGB(255,215,0)
        local lbl=Instance.new("TextLabel",Frame); lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1
        lbl.Text="💰 R$ "..math.random(10000,99999); lbl.TextColor3=Color3.fromRGB(255,215,0); lbl.Font=Enum.Font.GothamBold; lbl.TextSize=18
        local CloseB=Instance.new("TextButton",Frame); CloseB.Size=UDim2.fromOffset(20,20); CloseB.Position=UDim2.new(1,-22,0,2)
        CloseB.BackgroundColor3=Color3.fromRGB(160,40,40); CloseB.Text="✕"; CloseB.TextColor3=Color3.new(1,1,1); CloseB.Font=Enum.Font.GothamBold; CloseB.TextSize=10; CloseB.BorderSizePixel=0
        Instance.new("UICorner",CloseB).CornerRadius=UDim.new(0,5); CloseB.MouseButton1Click:Connect(function() SGui:Destroy() end)
    end)
    N("💰 Fake Robux","Balance angezeigt! (klick um zu entfernen)",4)
end})

TabMisc:CreateButton({ Name="🌈 Fake Purchase Animation", Callback=function()
    pcall(function()
        local PlayerGui=Player:WaitForChild("PlayerGui")
        local SGui=Instance.new("ScreenGui",PlayerGui); SGui.ResetOnSpawn=false; SGui.IgnoreGuiInset=true
        local Frame=Instance.new("Frame",SGui)
        Frame.Size=UDim2.fromOffset(320,100); Frame.Position=UDim2.new(0.5,-160,0.5,100); Frame.BackgroundColor3=Color3.fromRGB(255,185,0); Frame.BorderSizePixel=0
        Instance.new("UICorner",Frame).CornerRadius=UDim.new(0,16)
        local lbl=Instance.new("TextLabel",Frame); lbl.Size=UDim2.fromScale(1,1); lbl.BackgroundTransparency=1
        lbl.Text="✅ PURCHASE SUCCESSFUL!\n💰 R$ "..Cfg.FakeAmount.." Robux gespendet!"
        lbl.TextColor3=Color3.fromRGB(20,15,5); lbl.Font=Enum.Font.GothamBold; lbl.TextSize=16; lbl.TextWrapped=true
        TweenService:Create(Frame,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0.5,-160,0.5,-50)}):Play()
        task.wait(2.5); TweenService:Create(Frame,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-160,0.5,100),BackgroundTransparency=1}):Play(); task.wait(0.4); SGui:Destroy()
    end)
    N("🌈 Purchase","Animation gespielt!",3)
end})

TabMisc:CreateButton({ Name="🛑 Alles AUS", Callback=function()
    State.AutoCollect=false; State.AutoDonate=false; State.SpamDonate=false; State.AutoTP=false; State.ShowESP=false
    for _,plr in pairs(Players:GetPlayers()) do pcall(function() if plr.Character then local h=plr.Character:FindFirstChild("CeliDonateESP"); if h then h:Destroy() end end end) end
    N("🛑","Alles deaktiviert!",3)
end})

TabMisc:CreateButton({ Name="🔄 Rejoin", Callback=function()
    N("🔄","Rejoining...",2); task.wait(1); pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId,Player) end)
end})

N("💰 Celi PLS DONATE","Tool geladen! Fake Donate, Stand & mehr ✅",6)
