-- ============================================================
-- CeliHub | Hamburg Edition 🏙️
-- Made by Celi 💫
-- ============================================================

-- // Services
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace        = game:GetService("Workspace")
local TeleportService  = game:GetService("TeleportService")
local ReplicatedStorage= game:GetService("ReplicatedStorage")

-- ============================================================
-- // Rayfield
-- ============================================================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ============================================================
-- // Player References
-- ============================================================
local Player    = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid  = Character:WaitForChild("Humanoid")
local RootPart  = Character:WaitForChild("HumanoidRootPart")

Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid  = char:WaitForChild("Humanoid")
    RootPart  = char:WaitForChild("HumanoidRootPart")
end)

-- ============================================================
-- // VARS
-- ============================================================
local SpeedMultiplier   = 1
local FlyEnabled        = false
local NoclipEnabled     = false
local InfiniteJump      = false
local GodMode           = false
local VehicleFlyEnabled = false
local AimbotEnabled     = false
local AimbotConnection  = nil
local AutoEatEnabled    = false
local MinHealth         = 30
local HAMBURG_GROUP_ID  = 0

local Keybinds = {
    Fly           = Enum.KeyCode.X,
    Noclip        = Enum.KeyCode.N,
    SavePos       = Enum.KeyCode.T,
    ReturnPos     = Enum.KeyCode.R,
    EmergencyStop = Enum.KeyCode.F5,
}
local KeybindActions = {}

-- ============================================================
-- // UTILITY
-- ============================================================
local function Notify(title, text, dur)
    Rayfield:Notify({Title=title, Content=tostring(text), Duration=dur or 3})
end

local FlyBV = nil

-- ============================================================
-- // MOVEMENT
-- ============================================================
local function ApplySpeedHack()
    RunService.Heartbeat:Connect(function()
        if not Humanoid or not RootPart then return end
        if Humanoid.MoveDirection.Magnitude > 0 then
            local v = Humanoid.MoveDirection * (16 * SpeedMultiplier)
            RootPart.Velocity = Vector3.new(v.X, RootPart.Velocity.Y, v.Z)
        end
    end)
end

local function SetupInfiniteJump()
    UserInputService.JumpRequest:Connect(function()
        if InfiniteJump and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function ToggleFly()
    FlyEnabled = not FlyEnabled
    if FlyEnabled then
        Notify("✈️ Fly", "Aktiviert! WASD + Space/Shift", 3)
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5,1e5,1e5); bv.Velocity = Vector3.zero
        bv.Parent = RootPart; FlyBV = bv
        RunService.Heartbeat:Connect(function()
            if not FlyEnabled or not FlyBV or not FlyBV.Parent then return end
            local d = Vector3.zero; local cam = Workspace.CurrentCamera
            if UserInputService:IsKeyDown(Enum.KeyCode.W)         then d += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S)         then d -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A)         then d -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D)         then d += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then d += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d -= Vector3.yAxis end
            FlyBV.Velocity = d.Magnitude > 0 and d.Unit * 60 or Vector3.zero
        end)
    else
        if FlyBV and FlyBV.Parent then FlyBV:Destroy() end
        FlyBV = nil; Notify("✈️ Fly", "Deaktiviert.", 2)
    end
end

