if not game:IsLoaded() then game.Loaded:Wait() end
repeat task.wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.PlayerGui
if not cloneref then cloneref = function(a) return a end end
local task = task
local debug = debug
local Ray = Ray
local math = math
local Drawing = Drawing
local Vector2 = Vector2
local Vector3 = Vector3
local Color3 = Color3
local CFrame = CFrame
local UDim = UDim
local UDim2 = UDim2
local ColorSequence = ColorSequence
local Instance = Instance
local setmetatable = setmetatable
local getgenv = getgenv
local xpcall = xpcall
local pcall = pcall
local pairs = pairs
local require = require
local hookmetamethod = hookmetamethod
local hookfunction = hookfunction
local setfpscap = setfpscap
local setconstant = debug and debug.setconstant
local getupvalue = debug and debug.getupvalue
local task_wait = task and task.wait
local task_spawn = task and task.spawn
local loadstring = loadstring
local RayNew = Ray and Ray.new
local MathRandom = math and math.random
local MathSqrt = math and math.sqrt
local MathRad = math and math.rad
local MathClamp = math.clamp
local MathFloor = math.floor
local DrawingNew = Drawing and Drawing.new
local Vector2New = Vector2 and Vector2.new
local Vector3New = Vector3 and Vector3.new
local Color3RGB = Color3 and Color3.fromRGB
local Color3FromHSV = Color3 and Color3.fromHSV
local Color3fromHex = Color3 and Color3.fromHex
local CFrameNew = CFrame and CFrame.new
local CFrameAngles = CFrame and CFrame.Angles
local CFrameLookAt = CFrame and CFrame.lookAt
local UDim2New = UDim2 and UDim2.new
local UDim2fromOffset = UDim2 and UDim2.fromOffset
local UDimNew = UDim and UDim.new
local InstanceNew = Instance and Instance.new
local Service = setmetatable({},{__index = function(_, name) return cloneref(game:GetService(name)) end})
local c = getgenv
if c().PIGHUB_LOADED then return end; c().PIGHUB_LOADED = true
local Players = Service.Players
local UserInputService = Service.UserInputService
local ReplicatedStorage = Service.ReplicatedStorage
local GuiService = Service.GuiService
local VirtualInputManager = Service.VirtualInputManager
local Lighting = Service.Lighting
local RunService = Service.RunService
local Debris = Service.Debris
local TeleportService = Service.TeleportService
local HttpService = Service.HttpService
local TweenService = Service.TweenService
local Client = Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")
local CONFIG_FOLDER = "PigHub/" .. game.PlaceId .. "/"
local CONFIG_FILE = CONFIG_FOLDER .. "settings.json"
local UI_STATE_FILE = CONFIG_FOLDER .. "ui_state.json"
if not isfolder("PigHub") then makefolder("PigHub") end
if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
local function saveConfig()
    local configData = {}
    for k, v in pairs(c()) do
        if type(v) ~= "function" and type(v) ~= "table" and k ~= "PIGHUB_LOADED" and k ~= "ACBYPASS" and k ~= "AimTarget" then
            configData[k] = v
        end
    end
    pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(configData)) end)
end
local function loadConfig()
    if not isfile(CONFIG_FILE) then return false end
    local success, data = pcall(function() return HttpService:JSONDecode(readfile(CONFIG_FILE)) end)
    if not success or type(data) ~= "table" then return false end
    for k, v in pairs(data) do
        c()[k] = v
    end
    return true
end
local function saveUIState()
    local uiState = {
        AimAssist = c().AimAssist or false,
        EnemyGlow = c().EnemyGlow or false,
        NameESP = c().NameESP or false,
        DistESP = c().DistESP or false,
        BarESP = c().BarESP or false,
        InvESP = c().InvESP or false,
        ItemESP = c().ItemESP or false,
        SpeedCustom = c().SpeedCustom or false,
        JumpCustom = c().JumpCustom or false,
        Snap = c().Snap or false,
        ItemDroppedGraber = c().ItemDroppedGraber or false,
        InfStamina = c().InfStamina or false,
        AutoRespawn = c().AutoRespawn or false,
        HideName = c().HideName or false,
        AntiRagdoll = c().AntiRagdoll or false,
        AntiDied = c().AntiDied or false,
        AntiAim = c().AntiAim or false,
        AutoHeal = c().AutoHeal or false,
        SpeedBostVehicle = c().SpeedBostVehicle or false,
        Wallbang = c().Wallbang or false,
        MultiShot = c().MultiShot or false,
        FriendIgnore = c().FriendIgnore or false,
        RainbowPov = c().RainbowPov or false,
        AutomaticGun = c().AutomaticGun or false,
        Desync = c().Desync or false,
        BlacklistItem = c().BlacklistItem or false,
        PovSize = c().PovSize or 150,
        SpeedValue = c().SpeedValue or 1,
        JumpValue = c().JumpValue or 10,
        SnapAmount = c().SnapAmount or 10,
        GrabRadius = c().GrabRadius or 45,
        HealThreshold = c().HealThreshold or 50,
        VehicleSpeedBost = c().VehicleSpeedBost or 20,
        AimPart = c().AimPart or "Head",
        FOVMode = c().FOVMode or "Center",
        FireRateGun = c().FireRateGun or 1000,
        RecoilGun = c().RecoilGun or 0.3,
        AccuracyGun = c().AccuracyGun or 1,
        DurabilityGun = c().DurabilityGun or 1000,
        AmmoCrate = c().AmmoCrate or "Pistol",
        GunCrate = c().GunCrate or "Basic",
        CarCrate = c().CarCrate or "Basic",
        BlacklistRarity = c().BlacklistRarity or {},
        ConfigName = c().ConfigName or "",
        FriendJobId = c().FriendJobId or "",
        SitHeight = c().SitHeight or -1,
        HeadSnapAll = c().HeadSnapAll or false,
        SnapZone = c().SnapZone or 20,
        FOVThickness = c().FOVThickness or 0.3,
        AutoDoorLock = c().AutoDoorLock or false,
    }
    pcall(function() writefile(UI_STATE_FILE, HttpService:JSONEncode(uiState)) end)
end
local function loadUIState()
    if not isfile(UI_STATE_FILE) then return false end
    local success, data = pcall(function() return HttpService:JSONDecode(readfile(UI_STATE_FILE)) end)
    if not success or type(data) ~= "table" then return false end
    for k, v in pairs(data) do
        c()[k] = v
    end
    return true
end
if not c().ACBYPASS then
    task_spawn(xpcall,function()
        repeat task_wait(2)
            if PlayerGui:FindFirstChild('SplashScreenGui') and not Client:GetAttribute('InMenuCharacterCreator') and not PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder').Visible then
                GuiService.SelectedObject = PlayerGui:FindFirstChild('SplashScreenGui').Frame.PlayButton
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            elseif not PlayerGui:FindFirstChild('SplashScreenGui') and Client:GetAttribute('InMenuCharacterCreator') then
                GuiService.SelectedObject = PlayerGui:FindFirstChild('CharacterCreator'):FindFirstChild('MenuFrame').AvatarMenuSkipButton
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            elseif PlayerGui:FindFirstChild('SplashScreenGui') and not Client:GetAttribute('InMenuCharacterCreator') and PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder').Visible then
                GuiService.SelectedObject = PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder'):FindFirstChild('SlideshowCloseButton')
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            elseif not PlayerGui:FindFirstChild('SplashScreenGui') and not Client:GetAttribute('InMenuCharacterCreator') and not PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder').Visible then
                local Net = require(ReplicatedStorage.Modules.Core.Net)
                local func = getupvalue(Net.get,2)
                setconstant(func,3,"___Bypass")
                setconstant(func,4,"___Bypass")
                GuiService.SelectedObject = nil
                c().ACBYPASS = true
            end
        until c().ACBYPASS
    end,warn)