local function ToggleNoclip()
    NoclipEnabled = not NoclipEnabled
    Notify("👻 NoClip", NoclipEnabled and "Aktiviert!" or "Deaktiviert.", 2)
    if NoclipEnabled then
        RunService.Stepped:Connect(function()
            if not NoclipEnabled or not Character then return end
            for _, p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end)
    else
        if Character then
            for _, p in pairs(Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end
end

local function ToggleGodMode()
    GodMode = not GodMode
    if GodMode then
        Humanoid.MaxHealth=math.huge; Humanoid.Health=math.huge
        Notify("🛡️ God Mode","Aktiviert!",3)
    else
        Humanoid.MaxHealth=100; Humanoid.Health=100
        Notify("🛡️ God Mode","Deaktiviert.",2)
    end
end

local function ToggleRainbow()
    _G.CeliRainbow = not _G.CeliRainbow
    Notify("🌈 Rainbow", _G.CeliRainbow and "On" or "Off", 2)
    if _G.CeliRainbow then
        task.spawn(function()
            local colors = {
                Color3.fromRGB(255,0,0), Color3.fromRGB(255,127,0),
                Color3.fromRGB(255,255,0), Color3.fromRGB(0,255,0),
                Color3.fromRGB(0,0,255), Color3.fromRGB(75,0,130), Color3.fromRGB(148,0,211)
            }
            local i = 1
            while _G.CeliRainbow do
                if Character then
                    for _, p in pairs(Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.Color = colors[i] end
                    end
                end
                i = (i % #colors) + 1; task.wait(0.3)
            end
        end)
    end
end

local function ToggleESP()
    _G.CeliESP = not _G.CeliESP
    Notify("👁️ ESP", _G.CeliESP and "Aktiviert!" or "Deaktiviert.", 2)
    if _G.CeliESP then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                local h = Instance.new("Highlight")
                h.FillColor=Color3.fromRGB(0,255,0); h.OutlineColor=Color3.fromRGB(255,255,255)
                h.Parent=plr.Character
            end
        end
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _, o in pairs(plr.Character:GetChildren()) do
                    if o:IsA("Highlight") then o:Destroy() end
                end
            end
        end
    end
end

local function ToggleNameTags()
    _G.CeliNameTags = not _G.CeliNameTags
    Notify("🏷️ NameTags", _G.CeliNameTags and "Aktiviert!" or "Deaktiviert.", 2)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            if _G.CeliNameTags then
                if plr.Character:FindFirstChild("CeliTag") then continue end
                local gui = Instance.new("BillboardGui", plr.Character)
                gui.Name="CeliTag"; gui.Adornee=plr.Character:FindFirstChild("Head")
                gui.Size=UDim2.new(0,200,0,50); gui.AlwaysOnTop=true
                local l=Instance.new("TextLabel",gui)
                l.BackgroundTransparency=1; l.Size=UDim2.new(1,0,1,0)
                l.Text=plr.Name; l.TextColor3=Color3.new(1,1,1)
                l.TextStrokeTransparency=0; l.Font=Enum.Font.GothamBold; l.TextSize=16
            else
                local t=plr.Character:FindFirstChild("CeliTag")
                if t then t:Destroy() end
            end
        end
    end
end

-- ============================================================
-- // AIMBOT
-- ============================================================
local function GetNearestPlayer()
    local cam=Workspace.CurrentCamera; local nearest=nil; local minDist=math.huge
    local center=Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr~=Player and plr.Character then
            local head=plr.Character:FindFirstChild("Head")
            if head then
                local sp, onScreen=cam:WorldToViewportPoint(head.Position)
                if onScreen then
                    local d=(Vector2.new(sp.X,sp.Y)-center).Magnitude
                    if d<minDist then minDist=d; nearest=plr end
                end
            end
        end
    end
    return nearest
end

-- ============================================================
-- // HAMBURG SPEZIFISCH: Auto Eat
-- ============================================================
local function StartAutoEat()
    task.spawn(function()
        while AutoEatEnabled do
            local ok, hp = pcall(function()
                return Player.Character.Humanoid.Health
            end)
            if ok and hp < MinHealth then
                pcall(function()
                    local ev = ReplicatedStorage:WaitForChild("events-vqp")
                    ev:WaitForChild("4faf9ae9-9bd7-476f-8c36-9a3965c2f9dc"):FireServer("Cookie")
                    task.wait(0.8)
                    local cookie = Player.Character:FindFirstChild("Cookie")
                    if cookie then
                        ev:WaitForChild("c8bc12bd-7a75-40f8-8b12-988efcb4b124"):FireServer(cookie)
                    end
                end)
                task.wait(3)
            else
                task.wait(0.1)
            end
            if not AutoEatEnabled then break end
        end
    end)
end

-- ============================================================
-- // HAMBURG: Fahrzeug Attribute
-- ============================================================
local function GetPlayerVehicle()
    local ok, v = pcall(function()
        return Workspace.Vehicles[Player.Name]
    end)
    return ok and v or nil
end

local function SetVehicleAttr(attr, value)
    local v = GetPlayerVehicle()
    if v then
        v:SetAttribute(attr, value)
        return true
    end
    return false
end

local function SetVehicleColor(color)
    local v = GetPlayerVehicle()
    if v then
        pcall(function() v.Body.Body.Color = color end)
        return true
    end
    return false
end

-- ============================================================
-- // HAMBURG: Waffen Modifikation
-- ============================================================
local function SetWeaponAttr(attr, value)
    local char = Workspace:FindFirstChild(Player.Name)
    if not char then return end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("Tool") then
            v:SetAttribute(attr, value)
        end
    end
end

-- ============================================================
-- // HAMBURG: Gefängnis-Ausbruch
-- ============================================================
local function EscapeJail()
    pcall(function()
        Player.Character.Head:Destroy()
    end)
    Notify("🔓 Escape Jail", "Charakter wird resettet!", 3)
end

-- ============================================================
-- // TELEPORT (Hamburg-Orte)
-- ============================================================
local TeleportLocations = {
    ["🏦 Bank"]          = CFrame.new(-1167.87, 7.87, 3161.57),
    ["💎 Juwelier"]      = CFrame.new(-394.55, 5.52, 3568.09),
    ["⛽ Tankstelle 1"]  = CFrame.new(-1531.95, 5.74, 3769.55),
    ["⛽ Tankstelle 2"]  = CFrame.new(-867.55, 5.04, 1543.24),
    ["🔧 Werkzeug Shop"] = CFrame.new(-746.76, 5.51, 636.71),
    ["🚔 Polizei"]       = CFrame.new(0, 5, 0),
    ["🏥 Krankenhaus"]   = CFrame.new(200, 5, 200),
    ["🚒 Feuerwehr"]     = CFrame.new(-300, 5, 400),
    ["🏠 Spawn"]         = CFrame.new(0, 5, 0),
}

local function TeleportTo(name)
    local cf = TeleportLocations[name]
    if cf and RootPart then RootPart.CFrame = cf; Notify("📍 TP", "➡️ "..name, 2) end
end

local function TeleportToPlayer(name)
    local t=Players:FindFirstChild(name)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
        RootPart.CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(3,0,0)
        Notify("📍 TP", "➡️ Zu "..name, 2)
    else
        Notify("📍 TP", "❌ Spieler nicht gefunden!", 3)
    end
end

local function SavePosition()
    if RootPart then _G.CeliSavedPos=RootPart.CFrame; Notify("📍","Position gespeichert!",2) end
end

local function ReturnToPosition()
    if _G.CeliSavedPos and RootPart then RootPart.CFrame=_G.CeliSavedPos; Notify("📍","Zurück!",2)
    else Notify("📍","❌ Keine Position gespeichert!",3) end
end

-- ============================================================
-- // FAHRZEUG FINDER GUI
-- ============================================================
local VehicleGuiOpen = false

local function FindAllVehicles()
    local vehicles={}; local seen={}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("VehicleSeat") or obj:IsA("Seat") then
            local model=obj:FindFirstAncestorOfClass("Model")
            if model and not seen[model] then
                seen[model]=true
                table.insert(vehicles, {seat=obj, model=model, name=model.Name, pos=obj.Position})
            end
        end
    end
    return vehicles
end

local function FindAndSitNearest()
    Notify("🚗","Suche nächstes Fahrzeug...",2)
    task.wait(0.3)
    local vehicles=FindAllVehicles()
    if #vehicles==0 then Notify("🚗","❌ Keine Fahrzeuge!",3); return end
    local closest, minDist=nil, math.huge
    for _,v in ipairs(vehicles) do
        local d=(RootPart.Position-v.pos).Magnitude
        if d<minDist then minDist=d; closest=v end
    end
    if closest then
        RootPart.CFrame=closest.seat.CFrame+Vector3.new(0,3,0)
        task.wait(0.35); closest.seat:Sit(Humanoid)
        Notify("🚗 Eingesessen",closest.name.."\n("..math.floor(minDist).." Studs)",4)
    end
end

local function OpenVehicleSelector()
    if VehicleGuiOpen then return end
    local vehicles=FindAllVehicles()
    if #vehicles==0 then Notify("🚗","❌ Keine Fahrzeuge gefunden!",3); return end
    VehicleGuiOpen=true
    local cGui=game:GetService("CoreGui")

    local SGui=Instance.new("ScreenGui"); SGui.Name="CeliVehicleSelector"
    SGui.ResetOnSpawn=false; SGui.DisplayOrder=100; SGui.Parent=cGui

    local Overlay=Instance.new("Frame",SGui); Overlay.Size=UDim2.fromScale(1,1)
    Overlay.BackgroundColor3=Color3.fromRGB(0,0,0); Overlay.BackgroundTransparency=0.5
    Overlay.BorderSizePixel=0

    local Win=Instance.new("Frame",Overlay); Win.Size=UDim2.fromOffset(380,420)
    Win.Position=UDim2.fromScale(0.5,0.5); Win.AnchorPoint=Vector2.new(0.5,0.5)
    Win.BackgroundColor3=Color3.fromRGB(15,15,24); Win.BorderSizePixel=0
    Instance.new("UICorner",Win).CornerRadius=UDim.new(0,14)

    local TBar=Instance.new("Frame",Win); TBar.Size=UDim2.new(1,0,0,44)
    TBar.BackgroundColor3=Color3.fromRGB(40,120,220); TBar.BorderSizePixel=0
    Instance.new("UICorner",TBar).CornerRadius=UDim.new(0,14)

    local TLabel=Instance.new("TextLabel",TBar); TLabel.Size=UDim2.new(1,-50,1,0)
    TLabel.Position=UDim2.fromOffset(14,0); TLabel.BackgroundTransparency=1
    TLabel.Text="🚗  Fahrzeuge  ("..#vehicles.." gefunden)"
    TLabel.TextColor3=Color3.fromRGB(255,255,255); TLabel.Font=Enum.Font.GothamBold
    TLabel.TextSize=15; TLabel.TextXAlignment=Enum.TextXAlignment.Left

    local CloseBtn=Instance.new("TextButton",TBar); CloseBtn.Size=UDim2.fromOffset(36,36)
    CloseBtn.Position=UDim2.new(1,-40,0,4); CloseBtn.BackgroundColor3=Color3.fromRGB(30,80,170)
    CloseBtn.Text="✕"; CloseBtn.TextColor3=Color3.fromRGB(255,255,255)
    CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.TextSize=16; CloseBtn.BorderSizePixel=0
    Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,8)
    CloseBtn.MouseButton1Click:Connect(function() SGui:Destroy(); VehicleGuiOpen=false end)

    local Scroll=Instance.new("ScrollingFrame",Win); Scroll.Size=UDim2.new(1,-16,1,-54)
    Scroll.Position=UDim2.fromOffset(8,50); Scroll.BackgroundTransparency=1
    Scroll.BorderSizePixel=0; Scroll.ScrollBarThickness=4
    Scroll.ScrollBarImageColor3=Color3.fromRGB(40,120,220)

    local Layout=Instance.new("UIListLayout",Scroll); Layout.Padding=UDim.new(0,6)
    Layout.SortOrder=Enum.SortOrder.LayoutOrder
    local Pad=Instance.new("UIPadding",Scroll); Pad.PaddingTop=UDim.new(0,4)
    Pad.PaddingLeft=UDim.new(0,4); Pad.PaddingRight=UDim.new(0,4)

    table.sort(vehicles,function(a,b)
        return (RootPart.Position-a.pos).Magnitude < (RootPart.Position-b.pos).Magnitude
    end)

    for idx,v in ipairs(vehicles) do
        local dist=math.floor((RootPart.Position-v.pos).Magnitude)
        local Row=Instance.new("Frame",Scroll); Row.Size=UDim2.new(1,0,0,60)
        Row.BackgroundColor3=Color3.fromRGB(22,22,34); Row.BorderSizePixel=0; Row.LayoutOrder=idx
        Instance.new("UICorner",Row).CornerRadius=UDim.new(0,8)

        local NL=Instance.new("TextLabel",Row); NL.Size=UDim2.new(1,-140,0,26)
        NL.Position=UDim2.fromOffset(10,6); NL.BackgroundTransparency=1
        NL.Text="🚗  "..v.name; NL.TextColor3=Color3.fromRGB(220,220,220)
        NL.Font=Enum.Font.GothamBold; NL.TextSize=13
        NL.TextXAlignment=Enum.TextXAlignment.Left; NL.TextTruncate=Enum.TextTruncate.AtEnd

        local DL=Instance.new("TextLabel",Row); DL.Size=UDim2.new(1,-140,0,20)
        DL.Position=UDim2.fromOffset(10,32); DL.BackgroundTransparency=1
        DL.Text="📏 "..dist.." Studs"; DL.TextColor3=Color3.fromRGB(130,130,160)
        DL.Font=Enum.Font.Gotham; DL.TextSize=11; DL.TextXAlignment=Enum.TextXAlignment.Left

        local TPB=Instance.new("TextButton",Row); TPB.Size=UDim2.fromOffset(60,36)
        TPB.Position=UDim2.new(1,-132,0,12); TPB.BackgroundColor3=Color3.fromRGB(40,120,220)
        TPB.Text="📍 TP"; TPB.TextColor3=Color3.fromRGB(255,255,255)
        TPB.Font=Enum.Font.GothamBold; TPB.TextSize=12; TPB.BorderSizePixel=0
        Instance.new("UICorner",TPB).CornerRadius=UDim.new(0,7)

        local vR=v
        TPB.MouseButton1Click:Connect(function()
            RootPart.CFrame=vR.seat.CFrame+Vector3.new(0,4,0); Notify("📍","Zu "..vR.name,2)
        end)

        local SB=Instance.new("TextButton",Row); SB.Size=UDim2.fromOffset(64,36)
        SB.Position=UDim2.new(1,-66,0,12); SB.BackgroundColor3=Color3.fromRGB(40,120,220)
        SB.Text="🚗 Rein"; SB.TextColor3=Color3.fromRGB(255,255,255)
        SB.Font=Enum.Font.GothamBold; SB.TextSize=12; SB.BorderSizePixel=0
        Instance.new("UICorner",SB).CornerRadius=UDim.new(0,7)

        SB.MouseButton1Click:Connect(function()
            RootPart.CFrame=vR.seat.CFrame+Vector3.new(0,3,0); task.wait(0.3)
            vR.seat:Sit(Humanoid); Notify("🚗","Eingesessen: "..vR.name,3)
            SGui:Destroy(); VehicleGuiOpen=false
        end)
    end

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize=UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y+12)
    end)
    Scroll.CanvasSize=UDim2.new(0,0,0,#vehicles*66+12)
end

local function VehicleFling()
    if Humanoid and Humanoid.SeatPart then
        local model=Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
        if model then
            local p=model.PrimaryPart or Humanoid.SeatPart
            p.Velocity=Vector3.new(0,600,0)
            Notify("💥 Fling","Fahrzeug geflingt!",3); return
        end
    end
    Notify("💥 Fling","❌ Du sitzt in keinem Fahrzeug!",3)
end

local function ToggleVehicleFly()
    VehicleFlyEnabled=not VehicleFlyEnabled
    Notify("✈️ Vehicle Fly",VehicleFlyEnabled and "Aktiviert" or "Deaktiviert",2)
    if VehicleFlyEnabled then
        local seatPart = Humanoid and Humanoid.SeatPart
        if not seatPart then
            Notify("✈️","❌ Du sitzt in keinem Fahrzeug!",3); VehicleFlyEnabled=false; return
        end
        local bv=Instance.new("BodyVelocity",seatPart); bv.MaxForce=Vector3.new(1e5,1e5,1e5); bv.Velocity=Vector3.zero
        RunService.Heartbeat:Connect(function()
            if not VehicleFlyEnabled or not bv.Parent then pcall(function() bv:Destroy() end); return end
            local cam=Workspace.CurrentCamera; local d=Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W)         then d+=cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S)         then d-=cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then d+=Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d-=Vector3.yAxis end
            bv.Velocity=d.Magnitude>0 and d.Unit*120 or Vector3.zero
        end)
    end
end

-- ============================================================
-- // ADMIN CHECKER
-- ============================================================
local function IsInVehicle(plr)
    if not plr.Character then return false end
    local hum=plr.Character:FindFirstChild("Humanoid")
    return hum and hum.SeatPart~=nil
end

local function IsInAirVehicle(plr)
    if not plr.Character then return false end
    local hum=plr.Character:FindFirstChild("Humanoid")
    if hum and hum.SeatPart then
        local model=hum.SeatPart:FindFirstAncestorOfClass("Model")
        if model then
            local n=model.Name:lower()
            if n:find("heli") or n:find("helicopter") or n:find("plane") or
               n:find("flugzeug") or n:find("aircraft") or n:find("jet") then return true end
        end
    end
    return false
end

local function IsPlayerFlying(plr)
    if not plr.Character then return false end
    if IsInAirVehicle(plr) or IsInVehicle(plr) then return false end
    local root=plr.Character:FindFirstChild("HumanoidRootPart"); if not root then return false end
    for _,obj in pairs(root:GetChildren()) do
        if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") or obj:IsA("BodyPosition") then return true end
    end
    local params=RaycastParams.new(); params.FilterDescendantsInstances={plr.Character}
    params.FilterType=Enum.RaycastFilterType.Exclude
    local hit=Workspace:Raycast(root.Position,Vector3.new(0,-60,0),params)
    return (not hit and math.abs(root.Velocity.Y)<2)