end
repeat task_wait() until c().ACBYPASS
local configLoaded = loadConfig()
local uiLoaded = loadUIState()
repeat task_wait(0.5) until Client.Character and Client.Character:FindFirstChild("Humanoid")
task.wait(1)
local Character = Client.Character
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Backpack = Client:WaitForChild("Backpack")
if Client.Character then
    Humanoid.StateChanged:Connect(function(_, State)
        if State == Enum.HumanoidStateType.FallingDown then
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end
Client.CharacterAdded:Connect(function(newCharacter)
    task.wait(0.5)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    Backpack = Client:WaitForChild("Backpack")
    Humanoid.StateChanged:Connect(function(_, State)
        if State == Enum.HumanoidStateType.FallingDown then
            Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
    if RootPart:FindFirstChild("CharacterBillboardGui") then
        RootPart:FindFirstChild("CharacterBillboardGui").Enabled = not c().HideName
    end
end)
local func = {}
local RarityData = {
    Common = Color3RGB(255, 255, 255),
    Uncommon = Color3RGB(99, 255, 52),
    Rare = Color3RGB(51, 170, 255),
    Epic = Color3RGB(237, 44, 255),
    Legendary = Color3RGB(255, 150, 0),
    Omega = Color3RGB(255, 20, 51)
}
local espData = {
    Players = {},
    Items = {}
}
local fakeCframe = nil
local SavedHistoryCFrame = nil
local DropFolder = workspace:FindFirstChild('DroppedItems')
local VehicleFolder = workspace:FindFirstChild("Vehicles")
local Cam = workspace.CurrentCamera
local PlaceId = game.PlaceId
local JobId = game.JobId
local Char = require(ReplicatedStorage.Modules.Core.Char)
local Util = require(ReplicatedStorage.Modules.Core.Util)
local Data = require(ReplicatedStorage.Modules.Core.Data)
local SprintModule = require(ReplicatedStorage.Modules.Game.Sprint)
local Network = require(ReplicatedStorage.Modules.Core.Net)
local RagdollModule = require(ReplicatedStorage.Modules.Game.Ragdoll)
local VehicleSystem = require(ReplicatedStorage.Modules.Game.VehicleSystem.Vehicle)
local CrateController = require(ReplicatedStorage.Modules.Game.CrateSystem.Crate)
local DroppedCore = require(ReplicatedStorage.Modules.Game.DroppedItem)
local glowHighlights = {}
local function createSelfGlow(character)
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    if glowHighlights[character] then
        pcall(function() glowHighlights[character]:Destroy() end)
        glowHighlights[character] = nil
    end
    local highlight = Instance.new("Highlight")
    highlight.Name = "SynixiaGlow"
    highlight.FillColor = Color3.fromRGB(160, 32, 240)
    highlight.OutlineColor = Color3.fromRGB(200, 100, 255)
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 0.1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    glowHighlights[character] = highlight
end
local function createEnemyGlow(character)
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    if glowHighlights[character] then
        pcall(function() glowHighlights[character]:Destroy() end)
        glowHighlights[character] = nil
    end
    local highlight = Instance.new("Highlight")
    highlight.Name = "SynixiaGlow"
    highlight.FillColor = Color3.fromRGB(0, 100, 255)
    highlight.OutlineColor = Color3.fromRGB(50, 150, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0.15
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    glowHighlights[character] = highlight
end
local function removeSynixiaGlow(character)
    if glowHighlights[character] then
        pcall(function() glowHighlights[character]:Destroy() end)
        glowHighlights[character] = nil
    end
end
local function applySelfAura(character)
    task_spawn(function()
        repeat task_wait(0.5) until character and character:FindFirstChild("HumanoidRootPart")
        createSelfGlow(character)
    end)
end
applySelfAura(Character)
Client.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    Backpack = Client:WaitForChild("Backpack")
    applySelfAura(newChar)
end)
local playerESPHighlights = {}
local function addPlayerESPHighlight(character)
    if not character or not character.Parent then return end
    if playerESPHighlights[character] then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "SynixiaPlayerESP"
    highlight.FillColor = Color3.fromRGB(0, 100, 255)
    highlight.OutlineColor = Color3.fromRGB(50, 150, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0.15
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    playerESPHighlights[character] = highlight
end
local function removePlayerESPHighlight(character)
    if playerESPHighlights[character] then
        pcall(function() playerESPHighlights[character]:Destroy() end)
        playerESPHighlights[character] = nil
    end
end
function func.EnemyGlow()
    while task_wait(0.3) do
        if c().EnemyGlow then
            for _, targetChar in pairs(Char.get_all()) do
                if targetChar and targetChar ~= Character and targetChar.Parent then
                    addPlayerESPHighlight(targetChar)
                end
            end
            for char, _ in pairs(playerESPHighlights) do
                if not char or not char.Parent then
                    removePlayerESPHighlight(char)
                end
            end
        else
            for char, _ in pairs(playerESPHighlights) do
                removePlayerESPHighlight(char)
            end
        end
    end
end
local function GetDist(root)
    local RootPos = RootPart.Position
    local TargetType = typeof(root)
    if TargetType == "Vector3" then
        return (root - RootPos).Magnitude
    elseif TargetType == "CFrame" then
        return (root.Position - RootPos).Magnitude
    elseif TargetType ~= "Instance" then
        return math.huge
    end
    local TargetPos = root:IsA("Model") and root:GetPivot().Position or root.Position
    return (TargetPos - RootPos).Magnitude
end
local function IsLive(model)
    if not model then return false; end
    local hum = model:FindFirstChildOfClass('Humanoid')
    if not hum then return false; end
    local rp = model:FindFirstChild('HumanoidRootPart')
    if not rp then return false; end
    return hum.Health > 0 and true or false
end
local function GetMoney()
    local a = {}
    function a.Money()
        local hand = Data.money.hand
        local bank = Data.money.bank
        return {Hand = hand, Bank = bank}
    end
    return a
end
local function onEvent(e,f)
    local con = e:Connect(f)
    return con
end
local function HighVelocity(Root)
    local A, B, C, R = Root.Velocity, Root.AssemblyLinearVelocity, Root.AssemblyAngularVelocity, Root.RotVelocity
    Root.Velocity = Vector3New(MathRandom(-750000, 999999), MathRandom(-750000, 999999), MathRandom(-750000, 999999))
    Root.AssemblyLinearVelocity = Vector3New(MathRandom(-750000, 999999), MathRandom(-750000, 999999), MathRandom(-750000, 999999))
    Root.AssemblyAngularVelocity = Vector3New(MathRandom(-500000, 999999), MathRandom(-500000, 999999), MathRandom(-500000, 999999))
    Root.RotVelocity = Vector3New(MathRandom(-500000, 999999), MathRandom(-500000, 999999), MathRandom(-500000, 999999))
    RunService.RenderStepped:Wait()
    Root.Velocity = A
    Root.AssemblyLinearVelocity = B
    Root.AssemblyAngularVelocity = C
    Root.RotVelocity = R
end
local function Csync(Root)
    local SavedCFrame = Root.CFrame
    SavedHistoryCFrame = SavedCFrame
    local FakeCFrame = CFrameNew(Root.Position + Vector3New(MathRandom(-100, 100), MathRandom(-100, 100), MathRandom(-100, 100)))
    Root.CFrame = FakeCFrame
    RunService.RenderStepped:Wait()
    Root.CFrame = SavedHistoryCFrame
end
local function MakeDraw(type, props)
    local obj = DrawingNew(type)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end
local function CheckWall(startPos, endPos)
    if not startPos or not endPos then return false end
    local ray = RayNew(startPos, endPos - startPos)
    local ignore = {}
    if Character then table.insert(ignore, Character) end
    local target = c().AimTarget
    if target then table.insert(ignore, target) end
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, ignore)
    return hit ~= nil
end
local function WorldToScreen(obj)
    local pos = typeof(obj) == "Vector3" and obj or obj.Position
    local vp, on = Cam:WorldToViewportPoint(pos)
    return vp, on
end;
local function SolveQuad(A, B, C)
    local disc = B^2 - 4*A*C
    if disc < 0 then return nil, nil end
    local sqrtDisc = MathSqrt(disc)
    local r1 = (-B - sqrtDisc) / (2*A)
    local r2 = (-B + sqrtDisc) / (2*A)
    return r1, r2
end
local function GetFlyTime(dir, grav, speed)
    local dist = dir.Magnitude
    if dist <= 0 then return 0 end
    return dist / speed
end
local function DropCalc(acc, t)
    return 0
end
local function PredictPos(targetPos, vel, time, grav)
    return targetPos + vel * time
end
local function DeltaY(baseY, curY, off)
    local targetY = baseY - off
    return targetY - curY
end
local function ClearESP()
    for player, draw in pairs(espData.Players) do
        if draw then
            if draw.Name and draw.Name.Remove then draw.Name:Remove() end
            if draw.Dist and draw.Dist.Remove then draw.Dist:Remove() end
            if draw.Bar and draw.Bar.Remove then draw.Bar:Remove() end
            if draw.TargetBox and draw.TargetBox.Remove then draw.TargetBox:Remove() end
            if draw.Tracer and draw.Tracer.Remove then draw.Tracer:Remove() end
        end
    end
    espData.Players = {}
end
local learnedBulletSpeed = {}
local function getToolBulletSpeed(tool)
    if not tool then return 2350 end
    if learnedBulletSpeed[tool.Name] then return learnedBulletSpeed[tool.Name] end
    local spd = tool:GetAttribute("BulletSpeed")
        or tool:GetAttribute("ProjectileSpeed")
        or tool:GetAttribute("Speed")
        or tool:GetAttribute("MuzzleVelocity")
        or tool:GetAttribute("Velocity")
    if spd and spd > 0 then
        learnedBulletSpeed[tool.Name] = spd
        return spd
    end
    for _, mod in pairs(tool:GetDescendants()) do
        if mod:IsA("ModuleScript") then
            local ok, result = pcall(require, mod)
            if ok and type(result) == "table" then
                local s = result.BulletSpeed or result.ProjectileSpeed or result.Speed or result.MuzzleVelocity or result.Velocity
                if type(s) == "number" and s > 0 then
                    learnedBulletSpeed[tool.Name] = s
                    return s
                end
            end
        end
    end
    local weaponConfig = ReplicatedStorage:FindFirstChild("WeaponConfig") or ReplicatedStorage:FindFirstChild("Weapons") or ReplicatedStorage:FindFirstChild("Items")
    if weaponConfig then
        local itemFolder = weaponConfig:FindFirstChild(tool.Name)
        if itemFolder then
            local mod = itemFolder:FindFirstChildWhichIsA("ModuleScript")
            if mod then
                local ok, result = pcall(require, mod)
                if ok and type(result) == "table" then
                    local s = result.BulletSpeed or result.ProjectileSpeed or result.Speed or result.MuzzleVelocity
                    if type(s) == "number" and s > 0 then
                        learnedBulletSpeed[tool.Name] = s
                        return s
                    end
                end
            end
        end
    end
    return 2350
end
local function isTargetInVehicle(targetChar)
    if not targetChar then return false end
    local plr = Players:GetPlayerFromCharacter(targetChar)
    if not plr then return false end
    local vehicleSeat = targetChar:FindFirstChild("VehicleSeat")
    if vehicleSeat and vehicleSeat:IsA("VehicleSeat") and vehicleSeat.Occupant == targetChar:FindFirstChildOfClass("Humanoid") then
        return true
    end
    local hum = targetChar:FindFirstChildOfClass("Humanoid")
    if hum and hum.SeatPart and hum.SeatPart:IsDescendantOf(workspace:FindFirstChild("Vehicles") or workspace) then
        return true
    end
    return false
end
local fovMode = "Center"
local mousePos = Vector2New(0, 0)
local FOVLines = {}
local function CreateFOVPolygon(radius, numSides, thickness)
    if FOVLines then
        for _, line in ipairs(FOVLines) do
            if line and line.Remove then
                pcall(line.Remove, line)
            end
        end
        FOVLines = {}
    end
    numSides = numSides or 32
    thickness = thickness or 0.3
    local center
    if c().FOVMode == "Follow" then
        center = mousePos
    else
        center = Vector2New(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    end
    local points = {}
    for i = 0, numSides - 1 do
        local angle = (i / numSides) * 2 * math.pi
        local x = center.X + radius * math.cos(angle)
        local y = center.Y + radius * math.sin(angle)
        table.insert(points, Vector2New(x, y))
    end
    for i = 1, #points do
        local nextIdx = (i % #points) + 1
        local line = DrawingNew("Line")
        line.From = points[i]
        line.To = points[nextIdx]
        line.Thickness = thickness
        line.Visible = false
        line.Transparency = 1
        local hue = (i - 1) / #points
        line.Color = Color3FromHSV(hue, 1, 1)
        table.insert(FOVLines, line)
    end
end
local function UpdateFOVPolygon(radius, thickness)
    if not FOVLines or #FOVLines == 0 then
        CreateFOVPolygon(radius, 32, thickness)
        return
    end
    local numSides = #FOVLines
    local center
    if c().FOVMode == "Follow" then
        center = mousePos
    else
        center = Vector2New(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
    end
    local points = {}
    for i = 0, numSides - 1 do
        local angle = (i / numSides) * 2 * math.pi
        local x = center.X + radius * math.cos(angle)
        local y = center.Y + radius * math.sin(angle)
        table.insert(points, Vector2New(x, y))
    end
    for i = 1, #points do
        local nextIdx = (i % #points) + 1
        local line = FOVLines[i]
        if line then
            line.From = points[i]
            line.To = points[nextIdx]
            if c().RainbowPov then
                local t = tick()
                local hue = (t * 0.15 + (i - 1) / #points) % 1
                line.Color = Color3FromHSV(hue, 1, 1)
            else
                local hue = (i - 1) / #points
                line.Color = Color3FromHSV(hue, 1, 1)
            end
            line.Thickness = thickness or 0.3
            line.Visible = c().AimAssist or false
            line.Transparency = 1
        end
    end
end
CreateFOVPolygon(c().PovSize or 150, 32, c().FOVThickness or 0.3)
Util.hook_children(Backpack,function(tool)
    if tool and tool:IsA("Tool") and not tool:GetAttribute('Locked') then
        tool:SetAttribute("Locked", true)
    end
end)
local function AddPlayerESP(plr)
    if espData.Players[plr] then return end
    espData.Players[plr] = {
        Name = MakeDraw("Text",{
            Visible = false, Color = Color3.new(1,1,1), Size = 14,
            Center = true, Outline = true, OutlineColor = Color3.new(0,0,0),
            Text = plr.Name
        }),
        Dist = MakeDraw("Text",{
            Visible = false, Color = Color3.new(1,1,1), Size = 12,
            Center = true, Outline = true, OutlineColor = Color3.new(0,0,0),
            Text = ""
        }),
        Bar = MakeDraw("Line",{
            Visible = false, Color = Color3RGB(0, 255, 0),
            Thickness = 6,
            Transparency = 0.8
        }),
        TargetBox = MakeDraw("Square",{
            Visible = false, Color = Color3RGB(255,0,0),
            Thickness = 2, Transparency = 1, Filled = false
        }),
        Tracer = MakeDraw("Line",{
            Visible = false, Color = Color3RGB(255,0,0), Thickness = 1.5
        }),
    }
end
Util.hook_players(function(v)
    if v ~= Client then AddPlayerESP(v) end
end)
onEvent(Players.PlayerAdded, function(plr)
    if plr ~= Client then
        task_wait(0.5)
        AddPlayerESP(plr)
    end
end)
onEvent(Players.PlayerRemoving,function(plr)
    if espData.Players[plr] then
        if espData.Players[plr].Name and espData.Players[plr].Name.Remove then
            espData.Players[plr].Name:Remove()
        end
        if espData.Players[plr].Dist and espData.Players[plr].Dist.Remove then
            espData.Players[plr].Dist:Remove()
        end
        if espData.Players[plr].Bar and espData.Players[plr].Bar.Remove then
            espData.Players[plr].Bar:Remove()
        end
        if espData.Players[plr].TargetBox and espData.Players[plr].TargetBox.Remove then
            espData.Players[plr].TargetBox:Remove()
        end
        if espData.Players[plr].Tracer and espData.Players[plr].Tracer.Remove then
            espData.Players[plr].Tracer:Remove()
        end
        espData.Players[plr] = nil
    end
end)
local playerCache = {}
onEvent(RunService.RenderStepped, function()
    if c().AimAssist and not c().HeadSnapAll then
        c().HeadSnapAll = true
    end
    if not c().AimAssist and c().HeadSnapAll then
        c().HeadSnapAll = false
    end
    do
        local radius = c().PovSize or 200
        local thickness = c().FOVThickness or 0.3
        UpdateFOVPolygon(radius, thickness)
    end
    for _, draw in pairs(espData.Players) do
        if draw then
            if draw.Tracer then draw.Tracer.Visible = false end
            if draw.TargetBox then draw.TargetBox.Visible = false end
        end
    end
    local closest, closestDist = nil, math.huge
    local cx = Cam.ViewportSize.X / 2
    local cy = Cam.ViewportSize.Y / 2
    local radius = c().PovSize or 200
    for _, targetChar in pairs(Char.get_all()) do
        if targetChar ~= Character and IsLive(targetChar) then
            local targetPlr = Players:GetPlayerFromCharacter(targetChar)
            if targetPlr and not targetPlr:GetAttribute("InMenuCharacterCreator") and not targetPlr:GetAttribute("InSplashScreen") and not targetPlr:GetAttribute('IsSafeZoneProtected') and not targetChar:GetAttribute('IsSpawnProtected') then
                local rp = targetChar:FindFirstChild("HumanoidRootPart")
                if rp and not (c().FriendIgnore and targetPlr:IsFriendsWith(Client.UserId)) then
                    local pos, on = WorldToScreen(rp)
                    if on then
                        local dx = pos.X - cx
                        local dy = pos.Y - cy
                        local dist = MathSqrt(dx*dx + dy*dy)
                        if dist <= radius and dist < closestDist then
                            closest = targetChar
                            closestDist = dist
                        end
                    end
                end
            end
        end
    end
    c().AimTarget = closest
    if closest then
        local targetPlr = Players:GetPlayerFromCharacter(closest)
        if targetPlr then
            local draw = espData.Players[targetPlr]
            if draw then
                local part = closest:FindFirstChild((c().AimPart or "Head"))
                if part then
                    local pos, on = WorldToScreen(part)
                    local size = 1000 / pos.Z
                    if draw.Tracer then
                        draw.Tracer.Color = Color3RGB(255,0,0)
                        draw.Tracer.Visible = (c().AimAssist and on) or false
                        draw.Tracer.From = Vector2New(cx, cy)
                        draw.Tracer.To = Vector2New(pos.X, pos.Y)
                    end
                    if draw.TargetBox then
                        draw.TargetBox.Size = Vector2New(size, size)
                        draw.TargetBox.Position = Vector2New(pos.X - size/2, pos.Y - size/2)
                        draw.TargetBox.Color = Color3RGB(255,0,0)
                        draw.TargetBox.Visible = (c().AimAssist and on) or false
                    end
                end
            end
        end
    end
    if Character and IsLive(Character) then
        Humanoid.JumpHeight = (c().JumpCustom and (c().JumpValue or 4)) or 3.89
        local dir = Humanoid.MoveDirection
        if dir.Magnitude > 0 then
            Network.send("set_sprinting_1",true)
            if c().SpeedCustom then
                if Humanoid:GetAttribute("TargetWalkSpeed") ~= 30 and Humanoid.WalkSpeed ~= 30 then
                    Humanoid:SetAttribute("TargetWalkSpeed", 30)
                    Humanoid.WalkSpeed = 30
                end
                RootPart.CFrame = RootPart.CFrame + (dir.Unit * ((c().SpeedValue or 3) / 155))
            end
        end
    end
end)
local espTimer = 0
local ESP_RATE = 1/40
local DroppedItemESP = {
    Guis = {},
    Data = {},
    MoneyImageId = "110255719918631",
    Enabled = false
}
function DroppedItemESP:Toggle(state)
    self.Enabled = state
    if not state then
        for itemInst, drawObj in pairs(espData.Items) do
            if drawObj.Display and drawObj.Display.Gui then
                pcall(function() drawObj.Display.Gui:Destroy() end)
            end
            espData.Items[itemInst] = nil
        end
    end
end
function DroppedItemESP:CreateDisplay(itemInst, itemName, rarityName, imageId)
    local gui = Instance.new("ScreenGui")
    gui.Name = "ItemESP_" .. itemName .. "_" .. tostring(itemInst)
    gui.ResetOnSpawn = false
    gui.Parent = Client:WaitForChild("PlayerGui")
    gui.Enabled = false
    local frame = Instance.new("Frame")
    frame.Name = "ItemFrame"
    frame.Size = UDim2.new(0, 40, 0, 40)
    frame.Position = UDim2.new(0.5, -20, 0.5, -20)
    frame.BackgroundTransparency = 1
    frame.BackgroundColor3 = RarityData[rarityName] or Color3RGB(255,255,255)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    local bg = Instance.new("ImageLabel")
    bg.Name = "Background"
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.Position = UDim2.new(0, 0, 0, 0)
    bg.BackgroundTransparency = 1
    bg.Image = "rbxassetid://137066731814190"
    bg.ImageColor3 = RarityData[rarityName] or Color3RGB(255,255,255)
    bg.ScaleType = Enum.ScaleType.Fit
    bg.Parent = frame
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "ItemImage"
    imageLabel.Size = UDim2.new(0.85, 0, 0.85, 0)
    imageLabel.Position = UDim2.new(0.075, 0, 0.075, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = imageId or "rbxassetid://137066731814190"
    imageLabel.ScaleType = Enum.ScaleType.Fit    imageLabel.Parent = frame
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.Position = UDim2.new(0, 0, 1, 2)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = itemName
    nameLabel.TextColor3 = Color3RGB(255,255,255)
    nameLabel.TextSize = 11
    nameLabel.TextScaled = false
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeColor3 = Color3RGB(0,0,0)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.Parent = frame
    local countLabel = Instance.new("TextLabel")
    countLabel.Name = "CountLabel"
    countLabel.Size = UDim2.new(1, 0, 0, 16)
    countLabel.Position = UDim2.new(0, 0, 1, 22)
    countLabel.BackgroundTransparency = 1
    countLabel.Text = ""
    countLabel.TextColor3 = Color3RGB(255,255,255)
    countLabel.TextSize = 10
    countLabel.TextScaled = false
    countLabel.Font = Enum.Font.Gotham
    countLabel.TextStrokeColor3 = Color3RGB(0,0,0)
    countLabel.TextStrokeTransparency = 0.3
    countLabel.Parent = frame
    return {
        Gui = gui,
        Frame = frame,
        NameLabel = nameLabel,
        CountLabel = countLabel,
        ImageLabel = imageLabel
    }
end
function DroppedItemESP:GetItemInfo(itemInst)
    local rarityName = "Common"
    local imageId = "rbxassetid://137066731814190"
    local itemName = itemInst.Name or "Unknown"
    if itemName == "Money" or itemName == "Cash" or itemName == "Coin" then
        imageId = "rbxassetid://" .. self.MoneyImageId
        rarityName = "Common"
        return rarityName, imageId, itemName
    end
    pcall(function()
        local itemType = itemInst:GetAttribute("item_type")
        local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
        if itemsFolder and itemType then
            local typeFolder = itemsFolder:FindFirstChild(itemType)
            if typeFolder then
                local itemConfig = typeFolder:FindFirstChild(itemInst.Name)
                if itemConfig then
                    rarityName = itemConfig:GetAttribute("RarityName") or "Common"
                    imageId = itemConfig:GetAttribute("ImageId") or "rbxassetid://137066731814190"
                end
            end
        end
    end)
    return rarityName, imageId, itemName
end
function DroppedItemESP:Update()
    if not self.Enabled then
        for itemInst, drawObj in pairs(espData.Items) do
            if drawObj.Display and drawObj.Display.Gui then
                pcall(function() drawObj.Display.Gui:Destroy() end)
            end
            espData.Items[itemInst] = nil
        end
        return
    end
    for itemInst, drawObj in pairs(espData.Items) do
        if not itemInst or not itemInst.Parent then
            if drawObj.Display and drawObj.Display.Gui then
                pcall(function() drawObj.Display.Gui:Destroy() end)
            end
            espData.Items[itemInst] = nil
        end
    end
    for itemInst, itemData in pairs(DroppedCore.class.objects) do
        if itemInst and not itemInst:GetAttribute("Locked") then
            if not espData.Items[itemInst] then
                local rarityName, imageId, itemName = self:GetItemInfo(itemInst)
                local display = self:CreateDisplay(itemInst, itemName, rarityName, imageId)
                espData.Items[itemInst] = {
                    Display = display,
                    Rarity = rarityName,
                    Name = itemName,
                    ImageId = imageId
                }
            end
            local drawObj = espData.Items[itemInst]
            if drawObj and drawObj.Display then
                local zone = itemInst.PickUpZone
                local pos2d, on = WorldToScreen(zone)
                local isBlacklisted = c().BlacklistRarity and #c().BlacklistRarity > 0 and table.find(c().BlacklistRarity, drawObj.Rarity)
                local state = (c().ItemESP and (not c().BlacklistItem or not isBlacklisted)) or false
                if on and state then
                    local gui = drawObj.Display.Gui
                    local frame = drawObj.Display.Frame
                    local size = 40
                    local screenPos = Vector2New(pos2d.X - size/2, pos2d.Y - size - 10)
                    frame.Size = UDim2.new(0, size, 0, size)
                    frame.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y)
                    local amount = itemData.states.amount.get()
                    drawObj.Display.CountLabel.Text = "x" .. amount
                    drawObj.Display.CountLabel.Visible = amount > 1
                    gui.Enabled = true
                else
                    drawObj.Display.Gui.Enabled = false
                end
            end
        end
    end
end
onEvent(RunService.Heartbeat, function()
    if c().AntiAim then
        local humMod = Char.get_hum()
        if humMod and not humMod:GetAttribute("HasBeenDowned") then
            local rpMod = Char.get_hrp()
            HighVelocity(rpMod)
            Csync(rpMod)
        end
    end
end)
onEvent(RunService.Heartbeat, function(dt)
    espTimer = espTimer + dt
    if espTimer < ESP_RATE then return end
    espTimer = 0
    for i = #playerCache, 1, -1 do
        local data = playerCache[i]
        if not data.Char or not data.Char.Parent then
            table.remove(playerCache, i)
        end
    end
    for _, targetChar in pairs(Char.get_all()) do
        if targetChar ~= Character and IsLive(targetChar) then
            local targetPlr = Players:GetPlayerFromCharacter(targetChar)
            if targetPlr then
                local found = false
                for _, ex in pairs(playerCache) do
                    if ex.Player == targetPlr then found = true; break end
                end
                if not found then
                    local rp = targetChar:FindFirstChild("HumanoidRootPart")
                    local head = targetChar:FindFirstChild("Head")
                    local hum = targetChar:FindFirstChildOfClass("Humanoid")
                    if rp and head and hum then
                        table.insert(playerCache, {
                            Player = targetPlr,
                            Char = targetChar,
                            Root = rp,
                            Head = head,
                            Humanoid = hum,
                        })
                        if not espData.Players[targetPlr] then
                            AddPlayerESP(targetPlr)
                        end
                    end
                end
            end
        end
    end
    local showName = c().NameESP or false
    local showDist = c().DistESP or false
    local showBar = c().BarESP or false
    for _, data in pairs(playerCache) do
        if data.Char and data.Char.Parent then
            data.Root = data.Char:FindFirstChild("HumanoidRootPart") or data.Root
            data.Head = data.Char:FindFirstChild("Head") or data.Head
            data.Humanoid = data.Char:FindFirstChildOfClass("Humanoid") or data.Humanoid
        end
        local draw = espData.Players[data.Player]
        if draw and data.Root and data.Root.Parent == data.Char and data.Head and data.Head.Parent == data.Char then
            local headPos, headOn = WorldToScreen(data.Head.Position + Vector3New(0, 0.5, 0))
            local footPos, footOn = WorldToScreen(data.Root.Position - Vector3New(0, 2.2, 0))
            local rootPos, rootOn = WorldToScreen(data.Root.Position)
            if not headOn and not rootOn then
                if draw.Name then draw.Name.Visible = false end
                if draw.Dist then draw.Dist.Visible = false end
                if draw.Bar then draw.Bar.Visible = false end
            else
                local usePos = headOn and headPos or rootPos
                if draw.Name then
                    draw.Name.Position = Vector2New(usePos.X, usePos.Y - 25)
                    draw.Name.Visible = showName
                end
                if draw.Dist then
                    local dist = GetDist(data.Root)
                    draw.Dist.Text = "[" .. math.floor(dist) .. "m]"
                    draw.Dist.Position = Vector2New(usePos.X, usePos.Y - 15)
                    draw.Dist.Visible = showDist
                end
                if draw.Bar and footOn then
                    local barWidth = 55
                    local barHeight = 5
                    local hpPercent = data.Humanoid.Health / data.Humanoid.MaxHealth
                    local leftX = footPos.X - barWidth/2
                    local rightX = leftX + (barWidth * hpPercent)
                    local barY = footPos.Y + 5
                    draw.Bar.From = Vector2New(leftX, barY)
                    draw.Bar.To = Vector2New(rightX, barY)
                    draw.Bar.Color = Color3RGB(0, 255, 0)
                    draw.Bar.Thickness = barHeight
                    draw.Bar.Visible = showBar
                end
            end
        end
    end
    DroppedItemESP:Update()
end)
task_spawn(function()
    while true do
        task_wait(0.5)
        for _, v in pairs(Char.get_all()) do
            if v ~= Character and IsLive(v) then
                local rp = v:FindFirstChild('HumanoidRootPart')
                local plr = Players:GetPlayerFromCharacter(v)
                if not plr then continue end
                if not rp:FindFirstChild('InvViewer') then
                    local viewer = InstanceNew('BillboardGui')
                    viewer.Name = "InvViewer"
                    viewer.AlwaysOnTop = true
                    viewer.Adornee = rp
                    viewer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                    viewer.Size = UDim2New(0,200,0,30)
                    viewer.StudsOffset = Vector3New(0,4,0)
                    viewer.ExtentsOffset = Vector3New(0,1,0)
                    viewer.Parent = rp
                    local bg = InstanceNew('Frame')
                    bg.Name = "BG"
                    bg.BackgroundTransparency = 1
                    bg.Size = UDim2New(1,0,1,0)
                    bg.AnchorPoint = Vector2New(0.5,0.5)
                    bg.Position = UDim2New(0.5,0,0.5,0)
                    bg.Parent = viewer
                    local layout = InstanceNew('UIListLayout')
                    layout.FillDirection = Enum.FillDirection.Horizontal
                    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    layout.VerticalAlignment = Enum.VerticalAlignment.Center
                    layout.Padding = UDimNew(0,5)
                    layout.Parent = bg
                end
                local inv = {}
                local viewer = rp:FindFirstChild('InvViewer')
                local bg = viewer and viewer:FindFirstChild('BG')
                if bg then
                    for _, container in pairs({plr.Backpack, v}) do
                        if container then
                            for _, tool in pairs(container:GetChildren()) do
                                if tool:IsA("Tool") and not tool:GetAttribute("JobTool") and not tool:GetAttribute("Locked") then
                                    local att = tool:GetAttributes()
                                    local folder
                                    for _, val in pairs(att) do
                                        if type(val) == "string" and val:lower():find("melee") then
                                            folder = ReplicatedStorage.Items.melee:GetChildren()
                                            break
                                        end
                                    end
                                    if not folder then
                                        folder = (att.AmmoType and att.Recoil) and ReplicatedStorage.Items.gun:GetChildren() or ReplicatedStorage.Items.throwable:GetChildren()
                                    end
                                    for _, item in pairs(folder) do
                                        if tool:GetAttribute("RarityName") == item:GetAttribute("RarityName") and tool:GetAttribute("RarityPrice") == item:GetAttribute("RarityPrice") then
                                            local imgId = item:GetAttribute("ImageId")
                                            if imgId then
                                                inv[item.Name] = true
                                                if not bg:FindFirstChild(item.Name) then
                                                    local icon = InstanceNew('ImageLabel')
                                                    icon.Name = item.Name
                                                    icon.Image = 'rbxassetid://137066731814190'
                                                    icon.BackgroundTransparency = 1
                                                    icon.BorderSizePixel = 0
                                                    icon.ImageColor3 = RarityData[tool:GetAttribute("RarityName")] or Color3RGB(255,255,255)
                                                    icon.Size = UDim2New(0,22,0,22)
                                                    icon.Parent = bg
                                                    local base = InstanceNew('ImageLabel')
                                                    base.Name = "Base"
                                                    base.Image = imgId
                                                    base.BackgroundTransparency = 1
                                                    base.BorderSizePixel = 0
                                                    base.Size = UDim2New(0.9,0,0.9,0)
                                                    base.AnchorPoint = Vector2New(0.5,0.5)
                                                    base.Position = UDim2New(0.5,0,0.5,0)
                                                    base.Parent = icon
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    viewer.Enabled = (c().InvESP and v:FindFirstChild('Humanoid').Health > 0) or false
                    for _, obj in pairs(bg:GetChildren()) do
                        if obj:IsA("ImageLabel") and not inv[obj.Name] then
                            obj:Destroy()
                        end
                    end
                end
            end
        end
    end
end)
do
    local oldTween = Util.tween;
    Util.tween = function(inst, info, props)
        if inst and inst:IsA("NumberValue") and props and props.Value ~= nil then
            inst.Value = props.Value
            return {Cancel = function() end}
        end
        return oldTween(inst, info, props)
    end
end
do
    local oldIndex; oldIndex = hookmetamethod(game, "__index", function(self, idx)
        if not checkcaller() and c().AntiAim and idx == "CFrame" and self == RootPart and IsLive(Character) and SavedHistoryCFrame and not Char.get_hum():GetAttribute("HasBeenDowned") then
            return SavedHistoryCFrame
        end
        return oldIndex(self, idx)
    end)
end
local function calculateAutoSnapStrength(dist)
    local baseStrength = 0.4
    local distanceFactor = MathClamp(dist / 300, 0.2, 1.0)
    local autoStrength = baseStrength * (0.5 + distanceFactor * 0.5)
    if dist > 400 then
        autoStrength = MathClamp(autoStrength * 1.3, 0.1, 0.6)
    end
    return MathClamp(autoStrength, 0.1, 0.6)
end
local function calculateAutoLongRangeBoost(dist)
    if dist > 500 then
        return 1.4
    elseif dist > 300 then
        return 1.2
    elseif dist > 150 then
        return 1.1
    else
        return 1.0
    end
end
do
    local history = {};
    oldSend = hookfunction(Network.send, function(...)
        local args = {...}
        if args[1] == "shoot_gun" and c().AimAssist and c().AimTarget then
            local startTime = tick()
            local targetPart = c().AimTarget:FindFirstChild((c().AimPart or "Head"))
            if not targetPart then return oldSend(table.unpack(args)) end
            local clientPos = RootPart.Position
            local targetPos = targetPart.Position
            local dist = (targetPos - clientPos).Magnitude
            local gravity = Vector3New(0, -workspace.Gravity, 0)
            history[c().AimTarget] = history[c().AimTarget] or {}
            local hist = history[c().AimTarget]
            if #hist >= 8 then table.remove(hist, 1) end
            table.insert(hist, {pos = targetPos, time = startTime})
            local tool = Character:FindFirstChildWhichIsA("Tool")
            local bulletSpeed = getToolBulletSpeed(tool)
            local vec = targetPos - clientPos
            local travel = GetFlyTime(vec, gravity, bulletSpeed)
            if travel == 0 then travel = dist / bulletSpeed end
            local approxVel = Vector3.zero
            local n = #hist
            if n >= 4 then
                local p1, p2, p3, p4 = hist[n-3], hist[n-2], hist[n-1], hist[n]
                local dt1 = math.max(p2.time - p1.time, 1e-4)
                local dt2 = math.max(p3.time - p2.time, 1e-4)
                local dt3 = math.max(p4.time - p3.time, 1e-4)
                local v1 = (p2.pos - p1.pos) / dt1
                local v2 = (p3.pos - p2.pos) / dt2
                local v3 = (p4.pos - p3.pos) / dt3
                local acc1 = (v2 - v1) / math.max(dt1 + dt2, 1e-4)
                local acc2 = (v3 - v2) / math.max(dt2 + dt3, 1e-4)
                local avgAcc = (acc1 + acc2) / 2
                approxVel = v3 + avgAcc * travel
                if approxVel.Magnitude > 80 then
                    approxVel = approxVel.Unit * 80
                end
            elseif n >= 2 then
                local p1, p2 = hist[1], hist[2]
                local dt = math.max(p2.time - p1.time, 1e-4)
                approxVel = (p2.pos - p1.pos) / dt
                if approxVel.Magnitude > 80 then
                    approxVel = approxVel.Unit * 80
                end
            end
            local leadMult = 1.0
            if dist > 150 then leadMult = 1.1
            elseif dist > 300 then leadMult = 1.2
            elseif dist > 500 then leadMult = 1.4 end
            local finalPos = targetPos + approxVel * travel * leadMult
            if c().HeadSnapAll then
                local headPos = c().AimTarget:FindFirstChild("Head") and c().AimTarget.Head.Position or targetPos
                local headDist = (headPos - finalPos).Magnitude
                local baseSnapZone = c().SnapZone or 20
                local dynamicSnapZone = baseSnapZone * (1 + dist / 300)
                local autoStrength = calculateAutoSnapStrength(dist)
                local autoLongRangeBoost = calculateAutoLongRangeBoost(dist)
                if headDist < dynamicSnapZone then
                    local headFactor = 1 - (headDist / dynamicSnapZone)
                    headFactor = MathClamp(headFactor, 0, 1)
                    local finalStrength = headFactor * autoStrength * autoLongRangeBoost
                    finalPos = finalPos:Lerp(headPos, finalStrength)
                    if dist > 400 then
                        finalPos = finalPos:Lerp(headPos, 0.7)
                    end
                end
            end
            local isShotgun = tool and tool:GetAttribute("AmmoType") == "shotgun"
            local wall = c().Wallbang and tool and tool:GetAttribute("AmmoType") ~= "shotgun" and CheckWall(clientPos, finalPos)
            args[3] = isShotgun and CFrameNew(clientPos, finalPos) or (wall and CFrameNew(math.huge, math.huge, math.huge) or CFrameNew(clientPos, finalPos))
            for _, v in pairs(args[4]) do
                for _, x in pairs(v) do
                    x.Normal = Vector3New(0,1,0)
                    x.Position = finalPos
                    x.Instance = targetPart
                end
            end
            if c().MultiShot then
                oldSend(table.unpack(args))
            end
            local tracer = InstanceNew("Part")
            tracer.Size = Vector3New(0.02, 0.02, dist)
            tracer.Color = Color3FromHSV((tick() % 5) / 5, 1, 1)
            tracer.Material = Enum.Material.Neon
            tracer.CanCollide = false
            tracer.Anchored = true
            tracer.Parent = workspace
            tracer.CFrame = CFrameNew(clientPos, finalPos) * CFrameNew(0, 0, -dist/2)
            Debris:AddItem(tracer, 0.5)
        end
        return oldSend(table.unpack(args))
    end)
end
do
    local ds = PlayerGui.DeathScreen.DeathScreenHolder
    ds.Frame.RespawnButtonFrame.RespawnButton.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
        if c().AutoRespawn and ds.Visible and ds.Frame.RespawnButtonFrame.RespawnButton.TextLabel.Text == "Respawn" then
            Network.send("death_screen_request_respawn")
        end
    end)
end
do
    local ConsumeStamina = SprintModule.consume_stamina
    local SprintBar = debug.getupvalue(ConsumeStamina,2).sprint_bar
    local oldUpdate = SprintBar.update
    SprintBar.update = function(...)
        if c().InfStamina then
            return (function() return 1 end)
        end
        return oldUpdate(...)
    end
end
do
    local GetRagdoll = RagdollModule.is_ragdolling.get
    RagdollModule.is_ragdolling.get = function(...)
        local result = GetRagdoll(...)
        if result == true and c().AntiRagdoll then
            RagdollModule.is_ragdolling.set(false)
            Network.send("end_ragdoll_early")
            Network.send("clear_ragdoll")
        end
        return result
    end
end
function func.Snap()
    local basePos = Char.get_hrp().Position
    local offY = c().SnapAmount or 1
    while task_wait() do
        if c().Snap then
            xpcall(function()
                if IsLive(Character) then
                    local curOff = c().SnapAmount or 1
                    if curOff ~= offY then offY = curOff end
                    local curY = Char.get_hrp().Position.Y
                    local delta = DeltaY(basePos.Y, curY, curOff)
                    Char.get_hrp().CFrame = Char.get_hrp().CFrame * CFrameNew(0, delta, 0)
                end
            end,warn)
        end
    end
end
function func.ItemDroppedGraber()
    local Radius = c().GrabRadius or 45
    local CheckInterval = 0.1
    local ActiveConnections = {}
    local function GetDroppedItemsContainer()
        local Container = workspace:FindFirstChild("DroppedItems")
        if not Container then
            local NewContainer = Instance.new("Folder")
            NewContainer.Name = "DroppedItems"
            NewContainer.Parent = workspace
            return NewContainer
        end
        return Container
    end
    local function PickupItem(Item, Character)
        local PickupZone = Item:FindFirstChild("PickUpZone")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not PickupZone or not HumanoidRootPart then
            return false
        end
        if not ActiveConnections[Item] then
            local Connection
            Connection = RunService.Heartbeat:Connect(function()
                if not Item or not Item.Parent or not Character or not Character.Parent then
                    if Connection then
                        Connection:Disconnect()
                    end
                    ActiveConnections[Item] = nil
                    return
                end
                pcall(function()
                    firetouchinterest(PickupZone, HumanoidRootPart, 0)
                    firetouchinterest(PickupZone, HumanoidRootPart, 1)
                end)
            end)
            ActiveConnections[Item] = Connection
        end
        return true
    end
    local function ScanAndPickup()
        local char = Char.get() or Client.Character
        if not char or not char.Parent then
            return
        end
        local CharacterPosition = char:GetPivot().Position
        local DroppedItemsContainer = GetDroppedItemsContainer()
        for _, Item in ipairs(DroppedItemsContainer:GetChildren()) do
            if Item:IsA("Model") then
                local ItemPosition = Item:GetPivot().Position
                local Distance = (ItemPosition - CharacterPosition).Magnitude
                if Distance <= Radius then
                    PickupItem(Item, char)
                end
            end
        end
    end
    while c().ItemDroppedGraber do
        pcall(ScanAndPickup)
        task.wait(CheckInterval)
    end
    for _, conn in pairs(ActiveConnections) do
        if conn and conn.Disconnect then
            conn:Disconnect()
        end
    end
    ActiveConnections = {}
end
function func.AntiDied()
    while task_wait() do
        if c().AntiDied then
            local humMod = Char.get_hum()
            if humMod and humMod:GetAttribute("HasBeenDowned") then
                local rpMod = Char.get_hrp()
                local char = Char.get()
                local newPos = rpMod.Position + Vector3New(0, -50, 0)
                local ray = RayNew(newPos + Vector3New(0, 10, 0), Vector3New(0, -20, 0))
                local hit = workspace:FindPartOnRay(ray, char)
                if hit then
                    newPos = hit.Position + Vector3New(0, 5, 0)
                end
                rpMod.CFrame = CFrameNew(newPos)
                char:PivotTo(CFrameNew(newPos))
                RootPart.CFrame = CFrameNew(newPos)
                Character:PivotTo(CFrameNew(newPos))
                rpMod.Anchored = false
                rpMod.CanCollide = true
                RootPart.Anchored = false
                RootPart.CanCollide = true
                for _,v in pairs(Character:GetDescendants()) do
                    if v:IsA('BasePart') then
                        v.Velocity = Vector3New(0, 0, 0)
                        v.AssemblyLinearVelocity = Vector3New(0, 0, 0)
                        v.AssemblyAngularVelocity = Vector3New(0, 0, 0)
                        v.RotVelocity = Vector3New(0, 0, 0)
                        v.Anchored = false
                        v.CanCollide = true
                    end
                end
                if humMod then
                    humMod:SetAttribute("HasBeenDowned", false)
                    humMod:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end
        end
    end
end
function func.SpeedBostVehicle()
    while task_wait() do
        if c().SpeedBostVehicle then
            xpcall(function()
                if VehicleSystem.get_car_player_is_in() then
                    local chassis = VehicleSystem.get_car_player_is_in().PrimaryPart
                    if not chassis then return end
                    local vel = chassis.AssemblyLinearVelocity
                    local dir = chassis.CFrame.LookVector
                    if vel.Magnitude > 0 then
                        local newVel = dir * c().VehicleSpeedBost
                        chassis.AssemblyLinearVelocity = Vector3New(newVel.X, vel.Y, newVel.Z)
                    end
                end
            end,warn)
        end
    end
end
local autoJumpConnection = nil
local isAutoJumpEnabled = false
local jumpCooldown = false
local function startAutoJump()
    if autoJumpConnection then
        autoJumpConnection:Disconnect()
        autoJumpConnection = nil
    end
    isAutoJumpEnabled = true
    jumpCooldown = false
    autoJumpConnection = RunService.Heartbeat:Connect(function()
        if not isAutoJumpEnabled then return end
        if not Character or not Character:FindFirstChild("Humanoid") then return end
        local humanoid = Character:FindFirstChild("Humanoid")
        local rootPart = Character:FindFirstChild("HumanoidRootPart")
        if not humanoid or not rootPart then return end
        local isOnGround = humanoid.FloorMaterial ~= Enum.Material.Air
        if isOnGround and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
            if not jumpCooldown then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                jumpCooldown = true
                task.delay(0.01, function()
                    jumpCooldown = false
                end)
            end
        end
    end)
end
local function stopAutoJump()
    isAutoJumpEnabled = false
    if autoJumpConnection then
        autoJumpConnection:Disconnect()
        autoJumpConnection = nil
    end
end
local function AutoDoorLock()
    while task_wait(0.5) do
        if c().AutoDoorLock then
            for _, door in pairs(workspace:GetDescendants()) do
                if door:IsA("BasePart") and (door.Name:lower():find("door") or door.Name:lower():find("gate") or door.Name:lower():find("entrance")) then
                    if door:FindFirstChild("ClickDetector") then
                        local detector = door:FindFirstChild("ClickDetector")
                        detector.MaxActivationDistance = 0
                        detector:Destroy()
                    end
                    if door:FindFirstChild("ProximityPrompt") then
                        local prompt = door:FindFirstChild("ProximityPrompt")
                        prompt.Enabled = false
                        prompt:Destroy()
                    end
                    door.CanCollide = true
                    door.Locked = true
                    door:SetAttribute("Locked", true)
                end
            end
        end
    end
end
task_spawn(AutoDoorLock)
local function FetchServerList()
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?limit=100"
    local ok, res = pcall(function() return HttpService:GetAsync(url, true) end)
    if not ok then return {} end
    local data = HttpService:JSONDecode(res)
    local list = {}
    if data and data.data then
        for _, info in ipairs(data.data) do
            if info.playing < info.maxPlayers - 1 and info.id ~= JobId then
                table.insert(list, {JobId = info.id, Players = info.playing, Max = info.maxPlayers, Ping = math.huge})
            end
        end
    end
    return list
end
local function GetPing(jobId)
    local start = tick()
    local ok = pcall(function() HttpService:GetAsync("https://www.roblox.com/games/" .. PlaceId .. "?jobId=" .. jobId, true) end)
    local elapsed = (tick() - start) * 1000
    return ok and elapsed or math.huge
end
local function JoinBestServer()
    local raw = FetchServerList()
    if #raw == 0 then return false end
    local toCheck = {}
    for i = 1, math.min(50, #raw) do table.insert(toCheck, raw[i]) end
    for _, sv in ipairs(toCheck) do
        sv.Ping = GetPing(sv.JobId)
        task.wait(0.1)
    end
    table.sort(toCheck, function(a,b) return a.Ping < b.Ping end)
    local best = toCheck[1]
    if not best or best.Ping == math.huge then return false end
    pcall(function() TeleportService:TeleportToPlaceInstance(PlaceId, best.JobId, Client) end)
    return true
end
local rainbowText = function(text, speed)
    speed = speed or 0.3
    local result = ""
    local chars = {}
    for i = 1, #text do
        chars[i] = text:sub(i, i)
    end
    local time = tick() * speed
    for i, char in ipairs(chars) do
        local hue = (time + (i / #text)) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        local hex = string.format("#%02x%02x%02x", 
            math.floor(color.R * 255), 
            math.floor(color.G * 255), 
            math.floor(color.B * 255))
        result = result .. string.format('<font color="%s">%s</font>', hex, char)
    end
    return result
end
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
WindUI:AddTheme({
    Name = "MacOS Dark",
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#101010"),
    BackgroundTransparency = 0.05,
    Outline = Color3.fromHex("#2a2a2e"),
    Text = Color3.fromHex("#ffffff"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#2c2c30"),
    Icon = Color3.fromHex("#a1a1aa"),
    Hover = Color3.fromHex("#ffffff"),
    WindowBackground = Color3.fromHex("#101010"),
    WindowShadow = Color3.fromHex("#000000"),
    WindowTopbarTitle = Color3.fromHex("#ffffff"),
    WindowTopbarAuthor = Color3.fromHex("#a1a1aa"),
    WindowTopbarIcon = Color3.fromHex("#ffffff"),
    WindowTopbarButtonIcon = Color3.fromHex("#a1a1aa"),
    TabBackground = Color3.fromHex("#18181b"),
    TabTitle = Color3.fromHex("#ffffff"),
    TabIcon = Color3.fromHex("#a1a1aa"),
    ElementBackground = Color3.fromHex("#1c1c1f"),
    ElementTitle = Color3.fromHex("#ffffff"),
    ElementDesc = Color3.fromHex("#a1a1aa"),
    ElementIcon = Color3.fromHex("#a1a1aa"),
    PopupBackground = Color3.fromHex("#101010"),
    PopupBackgroundTransparency = 0,
    PopupTitle = Color3.fromHex("#ffffff"),
    PopupContent = Color3.fromHex("#a1a1aa"),
    PopupIcon = Color3.fromHex("#a1a1aa"),
    Toggle = Color3.fromHex("#2c2c30"),
    ToggleBar = Color3.fromHex("#ffffff"),
    Checkbox = Color3.fromHex("#2c2c30"),
    CheckboxIcon = Color3.fromHex("#ffffff"),
    Slider = Color3.fromHex("#2c2c30"),
    SliderThumb = Color3.fromHex("#ffffff"),
})
WindUI:Gradient({
    ["0"] = { Color = Color3.fromHex("#1f1f23"), Transparency = 0 },
    ["100"] = { Color = Color3.fromHex("#18181b"), Transparency = 0 },
}, {
    Rotation = 0,
})
WindUI:SetTheme("MacOS Dark")
local Window = WindUI:CreateWindow({
    Title = "Pig Hub",
    Icon = "terminal",
    Author = "by ad Pig Synixia",
    Folder = "Admin",
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    ToggleKey = Enum.KeyCode.K,
    Transparent = true,
    Theme = "MacOS Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    Background = "rbxassetid://89402324814559",
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
        end,
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
})
local OpenBtn = Window:EditOpenButton({
    Title = "Pig Hub|Buy key",
    Icon = "rbxassetid://133989391698158",
    CornerRadius = UDim.new(0, 14),
    StrokeThickness = 3,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("#2C2C2E")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#45454a"))
    }),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})
task.spawn(function()
    while true do
        TweenService:Create(
            OpenBtn,
            TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            { Rotation = 8 }
        ):Play()
        task.wait(6)
        TweenService:Create(
            OpenBtn,
            TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
            { Rotation = -8 }
        ):Play()
        task.wait(6)
    end
end)
local currentTag
local frames = 0
local lastTime = os.clock()
local function createTag(fps)
    if currentTag then
        pcall(function()
            currentTag:Destroy()
        end)
        currentTag = nil
    end
    currentTag = Window:Tag({
        Title = "FPS: " .. fps,
        Icon = "activity",
        Color = Color3.fromHex("#0fff3b"),
        Radius = 8,
    })
end
createTag(0)
RunService.RenderStepped:Connect(function()
    frames += 1
    if os.clock() - lastTime >= 1 then
        local fps = frames
        frames = 0
        lastTime = os.clock()
        createTag(fps)
    end
end)
Window:Tag({
    Title = "v1.0.0",
    Icon = "tag",
    Color = Color3.fromHex("#ff443d"),
    Radius = 8,
})
Window:Tag({
    Title = "Synixia",
    Icon = "library",
    Color = Color3.fromHex("#efff3d"),
    Radius = 8,
})
local Tabs = {}
Tabs.Home = Window:Tab({
    Title = "Home",
    Icon = "house",
    Locked = false,
})
Tabs.General = Window:Tab({
    Title = "General",
    Icon = "sliders",
    Locked = false,
})
Tabs.Vehicle = Window:Tab({
    Title = "Vehicle",
    Icon = "car",
    Locked = false,
})
Tabs.Visual = Window:Tab({
    Title = "Visual",
    Icon = "eye",
    Locked = false,
})
Tabs.Pvp = Window:Tab({
    Title = "PVP",
    Icon = "target",
    Locked = false,
})
Tabs.GunMod = Window:Tab({
    Title = "Gun Mod",
    Icon = "zap",
    Locked = false,
})
Tabs.Miscellaneous = Window:Tab({
    Title = "Misc",
    Icon = "settings",
    Locked = false,
})
Tabs.Server = Window:Tab({
    Title = "Server",
    Icon = "server",
    Locked = false,
})
Tabs.Custom = Window:Tab({
    Title = "Custom",
    Icon = "bar-chart-3",
    Locked = false,
})
Tabs.Config = Window:Tab({
    Title = "Config",
    Icon = "save",
    Locked = false,
})
local HomeTab = Tabs.Home
HomeTab:Button({
    Title = "Copy Discord Link",
    Color = Color3.fromHex("#5865F2"),
    Justify = "Center",
    IconAlign = "Left",
    Icon = "link",
    Callback = function()
        setclipboard("https://discord.gg/Kzx78XyCt")
        WindUI:Notify({
            Title = "Copied!",
            Content = "Discord invite copied to clipboard",
            Duration = 3,
            Icon = "check",
        })
    end
})
HomeTab:Button({
    Title = "Open TikTok",
    Color = Color3.fromHex("#000000"),
    Justify = "Center",
    IconAlign = "Left",
    Icon = "music",
    Callback = function()
        setclipboard("https://tiktok.com/@pighub123")
        WindUI:Notify({
            Title = "Copied!",
            Content = "TikTok link copied to clipboard",
            Duration = 3,
            Icon = "check",
        })
    end
})
local Paragraph = HomeTab:Paragraph({
    Title = "About Script",
    Desc = "Welcome to Pig Hub. A powerful and user-friendly script designed for smooth performance, stability, and efficiency. Regularly updated with new features and improvements to provide the best experience possible.",
    Color = Color3.fromHex("#262424"),
    Image = "",
    ImageSize = 80,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
})
Paragraph:SetImage("rbxassetid://113696588380146")
local generalTab = Tabs.General
local moneySec = generalTab:Section({
    Title = "💰 ระบบการเงินของฉัน",
    Box = false,
    TextSize = 17,
    Opened = true
})
local moneyDisplay = moneySec:Code({
    Title = "",
    Code = "กำลังโหลดข้อมูลเงินค่ะ..."
})
task_spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local Data = require(ReplicatedStorage.Modules.Core.Data)
            local bankAmount = Data.money.bank
            local handAmount = Data.money.hand
            local totalAmount = bankAmount + handAmount
            moneyDisplay:SetCode(string.format([[
═══════════════════════════════════
          💰 ระบบการเงิน 💰
═══════════════════════════════════

  🏦 ธนาคาร            : $%s
  💵 เงินสดในมือ      : $%s
  ───────────────────────────────
  💎 รวมทั้งหมด        : $%s

═══════════════════════════════════
            ]], 
            tostring(bankAmount), 
            tostring(handAmount),
            tostring(totalAmount)))
        end)
    end
end)
local genSec = generalTab:Section({
    Title = "Humanoid Settings",
    Box = false,
    TextSize = 17,
    Opened = true
})
genSec:Toggle({
    Title = "Speed Custom",
    Desc = "ปรับความเร็วในการเคลื่อนไหวเองได้เลยค่ะ",
    Default = c().SpeedCustom or false,
    Callback = function(state)
        c().SpeedCustom = state
        saveUIState()
    end
})
genSec:Slider({
    Title = "Speed Amount",
    Value = {
        Min = 0.1,
        Max = 10,
        Default = c().SpeedValue or 1
    },
    Callback = function(value)
        c().SpeedValue = value
        saveUIState()
    end
})
genSec:Divider()
genSec:Toggle({
    Title = "Jump Custom",
    Desc = "ปรับแรงกระโดดเองได้เลยค่ะ",
    Default = c().JumpCustom or false,
    Callback = function(state)
        c().JumpCustom = state
        saveUIState()
    end
})
genSec:Slider({
    Title = "Jump Amount",
    Value = {
        Min = 1,
        Max = 25,
        Default = c().JumpValue or 10
    },
    Callback = function(value)
        c().JumpValue = value
        saveUIState()
    end
})
local snapSec = generalTab:Section({
    Title = "ระบบข้างบน",
    Box = false,
    TextSize = 17,
    Opened = true
})
snapSec:Toggle({
    Title = "Snap",
    Desc = "ทำให้ตัวละครลอยขึ้นไปด้านบนได้เลยค่ะ",
    Default = c().Snap or false,
    Callback = function(state)
        c().Snap = state
        saveUIState()
        if state then
            task_spawn(func.Snap)
        end
    end
})
snapSec:Slider({
    Title = "ความสูงในการลอย",
    Value = {
        Min = 1,
        Max = 150,
        Default = c().SnapAmount or 10
    },
    Callback = function(value)
        c().SnapAmount = value
        saveUIState()
    end
})
local sitSec = generalTab:Section({
    Title = "Snap v2",
    Box = false,
    TextSize = 17,
    Opened = true
})
local sitToggle = c().SitHeight ~= nil or false
local heightOffset = c().SitHeight or -3
local sitConnection = nil
sitSec:Toggle({
    Title = "snap v2",
    Desc = "ปรับความสูงได้เลยค่ะ",
    Default = c().SitHeight ~= nil,
    Callback = function(state)
        sitToggle = state
        c().SitHeight = heightOffset
        saveUIState()
        if sitConnection then
            sitConnection:Disconnect()
            sitConnection = nil
        end
        if state then
            local char = Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Sit = true
                sitConnection = RunService.Heartbeat:Connect(function()
                    if sitToggle and char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Sit then
                        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3New(0, heightOffset, 0)
                    end
                end)
            end
        else
            local char = Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Sit = false
            end
        end
    end
})
sitSec:Slider({
    Title = "ปรับความสูงได้เลยค่ะ",
    Value = {
        Min = -5,
        Max = -3,
        Default = c().SitHeight or -3
    },
    Callback = function(value)
        heightOffset = value
        c().SitHeight = value
        saveUIState()
    end
})
Client.CharacterAdded:Connect(function(newChar)
    Character = newChar
    if sitToggle then
        task.wait(0.5)
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.Sit = true
            if sitConnection then
                sitConnection:Disconnect()
                sitConnection = nil
            end
            sitConnection = RunService.Heartbeat:Connect(function()
                if sitToggle and Character and Character:FindFirstChild("HumanoidRootPart") and Character.Humanoid.Sit then
                    Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + Vector3New(0, heightOffset, 0)
                end
            end)
        end
    end
end)
local grabSec = generalTab:Section({
    Title = "Item Grabber",
    Box = false,
    TextSize = 17,
    Opened = true
})
grabSec:Toggle({
    Title = "Item Drop Grabber",
    Desc = "เก็บของที่อยู่บนพื้นอัตโนมัติเลยค่ะ",
    Default = c().ItemDroppedGraber or false,
    Callback = function(state)
        c().ItemDroppedGraber = state
        saveUIState()
        if state then
            task_spawn(func.ItemDroppedGraber)
        end
    end
})
local etcSec = generalTab:Section({
    Title = "Etc",
    Box = false,
    TextSize = 17,
    Opened = true
})
etcSec:Toggle({
    Title = "Infinity Stamina",
    Desc = "พลังไร้ขีดจำกัดเลยค่ะ",
    Default = c().InfStamina or false,
    Callback = function(state)
        c().InfStamina = state
        saveUIState()
    end
})
etcSec:Toggle({
    Title = "Auto Respawn",
    Desc = "เกิดใหม่อัตโนมัติเมื่อตายค่ะ",
    Default = c().AutoRespawn or false,
    Callback = function(state)
        c().AutoRespawn = state
        saveUIState()
        if state then
            local ds = PlayerGui.DeathScreen.DeathScreenHolder
            if ds.Visible and ds.Frame.RespawnButtonFrame.RespawnButton.TextLabel.Text == "Respawn" then
                Network.send("death_screen_request_respawn")
            end
        end
    end
})
etcSec:Toggle({
    Title = "Hide Name",
    Desc = "ซ่อนชื่อตัวเองค่ะ",
    Default = c().HideName or false,
    Callback = function(state)
        c().HideName = state
        saveUIState()
        if RootPart and RootPart:FindFirstChild("CharacterBillboardGui") then
            RootPart:FindFirstChild("CharacterBillboardGui").Enabled = not state
        end
    end
})
etcSec:Toggle({
    Title = "Anti Ragdoll",
    Desc = "ป้องกันการล้มค่ะ",
    Default = c().AntiRagdoll or false,
    Callback = function(state)
        c().AntiRagdoll = state
        saveUIState()
    end
})
etcSec:Toggle({
    Title = "Anti Died",
    Desc = "ป้องกันการตกตายค่ะ",
    Default = c().AntiDied or false,
    Callback = function(state)
        c().AntiDied = state
        saveUIState()
        if state then
            task_spawn(func.AntiDied)
        end
    end
})
etcSec:Toggle({
    Title = "Anti Aim",
    Desc = "ป้องกันการเล็งค่ะ",
    Default = c().AntiAim or false,
    Callback = function(state)
        c().AntiAim = state
        saveUIState()
    end
})
local autoJumpSec = etcSec:Section({
    Title = "Auto Jump",
    Box = false,
    TextSize = 17,
    Opened = true
})
autoJumpSec:Toggle({
    Title = "Auto Jump",
    Desc = "กระโดดอัตโนมัติเมื่อเท้าถึงพื้น - ใช้หลบหลีกกระสุนของศัตรู",
    Default = false,
    Callback = function(state)
        if state then
            startAutoJump()
        else
            stopAutoJump()
        end
    end
})
local healSec = generalTab:Section({
    Title = "Auto Heal",
    Box = false,
    TextSize = 17,
    Opened = true
})
healSec:Toggle({
    Title = "Auto Heal",
    Desc = "ใช้ไอเท็มรักษาอัตโนมัติค่ะ",
    Default = c().AutoHeal or false,
    Callback = function(state)
        c().AutoHeal = state
        saveUIState()
    end
})
healSec:Slider({
    Title = "Health Percent to Heal",
    Value = {
        Min = 1,
        Max = 100,
        Default = c().HealThreshold or 50
    },
    Callback = function(value)
        c().HealThreshold = value
        saveUIState()
    end
})
local etcSec2 = generalTab:Section({
    Title = "Door Lock",
    Box = false,
    TextSize = 17,
    Opened = true
})
etcSec2:Toggle({
    Title = "Auto Door Lock",
    Desc = "ล็อคประตูอัตโนมัติ - ไม่ต้องมีอนิเมชั่นเปิดประตู",
    Default = c().AutoDoorLock or false,
    Callback = function(state)
        c().AutoDoorLock = state
        saveUIState()
    end
})
local vehicleTab = Tabs.Vehicle
local vehSec = vehicleTab:Section({
    Title = "Vehicle Settings",
    Box = false,
    TextSize = 17,
    Opened = true
})
vehSec:Toggle({
    Title = "Speed Boost Vehicle",
    Desc = "เพิ่มความเร็วยานพาหนะค่ะ",
    Default = c().SpeedBostVehicle or false,
    Callback = function(state)
        c().SpeedBostVehicle = state
        saveUIState()
        if state then
            task_spawn(func.SpeedBostVehicle)
        end
    end
})
vehSec:Slider({
    Title = "Speed Boost Amount",
    Value = {
        Min = 1,
        Max = 80,
        Default = c().VehicleSpeedBost or 20
    },
    Callback = function(value)
        c().VehicleSpeedBost = value
        saveUIState()
    end
})
local miscVeh = vehicleTab:Section({
    Title = "Miscellaneous",
    Box = false,
    TextSize = 17,
    Opened = true
})
miscVeh:Button({
    Title = "Pull Your Vehicle",
    Desc = "ดึงยานพาหนะของคุณมาเลยค่ะ",
    Callback = function()
        local VehicleFolder = workspace:FindFirstChild("Vehicles")
        if VehicleFolder then
            for _, v in pairs(VehicleFolder:GetChildren()) do
                if v:IsA("Model") then
                    local owner = v:GetAttribute("OwnerUserId")
                    if owner and owner == Client.UserId then
                        v:PivotTo(RootPart.CFrame * CFrameNew(0,5,-5))
                        return
                    end
                end
            end
        end
    end
})
miscVeh:Button({
    Title = "Explode Occupied Vehicle",
    Desc = "ระเบิดยานพาหนะที่กำลังขี่อยู่ค่ะ",
    Callback = function()
        local VehicleSystem = require(ReplicatedStorage.Modules.Game.VehicleSystem.Vehicle)
        local Network = require(ReplicatedStorage.Modules.Core.Net)
        for _ = 1, 15 do Network.send("crashed_car", VehicleSystem.get_car_player_is_in(), 150) end
    end
})
local visualTab = Tabs.Visual
local visSec = visualTab:Section({
    Title = "Player ESP",
    Box = false,
    TextSize = 17,
    Opened = true
})
visSec:Toggle({
    Title = "Enemy Glow",
    Desc = "เอฟเฟกต์เรืองแสงสีฟ้าน้ำเงินให้ศัตรูค่ะ",
    Default = c().EnemyGlow or false,
    Callback = function(state)
        c().EnemyGlow = state
        saveUIState()
    end
})
visSec:Toggle({
    Title = "Name ESP",
    Desc = "แสดงชื่อผู้เล่นค่ะ",
    Default = c().NameESP or false,
    Callback = function(state)
        c().NameESP = state
        saveUIState()
    end
})
visSec:Toggle({
    Title = "Distance ESP",
    Desc = "แสดงระยะทางค่ะ",
    Default = c().DistESP or false,
    Callback = function(state)
        c().DistESP = state
        saveUIState()
    end
})
visSec:Toggle({
    Title = "Health Bar ESP",
    Desc = "แสดงแถบเลือดค่ะ",
    Default = c().BarESP or false,
    Callback = function(state)
        c().BarESP = state
        saveUIState()
    end
})
visSec:Toggle({
    Title = "Inventory ESP",
    Desc = "แสดงไอเท็มของผู้เล่นค่ะ",
    Default = c().InvESP or false,
    Callback = function(state)
        c().InvESP = state
        saveUIState()
    end
})
local itemSec = visualTab:Section({
    Title = "Item ESP",
    Box = false,
    TextSize = 17,
    Opened = true
})
itemSec:Toggle({
    Title = "Item ESP",
    Desc = "แสดงไอเท็มที่ตกอยู่ค่ะ",
    Default = c().ItemESP or false,
    Callback = function(state)
        c().ItemESP = state
        DroppedItemESP:Toggle(state)
        saveUIState()
    end
})
itemSec:Toggle({
    Title = "Blacklist Item",
    Desc = "ซ่อนไอเท็มที่ถูกบล็อคลิสต์ค่ะ",
    Default = c().BlacklistItem or false,
    Callback = function(state)
        c().BlacklistItem = state
        saveUIState()
    end
})
itemSec:Dropdown({
    Title = "Select Rarity to Blacklist",
    Values = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Omega"},
    Multi = true,
    Default = c().BlacklistRarity or {},
    Callback = function(selected)
        c().BlacklistRarity = selected
        saveUIState()
    end
})
local lagSec = visualTab:Section({
    Title = "Performance",
    Box = false,
    TextSize = 17,
    Opened = true
})
lagSec:Button({
    Title = "Reduce Lag",
    Desc = "ลดแลคด้วยการปรับกราฟิกให้ต่ำลงค่ะ",
    Callback = function()
        Lighting.FogEnd = 1e10
        Lighting.FogStart = 1e10
        Lighting.Brightness = 1.2
        Lighting.GlobalShadows = false
        Lighting.EnvironmentDiffuseScale = 0.5
        Lighting.EnvironmentSpecularScale = 0.3
        Lighting.ShadowSoftness = 0
        for _, e in pairs(Lighting:GetChildren()) do
            if e:IsA("BloomEffect") then e.Intensity = 0.2 end
            if e:IsA("BlurEffect") then e.Size = 0 end
            if e:IsA("SunRaysEffect") then e.Intensity = 0.1 end
            if e:IsA("ColorCorrectionEffect") then e.Saturation = 0.7 end
        end
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.CastShadow = false
                v.Reflectance = 0
            end
            if v:IsA("Decal") then v.Transparency = 1 end
        end
        if setfpscap then setfpscap(240) end
        WindUI:Notify({Title = "สำเร็จ!", Content = "ลดแลคแล้ว", Duration = 2})
    end
})
local Paragraph = visualTab:Paragraph({
    Title = "ปรับได้ตามสบายเลยนะค่ะขอให้เป็นวันที่ดีน้าา~~",
    Color = Color3.fromHex("#262424"),
    Image = "",
    ImageSize = 100,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
})
Paragraph:SetImage("rbxassetid://78531456063922")
local pvpTab = Tabs.Pvp
local pvpSec = pvpTab:Section({
    Title = "General",
    Box = false,
    TextSize = 17,
    Opened = true
})
pvpSec:Toggle({
    Title = "Silent Aim",
    Desc = "เปิดSilent aimได้เลยค่ะท่านแอดมินได้ปรับแต่งเป็นอย่างดีเลยน้าา",
    Default = c().AimAssist or false,
    Callback = function(state)
        c().AimAssist = state
        if state then
            c().HeadSnapAll = true
        end
        saveUIState()
    end
})
pvpSec:Toggle({
    Title = "Wallbang",
    Desc = "ยิงทะลุกำแพงได้ค่ะ",
    Default = c().Wallbang or false,
    Callback = function(state)
        c().Wallbang = state
        saveUIState()
    end
})
pvpSec:Toggle({
    Title = "Multi Shot",
    Desc = "ยิงสองนัดติดกันค่ะ",
    Default = c().MultiShot or false,
    Callback = function(state)
        c().MultiShot = state
        saveUIState()
    end
})
pvpSec:Toggle({
    Title = "Friend Ignore",
    Desc = "ไม่เล็งเพื่อนค่ะ",
    Default = c().FriendIgnore or false,
    Callback = function(state)
        c().FriendIgnore = state
        saveUIState()
    end
})
pvpSec:Toggle({
    Title = "Rainbow POV",
    Desc = "FOV สีรุ้งสวยๆ ค่ะ",
    Default = c().RainbowPov or false,
    Callback = function(state)
        c().RainbowPov = state
        saveUIState()
    end
})
pvpSec:Dropdown({
    Title = "Aim Target",
    Values = {"Head", "HumanoidRootPart"},
    Multi = false,
    Default = c().AimPart or "Head",
    Callback = function(selected)
        c().AimPart = selected
        saveUIState()
    end
})
pvpSec:Slider({
    Title = "FOV Size",
    Value = {
        Min = 30,
        Max = 800,
        Default = c().PovSize or 150
    },
    Callback = function(value)
        c().PovSize = value
        saveUIState()
    end
})
pvpSec:Slider({
    Title = "FOV Thickness",
    Value = {
        Min = 0.05,
        Max = 2,
        Default = c().FOVThickness or 0.3
    },
    Callback = function(value)
        c().FOVThickness = value
        saveUIState()
    end
})
pvpSec:Dropdown({
    Title = "FOV Mode",
    Values = {"Center", "Follow"},
    Multi = false,
    Default = c().FOVMode or "Center",
    Callback = function(selected)
        c().FOVMode = selected
        fovMode = selected
        saveUIState()
    end
})
local gunTab = Tabs.GunMod
local gunSec = gunTab:Section({
    Title = "Gun Settings",
    Box = false,
    TextSize = 17,
    Opened = true
})
gunSec:Button({
    Title = "ปรับแต่ง",
    Desc = "ปรับแต่งปืนที่คุณกําลังถือโดยทันที",
    Callback = function()
        if not Character:FindFirstChildWhichIsA('Tool') then return end
        for _, GunExampleObject in pairs(ReplicatedStorage.Items.gun:GetChildren()) do
            if Character:FindFirstChildWhichIsA('Tool').Name == GunExampleObject.Name then
                Character:FindFirstChildWhichIsA('Tool'):SetAttribute("fire_rate", (c().FireRateGun or Character:FindFirstChildWhichIsA('Tool'):GetAttribute("fire_rate")))
                Character:FindFirstChildWhichIsA('Tool'):SetAttribute("accuracy", (c().AccuracyGun or Character:FindFirstChildWhichIsA('Tool'):GetAttribute("accuracy")))
                Character:FindFirstChildWhichIsA('Tool'):SetAttribute("Recoil", (c().RecoilGun or Character:FindFirstChildWhichIsA('Tool'):GetAttribute("Recoil")))
                Character:FindFirstChildWhichIsA('Tool'):SetAttribute("Durability", (c().DurabilityGun or Character:FindFirstChildWhichIsA('Tool'):GetAttribute("Durability")))
                Character:FindFirstChildWhichIsA('Tool'):SetAttribute("automatic", (c().AutomaticGun or Character:FindFirstChildWhichIsA('Tool'):GetAttribute("automatic")))
            end
        end
    end
})
gunSec:Toggle({
    Title = "โหมดปืนออโต้ ยิงรัว",
    Desc = "โหมดออโต้",
    Default = c().AutomaticGun or false,
    Callback = function(state)
        c().AutomaticGun = state
        saveUIState()
    end
})
gunSec:Slider({
    Title = "อัตราการยิง",
    Value = {
        Min = 1,
        Max = 3000,
        Default = c().FireRateGun or 1000
    },
    Callback = function(value)
        c().FireRateGun = value
        saveUIState()
    end
})
gunSec:Slider({
    Title = "แรงดีด",
    Value = {
        Min = 0.1,
        Max = 10,
        Default = c().RecoilGun or 0.3
    },
    Callback = function(value)
        c().RecoilGun = value
        saveUIState()
    end
})
gunSec:Slider({
    Title = "ความแม่น",
    Value = {
        Min = 0.01,
        Max = 1,
        Default = c().AccuracyGun or 1
    },
    Callback = function(value)
        c().AccuracyGun = value
        saveUIState()
    end
})
gunSec:Slider({
    Title = "ความทนทาน",
    Value = {
        Min = 1,
        Max = 3000,
        Default = c().DurabilityGun or 1000
    },
    Callback = function(value)
        c().DurabilityGun = value
        saveUIState()
    end
})
local miscTab = Tabs.Miscellaneous
local invSec = miscTab:Section({
    Title = "Invisibility",
    Box = false,
    TextSize = 17,
    Opened = true
})
invSec:Toggle({
    Title = "Desync Invisible",
    Desc = "ทำให้ตัวละครล่องหนแบบ Desync ค่ะ",
    Default = c().Desync or false,
    Callback = function(state)
        local raknetLib = Raknet or raknet
        if not raknetLib then
            WindUI:Notify({Title = "ขอโทษค่ะ", Content = "เอ็กซีคิวเตอร์ของคุณไม่รองรับนะคะ", Duration = 3})
            return
        end
        c().Desync = state
        saveUIState()
        raknetLib.desync(state)
    end
})
invSec:Keybind({
    Title = "Desync Keybind",
    Value = "G",
    Callback = function(key)
        local raknetLib = Raknet or raknet
        if not raknetLib then
            WindUI:Notify({Title = "ขอโทษค่ะ", Content = "เอ็กซีคิวเตอร์ของคุณไม่รองรับนะคะ", Duration = 3})
            return
        end
        local currentState = c().Desync or false
        local newState = not currentState
        c().Desync = newState
        saveUIState()
        raknetLib.desync(newState)
        WindUI:Notify({
            Title = "Desync " .. (newState and "เปิด" or "ปิด"),
            Content = newState and "ล่องหนแล้วค่ะ!" or "กลับมาปรากฏตัวแล้วค่ะ",
            Duration = 2
        })
    end
})
local crateSec = miscTab:Section({
    Title = "Crate System",
    Box = false,
    TextSize = 17,
    Opened = true
})
crateSec:Dropdown({
    Title = "Select Ammo Crate",
    Values = {"Pistol","Rifle","Shotgun","Special"},
    Multi = false,
    Default = c().AmmoCrate or "Pistol",
    Callback = function(selected)
        c().AmmoCrate = selected
        saveUIState()
    end
})
crateSec:Button({
    Title = "Open Ammo Crate",
    Desc = "เปิดกล่องกระสุนเลยค่ะ",
    Callback = function()
        local Network = require(ReplicatedStorage.Modules.Core.Net)
        Network.send("open_crate", workspace.Map.Tiles.GunShopTile.PatriotWeapons.Interior.Crates["Ammo Crate"].CrateOptions[c().AmmoCrate], "money")
    end
})
crateSec:Dropdown({
    Title = "Select Weapon Crate",
    Values = {"Basic","Advanced","Superior","Elite","Legendary"},
    Multi = false,
    Default = c().GunCrate or "Basic",
    Callback = function(selected)
        c().GunCrate = selected
        saveUIState()
    end
})
crateSec:Button({
    Title = "Open Weapon Crate",
    Desc = "เปิดกล่องอาวุธเลยค่ะ",
    Callback = function()
        local Network = require(ReplicatedStorage.Modules.Core.Net)
        Network.send("open_crate", workspace.Map.Tiles.GunShopTile.PatriotWeapons.Interior.Crates["Weapon Crate"].CrateOptions[c().GunCrate], "money")
    end
})
crateSec:Dropdown({
    Title = "Select Car Crate",
    Values = {"Basic","Rare","Elite","Omega"},
    Multi = false,
    Default = c().CarCrate or "Basic",
    Callback = function(selected)
        c().CarCrate = selected
        saveUIState()
    end
})
crateSec:Button({
    Title = "Open Car Crate",
    Desc = "เปิดกล่องรถเลยค่ะ",
    Callback = function()
        local Network = require(ReplicatedStorage.Modules.Core.Net)
        Network.send("open_crate", workspace.Map.Tiles.PrestigeDealerAndHousing.PrestigeCarDealer.Interior.Crates["Car Crate"].CrateOptions[c().CarCrate], "money")
    end
})
local miscSec = miscTab:Section({
    Title = "Other",
    Box = false,
    TextSize = 17,
    Opened = true
})
miscSec:Button({
    Title = "Skip Crate Animation",
    Desc = "ข้ามอนิเมชั่นการเปิดกล่องเลยค่ะ",
    Callback = function()
        local CrateController = require(ReplicatedStorage.Modules.Game.CrateSystem.Crate)
        if CrateController.spinning.get() then return end
        CrateController.skip_spin()
    end
})
miscSec:Button({
    Title = "Complete All Quests",
    Desc = "เคลมเควสทั้งหมดเลยค่ะ",
    Callback = function()
        local Network = require(ReplicatedStorage.Modules.Core.Net)
        local qh = PlayerGui:FindFirstChild('Quests') and PlayerGui:FindFirstChild('Quests'):FindFirstChild('QuestsHolder')
        if qh and qh.QuestsScrollingFrame then
            for _, q in pairs(qh.QuestsScrollingFrame:GetChildren()) do
                if q:IsA("Frame") or q:IsA("TextButton") or q:IsA("ImageButton") then
                    Network.get("claim_quest", q.Name)
                end
            end
        end
    end
})
local serverTab = Tabs.Server
local serverStatusSec = serverTab:Section({Title = "Server Status", Box = false, TextSize = 17, Opened = true})
local infoDisplay = serverStatusSec:Code({
    Title = "",
    Code = "กำลังโหลดข้อมูลเซิร์ฟเวอร์ค่ะ..."
})
task_spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local jobId = game.JobId
            local placeId = game.PlaceId
            local success, ping = pcall(function()
                local start = tick()
                HttpService:GetAsync("https://www.roblox.com/games/" .. placeId .. "?jobId=" .. jobId, true)
                return math.floor((tick() - start) * 1000)
            end)
            local pingText = success and (ping .. " ms") or "ล้มเหลวค่ะ"
            local playerCount = #Players:GetPlayers()
            infoDisplay:SetCode(string.format([[
Server Information
/
Job ID: %s
Players: %d
Ping: %s
            ]], jobId:sub(1, 12).."...", playerCount, pingText))
        end)
    end
end)
local serverControlSec = serverTab:Section({Title = "Server Control", Box = false, TextSize = 17, Opened = true})
local friendJobIdInput = serverControlSec:Input({
    Title = "Friend's Server Job ID",
    Placeholder = "วาง Job ID ตรงนี้เลยค่ะ...",
    Default = c().FriendJobId or "",
    Callback = function(text)
        c().FriendJobId = text
        saveUIState()
    end
})
serverControlSec:Button({
    Title = "Teleport to Friend's Server",
    Desc = "เทเลพอร์ตไปเซิร์ฟเวอร์เพื่อนเลยค่ะ",
    Callback = function()
        local jobId = c().FriendJobId or ""
        if jobId and jobId ~= "" then
            WindUI:Notify({Title = "กำลังเทเลพอร์ตค่ะ", Content = "ไปเซิร์ฟเวอร์เพื่อน...", Duration = 2})
            pcall(function()
                TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, Client)
            end)
        else
            WindUI:Notify({Title = "ขอโทษค่ะ", Content = "กรุณาใส่ Job ID ให้ถูกต้องนะคะ", Duration = 3})
        end
    end
})
serverControlSec:Divider()
serverControlSec:Button({
    Title = "Rejoin Server",
    Desc = "เข้าเซิร์ฟเวอร์ใหม่เลยค่ะ",
    Callback = function()
        WindUI:Notify({Title = "กำลังเข้าใหม่ค่ะ", Content = "เข้าเซิร์ฟเวอร์ใหม่...", Duration = 2})
        TeleportService:Teleport(game.PlaceId, Client)
    end
})
local customTab = Tabs.Custom
local mainSection = customTab:Section({Title = "Real-time Data", Box = false, TextSize = 17, Opened = true})
local mainDisplay = mainSection:Code({
    Title = "",
    Code = "กำลังโหลดข้อมูลค่ะ..."
})
task_spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local char = Character
            local lines = {}
            if char and char:FindFirstChild("HumanoidRootPart") then
                local pos = char.HumanoidRootPart.Position
                local hum = char:FindFirstChildOfClass("Humanoid")
                local health = hum and math.floor(hum.Health) or 0
                local maxHealth = hum and math.floor(hum.MaxHealth) or 100
                local speed = hum and math.floor(hum.WalkSpeed) or 0
                table.insert(lines, "พิกัด")
                table.insert(lines, "/")
                table.insert(lines, string.format("X: %.2f", pos.X))
                table.insert(lines, string.format("Y: %.2f", pos.Y))
                table.insert(lines, string.format("Z: %.2f", pos.Z))
                table.insert(lines, "")
                table.insert(lines, string.format("HEALTH: %d / %d", health, maxHealth))
                table.insert(lines, string.format("SPEED: %d", speed))
                table.insert(lines, "")
            else
                table.insert(lines, "ไม่พบตัวละครค่ะ")
                table.insert(lines, "")
            end
            mainDisplay:SetCode(table.concat(lines, "\n"))
        end)
    end
end)
local actionSection = customTab:Section({Title = "Quick Actions", Box = false, TextSize = 17, Opened = true})
actionSection:Button({
    Title = "Copy Coordinates",
    Desc = "คัดลอกตำแหน่งที่อยู่ไปคลิปบอร์ดเลยค่ะ",
    Callback = function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            local pos = Character.HumanoidRootPart.Position
            local posStr = string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z)
            if setclipboard then
                setclipboard(posStr)
                WindUI:Notify({Title = "คัดลอกแล้วค่ะ!", Content = posStr, Duration = 2})
            else
                WindUI:Notify({Title = "ขอโทษค่ะ", Content = "setclipboard ไม่รองรับนะคะ", Duration = 2})
            end
        end
    end
})
actionSection:Button({
    Title = "Refresh Data",
    Desc = "รีเฟรชข้อมูลทั้งหมดเลยค่ะ",
    Callback = function()
        WindUI:Notify({Title = "รีเฟรชแล้วค่ะ!", Content = "อัปเดตข้อมูลเรียบร้อยนะคะ", Duration = 1})
    end
})
local configTab = Tabs.Config
local configSection = configTab:Section({
    Title = "📁 ระบบจัดการ Config",
    Box = false,
    TextSize = 17,
    Opened = true
})
local configStatusDisplay = configSection:Code({
    Title = "",
    Code = "กำลังโหลดข้อมูล Config ค่ะ..."
})
local function updateConfigStatus()
    local hasConfig = isfile(CONFIG_FILE)
    local hasUIState = isfile(UI_STATE_FILE)
    local lines = {}
    if hasConfig then
        table.insert(lines, "✅ มีไฟล์ Config: settings.json")
    else
        table.insert(lines, "❌ ไม่มีไฟล์ Config")
    end
    if hasUIState then
        table.insert(lines, "✅ มีไฟล์ UI State: ui_state.json")
    else
        table.insert(lines, "❌ ไม่มีไฟล์ UI State")
    end
    if hasConfig or hasUIState then
        table.insert(lines, "\n📂 ตำแหน่ง: " .. CONFIG_FOLDER)
    else
        table.insert(lines, "\n💡 ตั้งค่าต่างๆ แล้วกด '💾 บันทึก Config'")
    end
    configStatusDisplay:SetCode(table.concat(lines, "\n"))