end

local function IsPlayerSpeedHacking(plr)
    if not plr.Character or IsInVehicle(plr) then return false, 0 end
    local root=plr.Character:FindFirstChild("HumanoidRootPart"); if not root then return false, 0 end
    local spd=Vector3.new(root.Velocity.X,0,root.Velocity.Z).Magnitude
    return spd>50, math.floor(spd)
end

local function HasAdminIndicator(plr)
    local kws={"admin","mod","staff","owner","dev","manager","co-owner","support","helper","leiter","sl"}
    local function chk(s)
        s=s:lower()
        for _,kw in ipairs(kws) do if s:find(kw) then return true,kw end end
        return false,nil
    end
    local o,k=chk(plr.Name); if o then return true,k end
    local o2,k2=chk(plr.DisplayName); if o2 then return true,k2 end
    if plr.Character then
        for _,obj in pairs(plr.Character:GetDescendants()) do
            if obj:IsA("TextLabel") then local o3,k3=chk(obj.Text); if o3 then return true,k3 end end
        end
    end
    return false,nil
end

local function GetGroupRank(plr)
    if HAMBURG_GROUP_ID==0 then return 0,"Keine Group-ID" end
    local ok,rank=pcall(function() return plr:GetRankInGroup(HAMBURG_GROUP_ID) end)
    if ok and rank>0 then
        local ok2,role=pcall(function() return plr:GetRoleInGroup(HAMBURG_GROUP_ID) end)
        return rank, ok2 and role or ("Rang "..rank)
    end
    return 0,"Kein Mitglied"
end

local function CheckAdmins()
    Notify("🛡️ Admin Check","Scanne Spieler...",3); task.wait(0.8)
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=Player then
            local lines,sus={},false
            if IsInVehicle(plr) then table.insert(lines, IsInAirVehicle(plr) and "🚁 Im Luft-Fzg" or "🚗 Im Fahrzeug") end
            if IsPlayerFlying(plr) then table.insert(lines,"✈️ FLIEGT (Hack)"); sus=true end
            local sp,spd=IsPlayerSpeedHacking(plr); if sp then table.insert(lines,"⚡ SPEED("..spd..")"); sus=true end
            local ht,htk=HasAdminIndicator(plr); if ht then table.insert(lines,"🏷️ Admin-Name: '"..htk.."'"); sus=true end
            local rank,role=GetGroupRank(plr)
            if rank>0 then table.insert(lines,"🛡️ "..role.." ("..rank..")"); if rank>=50 then sus=true end end
            if plr.AccountAge<30 then table.insert(lines,"⚠️ Neu: "..plr.AccountAge.." Tage") end
            if #lines==0 then table.insert(lines,"Nichts Auffälliges.") end
            Notify((sus and "🚨 " or "✅ ")..plr.Name, table.concat(lines,"\n"), 7); task.wait(0.5)
        end
    end
    Notify("✅ Scan","Admin Check fertig!",3)
end

-- ============================================================
-- // SERVER INFO
-- ============================================================
local function CheckServerInfo()
    local isP=game.PrivateServerId~=nil and game.PrivateServerId~=""
    local lines={
        isP and "🔒 Privater Server" or "🌐 Öffentlicher Server",
        "🎮 PlaceId: "..tostring(game.PlaceId),
        "🆔 JobId: "..tostring(game.JobId):sub(1,16).."...",
        "👥 Spieler: "..#Players:GetPlayers().." online"
    }
    local cId=game.CreatorId
    if game.CreatorType==Enum.CreatorType.User then
        local ok,n=pcall(function() return Players:GetNameFromUserIdAsync(cId) end)
        table.insert(lines,"👤 Creator: "..(ok and n or tostring(cId)))
    else
        table.insert(lines,"👥 Gruppen-Spiel ("..cId..")")
    end
    if isP and game.PrivateServerOwnerId and game.PrivateServerOwnerId~=0 then
        local ok,n=pcall(function() return Players:GetNameFromUserIdAsync(game.PrivateServerOwnerId) end)
        table.insert(lines,"🔑 PS-Owner: "..(ok and n or "Unbekannt"))
    end
    for _,l in ipairs(lines) do Notify("🌐 Server Info",l,5); task.wait(0.35) end
end

-- ============================================================
-- // NOTFALL
-- ============================================================
local function DeactivateAll()
    if FlyEnabled then ToggleFly() end
    NoclipEnabled=false; _G.CeliRainbow=false; GodMode=false; VehicleFlyEnabled=false
    AimbotEnabled=false; AutoEatEnabled=false
    if AimbotConnection then AimbotConnection:Disconnect(); AimbotConnection=nil end
    if Humanoid then Humanoid.MaxHealth=100; Humanoid.Health=100 end
    if RootPart then
        for _,v in pairs(RootPart:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
        end
    end
    if Character then
        for _,p in pairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=true end
        end
    end
    SpeedMultiplier=1
    Notify("🛑 NOTFALL","Alle Hacks deaktiviert!",4)
end

-- ============================================================
-- // UI WINDOW
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name            = "CeliHub | Hamburg Edition 🏙️",
    LoadingTitle    = "CeliHub",
    LoadingSubtitle = "Made by Celi 💫",
    ConfigurationSaving = {Enabled=true, FolderName="CeliHubHamburg"}
})