end
updateConfigStatus()
configSection:Button({
    Title = "💾 บันทึก Config",
    Desc = "บันทึกการตั้งค่าทั้งหมดที่ใช้อยู่ตอนนี้",
    Callback = function()
        saveConfig()
        saveUIState()
        WindUI:Notify({Title = "✅ บันทึกสำเร็จ!", Content = "บันทึกการตั้งค่าปัจจุบันแล้วค่ะ", Duration = 2})
        updateConfigStatus()
    end
})
configSection:Button({
    Title = "📂 โหลด Config",
    Desc = "โหลดการตั้งค่าที่บันทึกไว้ครั้งล่าสุด",
    Callback = function()
        local configLoaded = loadConfig()
        local uiLoaded = loadUIState()
        if configLoaded or uiLoaded then
            WindUI:Notify({Title = "✅ โหลด Config สำเร็จ!", Content = "โหลดการตั้งค่าครั้งล่าสุดแล้วค่ะ", Duration = 2})
            if c().EnemyGlow then task_spawn(func.EnemyGlow) end
            if c().ItemDroppedGraber then task_spawn(func.ItemDroppedGraber) end
            if c().Snap then task_spawn(func.Snap) end
            if c().AntiDied then task_spawn(func.AntiDied) end
            if c().SpeedBostVehicle then task_spawn(func.SpeedBostVehicle) end
            if c().ItemESP then DroppedItemESP:Toggle(true) else DroppedItemESP:Toggle(false) end
            if c().Desync then
                local raknetLib = Raknet or raknet
                if raknetLib then raknetLib.desync(true) end
            end
            if c().AutoRespawn then
                local ds = PlayerGui.DeathScreen.DeathScreenHolder
                if ds.Visible and ds.Frame.RespawnButtonFrame.RespawnButton.TextLabel.Text == "Respawn" then
                    Network.send("death_screen_request_respawn")
                end
            end
            if c().HideName then
                if RootPart and RootPart:FindFirstChild("CharacterBillboardGui") then
                    RootPart:FindFirstChild("CharacterBillboardGui").Enabled = false
                end
            end
            if c().AutoJump then startAutoJump() end
            updateConfigStatus()
        else
            WindUI:Notify({Title = "❌ ไม่พบ Config", Content = "ยังไม่มีไฟล์ Config ที่บันทึกไว้ค่ะ", Duration = 2})
        end
    end
})
configSection:Divider()
configSection:Button({
    Title = "🗑️ ลบ Config ทั้งหมด",
    Desc = "ลบไฟล์ settings.json และ ui_state.json",
    Color = Color3.fromHex("#ff4444"),
    Callback = function()
        local confirmPopup = WindUI:Popup({
            Title = "⚠️ ยืนยันการลบ",
            Content = "คุณแน่ใจหรือไม่ที่จะลบไฟล์ Config และ UI State ทั้งหมด?\n\n" ..
                      "📂 " .. CONFIG_FILE .. "\n" ..
                      "📂 " .. UI_STATE_FILE .. "\n\n" ..
                      "❌ การกระทำนี้ไม่สามารถกู้คืนได้!",
            Icon = "alert-triangle",
            Buttons = {
                {
                    Title = "❌ ยกเลิก",
                    Variant = "Secondary",
                    Callback = function()
                        WindUI:Notify({Title = "ยกเลิกแล้ว", Content = "ไม่มีการลบไฟล์ใดๆ ค่ะ", Duration = 2})
                    end
                },
                {
                    Title = "🗑️ ลบเลย",
                    Variant = "Danger",
                    Callback = function()
                        local deleted = 0
                        if isfile(CONFIG_FILE) then
                            pcall(function() 
                                delfile(CONFIG_FILE)
                                deleted = deleted + 1
                            end)
                        end
                        if isfile(UI_STATE_FILE) then
                            pcall(function() 
                                delfile(UI_STATE_FILE)
                                deleted = deleted + 1
                            end)
                        end
                        c().PIGHUB_LOADED = nil
                        if deleted > 0 then
                            WindUI:Notify({Title = "🗑️ ลบสำเร็จ!", Content = "ลบไฟล์ Config แล้ว " .. deleted .. " ไฟล์ ค่ะ", Duration = 3})
                            updateConfigStatus()
                            WindUI:Notify({Title = "🔄 รีโหลด", Content = "กรุณากดปุ่มโหลด Config เพื่อตั้งค่าใหม่ค่ะ", Duration = 3})
                        else
                            WindUI:Notify({Title = "❌ ไม่พบไฟล์", Content = "ไม่มีไฟล์ Config ให้ลบค่ะ", Duration = 2})
                        end
                    end
                }
            }
        })
    end
})
local Popup = WindUI:Popup({
    Title = "ยินดีต้อนรับนะคะ ✨",
    Content = "ขอบคุณที่เลือกใช้ Pig Hub ค่ะ\n\n" ..
              "💖 ขอให้ทุกคนสนุกกับฟีเจอร์ต่าง ๆ ภายในสคริปต์นะคะ\n" ..
              "🌷 หากพบปัญหาหรือมีข้อเสนอแนะ สามารถแจ้งทีมงานได้เลยค่ะ",
    Icon = "rbxassetid://84104441047896",
    Buttons = {
        {
            Title = "เข้าใจแล้วค่ะ 💕",
            Variant = "Primary",
            Callback = function()
                WindUI:Notify({
                    Title = "ขอบคุณนะคะ 🌷",
                    Content = "ขอให้สนุกกับการใช้งาน Pig Hub ค่ะ",
                    Duration = 3
                })
            end
        }
    }
})