local MainTab      = Window:CreateTab("📊 Main",         4483362458)
local MovementTab  = Window:CreateTab("🚀 Movement",     4483362458)
local CombatTab    = Window:CreateTab("🎯 Combat",       4483362458)
local PlayerTab    = Window:CreateTab("🧍 Player Mods",  4483362458)
local WeaponTab    = Window:CreateTab("🔫 Waffen",       4483362458)
local VisualsTab   = Window:CreateTab("👁️ Visuals/ESP",  4483362458)
local VehicleTab   = Window:CreateTab("🚗 Fahrzeuge",    4483362458)
local TeleportTab  = Window:CreateTab("📍 Teleport",     4483362458)
local AdminTab     = Window:CreateTab("🛡️ Admin Check",  4483362458)
local ServerTab    = Window:CreateTab("🌐 Server Info",  4483362458)
local EmergencyTab = Window:CreateTab("🚨 Notfall",      4483362458)
local KeybindTab   = Window:CreateTab("⌨️ Keybinds",     4483362458)

-- ============================================================
-- MAIN TAB
-- ============================================================
MainTab:CreateSection("👤 Spieler Info")
MainTab:CreateParagraph({
    Title   = "Spieler",
    Content = "Name: "..Player.Name.."\nAnzeigename: "..Player.DisplayName.."\nUserId: "..Player.UserId
})
MainTab:CreateSection("🎮 Spiel Info")
MainTab:CreateParagraph({
    Title   = "Emergency Hamburg",
    Content = "PlaceId: "..tostring(game.PlaceId).."\nServer: "..tostring(game.JobId):sub(1,16).."..."
})

-- ============================================================
-- MOVEMENT
-- ============================================================
MovementTab:CreateSlider({
    Name="⚡ Speed Multiplier", Range={1,20}, Increment=0.5, CurrentValue=1,
    Callback=function(v) SpeedMultiplier=v end
})
MovementTab:CreateButton({Name="✈️ Toggle Fly",    Callback=ToggleFly})
MovementTab:CreateButton({Name="👻 Toggle NoClip", Callback=ToggleNoclip})

-- ============================================================
-- COMBAT
-- ============================================================
CombatTab:CreateSection("🎯 Aimbot")
CombatTab:CreateToggle({
    Name="🎯 Aimbot", CurrentValue=false,
    Callback=function(v)
        AimbotEnabled=v
        if v then
            if AimbotConnection then AimbotConnection:Disconnect() end
            AimbotConnection=RunService.RenderStepped:Connect(function()
                if not AimbotEnabled then return end
                local t=GetNearestPlayer()
                if t and t.Character then
                    local head=t.Character:FindFirstChild("Head")
                    if head then
                        Workspace.CurrentCamera.CFrame=CFrame.new(Workspace.CurrentCamera.CFrame.Position,head.Position)
                    end
                end
            end)
            Notify("🎯 Aimbot","Aktiviert!",3)
        else
            if AimbotConnection then AimbotConnection:Disconnect(); AimbotConnection=nil end
            Notify("🎯 Aimbot","Deaktiviert.",2)
        end
    end
})
CombatTab:CreateSection("💀 Weitere Optionen")
CombatTab:CreateButton({
    Name="🔍 Nächsten Spieler anzeigen",
    Callback=function()
        local t=GetNearestPlayer()
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            local d=math.floor((RootPart.Position-t.Character.HumanoidRootPart.Position).Magnitude)
            Notify("🔍 Nächster",t.Name.."\n📏 "..d.." Studs",5)
        else Notify("🔍","Keine Spieler in Sicht!",3) end
    end
})
CombatTab:CreateButton({
    Name="📍 Zum nächsten Spieler TP",
    Callback=function()
        local t=GetNearestPlayer()
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
            RootPart.CFrame=t.Character.HumanoidRootPart.CFrame+Vector3.new(3,0,0)
            Notify("📍","Zu "..t.Name,2)
        end
    end
})

-- ============================================================
-- PLAYER MODS
-- ============================================================
PlayerTab:CreateSection("🏃 Grundlegendes")
PlayerTab:CreateToggle({Name="∞ Infinite Jump", CurrentValue=false, Callback=function(v) InfiniteJump=v end})
PlayerTab:CreateToggle({Name="🛡️ God Mode", CurrentValue=false, Callback=function(v)
    GodMode=v
    if v then Humanoid.MaxHealth=math.huge; Humanoid.Health=math.huge
    else Humanoid.MaxHealth=100; Humanoid.Health=100 end
    Notify("🛡️ God Mode",v and "Aktiviert!" or "Deaktiviert.",2)
end})
PlayerTab:CreateToggle({Name="🌈 Rainbow", CurrentValue=false, Callback=function(v)
    _G.CeliRainbow=v; if v then ToggleRainbow() end
end})

PlayerTab:CreateSection("🍪 Auto Eat (Cookie bei niedriger HP)")
PlayerTab:CreateSlider({
    Name="Mindest-HP", Range={1,100}, Increment=1, CurrentValue=30,
    Callback=function(v) MinHealth=v end
})
PlayerTab:CreateToggle({
    Name="🍪 Auto Eat aktivieren", CurrentValue=false,
    Callback=function(v)
        AutoEatEnabled=v
        if v then StartAutoEat(); Notify("🍪 Auto Eat","Aktiviert! Mindest-HP: "..MinHealth,3)
        else Notify("🍪 Auto Eat","Deaktiviert.",2) end
    end
})

PlayerTab:CreateSection("🔓 Sonstiges")
PlayerTab:CreateButton({Name="🔓 Gefängnis-Ausbruch (Charakter reset)", Callback=EscapeJail})
PlayerTab:CreateButton({
    Name="🏃 Charakter respawnen",
    Callback=function() Player:LoadCharacter(); Notify("🔁","Respawned!",2) end
})
PlayerTab:CreateButton({
    Name="🌍 Charakter zu Boden setzen",
    Callback=function()
        if RootPart then
            local p=RaycastParams.new(); p.FilterDescendantsInstances={Character}
            p.FilterType=Enum.RaycastFilterType.Exclude
            local r=Workspace:Raycast(RootPart.Position,Vector3.new(0,-200,0),p)
            if r then RootPart.CFrame=CFrame.new(r.Position+Vector3.new(0,3,0)); Notify("✅","Auf Boden gesetzt!",2) end
        end
    end
})

-- ============================================================
-- WAFFEN MOD
-- ============================================================
WeaponTab:CreateSection("🔫 Waffen Modifikation")
WeaponTab:CreateLabel("Halte die Waffe, die du modifizieren willst!")
WeaponTab:CreateSlider({
    Name="⏱️ Aim Delay", Range={0,100}, Increment=1, CurrentValue=50,
    Callback=function(v) SetWeaponAttr("AimDelay", v/100) end
})
WeaponTab:CreateSlider({
    Name="🔭 Aim FOV", Range={50,120}, Increment=1, CurrentValue=70,
    Callback=function(v) SetWeaponAttr("AimFieldOfView", v) end
})
WeaponTab:CreateSlider({
    Name="📦 Magazin Größe", Range={1,999}, Increment=1, CurrentValue=30,
    Callback=function(v) SetWeaponAttr("MagMaxSize",v); SetWeaponAttr("MagCurrentSize",v) end
})
WeaponTab:CreateSlider({
    Name="⏱️ Nachladezeit", Range={0,300}, Increment=1, CurrentValue=230,
    Callback=function(v) SetWeaponAttr("ReloadTime", v/100) end
})
WeaponTab:CreateSlider({
    Name="⚡ Schuss Delay", Range={0,100}, Increment=1, CurrentValue=50,
    Callback=function(v) SetWeaponAttr("ShootDelay", v/100) end
})

-- ============================================================
-- VISUALS
-- ============================================================
VisualsTab:CreateButton({Name="👁️ Toggle ESP (Highlight)",    Callback=ToggleESP})
VisualsTab:CreateButton({Name="🏷️ Toggle NameTags",           Callback=ToggleNameTags})

-- ============================================================
-- FAHRZEUGE
-- ============================================================
VehicleTab:CreateSection("🗂️ Fahrzeug Finder")
VehicleTab:CreateButton({Name="🗂️ Alle Fahrzeuge anzeigen & auswählen",        Callback=OpenVehicleSelector})
VehicleTab:CreateButton({Name="🔍 Nächstes Fahrzeug — automatisch einsetzen",  Callback=FindAndSitNearest})

VehicleTab:CreateSection("🛠️ Fahrzeug Hacks")
VehicleTab:CreateButton({Name="✈️ Vehicle Fly (Sitz im Fahrzeug!)",  Callback=ToggleVehicleFly})
VehicleTab:CreateButton({Name="💥 Vehicle Fling",                    Callback=VehicleFling})

VehicleTab:CreateSection("⚙️ Fahrzeug Attribute (Hamburg-Spezifisch)")
VehicleTab:CreateToggle({
    Name="♾️ Car God Mode / Inf Fuel", CurrentValue=false,
    Callback=function(v)
        if not SetVehicleAttr("IsOn", v) then Notify("❌","Kein Fahrzeug mit deinem Namen gefunden!",3) end
    end
})
VehicleTab:CreateToggle({
    Name="🔗 Towable (Abschleppbar)", CurrentValue=true,
    Callback=function(v) SetVehicleAttr("Towable", v) end
})
VehicleTab:CreateSlider({
    Name="🏎️ Max Speed", Range={1,400}, Increment=1, CurrentValue=100,
    Callback=function(v) SetVehicleAttr("MaxSpeed", v) end
})
VehicleTab:CreateSlider({
    Name="🔁 Rückwärts Max Speed", Range={1,200}, Increment=1, CurrentValue=40,
    Callback=function(v) SetVehicleAttr("ReverseMaxSpeed", v) end
})
VehicleTab:CreateSlider({
    Name="⚡ Beschleunigungs-Force", Range={1,1000}, Increment=1, CurrentValue=100,
    Callback=function(v)
        SetVehicleAttr("MaxAccelerateForce", v)
        SetVehicleAttr("MinAccelerateForce", v)
    end
})
VehicleTab:CreateSlider({
    Name="🛑 Brems-Force", Range={1,1000}, Increment=1, CurrentValue=100,
    Callback=function(v)
        SetVehicleAttr("MaxBrakeForce", v)
        SetVehicleAttr("MinBrakeForce", v)
    end
})

-- ============================================================
-- TELEPORT
-- ============================================================
TeleportTab:CreateSection("📍 Hamburg Orte")
for name, _ in pairs(TeleportLocations) do
    local n=name
    TeleportTab:CreateButton({Name="➡️ "..n, Callback=function() TeleportTo(n) end})
end
TeleportTab:CreateSection("💾 Position")
TeleportTab:CreateButton({Name="📍 Position speichern",         Callback=SavePosition})
TeleportTab:CreateButton({Name="🔙 Zur gespeicherten Position", Callback=ReturnToPosition})
TeleportTab:CreateSection("👥 Zu Spieler")
TeleportTab:CreateInput({
    Name="Spielername", PlaceholderText="z.B. Player123",
    RemoveTextAfterFocusLost=false,
    Callback=function(t) if t~="" then TeleportToPlayer(t) end end
})
TeleportTab:CreateButton({
    Name="📋 Spielerliste",
    Callback=function()
        local l={}
        for _,p in pairs(Players:GetPlayers()) do if p~=Player then table.insert(l,p.Name) end end
        Notify("👥 Online", #l>0 and table.concat(l,", ") or "Niemand sonst!",5)
    end
})

-- ============================================================
-- ADMIN CHECKER
-- ============================================================
AdminTab:CreateSection("🔍 Analyse")
AdminTab:CreateButton({Name="🛡️ Vollen Admin Check starten", Callback=CheckAdmins})
AdminTab:CreateButton({
    Name="✈️ Fly/Speed Check",
    Callback=function()
        local found=false
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player then
                local fl=IsPlayerFlying(plr); local sp,spd=IsPlayerSpeedHacking(plr)
                if fl or sp then
                    found=true
                    Notify("🚨 "..plr.Name,(fl and "✈️ FLIEGT\n" or "")..(sp and "⚡ SPEED: "..spd or ""),6)
                end
            end
        end
        if not found then Notify("✅","Niemand auffällig!",3) end
    end
})
AdminTab:CreateButton({
    Name="⚠️ Neue Accounts (< 30 Tage)",
    Callback=function()
        local found=false
        for _,plr in pairs(Players:GetPlayers()) do
            if plr~=Player and plr.AccountAge<30 then
                Notify("⚠️",plr.Name.." ("..plr.AccountAge.." Tage)",5); found=true
            end
        end
        if not found then Notify("✅","Keine neuen Accounts!",3) end
    end
})
AdminTab:CreateSection("⚙️ Einstellungen")
AdminTab:CreateInput({
    Name="Hamburg Group-ID", PlaceholderText="Gruppen-ID eingeben",
    RemoveTextAfterFocusLost=false,
    Callback=function(t)
        local id=tonumber(t)
        if id then HAMBURG_GROUP_ID=id; Notify("Group-ID","✅ Gesetzt: "..id,3)
        else Notify("❌","Ungültige Zahl!",3) end
    end
})

-- ============================================================
-- SERVER INFO
-- ============================================================
ServerTab:CreateButton({Name="🌐 Server Info anzeigen",  Callback=CheckServerInfo})
ServerTab:CreateButton({
    Name="👥 Alle Spieler + Details",
    Callback=function()
        for _,plr in pairs(Players:GetPlayers()) do
            local rank,role=GetGroupRank(plr)
            local rs=rank>0 and (" | 🛡️ "..role) or ""
            Notify("👤 "..plr.Name,"Konto: "..plr.AccountAge.." Tage"..rs,5); task.wait(0.35)
        end
    end
})

-- ============================================================
-- NOTFALL
-- ============================================================
EmergencyTab:CreateSection("⚡ Sofort")
EmergencyTab:CreateButton({Name="🛑 ALLE HACKS DEAKTIVIEREN", Callback=DeactivateAll})
EmergencyTab:CreateSection("🚪 Verbindung")
EmergencyTab:CreateButton({Name="🔄 Rejoin (öffentlich)", Callback=function()
    Notify("🔄","Rejoining...",2); task.wait(1); TeleportService:Teleport(game.PlaceId, Player)
end})
EmergencyTab:CreateButton({Name="🔒 Rejoin (privater Server)", Callback=function()
    local pid=game.PrivateServerId
    if pid and pid~="" then
        Notify("🔒","Rejoining PS...",2); task.wait(1)
        TeleportService:TeleportToPrivateServer(game.PlaceId, pid, {Player})
    else Notify("❌","Kein privater Server!",3) end
end})
EmergencyTab:CreateButton({Name="🚪 Spiel verlassen", Callback=function()
    Notify("🚪","Verlasse...",2); task.wait(1); game:Shutdown()
end})

-- ============================================================
-- KEYBINDS
-- ============================================================
KeybindActions = {
    Fly           = ToggleFly,
    Noclip        = ToggleNoclip,
    SavePos       = SavePosition,
    ReturnPos     = ReturnToPosition,
    EmergencyStop = DeactivateAll,
}

local KeybindLabels = {
    Fly           = "✈️ Fly togglen",
    Noclip        = "👻 NoClip togglen",
    SavePos       = "📍 Position speichern",
    ReturnPos     = "🔙 Zur Position zurück",
    EmergencyStop = "🛑 Alle Hacks OFF",
}

local KeybindDefaults = {
    Fly="X", Noclip="N", SavePos="T", ReturnPos="R", EmergencyStop="F5"
}

KeybindTab:CreateSection("⌨️ Tasten anpassen")
for bk, label in pairs(KeybindLabels) do
    local k=bk
    KeybindTab:CreateKeybind({
        Name=label, CurrentKeybind=KeybindDefaults[k], HoldToInteract=false,
        Callback=function(newKey)
            local ok,kc=pcall(function() return Enum.KeyCode[newKey] end)
            if ok and kc then Keybinds[k]=kc; Notify("⌨️",label.."\n→ "..newKey,3) end
        end
    })
end

-- ============================================================
-- // INPUT HANDLER
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    for action, bound in pairs(Keybinds) do
        if input.KeyCode==bound and KeybindActions[action] then
            KeybindActions[action]()
        end
    end
end)

-- ============================================================
-- // INIT
-- ============================================================
ApplySpeedHack()
SetupInfiniteJump()

Notify("🏙️ CeliHub","Hamburg Edition geladen!\nKey: ✅  Viel Spaß!",5)
