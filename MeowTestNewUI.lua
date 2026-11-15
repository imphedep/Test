loadstring(game:HttpGet("https://raw.githubusercontent.com/imphedep/core/refs/heads/main/PheYeuPhe.lua"))()

pcall(function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", false)
end)


-- ==========================================
-- CHẶN ÂM THANH RÁC TỪ ĐẦU (CHỐNG LAG & SPAM LOG)
-- ==========================================
local badSoundId = "74728593468749"
local RunService = game:GetService("RunService")

local function killSound(obj)
    if obj:IsA("Sound") and string.find(obj.SoundId, badSoundId) then
        obj:Destroy()
    end
end

-- Quét ngay lập tức các âm thanh đang có sẵn trong game
for _, v in pairs(game:GetDescendants()) do
    killSound(v)
end

-- Hook để chặn ngay khi nó vừa được sinh ra
game.DescendantAdded:Connect(killSound)
workspace.DescendantAdded:Connect(killSound)
game:GetService("SoundService").DescendantAdded:Connect(killSound)

-- Quét liên tục mỗi frame để bóp nghẹt nó nếu nó lọt qua khe hở
RunService.Heartbeat:Connect(function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Sound") and string.find(v.SoundId, badSoundId) then
            v:Destroy()
        end
    end
end)

-- ==========================================
-- KHỞI TẠO FLUENTPLUS
-- ==========================================
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/release.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

local v2 = lib:CreateWindow({
    Title = "Meow Hub",
    SubTitle = "Blox Fruit [ BETA ]",
    TitleIcon = "rbxassetid://114761144239319",
    Image = "rbxassetid://114761144239319",
    DropdownsOutsideWindow = true,
    Size = UDim2.fromOffset(580, 460),
    TabWidth = 160,
    Acrylic = true,
    Theme = "Dark",
    Search = true,
    MinimizeKey = Enum.KeyCode.LeftControl,
    UserInfo = false,
    UserInfoTop = true,
    UserInfoTitle = game:GetService("Players").LocalPlayer.DisplayName,
    UserInfoSubtitle = "User",
    UserInfoSubtitleColor = Color3.fromRGB(255, 255, 255)
})

if v2 and v2.Root then
    v2.Root.ClipsDescendants = true
end

SaveManager:SetLibrary(lib)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("MeowHub")
SaveManager:BuildConfigSection(v2:AddTab({ Title = "Configs", Icon = "settings" }))
SaveManager:LoadAutoloadConfig()

-- ==========================================
-- TẮT AUTO TRANSLATE CỦA ROBLOX
-- ==========================================
local function DisableAutoLocalize(inst)
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
        pcall(function()
            inst.AutoLocalize = false
        end)
    end
end

task.spawn(function()
    task.wait(0.5)
    local root = v2.Root or v2.Frame or v2.Gui
    if root then
        for _, obj in ipairs(root:GetDescendants()) do
            DisableAutoLocalize(obj)
        end
        root.DescendantAdded:Connect(DisableAutoLocalize)
    end
end)

-- ==========================================
-- TẠO CÁC TAB
-- ==========================================
local t1 = {
    Info = v2:AddTab({
        Title = "Info And Status",
        Icon = "info",
        Description = "Thông Tin & Trạng Thái"
    }),
    Main = v2:AddTab({
        Title = "Farming",
        Icon = "sword",
        Description = "Tự Động Farm"
    }),
    Settings = v2:AddTab({
        Title = "Setting",
        Icon = "settings",
        Description = "Cài Đặt Chung"
    }),
    Fish = v2:AddTab({
        Title = "Fishing",
        Icon = "anchor",
        Description = "Câu Cá"
    }),
    Quests = v2:AddTab({
        Title = "Quest And Item",
        Icon = "scroll",
        Description = "Nhiệm Vụ & Vật Phẩm"
    }),
    SeaEvent = v2:AddTab({
        Title = "Sea Event",
        Icon = "compass",
        Description = "Sự Kiện Biển"
    }),
    Race = v2:AddTab({
        Title = "Mirage And Race",
        Icon = "moon",
        Description = "Ảo Ảnh & Chủng Tộc"
    }),
    Prehistoric = v2:AddTab({
        Title = "Volcano Event",
        Icon = "flame",
        Description = "Sự Kiện Núi Lửa"
    }),
    Esp = v2:AddTab({
        Title = "Stats And Esp",
        Icon = "eye",
        Description = "Chỉ Số & Esp"
    }),
    Raids = v2:AddTab({
        Title = "Fruit And Raid",
        Icon = "skull",
        Description = "Trái & Raid"
    }),
    Combat = v2:AddTab({
        Title = "Local Player",
        Icon = "crosshair",
        Description = "Người Chơi"
    }),
    Travel = v2:AddTab({
        Title = "Teleport",
        Icon = "map-pin",
        Description = "Dịch Chuyển"
    }),
    Shop = v2:AddTab({
        Title = "Shopping",
        Icon = "shopping-cart",
        Description = "Cửa Hàng"
    }),
    Misc = v2:AddTab({
        Title = "Miscellaneous",
        Icon = "more-horizontal",
        Description = "Khác"
    })
}

-- ==========================================
-- TOGGLE DRAGON HUB
-- ==========================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MeowHubDragonToggle"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = game:GetService("CoreGui")

local ToggleFrame = Instance.new("Frame")
ToggleFrame.Name = "ToggleFrame"
ToggleFrame.Parent = ScreenGui
ToggleFrame.Size = UDim2.new(0, 44, 0, 44)
ToggleFrame.Position = UDim2.new(0, 15, 0, 80)
ToggleFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
ToggleFrame.BackgroundTransparency = 0.05
ToggleFrame.BorderSizePixel = 0
ToggleFrame.Active = true
ToggleFrame.ClipsDescendants = true

local ToggleCorner = Instance.new("UICorner", ToggleFrame)
ToggleCorner.CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleFrame)
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Transparency = 0.3

local Icon = Instance.new("ImageLabel")
Icon.Parent = ToggleFrame
Icon.Size = UDim2.new(0.8, 0, 0.8, 0)
Icon.Position = UDim2.new(0.1, 0, 0.1, 0)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://114761144239319"
Icon.ScaleType = Enum.ScaleType.Fit
Icon.Name = "Icon"
Icon.ZIndex = 2

local IconCorner = Instance.new("UICorner", Icon)
IconCorner.CornerRadius = UDim.new(1, 0)

local isMenuOpen = true
local isKilled = false

local function ToggleMenuInstant()
    if isKilled then return end
    local root = nil
    pcall(function()
        root = v2.Root
    end)
    if root then
        isMenuOpen = not isMenuOpen
        if isMenuOpen then
            root.Size = UDim2.new(0, 580, 0, 460)
            root.Visible = true
        else
            root.Visible = false
        end
    end
end

local function PlayToggleAnimation()
    if isKilled then return end
    TweenService:Create(ToggleFrame, TweenInfo.new(0.08), {
        Size = UDim2.new(0, 38, 0, 38)
    }):Play()
    ToggleMenuInstant()
    task.delay(0.1, function()
        TweenService:Create(ToggleFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 44, 0, 44)
        }):Play()
    end)
end

ToggleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        PlayToggleAnimation()
    end
end)

local dragging, dragInput, dragStart, startPos
ToggleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleFrame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local CtrlDown = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or isKilled then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        if CtrlDown then return end
        CtrlDown = true
        PlayToggleAnimation()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        CtrlDown = false
    end
end)

local function KillScript()
    if isKilled then return end
    isKilled = true
    for k, v in pairs(_G) do
        if type(v) == "boolean" then _G[k] = false end
    end
    pcall(function()
        v2:Destroy()
    end)
    pcall(function()
        ScreenGui:Destroy()
    end)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Meow Hub",
        Text = "The script has been compeletely turn off!",
        Duration = 3
    })
end

task.spawn(function()
    task.wait(1)
    local root = nil
    pcall(function()
        root = v2.Root
    end)
    if root then
        for _, v in ipairs(root:GetDescendants()) do
            if v:IsA("TextButton") and (v.Name == "Close" or v.Name == "X" or v.Text == "X" or v.Text == "×") then
                v.MouseButton1Click:Connect(function()
                    KillScript()
                end)
                break
            end
        end
    end
end)

-- ==========================================
-- HẾT PHẦN TOGGLE
-- ==========================================

local function v4(p1)
    local AddDropdown = p1.AddDropdown
    if AddDropdown then
        p1.AddDropdown = function(p2, p3, p4)
            local Callback = p4.Callback
            local Default = p4.Default
            local Values = p4.Values or {}
            local v9 = AddDropdown(p2, p3, p4)
            if v9 and v9.OnChanged and Callback then
                v9:OnChanged(function(p5)
                    Callback(p5)
                end)
            end
            local Value
            if v9 and v9.Value ~= nil then
                Value = v9.Value
            elseif type(Default) ~= "number" or Values[Default] == nil then
                Value = Default
            else
                Value = Values[Default]
            end
            if Value ~= nil and Callback then
                task.spawn(function()
                    pcall(Callback, Value)
                end)
            end
            return v9
        end
    end
    local AddSection = p1.AddSection
    if AddSection then
        p1.AddSection = function(p6, p7)
            local v12 = AddSection(p6, p7)
            v4(v12)
            return v12
        end
    end
end

for _, v in pairs(t1) do
    v4(v)
end

_G.ChooseWP = _G.ChooseWP or "Melee"
_G.SelectedBoat = _G.SelectedBoat or "Guardian"
_G.DangerSc = _G.DangerSc or "Lv 1"
_G.SelectIslandMastery = _G.SelectIslandMastery or "Cake"
getgenv().SelectIslandMastery = getgenv().SelectIslandMastery or "Cake"

-- ==========================================
-- TAB INFO
-- ==========================================
GRP_Info_Status_Server = t1.Info:AddSection("Status Server", "Trạng thái của server")
local v15 = GRP_Info_Status_Server:AddParagraph({
    Title = "Game Time",
    Description = "Thời gian trong game",
    Content = ""
})

UpdateGameTime = function()
    local v16 = math.floor(workspace.DistributedGameTime + 0.5)
    v15:SetDesc(math.floor(v16 / 3600) % 24 .. " Hour (h) " .. math.floor(v16 / 60) % 60 .. " Minute (m) " .. math.floor(v16 / 1) % 60 .. " Second (s)")
end

spawn(function()
    while true do
        UpdateGameTime()
        wait(1)
    end
end)

do
    local v17 = GRP_Info_Status_Server:AddParagraph({
        Title = "Mirage Island",
        Description = "Đảo Ảo Ảnh",
        Content = "Status: "
    })
    local s1 = ""
    spawn(function()
        pcall(function()
            while true do
                wait(1)
                local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil and "✅" or "❌"
                if status ~= s1 then
                    v17:SetDesc("Status: " .. status)
                    s1 = status
                end
            end
        end)
    end)
end

do
    local v20 = GRP_Info_Status_Server:AddParagraph({
        Title = "Kitsune Island",
        Description = "Đảo Cáo Kitsune",
        Content = "Status: "
    })
    local s2 = ""
    spawn(function()
        while task.wait(1) do
            local status = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and "✅" or "❌"
            if status ~= s2 then
                v20:SetDesc("Status: " .. status)
                s2 = status
            end
        end
    end)
end

do
    local v23 = GRP_Info_Status_Server:AddParagraph({
        Title = "Prehistoric Island",
        Description = "Đảo Tiền Sử",
        Content = "Status: "
    })
    local s3 = ""
    task.spawn(function()
        while task.wait(1) do
            local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and "✅" or "❌"
            if status ~= s3 then
                v23:SetDesc("Status: " .. status)
                s3 = status
            end
        end
    end)
end

do
    local v26 = GRP_Info_Status_Server:AddParagraph({
        Title = "Frozen Dimension",
        Description = "Chiều Không Gian Băng Giá",
        Content = "Status: "
    })
    local s4 = ""
    spawn(function()
        while wait(1) do
            local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") and "✅" or "❌"
            if status ~= s4 then
                v26:SetDesc("Status: " .. status)
                s4 = status
            end
        end
    end)
end

do
    local v29 = GRP_Info_Status_Server:AddParagraph({
        Title = "Rip Indra",
        Description = "Trùm Rip Indra",
        Content = "Status: "
    })
    local s5 = ""
    spawn(function()
        while wait(1) do
            local status = (game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and "✅" or "❌"
            if status ~= s5 then
                v29:SetDesc("Status: " .. status)
                s5 = status
            end
        end
    end)
end

do
    local v32 = GRP_Info_Status_Server:AddParagraph({
        Title = "Dough King",
        Description = "Trùm Dough King",
        Content = "Status: "
    })
    local s6 = ""
    spawn(function()
        while wait(1) do
            local status = (game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and "✅" or "❌"
            if status ~= s6 then
                v32:SetDesc("Status: " .. status)
                s6 = status
            end
        end
    end)
end

local v35 = GRP_Info_Status_Server:AddParagraph({
    Title = "Full Moon",
    Description = "Trăng Tròn (Dùng để tiến hóa race V4)",
    Content = ""
})

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local MoonTextureId = game:GetService("Lighting").Sky.MoonTextureId
            local s7 = "Moon: 0/5"
            if MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                s7 = "Moon: 5/5 (Full Moon) ✅"
            elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                s7 = "Moon: 4/5"
            elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                s7 = "Moon: 3/5"
            elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                s7 = "Moon: 2/5"
            elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                s7 = "Moon: 1/5"
            end
            v35:SetDesc(s7)
        end)
    end
end)

do
    local v38 = GRP_Info_Status_Server:AddParagraph({
        Title = "Legendary Sword",
        Description = "Kiếm Huyền Thoại (Shisui, Wando, Saddi)",
        Content = "Status: "
    })
    spawn(function()
        while wait(1) do
            pcall(function()
                local s8 = "Not Found"
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                    s8 = "Shisui ✅"
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
                    s8 = "Wando ✅"
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
                    s8 = "Saddi ✅"
                end
                v38:SetDesc(s8)
            end)
        end
    end)
end

do
    local v40 = GRP_Info_Status_Server:AddParagraph({
        Title = "Cake Prince",
        Description = "Trùm Bánh Kem",
        Content = ""
    })
    spawn(function()
        while wait(1) do
            pcall(function()
                local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                local s9 = "Cake Prince: ✅"
                if type(response) == "string" and string.len(response) >= 86 then
                    s9 = "Killed: " .. string.sub(response, 39, 41)
                end
                v40:SetDesc(s9)
            end)
        end
    end)
end

local v43 = GRP_Info_Status_Server:AddParagraph({
    Title = "Bone",
    Description = "Xương (Tiền tệ sự kiện Halloween)",
    Content = ""
})

spawn(function()
    while wait(1) do
        pcall(function()
            local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            v43:SetDesc("You Have: " .. tostring(response) .. " Bones")
        end)
    end
end)

-- ==========================================
-- TAB MAIN
-- ==========================================
GRP_Main_Select_Weapon = t1.Main:AddSection("Select Weapon", "Chọn vũ khí để tự động đánh")

do
    WeaponDropdown = GRP_Main_Select_Weapon:AddDropdown("Select_Weapon", {
        Title = "Select Weapon",
        Description = "Chọn Vũ Khí (Cận chiến, Kiếm, Trái, Súng)",
        Values = { "Melee", "Sword", "Blox Fruit", "Gun" },
        Default = "Melee",
        Callback = function(p8)
            _G.ChooseWP = p8
        end
    })
end

GRP_Main_Farming = t1.Main:AddSection("Farming", "Cày Cuốc Cơ Bản")

FarmLevel = GRP_Main_Farming:AddToggle("Auto_Farm_Level", {
    Title = "Auto Farm Level",
    Description = "Tự Động Cày Cấp Độ",
    Default = false,
    Callback = function(p9)
        _G.Level = p9
    end
})

ClosetMons = GRP_Main_Farming:AddToggle("Auto_Farm_Nearest", {
    Title = "Auto Farm Nearest",
    Description = "Tự Động Đánh Quái Gần Nhất",
    Default = false,
    Callback = function(p10)
        _G.AutoFarmNear = p10
    end
})

FactoryRaids = GRP_Main_Farming:AddToggle("Auto_Factory_Raid", {
    Title = "Auto Factory Raid",
    Description = "Tự Động Raid Xưởng (Factory)",
    Default = false,
    Callback = function(p11)
        _G.AutoFactory = p11
    end
})

CastleRaids = GRP_Main_Farming:AddToggle("Auto_Pirate_Raid", {
    Title = "Auto Pirate Raid",
    Description = "Tự Động Raid Lâu Đài Hải Tặc",
    Default = false,
    Callback = function(p12)
        _G.AutoRaidCastle = p12
    end
})

Ecto = GRP_Main_Farming:AddToggle("Auto_Farm_Ectoplasm", {
    Title = "Auto Farm Ectoplasm",
    Description = "Tự Động Cày Dịch Ma (Ectoplasm)",
    Default = false,
    Callback = function(p13)
        _G.AutoEctoplasm = p13
    end
})

GRP_Main_Chest = t1.Main:AddSection("Chest", "Rương")

ChestTW = GRP_Main_Chest:AddToggle("Auto_Farm_Chest", {
    Title = "Auto Farm Chest",
    Description = "Tự Động Mở Rương",
    Default = false,
    Callback = function(p14)
        _G.AutoFarmChest = p14
    end
})

do
    ChestBP = GRP_Main_Chest:AddToggle("Auto_Chest_Bypass", {
        Title = "Auto Chest Bypass",
        Description = "Tự Động Xuyên Tường Mở Rương (Bypass)",
        Default = false,
        Callback = function(p15)
            _G.AutoChestBP = p15
            if p15 then
                local LocalPlayer = game:GetService("Players").LocalPlayer
                local u46 = false
                local t2 = {}
                local u48 = true

                local function v49()
                    if not LocalPlayer.Character then
                        LocalPlayer.CharacterAdded:Wait()
                    end
                    LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                    return LocalPlayer.Character
                end

                local function v50()
                    if u48 then
                        u48 = false
                        for _, descendant in pairs(game:GetDescendants()) do
                            if descendant.Name:find("Chest") and descendant.ClassName == "Part" then
                                table.insert(t2, descendant)
                            end
                        end
                    end
                    local t3 = {}
                    for _, v in pairs(t2) do
                        if v:FindFirstChild("TouchInterest") then
                            table.insert(t3, v)
                        end
                    end
                    local LowerTorso = v49().LowerTorso
                    table.sort(t3, function(p16, p17)
                        return (LowerTorso.Position - p16.Position).Magnitude < (LowerTorso.Position - p17.Position).Magnitude
                    end)
                    return t3
                end

                local function v57()
                    if u46 then
                        return
                    end
                    u46 = true
                    task.spawn(function()
                        if _G.AutoChestBP and LocalPlayer.Character and LocalPlayer.Character.Parent then
                            repeat
                                local v58 = v50()
                                if #v58 > 0 then
                                    v49().HumanoidRootPart.CFrame = v58[1].CFrame
                                end
                                task.wait(0.1)
                            until not _G.AutoChestBP or not LocalPlayer.Character or not LocalPlayer.Character.Parent
                        end
                        u46 = false
                    end)
                end

                LocalPlayer.CharacterAdded:Connect(function()
                    v49()
                    task.wait(0.5)
                    if _G.AutoChestBP then
                        v57()
                    end
                end)
                v57()
            end
        end
    })
end

do
    StopI = GRP_Main_Chest:AddToggle("Stop_Items", {
        Title = "Stop Farm for FOD & Chalice",
        Description = "Dừng Farm Khi Có Trái FOD & Chalice",
        Default = true,
        Callback = function(p18)
            _G.StopWhenChalice = p18
        end
    })
end

GRP_Main_Collect_Berry = t1.Main:AddSection("Berry", "Quả Berry")

Berry = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry", {
    Title = "Auto Farm Berry",
    Description = "Tự Động Cày Quả Berry",
    Default = false,
    Callback = function(p19)
        _G.AutoBerry = p19
    end
})

do
    BerryH = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry_+_Hop", {
        Title = "Auto Farm Berry + Hop",
        Description = "Tự Động Cày Berry + Chuyển Server Liên Tục",
        Default = false,
        Callback = function(p20)
            _G.AutoBerryH = p20
        end
    })
end

GRP_Main_Farm_Mob = t1.Main:AddSection("Farm Mob", "Farm Quái Theo Loại")

do
    if World1 then
        GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
            Title = "Select Mob",
            Description = "Chọn Quái (Sea 1)",
            Values = {
                "Bandit", "Monkey", "Gorilla", "Pirate", "Brute", "Desert Bandit", "Desert Officer",
                "Snow Bandit", "Snowman", "Chief Petty Officer", "Sky Bandit", "Dark Master",
                "Toga Warrior", "Gladiator", "Military Soldier", "Military Spy", "Fishman Warrior",
                "Fishman Commando", "God's Guard", "Shanda", "Royal Squad", "Royal Soldier",
                "Galley Pirate", "Galley Captain"
            },
            Default = 1,
            Callback = function(p21)
                getgenv().SelectMob = p21
            end
        })
    elseif World2 then
        GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
            Title = "Select Mob",
            Description = "Chọn Quái (Sea 2)",
            Values = {
                "Raider", "Mercenary", "Swan Pirate", "Factory Staff", "Marine Lieutenant",
                "Marine Captain", "Zombie", "Vampire", "Snow Trooper", "Winter Warrior",
                "Lab Subordinate", "Horned Warrior", "Magma Ninja", "Lava Pirate",
                "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer",
                "Arctic Warrior", "Snow Lurker", "Sea Soldier", "Water Fighter"
            },
            Default = 1,
            Callback = function(p22)
                getgenv().SelectMob = p22
            end
        })
    elseif World3 then
        GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
            Title = "Select Mob",
            Description = "Chọn Quái (Sea 3)",
            Values = {
                "Pirate Millionaire", "Dragon Crew Warrior", "Dragon Crew Archer",
                "Female Islander", "Giant Islander", "Marine Commodore", "Marine Rear Admiral",
                "Fishman Raider", "Fishman Captain", "Forest Pirate", "Mythological Pirate",
                "Jungle Pirate", "Musketeer Pirate", "Reborn Skeleton", "Living Zombie",
                "Demonic Soul", "Posessed Mummy", "Peanut Scout", "Peanut President",
                "Ice Cream Chef", "Ice Cream Commander", "Cookie Crafter", "Cake Guard",
                "Baking Staff", "Head Baker", "Cocoa Warrior", "Chocolate Bar Battler",
                "Sweet Thief", "Candy Rebel", "Candy Pirate", "Snow Demon", "Isle Outlaw",
                "Island Boy", "Sun-kissed Warrior", "Isle Champion"
            },
            Default = 1,
            Callback = function(p23)
                getgenv().SelectMob = p23
            end
        })
    end
end

GRP_Main_Farm_Mob:AddToggle("Auto_Kill_Mob", {
    Title = "Auto Kill Mob",
    Description = "Tự Động Giết Quái Đã Chọn",
    Default = false,
    Callback = function(p24)
        _G.AutoKillMob = p24
    end
})

GRP_Main_Farm_All_Island = t1.Main:AddSection("Farm Island", "Farm Toàn Bộ Đảo")

do
    if World1 then
        GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
            Title = "Select Island",
            Description = "Chọn Đảo (Sea 1)",
            Values = {
                "Pirates", "Marine", "Jungle", "Pirate Village", "Desert", "Frozen Village",
                "Marine Fortress", "Skylands Lower", "Prison", "Colosseum", "Magma Village",
                "Underwater City", "Skylands Upper"
            },
            Default = 1,
            Callback = function(p25)
                _G.SelectIsland = p25
            end
        })
    elseif World2 then
        GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
            Title = "Select Island",
            Description = "Chọn Đảo (Sea 2)",
            Values = {
                "Kingdom of Rose", "Green Zone", "Graveyard Island", "Snow Mountain",
                "Hot and Cold (Cold)", "Hot and Cold (Hot)", "Cursed Ship", "Ice Castle",
                "Forgotten Island"
            },
            Default = 1,
            Callback = function(p26)
                _G.SelectIsland = p26
            end
        })
    elseif World3 then
        GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
            Title = "Select Island",
            Description = "Chọn Đảo (Sea 3)",
            Values = {
                "Port Town", "Hydra Island", "Great Tree", "Floating Turtle",
                "Haunted Castle", "Sea of Treats", "Tiki Outpost", "Submerged Island"
            },
            Default = 1,
            Callback = function(p27)
                _G.SelectIsland = p27
            end
        })
    end
end

GRP_Main_Farm_All_Island:AddToggle("Auto_Farm_All_Island", {
    Title = "Auto Farm All Island",
    Description = "Tự Động Farm Toàn Bộ Quái Trên Đảo",
    Default = false,
    Callback = function(p28)
        _G.AutoFarmIsland = p28
    end
})

GRP_Main_Farm_Elite_Hunter = t1.Main:AddSection("Elite Hunter", "Săn Elite Hunter (Diablo, Urban, Deandre)")

local v59 = GRP_Main_Farm_Elite_Hunter:AddParagraph({
    Title = "Elite Hunter",
    Description = "Trạng thái Elite Hunter",
    Content = "Status: "
})

spawn(function()
    local s10 = ""
    while wait(1) do
        local Diablo = game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or
            game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or
            game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or
            game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or
            game:GetService("Workspace").Enemies:FindFirstChild("Deandre")

        Diablo = (Diablo or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and "✅" or "❌"

        local response = replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
        if Diablo ~= s10 then
            v59:SetDesc("Status: " .. Diablo .. " | Killed: " .. tostring(response))
            s10 = Diablo
        end
    end
end)

do
    EliteQ = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite", {
        Title = "Auto Farm Elite",
        Description = "Tự Động Săn Elite",
        Default = false,
        Callback = function(p29)
            _G.FarmEliteHunt = p29
        end
    })
end

do
    EliteH = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite_+_Hop", {
        Title = "Auto Farm Elite + Hop",
        Description = "Tự Động Săn Elite + Chuyển Server",
        Default = false,
        Callback = function(p30)
            _G.FarmEliteHuntH = p30
        end
    })
end

GRP_Main_Farm_Rip_Indra = t1.Main:AddSection("Rip Indra", "Farm Trùm Rip Indra")

GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Attack_Rip_Indra", {
    Title = "Auto Attack Rip Indra",
    Description = "Tự Động Đánh Rip Indra",
    Default = false,
    Callback = function(p31)
        _G.AttackRipIndra = p31
    end
})

do
    GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Unlocked_Haki", {
        Title = "Auto Unlock Haki",
        Description = "Tự Động Mở Khóa Haki",
        Default = false,
        Callback = function(p32)
            _G.AutoUnHaki = p32
        end
    })
end

GRP_Main_Farming_Cake = t1.Main:AddSection("Cake Prince", "Trùm Bánh Kem")

local v63 = GRP_Main_Farming_Cake:AddParagraph({
    Title = "Cake Prince",
    Description = "Trạng thái Trùm Bánh Kem",
    Content = ""
})

spawn(function()
    while wait(1) do
        pcall(function()
            local v64 = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")
            if v64 then
                v63:SetDesc("Killed : " .. 500 - (tonumber(v64) or 0))
            end
        end)
    end
end)

do
    Cake = GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Cake_Prince", {
        Title = "Auto Farm Cake Prince",
        Description = "Tự động đánh Cake Prince",
        Default = false,
        Callback = function(p33)
            _G.Auto_Cake_Prince = p33
        end
    })
end

CakeQ = GRP_Main_Farming_Cake:AddToggle("Accept_Quests", {
    Title = "Accept Quests",
    Description = "Tự động nhận nhiệm vụ Cake",
    Default = false,
    Callback = function(p34)
        _G.AcceptQuestBoss = p34
    end
})

CakeSM = GRP_Main_Farming_Cake:AddToggle("Auto_Summon_Cake_Prince", {
    Title = "Auto Summon Cake Prince",
    Description = "Tự động triệu hồi Cake Prince",
    Default = false,
    Callback = function(p35)
        _G.AutoSpawnCP = p35
    end
})

GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Dough_King", {
    Title = "Auto Farm Dough King",
    Description = "Tự động đánh Dough King",
    Default = false,
    Callback = function(p36)
        _G.AutoAttackDoughKing = p36
    end
})

GRP_Main_Farming_Cake:AddToggle("Auto_Dough_King_Fully", {
    Title = "Auto Farm Dough King Fully",
    Description = "Tự động farm Dough King hoàn chỉnh",
    Default = false,
    Callback = function(p37)
        _G.AutoDoughKing = p37
    end
})

do
    GRP_Main_Farming_Cake:AddToggle("Auto_Dough_King_Hop", {
        Title = "Auto Farm Dough King + Hop",
        Description = "Tự động farm Dough King + Chuyển server",
        Default = false,
        Callback = function(p38)
            _G.AutoHop_Dough = p38
        end
    })
end

GRP_Main_Farming_Bone = t1.Main:AddSection("Bone", "Farm Xương")

local v65 = GRP_Main_Farming_Bone:AddParagraph({
    Title = "Bones",
    Description = "Số lượng xương hiện có",
    Content = ""
})

spawn(function()
    while wait(1) do
        pcall(function()
            local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
            v65:SetDesc("You Have: " .. tostring(response) .. " Bones")
        end)
    end
end)

GRP_Main_Farming_Bone:AddToggle("Auto_Farm_Bone", {
    Title = "Auto Farm Bone",
    Description = "Tự động cày xương",
    Default = false,
    Callback = function(p39)
        _G.AutoFarm_Bone = p39
    end
})

BoneQ = GRP_Main_Farming_Bone:AddToggle("Accept_Quests_Bone", {
    Title = "Accept Quests",
    Description = "Tự động nhận nhiệm vụ cày xương",
    Default = false,
    Callback = function(p40)
        _G.AcceptQuestBoss = p40
    end
})

RanBone = GRP_Main_Farming_Bone:AddToggle("Auto_Random_Bones", {
    Title = "Auto Random Bones",
    Description = "Tự động đổi xương lấy vật phẩm random",
    Default = false,
    Callback = function(p41)
        _G.Auto_Random_Bone = p41
    end
})

GRP_Main_Farming_Bone:AddToggle("Auto_Soul_Reaper", {
    Title = "Auto Soul Reaper",
    Description = "Tự động đánh Soul Reaper",
    Default = false,
    Callback = function(p42)
        _G.AutoHytHallow = p42
    end
})

do
    Lucky = GRP_Main_Farming_Bone:AddToggle("Auto_Try_Luck_Gravestone", {
        Title = "Auto Try Luck Gravestone",
        Description = "Tự động thử vận may ở Mộ Bia",
        Default = false,
        Callback = function(p43)
            _G.TryLucky = p43
        end
    })
end

Pray = GRP_Main_Farming_Bone:AddToggle("Auto_Pray_Gravestone", {
    Title = "Auto Pray Gravestone",
    Description = "Tự động cầu nguyện ở Mộ Bia",
    Default = false,
    Callback = function(p44)
        _G.Praying = p44
    end
})

GRP_Main_Tyrant_of_the_Skies = t1.Main:AddSection("Tyrant of the Skies", "Trùm Rồng Trời")

local v67 = GRP_Main_Tyrant_of_the_Skies:AddParagraph({
    Title = "Boss Spawn",
    Description = "Trạng thái xuất hiện của trùm",
    Content = ""
})

spawn(function()
    pcall(function()
        while wait(1) do
            if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
                v67:SetDesc("✅")
            else
                v67:SetDesc("❌")
            end
        end
    end)
end)

do
    local v68 = GRP_Main_Tyrant_of_the_Skies:AddParagraph({
        Title = "Eyes Status",
        Description = "Trạng thái 4 con mắt (để triệu hồi trùm)",
        Content = ""
    })

    Check_Eye = function()
        local ok, result = pcall(function()
            return workspace.Map.TikiOutpost.IslandModel
        end)
        if not ok or not result then
            return 0, false
        end
        local t4 = {
            result:FindFirstChild("Eye1"),
            result:FindFirstChild("Eye2"),
            result:FindFirstChild("IslandChunks") and result.IslandChunks:FindFirstChild("E") and result.IslandChunks.E:FindFirstChild("Eye3"),
            result:FindFirstChild("IslandChunks") and result.IslandChunks:FindFirstChild("E") and result.IslandChunks.E:FindFirstChild("Eye4")
        }
        local n1 = 0
        for _, v in ipairs(t4) do
            if v and v.Transparency ~= 1 then
                n1 += 1
            end
        end
        return n1, n1 == 4
    end

    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                local v75 = Check_Eye()
                v68:SetDesc("Eyes: " .. v75 .. "/4")
            end)
        end
    end)
end

FarmTyrant = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Farm_Boss_TOTS", {
    Title = "Auto Farm Tyrant of the Skies",
    Description = "Tự động đánh trùm Tyrant of the Skies",
    Default = false,
    Callback = function(p45)
        _G.BossTots = p45
    end
})

FarmPhaBinh = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Summon_Boss", {
    Title = "Auto Summon Tyrant of the Skies",
    Description = "Tự động thu thập mắt và triệu hồi trùm",
    Default = false,
    Callback = function(p46)
        _G.PhaBinh = p46
    end
})

GRP_Main_Farm_Material = t1.Main:AddSection("Material", "Farm Nguyên Liệu")

do
    Test = GRP_Main_Farm_Material:AddDropdown("Choose_Material", {
        Title = "Select Material",
        Description = "Chọn nguyên liệu để farm",
        Values = MaterialList,
        Default = 1,
        Callback = function(p47)
            getgenv().SelectMaterial = p47
        end
    })
end

Toggle = GRP_Main_Farm_Material:AddToggle("Auto_Farm_Materials", {
    Title = "Auto Farm Materials",
    Description = "Tự động farm nguyên liệu đã chọn",
    Default = false,
    Callback = function(p48)
        _G.AutoMaterial = p48
    end
})

GRP_Main_Farm_Boss = t1.Main:AddSection("Boss", "Farm Trùm")

BossDropdown = GRP_Main_Farm_Boss:AddDropdown("Select_Boss", {
    Title = "Select Boss",
    Description = "Chọn trùm để farm",
    Values = BossList,
    Default = 1,
    Callback = function(p49)
        _G.FindBoss = p49
    end
})

FarmBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_Boss", {
    Title = "Auto Farm Boss",
    Description = "Tự động farm trùm đã chọn",
    Default = false,
    Callback = function(p50)
        _G.FarmBoss = p50
    end
})

BossQ = GRP_Main_Farm_Boss:AddToggle("Accept_Quests_Boss", {
    Title = "Accept Quests",
    Description = "Tự động nhận nhiệm vụ đánh trùm",
    Default = true,
    Callback = function(p51)
        _G.AcceptQuestBoss = p51
    end
})

FarmAllBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_All_Boss", {
    Title = "Auto Farm All Boss",
    Description = "Tự động farm tất cả các trùm",
    Default = false,
    Callback = function(p52)
        _G.AutoFarmAllBoss = p52
    end
})

GRP_Main_Farming_Mastery = t1.Main:AddSection("Mastery", "Thông Thạo Vũ Khí")

do
    local s11 = "Cake"
    _G.SelectIslandMastery = "Cake"
    getgenv().SelectIslandMastery = "Cake"
    GRP_Main_Farming_Mastery:AddDropdown("Choose_Island", {
        Title = "Select Island",
        Description = "Chọn đảo để farm thông thạo",
        Values = { "Cake", "Bone" },
        Default = "Cake",
        Callback = function(p53)
            s11 = p53
            _G.SelectIslandMastery = p53
            getgenv().SelectIslandMastery = p53
        end
    })
end

_G.MasteryHealthPct = 70
_G.SelectedMasterySkills = { Z = true, X = true, C = true, V = true, F = true }

GRP_Main_Farming_Mastery:AddSlider("NPC_Health___Switch_to_Weapon", {
    Title = "NPC Health % to Switch Weapon",
    Description = "Phần trăm máu quái để đổi vũ khí",
    Min = 10,
    Max = 95,
    Default = 70,
    Rounding = 1,
    Callback = function(p54)
        _G.MasteryHealthPct = p54
    end
})

do
    GRP_Main_Farming_Mastery:AddDropdown("Select_Skills_to_Use", {
        Title = "Select Skills to Use",
        Description = "Chọn kỹ năng để spam khi farm",
        Values = { "Z", "X", "C", "V", "F", "Y" },
        Multi = true,
        Default = { Z = true, X = true, C = true, V = true, F = true },
        Callback = function(p55)
            _G.SelectedMasterySkills = p55
        end
    })
end

GRP_Main_Farming_Mastery:AddToggle("Auto_Mastery_Fruits", {
    Title = "Auto Mastery Fruits",
    Description = "Tự động tăng thông thạo Trái Ác Quỷ",
    Default = false,
    Callback = function(p56)
        _G.FarmMastery_Dev = p56
    end
})

GRP_Main_Farming_Mastery:AddToggle("Auto_Mastery_Gun", {
    Title = "Auto Mastery Gun",
    Description = "Tự động tăng thông thạo Súng",
    Default = false,
    Callback = function(p57)
        _G.FarmMastery_G = p57
    end
})

GRP_Main_Farming_Mastery:AddToggle("Auto_Mastery_All_Sword", {
    Title = "Auto Mastery Sword",
    Description = "Tự động tăng thông thạo Kiếm",
    Default = false,
    Callback = function(p58)
        _G.FarmMastery_S = p58
    end
})

-- ==========================================
-- TAB SETTINGS
-- ==========================================
GRP_Settings_Settings_Configure = t1.Settings:AddSection("Setting", "Cài Đặt Chung")

do
    Initialize = GRP_Settings_Settings_Configure:AddToggle("Fast_Attack", {
        Title = "Fast Attack",
        Description = "Đánh nhanh (Bật để farm nhanh hơn)",
        Default = true,
        Callback = function(p59)
            _G.Seriality = p59
        end
    })
end

Bringmob = GRP_Settings_Settings_Configure:AddToggle("Bring_Mobs", {
    Title = "Bring Mobs",
    Description = "Kéo quái lại gần người chơi",
    Default = true,
    Callback = function(p60)
        _B = p60
    end
})

do
    GRP_Settings_Settings_Configure:AddToggle("Auto_Hop_Server_with_time", {
        Title = "Auto Hop Server with time",
        Description = "Tự động chuyển server sau một khoảng thời gian",
        Default = false,
        Callback = function(p61)
            _G.AutoHopServer = p61
            if not p61 then
                _G.HopTimer = nil
            end
        end
    })
end

GRP_Settings_Settings_Configure:AddSlider("Hop_Delay__Minutes_", {
    Title = "Hop Delay (Minutes)",
    Description = "Thời gian chờ trước khi chuyển server (Phút)",
    Min = 5,
    Max = 120,
    Default = 30,
    Rounding = 1,
    Callback = function(p62)
        _G.HopDelay = p62 * 60
    end
})

GRP_Settings_Settings_Configure:AddToggle("Auto_Set_Spawn_Point", {
    Title = "Auto Set Spawn Point",
    Description = "Tự động đặt điểm hồi sinh",
    Default = false,
    Callback = function(p63)
        getgenv().Set = p63
        if p63 then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
})

BusuAura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Buso", {
    Title = "Auto Turn on Buso",
    Description = "Tự động bật Buso (Haki Vũ Trang)",
    Default = true,
    Callback = function(p64)
        Boud = p64
    end
})

GRP_Settings_Settings_Configure:AddToggle("Auto_Haki_Observation", {
    Title = "Auto Haki Observation",
    Description = "Tự động bật Observation (Haki Quan Sát)",
    Default = false,
    Callback = function(p65)
        getgenv().Observation = p65
    end
})

RaceV3Aura = GRP_Settings_Settings_Configure:AddToggle("AutoTurnonRaceV3", {
    Title = "Auto Turn on Race V3",
    Description = "Tự động bật Năng lực Chủng Tộc V3",
    Default = false,
    Callback = function(p66)
        _G.RaceClickAutov3 = p66
    end
})

RaceV4Aura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Race_V4", {
    Title = "Auto Turn on Race V4",
    Description = "Tự động bật Năng lực Chủng Tộc V4",
    Default = false,
    Callback = function(p67)
        _G.RaceClickAutov4 = p67
    end
})

RandomAround = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Spin__xyz", {
    Title = "Auto Turn on Spin",
    Description = "Tự động xoay nhân vật (Chống bị kẹt)",
    Default = false,
    Callback = function(p68)
        RandomCFrame = p68
    end
})

SafeModes = GRP_Settings_Settings_Configure:AddToggle("Safe_Mode", {
    Title = "Safe Mode",
    Description = "Chế độ an toàn (Tránh bị quái đánh)",
    Default = false,
    Callback = function(p69)
        _G.Safemode = p69
    end
})

DisableHitVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Hit_VFX", {
    Title = "Remove Hit VFX",
    Description = "Tắt hiệu ứng khi đánh trúng (Tăng FPS)",
    Default = false,
    Callback = function(p70)
        _G.DestroyHit = p70
    end
})

RmvVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Death_&_Respawned_VFX", {
    Title = "Remove Death & Respawn VFX",
    Description = "Tắt hiệu ứng khi chết và hồi sinh",
    Default = false,
    Callback = function(p71)
        RDeath = p71
    end
})

DisblesNotify = GRP_Settings_Settings_Configure:AddToggle("Disable_Notify", {
    Title = "Disable Notifications",
    Description = "Tắt thông báo rác trên màn hình",
    Default = false,
    Callback = function(p72)
        RemoveDamage = p72
    end
})

GRP_Settings_Settings_Configure:AddToggle("Anti_AFK", {
    Title = "Anti AFK",
    Description = "Chống bị đá ra ngoài khi treo máy",
    Default = true,
    Callback = function(p73)
        if p73 then
            local VirtualUser = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
})

do
    GRP_Settings_Settings_Configure:AddToggle("Auto_Anti_-_Admin_Join_Server", {
        Title = "Auto Hop Server on Admin Join",
        Description = "Tự động chuyển server nếu có Admin vào",
        Default = true,
        Callback = function(p74)
            getgenv().HopServerAdmin = p74
        end
    })
end

GRP_Settings_Settings_Configure:AddToggle("No_Clip", {
    Title = "No Clip",
    Description = "Xuyên vật thể (Đi xuyên tường, đất)",
    Default = false,
    Callback = function(p75)
        getgenv().NoClip = p75
    end
})

-- ==========================================
-- TAB FISHING
-- ==========================================
GRP_Fish_Fishing = t1.Fish:AddSection("Fishing", "Câu Cá")

GRP_Fish_Fishing:AddDropdown("Select_Fishing_Rod", {
    Title = "Select Fishing Rod",
    Description = "Chọn cần câu",
    Values = { "Fishing Rod", "Gold Rod", "Shark Rod", "Shell Rod", "Treasure Rod" },
    Default = "Fishing Rod",
    Callback = function(p76)
        _G.SelectedRod = p76
    end
})

BaitDropdown = GRP_Fish_Fishing:AddDropdown("Select_Bait", {
    Title = "Select Bait",
    Description = "Chọn mồi câu",
    Values = { "Basic Bait", "Kelp Bait", "Good Bait", "Abyssal Bait", "Frozen Bait", "Epic Bait", "Carnivore Bait" },
    Default = "Basic Bait",
    Callback = function(p77)
        _G.SelectedBait = p77
        if _G.AutoBuyBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

BuyBaitToggle = GRP_Fish_Fishing:AddToggle("Auto_Buy_Bait", {
    Title = "Auto Buy Bait",
    Description = "Tự động mua mồi câu",
    Default = false,
    Callback = function(p78)
        _G.AutoBuyBait = p78
        if p78 and _G.SelectedBait then
            pcall(function()
                Remotes.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})

FishingToggle = GRP_Fish_Fishing:AddToggle("Auto_Fishing", {
    Title = "Auto Fishing",
    Description = "Tự động câu cá",
    Default = false,
    Callback = function(p79)
        _G.AutoFishing = p79
    end
})

do
    SellFishToggle = GRP_Fish_Fishing:AddToggle("Auto_Sell_Fish", {
        Title = "Auto Sell Fish",
        Description = "Tự động bán cá",
        Default = false,
        Callback = function(p80)
            _G.AutoSellFish = p80
            if p80 then
                pcall(function()
                    Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
                end)
            end
        end
    })
end

FishingQ = GRP_Fish_Fishing:AddToggle("Auto_Quest_Fishing", {
    Title = "Auto Fishing Quest",
    Description = "Tự động nhận nhiệm vụ câu cá",
    Default = false,
    Callback = function(p81)
        _G.AutoFishingQuest = p81
    end
})

QuestToggle = GRP_Fish_Fishing:AddToggle("Auto_Complete_Quest", {
    Title = "Auto Complete Quest",
    Description = "Tự động hoàn thành nhiệm vụ câu cá",
    Default = false,
    Callback = function(p82)
        _G.AutoQuestComplete = p82
        if p82 then
            pcall(function()
                Remotes.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
})

SpamSkillZ = GRP_Fish_Fishing:AddToggle("Auto_Spam_Skill_Z", {
    Title = "Auto Spam Skill Z",
    Description = "Tự động spam kỹ năng Z",
    Default = false,
    Callback = function(p83)
        _G.AutoSkillZ = p83
    end
})

-- ==========================================
-- TAB QUESTS
-- ==========================================
GRP_Quests_Auto_Quest_Sea = t1.Quests:AddSection("Auto Sea", "Tự Động Làm Nhiệm Vụ Biển")

TravelDress = GRP_Quests_Auto_Quest_Sea:AddToggle("Auto_Quest_Sea_2", {
    Title = "Auto Quest Sea 2",
    Description = "Tự động làm nhiệm vụ Biển 2 (Dressrosa)",
    Default = false,
    Callback = function(p84)
        _G.TravelDres = p84
    end
})

Zou = GRP_Quests_Auto_Quest_Sea:AddToggle("Auto_Quest_Sea_3", {
    Title = "Auto Quest Sea 3",
    Description = "Tự động làm nhiệm vụ Biển 3 (Zou)",
    Default = false,
    Callback = function(p85)
        _G.AutoZou = p85
    end
})

GRP_Quests_Tushita_Yama = t1.Quests:AddSection("Tushita + Yama", "Nhiệm Vụ Lấy Kiếm Tushita & Yama")

GRP_Quests_Tushita_Yama:AddToggle("Auto_Tushita_Sword", {
    Title = "Auto Tushita Sword",
    Description = "Tự động lấy kiếm Tushita",
    Default = false,
    Callback = function(p86)
        _G.Auto_Tushita = p86
    end
})

GRP_Quests_Tushita_Yama:AddToggle("Auto_Yama_Sword", {
    Title = "Auto Yama Sword",
    Description = "Tự động lấy kiếm Yama",
    Default = false,
    Callback = function(p87)
        _G.Auto_Yama = p87
    end
})

GRP_Quests_Skull_Guitars_Misc = t1.Quests:AddSection("Skull Guitar", "Nhiệm Vụ Lấy Đàn Skull Guitar")

local v79 = GRP_Quests_Skull_Guitars_Misc:AddParagraph({
    Title = "Skull Guitar",
    Description = "Trạng thái nhiệm vụ Skull Guitar",
    Content = ""
})

spawn(function()
    if wait(1) then
        repeat
            pcall(function()
                if Quest1 == true then
                    v79:SetDesc("Quest Number : Quest1")
                    return
                end
                if Quest2 == true then
                    v79:SetDesc("Quest Number : Quest2")
                    return
                end
                if Quest3 == true then
                    v79:SetDesc("Quest Number : Quest3")
                    return
                end
                if Quest4 == true then
                    v79:SetDesc("Quest Number : Quest4")
                else
                    if plr.Backpack:FindFirstChild("Skull Guitar") then
                        v79:SetDesc("Quest Number : Collect!!")
                        return
                    end
                    if plr.Character then
                        if plr.Character:FindFirstChild("Skull Guitar") then
                            v79:SetDesc("Quest Number : Collect!!")
                        else
                            v79:SetDesc("Quest Number : No Quest!!")
                        end
                    else
                        v79:SetDesc("Quest Number : No Quest!!")
                        return
                    end
                end
            end)
        until not wait(1)
    end
end)

GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Skull_Guitar", {
    Title = "Auto Skull Guitar",
    Description = "Tự động làm nhiệm vụ Skull Guitar",
    Default = false,
    Callback = function(p88)
        _G.Auto_Soul_Guitar = p88
    end
})

GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Farm_Material_Skull_Guitar", {
    Title = "Auto Farm Material Skull Guitar",
    Description = "Tự động farm nguyên liệu Skull Guitar",
    Default = false,
    Callback = function(p89)
        _G.AutoMatSoul = p89
    end
})

GRP_Quests_Cursed_Dual_Katana = t1.Quests:AddSection("Cursed Dual Katana", "Nhiệm Vụ Lấy Kiếm CDK")

local v80 = GRP_Quests_Cursed_Dual_Katana:AddParagraph({
    Title = "Cursed Dual Katana Quest",
    Description = "Trạng thái nhiệm vụ CDK",
    Content = ""
})

spawn(function()
    while wait(1) do
        pcall(function()
            if QuestYama_1 == true then
                v80:SetDesc("Quest Numbers : yama quest 1")
            elseif QuestYama_2 == true then
                v80:SetDesc("Quest Numbers : yama quest 2")
            elseif QuestYama_3 == true then
                v80:SetDesc("Quest Numbers : yama quest 3")
            elseif QuestTushita_1 == true then
                v80:SetDesc("Quest Numbers : tushita quest 1")
            elseif QuestTushita_2 == true then
                v80:SetDesc("Quest Numbers : tushita quest 2")
            elseif plr.Backpack:FindFirstChild("Cursed Dual Katana") then
                v80:SetDesc("Quest Numbers : CDK done!!")
            elseif plr.Character then
                if plr.Character:FindFirstChild("Cursed Dual Katana") then
                    v80:SetDesc("Quest Numbers : CDK done!!")
                    return
                end
            end
        end)
    end
end)

GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Get_CDK_[_Last_Quest_]", {
    Title = "Auto Get CDK Last Quest",
    Description = "Tự động làm nhiệm vụ cuối lấy CDK",
    Default = false,
    Callback = function(p90)
        _G.CDK = p90
    end
})

do
    GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Yama_CDK", {
        Title = "Auto Yama CDK",
        Description = "Tự động làm nhiệm vụ Yama cho CDK",
        Default = false,
        Callback = function(p91)
            _G.CDK_YM = p91
        end
    })
end

GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Tushita_CDK", {
    Title = "Auto Tushita CDK",
    Description = "Tự động làm nhiệm vụ Tushita cho CDK",
    Default = false,
    Callback = function(p92)
        _G.CDK_TS = p92
    end
})

GRP_Quests_True_Triple_Katana_Sword = t1.Quests:AddSection("True Triple Katana", "Nhiệm Vụ Lấy Kiếm TTK")

GRP_Quests_True_Triple_Katana_Sword:AddButton({
    Title = "Buy Legendary Sword",
    Description = "Mua Kiếm Huyền Thoại từ NPC",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
    end
})

GRP_Quests_True_Triple_Katana_Sword:AddButton({
    Title = "Buy True Triple Katana Sword",
    Description = "Mua Kiếm TTK",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("MysteriousMan", "2")
    end
})

GRP_Quests_True_Triple_Katana_Sword:AddToggle("Tween_to_Legendary_Sword_Dealer", {
    Title = "Tween to Legendary Sword Dealer",
    Description = "Tự động bay tới chỗ NPC bán kiếm",
    Default = false,
    Callback = function(p93)
        _G.Tp_LgS = p93
    end
})

GRP_Quests_Rengoku_Sword = t1.Quests:AddSection("Rengoku", "Nhiệm Vụ Lấy Kiếm Rengoku")

do
    GRP_Quests_Rengoku_Sword:AddToggle("Auto_Rengoku_Sword", {
        Title = "Auto Rengoku Sword",
        Description = "Tự động đánh trùm lấy Rengoku",
        Default = false,
        Callback = function(p94)
            _G.IceBossRen = p94
        end
    })
end

GRP_Quests_Rengoku_Sword:AddToggle("Auto_Key_Rengoku", {
    Title = "Auto Key Rengoku",
    Description = "Tự động lấy chìa khóa Rengoku",
    Default = false,
    Callback = function(p95)
        _G.KeysRen = p95
    end
})

GRP_Quests_Sword = t1.Quests:AddSection("Sword", "Nhiệm Vụ Lấy Các Loại Kiếm")

GRP_Quests_Sword:AddToggle("Auto_Pole_V1", {
    Title = "Auto Pole V1",
    Description = "Tự động lấy Pole V1",
    Default = false,
    Callback = function(p96)
        _G.AutoPole = p96
    end
})

GRP_Quests_Sword:AddToggle("Auto_Pole_V2", {
    Title = "Auto Pole V2",
    Description = "Tự động lấy Pole V2",
    Default = false,
    Callback = function(p97)
        _G.AutoPoleV2 = p97
    end
})

GRP_Quests_Sword:AddToggle("Auto_Saw_Sword", {
    Title = "Auto Saw Sword",
    Description = "Tự động lấy Saw Sword",
    Default = false,
    Callback = function(p98)
        _G.AutoSaw = p98
    end
})

GRP_Quests_Sword:AddToggle("Auto_Saber_Sword", {
    Title = "Auto Saber Sword",
    Description = "Tự động lấy Saber Sword",
    Default = false,
    Callback = function(p99)
        _G.AutoSaber = p99
    end
})

GRP_Quests_Sword:AddToggle("Auto_Warden_Sword", {
    Title = "Auto Warden Sword",
    Description = "Tự động lấy Warden Sword",
    Default = false,
    Callback = function(p100)
        _G.WardenBoss = p100
    end
})

GRP_Quests_Sword:AddToggle("Auto_Long_Sword", {
    Title = "Auto Long Sword",
    Description = "Tự động lấy Long Sword",
    Default = false,
    Callback = function(p101)
        _G.LongsWord = p101
    end
})

GRP_Quests_Sword:AddToggle("Auto_Canvendish_Sword", {
    Title = "Auto Cavendish Sword",
    Description = "Tự động lấy Cavendish Sword",
    Default = false,
    Callback = function(p102)
        _G.Auto_Cavender = p102
    end
})

GRP_Quests_Sword:AddToggle("Auto_Twin_Hooks", {
    Title = "Auto Twin Hooks",
    Description = "Tự động lấy Twin Hooks",
    Default = false,
    Callback = function(p103)
        _G.TwinHook = p103
    end
})

GRP_Quests_Sword:AddToggle("Auto_Bigmom", {
    Title = "Auto Bigmom",
    Description = "Tự động đánh Bigmom",
    Default = false,
    Callback = function(p104)
        _G.AutoBigmom = p104
    end
})

GRP_Quests_Sword:AddToggle("Auto_Midnight_Blade", {
    Title = "Auto Midnight Blade",
    Description = "Tự động lấy Midnight Blade",
    Default = false,
    Callback = function(p105)
        _G.AutoEcBoss = p105
    end
})

GRP_Quests_Sword:AddToggle("Auto_Black_Spikey", {
    Title = "Auto Black Spikey",
    Description = "Tự động lấy Black Spikey",
    Default = false,
    Callback = function(p106)
        _G.BlackSpikey = p106
    end
})

GRP_Quests_Sword:AddToggle("Auto_Dragon_Trident", {
    Title = "Auto Dragon Trident",
    Description = "Tự động lấy Dragon Trident",
    Default = false,
    Callback = function(p107)
        _G.AutoTridentW2 = p107
    end
})

do
    GRP_Quests_Sword:AddToggle("Auto_Bisento_V2", {
        Title = "Auto Bisento V2",
        Description = "Tự động lấy Bisento V2",
        Default = false,
        Callback = function(p108)
            _G.Greybeard = p108
        end
    })
end

GRP_Quests_Sword:AddToggle("Auto_Dark_Blade_V3", {
    Title = "Auto Dark Blade V3",
    Description = "Tự động lấy Dark Blade V3",
    Default = false,
    Callback = function(p109)
        _G.DarkBladev3 = p109
    end
})

GRP_Quests_Accessories = t1.Quests:AddSection("Accessories", "Nhiệm Vụ Lấy Phụ Kiện")

GRP_Quests_Accessories:AddToggle("Auto_Usoap's_Hat", {
    Title = "Auto Usoap's Hat",
    Description = "Tự động lấy nón Usoap",
    Default = false,
    Callback = function(p110)
        _G.AutoGetUsoap = p110
    end
})

GRP_Quests_Accessories:AddToggle("Auto_Marine_Coat", {
    Title = "Auto Marine Coat",
    Description = "Tự động lấy áo choàng Hải Quân",
    Default = false,
    Callback = function(p111)
        _G.MarinesCoat = p111
    end
})

do
    GRP_Quests_Accessories:AddToggle("Auto_Swan_Coat", {
        Title = "Auto Swan Coat",
        Description = "Tự động lấy áo choàng Swan",
        Default = false,
        Callback = function(p112)
            _G.SwanCoat = p112
        end
    })
end

GRP_Quests_Accessories:AddToggle("Auto_Swan_Glasses", {
    Title = "Auto Swan Glasses",
    Description = "Tự động lấy kính Swan",
    Default = false,
    Callback = function(p113)
        _G.Auto_SwanGG = p113
    end
})

GRP_Quests_Accessories:AddToggle("Auto_Lei_Accessory", {
    Title = "Auto Lei Accessory",
    Description = "Tự động lấy vòng hoa Lei",
    Default = false,
    Callback = function(p114)
        _G.AutoKilo = p114
    end
})

GRP_Quests_Gun = t1.Quests:AddSection("Gun", "Nhiệm Vụ Lấy Súng")

GRP_Quests_Gun:AddToggle("Auto_Serpent_Bow", {
    Title = "Auto Serpent Bow",
    Description = "Tự động lấy cung Serpent",
    Default = false,
    Callback = function(p115)
        _G.AutoSerpentBow = p115
    end
})

GRP_Quests_Other = t1.Quests:AddSection("Other", "Các Nhiệm Vụ Khác")

GRP_Quests_Other:AddToggle("Auto_Cybrog", {
    Title = "Auto Cyborg",
    Description = "Tự động làm nhiệm vụ Cyborg",
    Default = false,
    Callback = function(p116)
        _G.AutoColShad = p116
    end
})

GRP_Quests_Other:AddToggle("Auto_Darkbeard", {
    Title = "Auto Darkbeard",
    Description = "Tự động đánh Darkbeard lấy áo choàng",
    Default = false,
    Callback = function(p117)
        _G.Auto_Def_DarkCoat = p117
    end
})

GRP_Quests_Other:AddToggle("Auto_Unlocked_DonSwan", {
    Title = "Auto Unlocked DonSwan",
    Description = "Tự động mở khóa DonSwan",
    Default = false,
    Callback = function(p118)
        _G.Auto_DonAcces = p118
    end
})

GRP_Quests_Other:AddToggle("Auto_Done_Bartilo_Quest", {
    Title = "Auto Done Bartilo Quest",
    Description = "Tự động làm nhiệm vụ Bartilo",
    Default = false,
    Callback = function(p119)
        _G.Bartilo_Quest = p119
    end
})

GRP_Quests_Other:AddToggle("Auto_Done_Citizen_Quest", {
    Title = "Auto Done Citizen Quest",
    Description = "Tự động làm nhiệm vụ Citizen",
    Default = false,
    Callback = function(p120)
        _G.CitizenQuest = p120
    end
})

GRP_Quests_Other:AddToggle("Auto_Training_Dummy", {
    Title = "Auto Training Dummy",
    Description = "Tự động đánh bù nhìn luyện tập",
    Default = false,
    Callback = function(p121)
        _G.DummyMan = p121
    end
})

GRP_Quests_Buso_Aura_Colours = t1.Quests:AddSection("Haki Color", "Nhiệm Vụ Lấy Màu Haki")

GRP_Quests_Buso_Aura_Colours:AddButton({
    Title = "Buy Buso Colors",
    Description = "Mua màu Buso từ NPC",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
    end
})

GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Rainbow_Colors", {
    Title = "Auto Rainbow Colors",
    Description = "Tự động lấy màu cầu vồng",
    Default = false,
    Callback = function(p122)
        _G.Auto_Rainbow_Haki = p122
    end
})

do
    GRP_Quests_Buso_Aura_Colours:AddToggle("Accept_Rainbow_Quest_Faster", {
        Title = "Accept Rainbow Quest",
        Description = "Nhận nhiệm vụ cầu vồng nhanh",
        Default = false,
        Callback = function(p123)
            _G.GetQFast = p123
        end
    })
end

GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Teleport_Barista_Cousin", {
    Title = "Auto Teleport Barista Cousin",
    Description = "Tự động bay tới NPC Barista",
    Default = false,
    Callback = function(p124)
        _G.Tp_MasterA = p124
    end
})

GRP_Quests_Instinct_Observation = t1.Quests:AddSection("Observation", "Nhiệm Vụ Observation")

GRP_Quests_Instinct_Observation:AddToggle("Auto_Farm_Observation", {
    Title = "Auto Farm Observation",
    Description = "Tự động farm Observation",
    Default = false,
    Callback = function(p125)
        _G.obsFarm = p125
    end
})

do
    GRP_Quests_Instinct_Observation:AddToggle("Auto_Observation_V2", {
        Title = "Auto Observation V2",
        Description = "Tự động lấy Observation V2",
        Default = false,
        Callback = function(p126)
            _G.AutoKenVTWO = p126
        end
    })
end

GRP_Quests_Fighting_Melee_Styles = t1.Quests:AddSection("Fighting Style", "Nhiệm Vụ Võ Thuật")

SuperHuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Superhuman", {
    Title = "Auto Superhuman",
    Description = "Tự động lấy Superhuman",
    Default = false,
    Callback = function(p127)
        _G.Auto_SuperHuman = p127
    end
})

DeathStep = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DeathStep", {
    Title = "Auto DeathStep",
    Description = "Tự động lấy DeathStep",
    Default = false,
    Callback = function(p128)
        _G.AutoDeathStep = p128
    end
})

do
    SharkManV2 = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Sharkman_Karate", {
        Title = "Auto Sharkman Karate",
        Description = "Tự động lấy Sharkman Karate",
        Default = false,
        Callback = function(p129)
            _G.Auto_SharkMan_Karate = p129
        end
    })
end

ElectricClaw = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_ElectricClaw", {
    Title = "Auto ElectricClaw",
    Description = "Tự động lấy ElectricClaw",
    Default = false,
    Callback = function(p130)
        _G.Auto_Electric_Claw = p130
    end
})

DragonTalon = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DragonTalon", {
    Title = "Auto DragonTalon",
    Description = "Tự động lấy DragonTalon",
    Default = false,
    Callback = function(p131)
        _G.AutoDragonTalon = p131
    end
})

Godhuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Godhuman", {
    Title = "Auto Godhuman",
    Description = "Tự động lấy Godhuman",
    Default = false,
    Callback = function(p132)
        _G.Auto_God_Human = p132
    end
})

SanguineArt = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_SanguineArt", {
    Title = "Auto SanguineArt",
    Description = "Tự động lấy SanguineArt",
    Default = false,
    Callback = function(p133)
        _G.Snaguine = p133
    end
})

-- ==========================================
-- TAB SEA EVENT
-- ==========================================
GRP_SeaEvent_Sea_Event_Setting_Sail = t1.SeaEvent:AddSection("Sea Event Setting", "Cài Đặt Sự Kiện Trên Biển")

local t5 = { "Guardian", "PirateGrandBrigade", "MarineGrandBrigade", "PirateBrigade", "MarineBrigade", "PirateSloop", "MarineSloop", "Beast Hunter" }
local t6 = { "Lv 1", "Lv 2", "Lv 3", "Lv 4", "Lv 5", "Lv 6", "Lv Infinite" }

GRP_SeaEvent_Sea_Event_Setting_Sail:AddButton({
    Title = "Remove Lighting Effect",
    Description = "Xóa Hiệu Ứng Ánh Sáng",
    Callback = function()
        pcall(function()
            game:GetService("Lighting").BaseAtmosphere:Destroy()
        end)
    end
})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Ship_Speed_Modifier", {
    Title = "Ship Speed Modifier",
    Description = "Chỉnh Tốc Độ Thuyền",
    Default = false,
    Callback = function(p134)
        getgenv().SpeedBoat = p134
    end
})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddSlider("Ship_Speed", {
    Title = "Ship Speed",
    Description = "Tốc Độ Thuyền",
    Min = 0,
    Max = 1000,
    Default = 300,
    Rounding = 1,
    Callback = function(p135)
        SetSpeedBoat = p135
    end
})

GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Auto_Press_W", {
    Title = "Auto Press W",
    Description = "Tự Động Nhấn W (Chèo Thuyền)",
    Default = false,
    Callback = function(p136)
        getgenv().AutoPressW = p136
    end
})

do
    GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("No_Clip_Ship", {
        Title = "No Clip Ship",
        Description = "Thuyền Xuyên Vật Thể",
        Default = false,
        Callback = function(p137)
            getgenv().NoClipShip = p137
        end
    })
end

GRP_SeaEvent_Choose_Sea_Event = t1.SeaEvent:AddSection("Sea Event", "Sự Kiện Trên Biển")

do
    GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Boats", {
        Title = "Select Boats",
        Description = "Chọn Thuyền",
        Values = t5,
        Default = 1,
        Callback = function(p138)
            _G.SelectedBoat = p138
        end
    })
end

GRP_SeaEvent_Choose_Sea_Event:AddButton({
    Title = "Buy Boats",
    Description = "Mua Thuyền",
    Callback = function()
        local sb = _G.SelectedBoat
        local ok = sb
        if not ok then
            sb = t5
            ok = not sb
        end
        if ok then
            sb = sb or "Guardian"
        else
            sb = t5[1] or "Guardian"
        end
        replicated.Remotes.CommF_:InvokeServer("BuyBoat", sb)
    end
})

do
    GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Sea_Level", {
        Title = "Select Sea Level",
        Description = "Chọn Cấp Độ Biển",
        Values = t6,
        Default = 1,
        Callback = function(p139)
            _G.DangerSc = p139
        end
    })
end

GRP_SeaEvent_Choose_Sea_Event:AddToggle("Auto_Sail_Boat", {
    Title = "Auto Sail Boat",
    Description = "Tự Động Chèo Thuyền",
    Default = false,
    Callback = function(p140)
        _G.SailBoats = p140
    end
})

GRP_SeaEvent_Entity_Sea_Event = t1.SeaEvent:AddSection("Sea Event Entity", "Thực Thể Sự Kiện Biển")

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Shark", {
    Title = "Auto Shark",
    Description = "Tự Đánh Cá Mập",
    Default = false,
    Callback = function(p141)
        _G.Shark = p141
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Piranha", {
    Title = "Auto Piranha",
    Description = "Tự Đánh Cá Piranha",
    Default = false,
    Callback = function(p142)
        _G.Piranha = p142
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Terror_Shark", {
    Title = "Auto Terror Shark",
    Description = "Tự Đánh Terror Shark",
    Default = false,
    Callback = function(p143)
        _G.TerrorShark = p143
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Fish_Crew_Member", {
    Title = "Auto Fish Crew Member",
    Description = "Tự Đánh Thủy Thủ Cá",
    Default = false,
    Callback = function(p144)
        _G.MobCrew = p144
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Haunted_Crew_Member", {
    Title = "Auto Haunted Crew Member",
    Description = "Tự Đánh Thủy Thủ Ma",
    Default = false,
    Callback = function(p145)
        _G.HCM = p145
    end
})

do
    GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_PirateGrandBrigade", {
        Title = "Auto Attack Pirate Grand Brigade",
        Description = "Tự Đánh Pirate Grand Brigade",
        Default = false,
        Callback = function(p146)
            _G.PGB = p146
        end
    })
end

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Fish_Boat", {
    Title = "Auto Attack Fish Boat",
    Description = "Tự Đánh Thuyền Cá",
    Default = false,
    Callback = function(p147)
        _G.FishBoat = p147
    end
})

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Sea_Beast", {
    Title = "Auto Attack Sea Beast",
    Description = "Tự Đánh Quái Biển",
    Default = false,
    Callback = function(p148)
        _G.SeaBeast1 = p148
    end
})

GRP_SeaEvent_Crafting_Items = t1.SeaEvent:AddSection("Sea Event Crafting", "Chế Tạo Sự Kiện Biển")

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft SharkTooth",
    Description = "Chế Tạo Răng Cá Mập",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "SharkTooth" }))
    end
})

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft TerrorJaw",
    Description = "Chế Tạo Hàm Terror",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "TerrorJaw" }))
    end
})

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft SharkAnchor",
    Description = "Chế Tạo Mỏ Neo Cá Mập",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "SharkAnchor" }))
    end
})

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft LeviathanCrown",
    Description = "Chế Tạo Vương Miện Leviathan",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "LeviathanCrown" }))
    end
})

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft LeviathanShield",
    Description = "Chế Tạo Khiên Leviathan",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "LeviathanShield" }))
    end
})

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft LeviathanBoat",
    Description = "Chế Tạo Thuyền Leviathan",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "LeviathanBoat" }))
    end
})

GRP_SeaEvent_Crafting_Items:AddButton({
    Title = "Craft LegendaryScroll",
    Description = "Chế Tạo Cuộn Huyền Thoại",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "LegendaryScroll" }))
    end
})

do
    GRP_SeaEvent_Crafting_Items:AddButton({
        Title = "Craft MythicalScroll",
        Description = "Chế Tạo Cuộn Thần Thoại",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "MythicalScroll" }))
        end
    })
end

GRP_SeaEvent_Kitsune_Island_Event = t1.SeaEvent:AddSection("Kitsune Event", "Sự Kiện Kitsune")

do
    local v85 = GRP_SeaEvent_Kitsune_Island_Event:AddParagraph({
        Title = "Kitsune Island Status",
        Description = "Trạng Thái Đảo Kitsune",
        Content = ""
    })
    spawn(function()
        while wait(1) do
            pcall(function()
                if workspace.Map:FindFirstChild("KitsuneIsland") then
                    v85:SetDesc("Kitsune Island : True")
                    return
                elseif workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
                    v85:SetDesc("Kitsune Island : True")
                else
                    v85:SetDesc("Kitsune Island : False")
                end
            end)
        end
    end)
end

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Find_Kitsune_Island", {
    Title = "Auto Find Kitsune Island",
    Description = "Tự Tìm Đảo Kitsune",
    Default = false,
    Callback = function(p149)
        _G.AutofindKitIs = p149
    end
})

do
    GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Teleport_to_Shrine_Actived", {
        Title = "Auto Teleport to Activated Shrine",
        Description = "Tự Tới Đền Đã Kích Hoạt",
        Default = false,
        Callback = function(p150)
            _G.tweenShrine = p150
        end
    })
end

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Collect_Azure_Ember", {
    Title = "Auto Collect Azure Ember",
    Description = "Tự Nhặt Azure Ember",
    Default = false,
    Callback = function(p151)
        _G.Collect_Ember = p151
    end
})

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Trade_Azure_Ember", {
    Title = "Auto Trade Azure Ember",
    Description = "Tự Đổi Azure Ember",
    Default = false,
    Callback = function(p152)
        _G.Trade_Ember = p152
    end
})

do
    GRP_SeaEvent_Kitsune_Island_Event:AddButton({
        Title = "Trade Items Azure",
        Description = "Đổi Vật Phẩm Azure",
        Callback = function()
            replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
        end
    })
end

GRP_SeaEvent_Kitsune_Island_Event:AddButton({
    Title = "Talk to Kitsune Statue",
    Description = "Nói Chuyện Tượng Kitsune",
    Callback = function()
        replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()
    end
})

GRP_SeaEvent_Frozen_Dimension_Event = t1.SeaEvent:AddSection("Frozen Dimension", "Chiều Không Gian Băng Giá")

do
    local v86 = GRP_SeaEvent_Frozen_Dimension_Event:AddParagraph({
        Title = "Frozen Dimension",
        Description = "Trạng thái Chiều Không Gian Băng Giá",
        Content = ""
    })
    spawn(function()
        pcall(function()
            while wait(1) do
                if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                    v86:SetDesc("Frozen Dimension : True")
                else
                    v86:SetDesc("Frozen Dimension : False")
                end
            end
        end)
    end)
end

do
    local v87 = GRP_SeaEvent_Frozen_Dimension_Event:AddParagraph({
        Title = "Spy Status",
        Description = "Trạng Thái Do Thám",
        Content = ""
    })
    spawn(function()
        while wait(1) do
            pcall(function()
                local v88 = string.match(replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1"), "%d+")
                if v88 then
                    v87:SetDesc("Spy Leviathan : " .. tostring(v88))
                    if tonumber(v88) == 5 then
                        v87:SetDesc("Spy Leviathan : Already Done!!")
                    end
                end
            end)
        end
    end)
end

GRP_SeaEvent_Frozen_Dimension_Event:AddButton({
    Title = "Buy Spy",
    Description = "Mua Do Thám",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
    end
})

do
    GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Teleport_Frozen_Dimension", {
        Title = "Auto Teleport Frozen Dimension",
        Description = "Tự Tới Chiều Không Gian Băng Giá",
        Default = false,
        Callback = function(p153)
            _G.FrozenTP = p153
        end
    })
end

do
    GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Drive_To_Hydra_Island", {
        Title = "Auto Drive To Hydra Island",
        Description = "Tự Lái Thuyền Tới Đảo Hydra",
        Default = false,
        Callback = function(p154)
            _G.SailBoat_Hydra = p154
        end
    })
end

GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Attack_Leviathan", {
    Title = "Auto Attack Leviathan",
    Description = "Tự Đánh Leviathan",
    Default = false,
    Callback = function(p155)
        _G.Leviathan1 = p155
    end
})

-- ==========================================
-- TAB PREHISTORIC
-- ==========================================
GRP_Prehistoric_Dojo_Quest = t1.Prehistoric:AddSection("Dojo", "Võ Đường")

GRP_Prehistoric_Dojo_Quest:AddButton({
    Title = "Teleport To Dragon Dojo",
    Description = "Tới Võ Đường Rồng",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, -334.96499633789062))
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375)
        end
    end
})

DojoQ = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dojo_Trainer", {
    Title = "Auto Dojo Trainer",
    Description = "Tự Luyện Tập Võ Đường",
    Default = false,
    Callback = function(p156)
        _G.Dojoo = p156
    end
})

BlazeEM = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dragon_Hunter", {
    Title = "Auto Dragon Hunter",
    Description = "Tự Săn Rồng",
    Default = false,
    Callback = function(p157)
        _G.FarmBlazeEM = p157
    end
})

GRP_Prehistoric_Drago_Trial = t1.Prehistoric:AddSection("Draco Trial", "Thử Thách Draco")

do
    GRP_Prehistoric_Drago_Trial:AddToggle("Tween_To_Upgrade_Droco_Trial", {
        Title = "Tween To Upgrade Droco Trial",
        Description = "Tới Chỗ Nâng Cấp Draco",
        Default = false,
        Callback = function(p158)
            _G.UPGDrago = p158
        end
    })
end

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Droco_V1", {
    Title = "Auto Droco V1",
    Description = "Tự Lấy Draco V1",
    Default = false,
    Callback = function(p159)
        _G.DragoV1 = p159
    end
})

fireflower = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Droco_V2", {
    Title = "Auto Droco V2",
    Description = "Tự Lấy Draco V2",
    Default = false,
    Callback = function(p160)
        _G.AutoFireFlowers = p160
    end
})

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Droco_V3", {
    Title = "Auto Droco V3",
    Description = "Tự Lấy Draco V3",
    Default = false,
    Callback = function(p161)
        _G.DragoV3 = p161
    end
})

do
    GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Relic_Droco_Trial", {
        Title = "Auto Relic Droco Trial",
        Description = "Tự Lấy Di Vật Draco",
        Default = false,
        Callback = function(p162)
            _G.Relic123 = p162
        end
    })
end

GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Train_Droco_v4", {
    Title = "Auto Train Droco v4",
    Description = "Tự Luyện Draco V4",
    Default = false,
    Callback = function(p163)
        _G.TrainDrago = p163
    end
})

dragoTpVolcano = GRP_Prehistoric_Drago_Trial:AddToggle("Tween_to_Droco_Trials", {
    Title = "Tween to Drago Trials",
    Description = "Tới Thử Thách Draco",
    Default = false,
    Callback = function(p164)
        _G.TpDrago_Prehis = p164
    end
})

bdrago = GRP_Prehistoric_Drago_Trial:AddToggle("Swap_Droco_Race", {
    Title = "Swap Droco Race",
    Description = "Đổi Chủng Tộc Draco",
    Default = false,
    Callback = function(p165)
        _G.BuyDrago = p165
    end
})

UpTalon = GRP_Prehistoric_Drago_Trial:AddToggle("Upgrade_Dragon_Talon_With_Uzoth", {
    Title = "Upgrade Dragon Talon With Uzoth",
    Description = "Nâng Cấp Dragon Talon Với Uzoth",
    Default = false,
    Callback = function(p166)
        _G.DT_Uzoth = p166
    end
})

GRP_Prehistoric_Volcanic_Crafting = t1.Prehistoric:AddSection("Volcano Crafting", "Chế Tạo Núi Lửa")

GRP_Prehistoric_Volcanic_Crafting:AddButton({
    Title = "Craft Dragonheart",
    Description = "Chế Tạo Tim Rồng",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "Dragonheart" }))
    end
})

GRP_Prehistoric_Volcanic_Crafting:AddButton({
    Title = "Craft Dragonstorm",
    Description = "Chế Tạo Bão Rồng",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "Dragonstorm" }))
    end
})

GRP_Prehistoric_Volcanic_Crafting:AddButton({
    Title = "Craft Dino Hood",
    Description = "Chế Tạo Mũ Khủng Long",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "DinoHood" }))
    end
})

GRP_Prehistoric_Volcanic_Crafting:AddButton({
    Title = "Craft T-Rex Skull",
    Description = "Chế Tạo Đầu Lâu T-Rex",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "Trex" }))
    end
})

GRP_Prehistoric_Prehistoric_Island = t1.Prehistoric:AddSection("Prehistoric Island", "Đảo Tiền Sử")

do
    local v90 = GRP_Prehistoric_Prehistoric_Island:AddParagraph({
        Title = "Prehistoric Island Status",
        Description = "Trạng Thái Đảo Tiền Sử",
        Content = ""
    })
    spawn(function()
        if wait(1) then
            repeat
                pcall(function()
                    if workspace.Map:FindFirstChild("PrehistoricIsland") then
                        v90:SetDesc("Prehistoric Island : True")
                        return
                    elseif workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                        v90:SetDesc("Prehistoric Island : True")
                    else
                        v90:SetDesc("Prehistoric Island : False")
                    end
                end)
            until not wait(1)
        end
    end)
end

GRP_Prehistoric_Prehistoric_Island:AddButton({
    Title = "Craft Volcanic Magnet",
    Description = "Chế Tạo Nam Châm Núi Lửa",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ "CraftItem", "Craft", "Magnet" }))
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Craft_Volcanic_Magnet", {
    Title = "Craft Volcanic Magnet",
    Description = "Chế Tạo Nam Châm Núi Lửa",
    Default = false,
    Callback = function(p167)
        _G.Prehis_Find = p167
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Find_Prehistoric_Island", {
    Title = "Auto Find Prehistoric Island",
    Description = "Tự Tìm Đảo Tiền Sử",
    Default = false,
    Callback = function(p168)
        _G.Prehis_Find = p168
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Start_Prehistoric_Event", {
    Title = "Auto Start Prehistoric Event",
    Description = "Tự Bắt Đầu Sự Kiện Tiền Sử",
    Default = false,
    Callback = function(p169)
        _G.AutoStartPrehistoric = p169
    end
})

do
    GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Patch_Prehistoric_Event", {
        Title = "Auto Patch Prehistoric Event",
        Description = "Tự Vá Sự Kiện Tiền Sử",
        Default = false,
        Callback = function(p170)
            _G.Prehis_Skills = p170
        end
    })
end

Kaura = GRP_Prehistoric_Prehistoric_Island:AddToggle("Kill_Aura", {
    Title = "Kill Aura",
    Description = "Hào Quang Sát Thương",
    Default = false,
    Callback = function(p171)
        _G.KillAuraFull = p171
    end
})

VocanDino = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dino_Bones", {
    Title = "Auto Collect Dino Bones",
    Description = "Tự Nhặt Xương Khủng Long",
    Default = false,
    Callback = function(p172)
        _G.Prehis_DB = p172
    end
})

VocanEgg = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dragon_Eggs", {
    Title = "Auto Collect Dragon Eggs",
    Description = "Tự Nhặt Trứng Rồng",
    Default = false,
    Callback = function(p173)
        _G.Prehis_DE = p173
    end
})

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Reset_When_Complete_Volcano", {
    Title = "Auto Reset When Complete Volcano",
    Description = "Tự Reset Khi Xong Núi Lửa",
    Default = false,
    Callback = function(p174)
        _G.ResetPH = p174
    end
})

-- ==========================================
-- TAB RACE
-- ==========================================
GRP_Race_Mystic_Island_Full_Moon = t1.Race:AddSection("Mirage Island", "Đảo Ảo Ảnh")

do
    local v91 = GRP_Race_Mystic_Island_Full_Moon:AddParagraph({
        Title = "Full Moon",
        Description = "Trăng Tròn",
        Content = ""
    })
    local v92 = GRP_Race_Mystic_Island_Full_Moon:AddParagraph({
        Title = "Mirage Island",
        Description = "Đảo Ảo Ảnh",
        Content = ""
    })

    spawn(function()
        while wait(1) do
            pcall(function()
                if workspace.Map:FindFirstChild("MysticIsland") then
                    v92:SetDesc("Mirage Island : True")
                else
                    if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                        v92:SetDesc("Mirage Island : True")
                        return
                    end
                    v92:SetDesc("Mirage Island : False")
                end
            end)
        end
    end)

    spawn(function()
        if wait(1) then
            repeat
                pcall(function()
                    local MoonTextureId = game:GetService("Lighting").Sky.MoonTextureId
                    if MoonTextureId == "http://www.roblox.com/asset/?id=9709135895" then
                        v91:SetDesc("Moon : 0 / 8")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709139597" then
                        v91:SetDesc("Moon : 1 / 8")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                        v91:SetDesc("Moon : 2 / 8")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                        v91:SetDesc("Moon : 3 / 8 [ Next Night ]")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                        v91:SetDesc("Moon : 4 / 8 [ Full Moon ]")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                        v91:SetDesc("Moon : 5 / 8 [ Last Night ]")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150086" then
                        v91:SetDesc("Moon : 6 / 8")
                    elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                        v91:SetDesc("Moon : 7 / 8")
                    end
                end)
            until not wait(1)
        end
    end)
end

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Find_Mirage_Island", {
    Title = "Auto Find Mirage Island",
    Description = "Tự Tìm Đảo Ảo Ảnh",
    Default = false,
    Callback = function(p175)
        _G.FindMirage = p175
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Esp_Mirage_Island", {
    Title = "Esp Mirage Island",
    Description = "Esp Đảo Ảo Ảnh",
    Default = false,
    Callback = function(p176)
        MirageIslandESP = p176
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Mirage_Island", {
    Title = "Auto Tween To Mirage Island",
    Description = "Tự Tới Đảo Ảo Ảnh",
    Default = false,
    Callback = function(p177)
        _G.AutoMysticIsland = p177
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Highest_Point", {
    Title = "Auto Tween To Highest Point",
    Description = "Tự Tới Điểm Cao Nhất",
    Default = false,
    Callback = function(p178)
        _G.HighestMirage = p178
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Gear", {
    Title = "Auto Collect Gear",
    Description = "Tự Nhặt Bánh Răng",
    Default = false,
    Callback = function(p179)
        _G.TPGEAR = p179
    end
})

do
    GRP_Race_Mystic_Island_Full_Moon:AddToggle("Change_Transparency_can_see", {
        Title = "Change Transparency can see",
        Description = "Đổi Độ Trong Suốt",
        Default = false,
        Callback = function(p180)
            _G.can = p180
        end
    })
end

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_Advanced_Fruit_Dealer", {
    Title = "Auto Tween Advanced Fruit Dealer",
    Description = "Tự Tới Chỗ Bán Trái Nâng Cao",
    Default = false,
    Callback = function(p181)
        _G.Addealer = p181
    end
})

do
    GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Mirage_Chest", {
        Title = "Auto Collect Mirage Chest",
        Description = "Tự Nhặt Rương Ảo Ảnh",
        Default = false,
        Callback = function(p182)
            _G.FarmChestM = p182
        end
    })
end

do
    GRP_Race_Mystic_Island_Full_Moon:AddButton({
        Title = "Talk With Stone",
        Description = "Nói Chuyện Với Đá",
        Callback = function()
            replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Begin")
            replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Check")
            replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Teleport")
            replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("RaceV4Progress", "Continue")
        end
    })
end

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Look_At_Moon", {
    Title = "Auto Look At Moon",
    Description = "Tự Nhìn Trăng",
    Default = false,
    Callback = function(p183)
        _G.LookM = p183
    end
})

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Look_Moon_+_Auto_V3", {
    Title = "Look Moon + Auto V3",
    Description = "Nhìn Trăng + Tự V3",
    Default = false,
    Callback = function(p184)
        LookMV3 = p184
    end
})

GRP_Race_Upgrade_Races_V2_And_V3 = t1.Race:AddSection("Races V2 And V3", "Chủng Tộc V2 & V3")

RaceMink = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Mink", {
    Title = "Auto Upgrade Mink",
    Description = "Tự Nâng Cấp Mink",
    Default = false,
    Callback = function(p185)
        _G.Auto_Mink = p185
    end
})

RaceHuman = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Human", {
    Title = "Auto Upgrade Human",
    Description = "Tự Nâng Cấp Human",
    Default = false,
    Callback = function(p186)
        _G.Auto_Human = p186
    end
})

RaceSky = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Angel", {
    Title = "Auto Upgrade Angel",
    Description = "Tự Nâng Cấp Angel",
    Default = false,
    Callback = function(p187)
        _G.Auto_Skypiea = p187
    end
})

do
    RaceFish = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_FishMan", {
        Title = "Auto Upgrade FishMan",
        Description = "Tự Nâng Cấp FishMan",
        Default = false,
        Callback = function(p188)
            _G.Auto_Fish = p188
        end
    })
end

GRP_Race_Trials_Quest_V4 = t1.Race:AddSection("Trial Race V4", "Thử Thách Chủng Tộc V4")

do
    local v94 = GRP_Race_Trials_Quest_V4:AddParagraph({
        Title = "Race V4 Tier",
        Description = "Cấp Độ Race V4",
        Content = ""
    })
    spawn(function()
        pcall(function()
            while wait(1) do
                if plr.Data.Race:FindFirstChild("C") then
                    v94:SetDesc("Tiers - V4 : " .. " " .. tostring(plr.Data.Race.C.Value))
                end
            end
        end)
    end)
end

PullLv = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Pull_Lever", {
    Title = "Auto Pull Lever",
    Description = "Tự Kéo Cần Gạt",
    Default = false,
    Callback = function(p189)
        _G.Lver = p189
    end
})

Train = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Train_V4", {
    Title = "Auto Train V4",
    Description = "Tự Luyện Tập V4",
    Default = false,
    Callback = function(p190)
        _G.AcientOne = p190
    end
})

GRP_Race_Trials_Quest_V4:AddButton({
    Title = "Teleport to Temple of Time",
    Description = "Tới Đền Thời Gian",
    Callback = function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end
    end
})

do
    GRP_Race_Trials_Quest_V4:AddButton({
        Title = "Teleport to Ancient One",
        Description = "Tới Ancient One",
        Callback = function()
            local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
            end
        end
    })
end

GRP_Race_Trials_Quest_V4:AddButton({
    Title = "Teleport to Ancient Clock",
    Description = "Tới Đồng Hồ Cổ",
    Callback = function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(28286.35546875, 14895.3017578125, 102.62469482421875)
        end
    end
})

Doors = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Teleport_to_Race_Doors", {
    Title = "Auto Teleport to Race Doors",
    Description = "Tự Tới Cửa Thử Thách",
    Default = false,
    Callback = function(p191)
        _G.TPDoor = p191
    end
})

Trials = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Complete_Trial_Race", {
    Title = "Auto Complete Trial Race",
    Description = "Tự Hoàn Thành Thử Thách",
    Default = false,
    Callback = function(p192)
        _G.Complete_Trials = p192
    end
})

AutoKill = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Kill_Player_After_Trial", {
    Title = "Auto Kill Player After Trial",
    Description = "Tự Giết Người Chơi Sau Thử Thách",
    Default = false,
    Callback = function(p193)
        _G.Defeating = p193
    end
})

-- ==========================================
-- TAB ESP
-- ==========================================
GRP_Esp_Stats_Upgrade = t1.Esp:AddSection("Stats", "Chỉ Số")

do
    local n2 = 10
    StatusSelect = GRP_Esp_Stats_Upgrade:AddSlider("Stats_Value", {
        Title = "Stats Value",
        Description = "Giá Trị Chỉ Số",
        Min = 0,
        Max = 1000,
        Default = 10,
        Rounding = 1,
        Callback = function(p194)
            n2 = p194
        end
    })
end

do
    StatsMelee = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Melee", {
        Title = "Auto Melee",
        Description = "Tự Cận Chiến",
        Default = false,
        Callback = function(p195)
            _G.Auto_Melee = p195
        end
    })
end

StatsSword = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Swords", {
    Title = "Auto Sword",
    Description = "Tự Kiếm",
    Default = false,
    Callback = function(p196)
        _G.Auto_Sword = p196
    end
})

StatsGun = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Gun", {
    Title = "Auto Gun",
    Description = "Tự Súng",
    Default = false,
    Callback = function(p197)
        _G.Auto_Gun = p197
    end
})

StatsFruit = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Blox_Fruit", {
    Title = "Auto Blox Fruit",
    Description = "Tự Trái Ác Quỷ",
    Default = false,
    Callback = function(p198)
        _G.Auto_DevilFruit = p198
    end
})

StatsDef = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Defense", {
    Title = "Auto Defense",
    Description = "Tự Phòng Thủ",
    Default = false,
    Callback = function(p199)
        _G.Auto_Defense = p199
    end
})

GRP_Esp_Esp = t1.Esp:AddSection("Esp", "Tàng Hình")

GRP_Esp_Esp:AddToggle("Esp_Berry", {
    Title = "Esp Berry",
    Description = "Esp Quả Berry",
    Default = false,
    Callback = function(p200)
        BerryEsp = p200
        if p200 then
            task.spawn(function()
                if BerryEsp then
                    repeat
                        berriesEsp()
                        task.wait()
                    until not BerryEsp
                end
            end)
        else
            for _, child in ipairs(workspace:GetChildren()) do
                if child:IsA("Part") then
                    if child.Name:match("BerryEspPart_.*") then
                        child:Destroy()
                    end
                end
            end
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_Player", {
    Title = "Esp Player",
    Description = "Esp Người Chơi",
    Default = false,
    Callback = function(p201)
        PlayerEsp = p201
        if p201 then
            task.spawn(function()
                while PlayerEsp do
                    EspPly()
                    task.wait()
                end
            end)
        else
            local next_ = next
            local children, v103 = game.Players:GetChildren()
            for _, v in next_, children, v103 do
                pcall(function()
                    if not isnil(v.Character) and not isnil(v.Character.Head) then
                        if v.Character.Head:FindFirstChild("NameEsp" .. Number) then
                            v.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                        end
                    end
                end)
            end
        end
    end
})

do
    GRP_Esp_Esp:AddToggle("Esp_Chest", {
        Title = "Esp Chest",
        Description = "Esp Rương",
        Default = false,
        Callback = function(p202)
            ChestESP = p202
            if p202 then
                task.spawn(function()
                    while ChestESP do
                        ChestEsp()
                        task.wait()
                    end
                end)
            else
                for _, v in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
                    local ChestEspAttachment = v:FindFirstChild("ChestEspAttachment")
                    if ChestEspAttachment then
                        ChestEspAttachment:Destroy()
                    end
                end
            end
        end
    })
end

do
    GRP_Esp_Esp:AddToggle("Esp_Fruit", {
        Title = "Esp Fruit",
        Description = "Esp Trái Ác Quỷ",
        Default = false,
        Callback = function(p203)
            DevilFruitESP = p203
            if p203 then
                task.spawn(function()
                    while DevilFruitESP do
                        DevEsp()
                        task.wait()
                    end
                end)
            else
                local next_ = next
                local children, v111 = workspace:GetChildren()
                for _, v in next_, children, v111 do
                    pcall(function()
                        if v:FindFirstChild("Handle") then
                            if v.Handle:FindFirstChild("NameEsp" .. Number) then
                                v.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
                            end
                        end
                    end)
                end
            end
        end
    })
end

GRP_Esp_Esp:AddToggle("Esp_Island", {
    Title = "Esp Island",
    Description = "Esp Đảo",
    Default = false,
    Callback = function(p204)
        IslandESP = p204
        if p204 then
            task.spawn(function()
                while IslandESP do
                    LocationEsp()
                    task.wait()
                end
            end)
        else
            local next_ = next
            local children, v116 = workspace._WorldOrigin.Locations:GetChildren()
            for _, v in next_, children, v116 do
                pcall(function()
                    if v:FindFirstChild("NameEsp") then
                        v:FindFirstChild("NameEsp"):Destroy()
                    end
                end)
            end
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_Flower", {
    Title = "Esp Flower",
    Description = "Esp Hoa",
    Default = false,
    Callback = function(p205)
        FlowerESP = p205
        if p205 then
            task.spawn(function()
                if FlowerESP then
                    repeat
                        flowerEsp()
                        task.wait()
                    until not FlowerESP
                end
            end)
        else
            for _, child in pairs(workspace:GetChildren()) do
                pcall(function()
                    if (child.Name == "Flower2" or child.Name == "Flower1") and child:FindFirstChild("NameEsp" .. Number) then
                        child:FindFirstChild("NameEsp" .. Number):Destroy()
                    end
                end)
            end
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_Legendary_Sword", {
    Title = "Esp Legendary Sword",
    Description = "Esp Kiếm Huyền Thoại",
    Default = false,
    Callback = function(p206)
        LegenS = p206
        if p206 then
            task.spawn(function()
                while LegenS do
                    LegenSword()
                    task.wait()
                end
            end)
        elseif workspace:FindFirstChild("Lgd") then
            workspace:FindFirstChild("Lgd"):Destroy()
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_Haki_Color", {
    Title = "Esp Haki Color",
    Description = "Esp Màu Haki",
    Default = false,
    Callback = function(p207)
        ColorEsp = p207
        if p207 then
            task.spawn(function()
                while ColorEsp do
                    HakiClorEsp()
                    task.wait()
                end
            end)
        elseif workspace:FindFirstChild("Gay") then
            workspace:FindFirstChild("Gay"):Destroy()
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_Gear", {
    Title = "Esp Gear",
    Description = "Esp Bánh Răng",
    Default = false,
    Callback = function(p208)
        ESPGear = p208
        if p208 then
            task.spawn(function()
                while ESPGear do
                    gearEsp()
                    task.wait()
                end
            end)
        else
            local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")
            if MysticIsland then
                for _, descendant in pairs(MysticIsland:GetDescendants()) do
                    pcall(function()
                        if descendant:FindFirstChild("NameEsp") then
                            descendant:FindFirstChild("NameEsp"):Destroy()
                        end
                    end)
                end
            end
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_SeaEvent_Island", {
    Title = "Esp Sea Event Island",
    Description = "Esp Đảo Sự Kiện Biển",
    Default = false,
    Callback = function(p209)
        EspEventIsland = p209
        if p209 then
            task.spawn(function()
                while EspEventIsland do
                    EventIslandEsp()
                    task.wait()
                end
            end)
        else
            for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
                pcall(function()
                    if child:FindFirstChild("NameEsp") then
                        child:FindFirstChild("NameEsp"):Destroy()
                    end
                end)
            end
        end
    end
})

GRP_Esp_Esp:AddToggle("Esp_Advanced_Dealer", {
    Title = "Esp Advanced Dealer",
    Description = "Esp Trái Nâng Cao",
    Default = false,
    Callback = function(p210)
        advanEsp = p210
        if p210 then
            task.spawn(function()
                while advanEsp do
                    AdvanFruitEsp()
                    task.wait()
                end
            end)
        elseif workspace:FindFirstChild("Adv") then
            workspace:FindFirstChild("Adv"):Destroy()
        end
    end
})

-- ==========================================
-- TAB RAIDS
-- ==========================================
GRP_Raids_Fruits_Options = t1.Raids:AddSection("Fruit", "Trái Ác Quỷ")

do
    local function v126(p211)
        local v127 = tostring(p211)
        local v128
        repeat
            v127, v128 = v127:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        until v128 == 0
        return v127
    end

    local function v129()
        local s12 = "Advance Fruit Stock\n"
        local ok, result = pcall(function()
            return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
        end)
        if ok and result then
            local v133 = false
            for _, v in pairs(result) do
                if v.OnSale then
                    v133 = true
                    s12 ..= v.Name .. " - $" .. v126(v.Price) .. "\n"
                end
            end
            if not v133 then
                s12 ..= "- No fruit.\n"
            end
        else
            s12 ..= "- Error while retrieving data.\n"
        end

        local v136 = s12 .. "\nNormal Fruit Stock\n"
        local ok2, result2 = pcall(function()
            return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
        end)
        if ok2 and result2 then
            local v139 = false
            for _, v in pairs(result2) do
                if v.OnSale then
                    v139 = true
                    v136 ..= v.Name .. " - $" .. v126(v.Price) .. "\n"
                end
            end
            if not v139 then
                v136 ..= "- No fruit.\n"
            end
        else
            v136 ..= "- Error while retrieving data.\n"
        end
        return v136
    end

    local v142 = GRP_Raids_Fruits_Options:AddParagraph({
        Title = "Loading...",
        Description = "Đang tải...",
        Content = ""
    })
    task.spawn(function()
        if task.wait(60) then
            repeat
                pcall(function()
                    v142:SetDesc(v129())
                end)
            until not task.wait(60)
        end
    end)
    pcall(function()
        v142:SetDesc(v129())
    end)
end

RandomFF = GRP_Raids_Fruits_Options:AddToggle("Auto_Random_Fruit", {
    Title = "Auto Random Fruit",
    Description = "Tự Random Trái",
    Default = false,
    Callback = function(p212)
        _G.Random_Auto = p212
        _G.RandomFruitCooldown = nil
    end
})

DropF = GRP_Raids_Fruits_Options:AddToggle("Auto_Drop_Fruit", {
    Title = "Auto Drop Fruit",
    Description = "Tự Ném Trái",
    Default = false,
    Callback = function(p213)
        _G.DropFruit = p213
    end
})

StoredF = GRP_Raids_Fruits_Options:AddToggle("Auto_Store_Fruit", {
    Title = "Auto Store Fruit",
    Description = "Tự Cất Trái",
    Default = false,
    Callback = function(p214)
        _G.StoreF = p214
    end
})

do
    TwF = GRP_Raids_Fruits_Options:AddToggle("Auto_Tween_to_Fruit", {
        Title = "Auto Tween to Fruit",
        Description = "Tự Tới Trái",
        Default = false,
        Callback = function(p215)
            _G.TwFruits = p215
        end
    })
end

do
    BringF = GRP_Raids_Fruits_Options:AddToggle("Auto_Collect_Fruit", {
        Title = "Auto Collect Fruit",
        Description = "Tự Nhặt Trái",
        Default = false,
        Callback = function(p216)
            _G.InstanceF = p216
        end
    })
end

do
    GRP_Raids_Fruits_Options:AddDropdown("Select_Fruit_Shop", {
        Title = "Select Fruit Shop",
        Description = "Chọn Cửa Hàng Trái",
        Values = {
            "Rocket-Rocket", "Spin-Spin", "Blade-Blade", "Spring-Spring", "Bomb-Bomb",
            "Smoke-Smoke", "Spike-Spike", "Flame-Flame", "Ice-Ice", "Sand-Sand", "Dark-Dark",
            "Eagle-Eagle", "Diamond-Diamond", "Light-Light", "Rubber-Rubber", "Ghost-Ghost",
            "Magma-Magma", "Quake-Quake", "Buddha-Buddha", "Love-Love", "Creation-Creation",
            "Spider-Spider", "Sound-Sound", "Phoenix-Phoenix", "Portal-Portal",
            "Lightning-Lightning", "Pain-Pain", "Blizzard-Blizzard", "Gravity-Gravity",
            "T-Rex-T-Rex", "Mammoth-Mammoth", "Dough-Dough", "Shadow-Shadow", "Venom-Venom",
            "Gas-Gas", "Control-Control", "Spirit-Spirit", "Leopard-Leopard", "Yeti-Yeti",
            "Kitsune-Kitsune", "Dragon-Dragon"
        },
        Default = 1,
        Callback = function(p217)
            getgenv().SelectFruit = p217
        end
    })
end

do
    GRP_Raids_Fruits_Options:AddToggle("Auto_Buy_Fruit_Shop", {
        Title = "Auto Buy Fruit Shop",
        Description = "Tự Mua Trái Ở Shop",
        Default = false,
        Callback = function(p218)
            getgenv().AutoBuyFruitSniper = p218
        end
    })
end

GRP_Raids_Dungeon_Event_Raiding = t1.Raids:AddSection("Raid", "Raid")

DungeonTables = { "Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix", "Dough" }

Q = GRP_Raids_Dungeon_Event_Raiding:AddDropdown("Select_Chip", {
    Title = "Select Chip",
    Description = "Chọn Chip",
    Values = DungeonTables,
    Default = "",
    Callback = function(p219)
        _G.SelectChip = p219
    end
})

do
    Q = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Select_Dungeon_Chip", {
        Title = "Auto Select Raid Chip",
        Description = "Tự Chọn Chip Raid",
        Default = false,
        Callback = function(p220)
            _G.AutoSelectDungeon = p220
        end
    })
end

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Get_Fruit_In_Inventory_Below_1M", {
    Title = "Get Fruit in Inventory Below 1M",
    Description = "Lấy Trái Dưới 1M Trong Túi",
    Default = false,
    Callback = function(p221)
        getgenv().AutoGetFruit = p221
    end
})

GRP_Raids_Dungeon_Event_Raiding:AddButton({
    Title = "Buy Raid Chips Beli",
    Description = "Mua Chip Raid Bằng Beli",
    Callback = function()
        if not GetBP("Special Microchip") then
            replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
        end
    end
})

GRP_Raids_Dungeon_Event_Raiding:AddButton({
    Title = "Buy Dungeon Chips Devil Fruit",
    Description = "Mua Chip Raid Bằng Trái",
    Callback = function()
        if GetBP("Special Microchip") then
            return
        end
        local t7 = {}
        local response, v145 = replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits")
        for _, v in next, response, v145 do
            if v.Price <= 490000 then
                table.insert(t7, v.Name)
            end
        end
        for _, v in pairs(t7) do
            for _ in pairs(DungeonTables) do
                if not GetBP("Special Microchip") then
                    replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(v))
                    replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
                end
            end
        end
    end
})

AutoChipBeli = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Buy_Chip_[Beli]", {
    Title = "Auto Buy Chip Beli",
    Description = "Tự Mua Chip Beli",
    Default = false,
    Callback = function(p222)
        _G.AutoChipBeli = p222
    end
})

AutoChipFruit = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Buy_Chip_[Devil_Fruit]", {
    Title = "Auto Buy Chip Devil Fruit",
    Description = "Tự Mua Chip Trái",
    Default = false,
    Callback = function(p223)
        _G.AutoChipFruit = p223
    end
})

StartR = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Start_Raid", {
    Title = "Auto Start Raid",
    Description = "Tự Bắt Đầu Raid",
    Default = false,
    Callback = function(p224)
        _G.Auto_StartRaid = p224
    end
})

Raiding = GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Raid_+_Next_Island", {
    Title = "Auto Raid + Next Island",
    Description = "Tự Raid + Đảo Tiếp Theo",
    Default = false,
    Callback = function(p225)
        _G.Raiding = p225
    end
})

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Awakening", {
    Title = "Auto Awakening",
    Description = "Tự Thức Tỉnh",
    Default = false,
    Callback = function(p226)
        _G.Auto_Awakener = p226
    end
})

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Kill_Aura", {
    Title = "Kill Aura (Island 4 & 5)",
    Description = "Hào Quang Sát Thương (Đảo 4 & 5)",
    Default = false,
    Callback = function(p227)
        _G.KillAuraRaid = p227
    end
})

GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Teleport_To_Lab", {
    Title = "Auto Teleport to Lab",
    Description = "Tự Tới Phòng Thí Nghiệm",
    Default = false,
    Callback = function(p228)
        _G.TpLab = p228
        while _G.TpLab do
            wait()
            if _G.TpLab then
                if World2 and _G.TpLab then
                    _tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
                elseif World3 and _G.TpLab then
                    _tp(CFrame.new(-5046, 314, -2960))
                end
            end
        end
    end
})

GRP_Raids_Items_Law_Order_Sword = t1.Raids:AddSection("Law", "Law")

GRP_Raids_Items_Law_Order_Sword:AddButton({
    Title = "Buy Chip Law",
    Description = "Mua Chip Law",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
    end
})

GRP_Raids_Items_Law_Order_Sword:AddButton({
    Title = "Start Law Raids",
    Description = "Bắt Đầu Raid Law",
    Callback = function()
        fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
    end
})

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Buy_Microchip_Law", {
    Title = "Auto Buy Chip Law",
    Description = "Tự Mua Chip Law",
    Default = false,
    Callback = function(p229)
        getgenv().AutoBuyMicrochipLaw = p229
    end
})

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Start_Law_Raids", {
    Title = "Auto Start Law",
    Description = "Tự Bắt Đầu Law",
    Default = false,
    Callback = function(p230)
        getgenv().AutoStartLawRaids = p230
    end
})

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Kill_Law", {
    Title = "Auto Kill Law",
    Description = "Tự Đánh Law",
    Default = false,
    Callback = function(p231)
        _G.AutoLawKak = p231
    end
})

GRP_Raids_Raids_Dungeons = t1.Raids:AddSection("Dungeon", "Hầm Ngục")

GRP_Raids_Raids_Dungeons:AddToggle("Auto_Farm_Dungeon", {
    Title = "Auto Farm Dungeon",
    Description = "Tự Farm Hầm Ngục",
    Default = false,
    Callback = function(p232)
        _G.AutoFarmDungeon = p232
    end
})

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(1)", {
    Title = "TP Exit (1)",
    Description = "Dịch Chuyển Lối Ra (1)",
    Default = false,
    Callback = function(p233)
        _G.TPFloor1 = p233
    end
})

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(2)", {
    Title = "TP Exit (2)",
    Description = "Dịch Chuyển Lối Ra (2)",
    Default = false,
    Callback = function(p234)
        _G.TPFloor2 = p234
    end
})

GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(3)", {
    Title = "TP Exit (3)",
    Description = "Dịch Chuyển Lối Ra (3)",
    Default = false,
    Callback = function(p235)
        _G.TPFloor3 = p235
    end
})

do
    GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(4)", {
        Title = "TP Exit (4)",
        Description = "Dịch Chuyển Lối Ra (4)",
        Default = false,
        Callback = function(p236)
            _G.TPFloor4 = p236
        end
    })
end

-- ==========================================
-- TAB COMBAT
-- ==========================================
GRP_Combat_Combat_AimBot = t1.Combat:AddSection("Combat", "Chiến Đấu")

do
    local v151 = GRP_Combat_Combat_AimBot:AddParagraph({
        Title = "Players on Server",
        Description = "Người Chơi Trong Server",
        Content = ""
    })
    spawn(function()
        while wait(Sec) do
            pcall(function()
                local v152 = #game:GetService("Players"):GetPlayers()
                if v152 == 12 then
                    v151:SetDesc("All Players : " .. v152 .. " / 12 [Max]")
                else
                    v151:SetDesc("All Players : " .. v152 .. " / 12")
                end
            end)
        end
    end)
end

do
    local v153 = GRP_Combat_Combat_AimBot:AddParagraph({
        Title = "Aimbot Status",
        Description = "Trạng Thái Aimbot",
        Content = ""
    })
    Checking_AimStatus = function()
        if _G.AimCam then
            return "Aimbot Camera"
        end
        if _G.AimbotGun then
            return "Aimbot Guns"
        end
        return ""
    end
    spawn(function()
        if wait(0.2) then
            repeat
                pcall(function()
                    if _G.AimMethod then
                        if _G.AimCam or _G.AimbotGun then
                            v153:SetDesc("Aimbot - " .. Checking_AimStatus() .. " : True")
                        else
                            v153:SetDesc("Aimbot - Skills : True")
                        end
                    else
                        v153:SetDesc("Aimbot - Skills : False")
                    end
                end)
            until not wait(0.2)
        end
    end)
end

do
    local t8 = {}
    local Players = game:GetService("Players")
    for _, child in pairs(Players:GetChildren()) do
        table.insert(t8, child.Name)
    end
    GRP_Combat_Combat_AimBot:AddDropdown("Select_Players", {
        Title = "Select Players",
        Description = "Chọn Người Chơi",
        Values = t8,
        Default = 1,
        Callback = function(p237)
            _G.PlayersList = p237
        end
    })
end

GRP_Combat_Combat_AimBot:AddToggle("Teleport_To_Select_Players", {
    Title = "Teleport To Select Players",
    Description = "Dịch Chuyển Tới Người Chơi",
    Default = false,
    Callback = function(p238)
        _G.TpPly = p238
    end
})

GRP_Combat_Combat_AimBot:AddToggle("Spectate_Select_Players", {
    Title = "Spectate Select Players",
    Description = "Theo Dõi Người Chơi",
    Default = false,
    Callback = function(p239)
        SpectatePlys = p239
        spawn(function()
            repeat
                task.wait(0.1)
                if _G.PlayersList then
                    if game:GetService("Players"):FindFirstChild(_G.PlayersList) then
                        workspace.Camera.CameraSubject = game:GetService("Players"):FindFirstChild(_G.PlayersList).Character.Humanoid
                    end
                end
            until not SpectatePlys
            if plr and plr.Character then
                if plr.Character:FindFirstChild("Humanoid") then
                    workspace.Camera.CameraSubject = plr.Character.Humanoid
                end
            end
        end)
    end
})

do
    GRP_Combat_Combat_AimBot:AddDropdown("Select_Aim_Method", {
        Title = "Select Aim Method",
        Description = "Chọn Cách Aim",
        Values = { "Aim Player", "Nearest Aim" },
        Default = 1,
        Callback = function(p240)
            ABmethod = p240
        end
    })
end

GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Method_Skills", {
    Title = "Aimbot Method Skills",
    Description = "Aimbot Kỹ Năng",
    Default = false,
    Callback = function(p241)
        _G.AimMethod = p241
    end
})

GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Camera_Closet_Players", {
    Title = "Aimbot Camera Closest Players",
    Description = "Aimbot Camera Người Gần Nhất",
    Default = false,
    Callback = function(p242)
        _G.AimCam = p242
    end
})

GRP_Combat_Quests_Players = t1.Combat:AddSection("Quest Player", "Nhiệm Vụ Người Chơi")

GRP_Combat_Quests_Players:AddButton({
    Title = "Get Player Quests",
    Description = "Lấy Nhiệm Vụ Người Chơi",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
        end)
    end
})

GRP_Combat_Quests_Players:AddToggle("Auto_Get_PlayerQuest", {
    Title = "Auto Get Player Quest",
    Description = "Tự Lấy Nhiệm Vụ",
    Default = false,
    Callback = function(p243)
        _G.AutoReceivePlayerQuest = p243
    end
})

GRP_Combat_Quests_Players:AddToggle("Auto_Kill_Player_Quest", {
    Title = "Auto Kill Player Quest",
    Description = "Tự Đánh Người Chơi",
    Default = false,
    Callback = function(p244)
        _G.AutoPlayerHunter = p244
        if not p244 then
            Useskill = false
        end
    end
})

GRP_Combat_Quests_Players:AddToggle("Auto_Enable_PvP", {
    Title = "Auto Enable PvP",
    Description = "Tự Bật PvP",
    Default = false,
    Callback = function(p245)
        _G.AutoPvP = p245
    end
})

do
    GRP_Combat_Quests_Players:AddToggle("Auto_Safe_Mode", {
        Title = "Auto Safe Mode",
        Description = "Tự Chế Độ An Toàn",
        Default = false,
        Callback = function(p246)
            _G.SafeMode = p246
        end
    })
end

GRP_Combat_LocalPlayer_Settings = t1.Combat:AddSection("Local Player Setting", "Cài Đặt Cá Nhân")

game:GetService("Players")
game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local u159 = false
local n3 = 50

do
    local connection
    local t9 = { f = 0, b = 0, l = 0, r = 0 }
    local BodyGyro
    local BodyVelocity

    local function v165()
        local function v166()
            if not plr.Character then
                return
            end
            local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            if not Humanoid then
                return
            end
            local MoveDirection = Humanoid.MoveDirection
            t9.f = 0
            t9.b = 0
            t9.l = 0
            t9.r = 0
            if MoveDirection.Z < -0.1 then
                t9.f = 1
            elseif MoveDirection.Z > 0.1 then
                t9.b = 1
            end
            if MoveDirection.X < -0.1 then
                t9.l = 1
            elseif MoveDirection.X > 0.1 then
                t9.r = 1
            end
        end
        local connection2
        connection2 = RunService.Heartbeat:Connect(function()
            if u159 then
                v166()
            elseif connection2 then
                connection2:Disconnect()
            end
        end)
    end

    local function v170(p247)
        u159 = p247
        if u159 then
            if not plr.Character then
                return
            end
            local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            local Torso
            if plr.Character:FindFirstChild("Torso") then
                Torso = plr.Character.Torso
            else
                Torso = plr.Character.UpperTorso
            end
            if not Humanoid or not Torso then
                return
            end
            for _, descendant in ipairs(plr.Character:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false
                    descendant.Massless = true
                end
            end
            plr.Character.DescendantAdded:Connect(function(descendant)
                if u159 then
                    if descendant:IsA("BasePart") then
                        descendant.CanCollide = false
                        descendant.Massless = true
                    end
                end
            end)
            BodyGyro = Instance.new("BodyGyro", Torso)
            BodyGyro.P = 90000
            BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BodyGyro.cframe = Torso.CFrame
            BodyVelocity = Instance.new("BodyVelocity", Torso)
            BodyVelocity.velocity = Vector3.new(0, 0, 0)
            BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
            Humanoid.PlatformStand = true
            v165()
            connection = RunService.Heartbeat:Connect(function()
                if not u159 or not plr.Character then
                    return
                end
                for _, descendant in ipairs(plr.Character:GetDescendants()) do
                    if descendant:IsA("BasePart") and descendant.CanCollide then
                        descendant.CanCollide = false
                    end
                end
                if t9.l + t9.r == 0 and t9.f + t9.b == 0 then
                    BodyVelocity.velocity = Vector3.new(0, 0, 0)
                else
                    BodyVelocity.velocity = (workspace.CurrentCamera.CoordinateFrame.lookVector * (t9.f + t9.b) + (workspace.CurrentCamera.CoordinateFrame * CFrame.new(t9.l + t9.r, (t9.f + t9.b) * 0.2, 0).p - workspace.CurrentCamera.CoordinateFrame.p)) * n3
                end
                BodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            if plr.Character then
                local Humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.PlatformStand = false
                end
                for _, descendant in ipairs(plr.Character:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        descendant.CanCollide = true
                        descendant.Massless = false
                    end
                end
                if BodyGyro then
                    BodyGyro:Destroy()
                end
                if BodyVelocity then
                    BodyVelocity:Destroy()
                end
            end
            t9 = { f = 0, b = 0, l = 0, r = 0 }
        end
    end

    local function v180(p248)
        n3 = p248
    end

    GRP_Combat_LocalPlayer_Settings:AddToggle("Enable_Fly", {
        Title = "Enable Fly",
        Description = "Bật Bay",
        Default = false,
        Callback = function(p249)
            v170(p249)
        end
    })

    GRP_Combat_LocalPlayer_Settings:AddSlider("Speed_Fly_Mode", {
        Title = "Speed Fly Mode",
        Description = "Tốc Độ Bay",
        Min = 10,
        Max = 200,
        Default = 50,
        Rounding = 1,
        Callback = function(p250)
            v180(p250)
        end
    })
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Dash_No_Cooldown", {
    Title = "Dash No Cooldown",
    Description = "Lướt Không Hồi Chiêu",
    Default = false,
    Callback = function(p251)
        getgenv().DodgeNoCD = p251
    end
})

do
    GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Mink_V3_[_INF_]", {
        Title = "Instance Mink V3 [ INF ]",
        Description = "Vô Hạn Mink V3 [ INF ]",
        Default = false,
        Callback = function(p252)
            InfAblities = p252
        end
    })
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Energy_[_INF_]", {
    Title = "Instance Energy [ INF ]",
    Description = "Vô Hạn Năng Lượng [ INF ]",
    Default = false,
    Callback = function(p253)
        infEnergy = p253
        if p253 then
            getInfinity_Ability("Energy", infEnergy)
        end
    end
})

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Soru_[_INF_]", {
    Title = "Instance Soru [ INF ]",
    Description = "Vô Hạn Soru [ INF ]",
    Default = false,
    Callback = function(p254)
        _G.InfSoru = p254
        if p254 then
            getInfinity_Ability("Soru", _G.InfSoru)
        end
    end
})

do
    GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Observation_Range_[_INF_]", {
        Title = "Instance Observation Range [ INF ]",
        Description = "Vô Hạn Tầm Observation [ INF ]",
        Default = false,
        Callback = function(p255)
            _G.InfiniteObRange = p255
            if p255 then
                getInfinity_Ability("Observation", _G.InfiniteObRange)
            end
        end
    })
end

do
    GRP_Combat_LocalPlayer_Settings:AddToggle("Ignore_Same_Teams", {
        Title = "Ignore Same Teams",
        Description = "Bỏ Qua Đồng Đội",
        Default = false,
        Callback = function(p256)
            _G.NoAimTeam = p256
        end
    })
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Accept_Allies", {
    Title = "Accept Allies",
    Description = "Chấp Nhận Đồng Minh",
    Default = false,
    Callback = function(p257)
        _G.AcceptAlly = p257
    end
})

-- ==========================================
-- TAB TRAVEL
-- ==========================================
GRP_Travel_Travel_Worlds = t1.Travel:AddSection("Sea", "Biển")

GRP_Travel_Travel_Worlds:AddButton({
    Title = "Travel Sea 1",
    Description = "Đi Biển 1",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("TravelMain")
    end
})

GRP_Travel_Travel_Worlds:AddButton({
    Title = "Travel Sea 2",
    Description = "Đi Biển 2",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})

GRP_Travel_Travel_Worlds:AddButton({
    Title = "Travel Sea 3",
    Description = "Đi Biển 3",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("TravelZou")
    end
})

GRP_Travel_Travel_Island = t1.Travel:AddSection("Island", "Đảo")

Location = {}
for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
    table.insert(Location, child.Name)
end

Travelllll = GRP_Travel_Travel_Island:AddDropdown("Select_Travelling", {
    Title = "Select Island",
    Description = "Chọn Đảo",
    Values = Location,
    Default = 1,
    Callback = function(p258)
        _G.Island = p258
    end
})

GoIsland = GRP_Travel_Travel_Island:AddToggle("Auto_Travel", {
    Title = "Teleport Island",
    Description = "Dịch Chuyển Tới Đảo",
    Default = false,
    Callback = function(p259)
        _G.Teleport = p259
        if p259 then
            for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
                if child.Name == _G.Island then
                    while true do
                        wait()
                        _tp(child.CFrame * CFrame.new(0, 30, 0))
                        if _G.Teleport then
                            if Root.CFrame == child.CFrame then
                                break
                            end
                        else
                            break
                        end
                    end
                end
            end
        end
    end
})

GRP_Travel_Travel_Portal = t1.Travel:AddSection("Portal", "Cổng")

do
    local t10 = {}
    if World1 then
        t10 = { "Sky", "UnderWater" }
    elseif World2 then
        t10 = { "SwanRoom", "Cursed Ship" }
    elseif World3 then
        t10 = { "Castle On The Sea", "Mansion Cafe", "Hydra Teleport", "Canvendish Room", "Temple of Time" }
    end
    PortalTP = GRP_Travel_Travel_Portal:AddDropdown("Select_Portal", {
        Title = "Select Portal",
        Description = "Chọn Cổng",
        Values = t10,
        Default = 1,
        Callback = function(p260)
            _G.Island_PT = p260
        end
    })
end

do
    GRP_Travel_Travel_Portal:AddButton({
        Title = "Teleport Portal",
        Description = "Dịch Chuyển Tới Cổng",
        Callback = function()
            if _G.Island_PT == "Sky" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894, 5547, -380))
            elseif _G.Island_PT == "UnderWater" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163, 11, 1819))
            elseif _G.Island_PT == "SwanRoom" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2285, 15, 905))
            elseif _G.Island_PT == "Cursed Ship" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923, 126, 32852))
            elseif _G.Island_PT == "Castle On The Sea" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
            elseif _G.Island_PT == "Mansion Cafe" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
            elseif _G.Island_PT == "Hydra Teleport" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.45263671875, 1013.0858154296875, -340.51025390625))
            elseif _G.Island_PT == "Canvendish Room" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.54638671875, 22.562219619750977, -127.06755065917969))
            elseif _G.Island_PT == "Temple of Time" then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741, -0.469690144, -2.85620132e-08, -0.882831335, -3.23509219e-08, 1, -1.51411736e-08, 0.882831335, 2.14487486e-08, -0.469690144))
            end
        end
    })
end

GRP_Travel_Travel_NPCs = t1.Travel:AddSection("NPC", "NPC")

do
    local t11 = {}
    for _, child in pairs(replicated.NPCs:GetChildren()) do
        table.insert(t11, child.Name)
    end
    NPCsPos = GRP_Travel_Travel_NPCs:AddDropdown("Select_NPC", {
        Title = "Select NPCs",
        Description = "Chọn NPC",
        Values = t11,
        Default = 1,
        Callback = function(p261)
            _G.TPNpc = p261
        end
    })
end

GoNPCs = GRP_Travel_Travel_NPCs:AddToggle("Auto_Tween_to_NPC", {
    Title = "Auto Tween to NPC",
    Description = "Tự Động Tới NPC",
    Default = false,
    Callback = function(p262)
        _G.TPNpc = p262
    end
})

-- ==========================================
-- TAB SHOP
-- ==========================================
GRP_Shop_Shop_Options = t1.Shop:AddSection("Shop", "Cửa Hàng")

GRP_Shop_Shop_Options:AddButton({
    Title = "Buy Buso",
    Description = "Mua Buso",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
    end
})

GRP_Shop_Shop_Options:AddButton({
    Title = "Buy Geppo",
    Description = "Mua Geppo",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
    end
})

GRP_Shop_Shop_Options:AddButton({
    Title = "Buy Soru",
    Description = "Mua Soru",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
    end
})

GRP_Shop_Shop_Options:AddButton({
    Title = "Buy Ken",
    Description = "Mua Ken",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
    end
})

GRP_Shop_Fighting_Style = t1.Shop:AddSection("Fighting Style", "Võ Thuật")

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Black Leg",
    Description = "Mua Black Leg",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Electro",
    Description = "Mua Electro",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyElectro")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Fishman Karate",
    Description = "Mua Fishman Karate",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy DragonClaw",
    Description = "Mua DragonClaw",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Superhuman",
    Description = "Mua Superhuman",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Death Step",
    Description = "Mua Death Step",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Sharkman Karate",
    Description = "Mua Sharkman Karate",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy ElectricClaw",
    Description = "Mua ElectricClaw",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy DragonTalon",
    Description = "Mua DragonTalon",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy Godhuman",
    Description = "Mua Godhuman",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})

GRP_Shop_Fighting_Style:AddButton({
    Title = "Buy SanguineArt",
    Description = "Mua SanguineArt",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
})

GRP_Shop_Accessory = t1.Shop:AddSection("Accessories", "Phụ Kiện")

GRP_Shop_Accessory:AddButton({
    Title = "Buy Tomoe Ring",
    Description = "Mua Nhẫn Tomoe",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring")
    end
})

GRP_Shop_Accessory:AddButton({
    Title = "Buy Black Cape",
    Description = "Mua Áo Choàng Đen",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
    end
})

GRP_Shop_Accessory:AddButton({
    Title = "Buy Swordsman Hat",
    Description = "Mua Nón Kiếm Sĩ",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat")
    end
})

GRP_Shop_Accessory:AddButton({
    Title = "Buy Bizarre Rifle",
    Description = "Mua Súng Bizarre",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
    end
})

GRP_Shop_Accessory:AddButton({
    Title = "Buy Ghoul Mask",
    Description = "Mua Mặt Nạ Ghoul",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 2)
    end
})

GRP_Shop_Weapon_World1 = t1.Shop:AddSection("Weapon", "Vũ Khí")

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Cutlass",
    Description = "Mua Cutlass",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Katana",
    Description = "Mua Katana",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Katana")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Iron Mace",
    Description = "Mua Chùy Sắt",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Duel Katana",
    Description = "Mua Song Kiếm",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Triple Katana",
    Description = "Mua Tam Kiếm",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Pipe",
    Description = "Mua Ống Nước",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Dual-Headed Blade",
    Description = "Mua Kiếm Hai Đầu",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
    end
})

do
    GRP_Shop_Weapon_World1:AddButton({
        Title = "Buy Bisento",
        Description = "Mua Bisento",
        Callback = function()
            replicated.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
        end
    })
end

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Soul Cane",
    Description = "Mua Gậy Linh Hồn",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
    end
})

do
    GRP_Shop_Weapon_World1:AddButton({
        Title = "Buy Slingshot",
        Description = "Mua Ná Cao Su",
        Callback = function()
            replicated.Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
        end
    })
end

do
    GRP_Shop_Weapon_World1:AddButton({
        Title = "Buy Musket",
        Description = "Mua Súng Hỏa Mai",
        Callback = function()
            replicated.Remotes.CommF_:InvokeServer("BuyItem", "Musket")
        end
    })
end

do
    GRP_Shop_Weapon_World1:AddButton({
        Title = "Buy Dual Flintlock",
        Description = "Mua Súng Đôi",
        Callback = function()
            replicated.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
        end
    })
end

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Flintlock",
    Description = "Mua Súng Lửa",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
    end
})

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Refined Flintlock",
    Description = "Mua Súng Lửa Cải Tiến",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
    end
})

do
    GRP_Shop_Weapon_World1:AddButton({
        Title = "Buy Cannon",
        Description = "Mua Pháo",
        Callback = function()
            replicated.Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
        end
    })
end

GRP_Shop_Weapon_World1:AddButton({
    Title = "Buy Kabucha",
    Description = "Mua Kabucha",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
    end
})

GRP_Shop_Fragments_shop = t1.Shop:AddSection("Fragment", "Mảnh (Fragment)")

GRP_Shop_Fragments_shop:AddButton({
    Title = "Buy Refund Stats",
    Description = "Mua Hoàn Chỉ Số",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
    end
})

GRP_Shop_Fragments_shop:AddButton({
    Title = "Buy Reroll Race",
    Description = "Mua Đổi Chủng Tộc",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
    end
})

GRP_Shop_Fragments_shop:AddButton({
    Title = "Buy Ghoul Race",
    Description = "Mua Chủng Tộc Ghoul",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("Ectoplasm", " Change", 4)
    end
})

GRP_Shop_Fragments_shop:AddButton({
    Title = "Buy Cyborg Race (2.5k)",
    Description = "Mua Chủng Tộc Cyborg (2.5k)",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("CyborgTrainer", " Buy")
    end
})

GRP_Shop_Fragments_shop:AddButton({
    Title = "Buy Draco Race",
    Description = "Mua Chủng Tộc Draco",
    Callback = function()
        _tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
        local vector3 = Vector3.new(5814.42724609375, 1208.3267822265625, 884.57855224609375)
        local Character = plr.Character or plr.CharacterAdded:Wait()
        repeat
            wait()
        until (Character.HumanoidRootPart.Position - vector3).Magnitude < 1
        replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ { NPC = "Dragon Wizard", Command = "DragonRace" } }))
    end
})

-- ==========================================
-- TAB MISC
-- ==========================================
GRP_Misc_Server_Function = t1.Misc:AddSection("Server", "Server")

GRP_Misc_Server_Function:AddButton({
    Title = "Redeem All Codes",
    Description = "Nhập Tất Cả Code",
    Callback = function()
        local t12 = {
            "LIGHTNINGABUSE", "1LOSTADMIN", "ADMINFIGHT", "GIFTING_HOURS", "NOMOREHACK",
            "BANEXPLOIT", "WildDares", "BossBuild", "GetPranked", "EARN_FRUITS",
            "SUB2GAMERROBOT_RESET1", "KITT_RESET", "Bignews", "CHANDLER", "Fudd10",
            "fudd10_v2", "Sub2UncleKizaru", "FIGHT4FRUIT", "kittgaming", "TRIPLEABUSE",
            "Sub2CaptainMaui", "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK",
            "Starcodeheo", "Bluxxy", "SUB2GAMERROBOT_EXP1", "Sub2NoobMaster123",
            "Sub2Daigrock", "Axiore", "TantaiGaming", "StrawHatMaine", "Sub2OfficialNoobie",
            "TheGreatAce", "JULYUPDATE_RESET", "ADMINHACKED", "SEATROLLING", "24NOADMIN",
            "ADMIN_TROLL", "NEWTROLL", "SECRET_ADMIN", "staffbattle", "NOEXPLOIT",
            "NOOB2ADMIN", "CODESLIDE", "fruitconcepts", "krazydares"
        }
        local Redeem = replicated:WaitForChild("Remotes"):FindFirstChild("Redeem")
        if not Redeem then
            return
        end
        for _, v in ipairs(t12) do
            task.wait(0)
            pcall(function()
                if Redeem.InvokeServer then
                    Redeem:InvokeServer(v)
                else
                    Redeem:FireServer(v)
                end
            end)
        end
    end
})

GRP_Misc_Server_Function:AddButton({
    Title = "Rejoin Server",
    Description = "Vào Lại Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

GRP_Misc_Server_Function:AddButton({
    Title = "Hop Server",
    Description = "Chuyển Server",
    Callback = function()
        task.spawn(function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local Players = game:GetService("Players")
            local ok, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
            end)
            if ok and result then
                local id
                for _, v in pairs(result) do
                    if v.playing < v.maxPlayers then
                        id = v.id
                    end
                end
                if id then
                    pcall(function()
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, id, Players.LocalPlayer)
                    end)
                end
            end
        end)
    end
})

GRP_Misc_Server_Function:AddButton({
    Title = "Hop to Lowest Players",
    Description = "Chuyển Tới Server Ít Người",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local v206 = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local function v207(p263)
            return HttpService:JSONDecode(game:HttpGet(v206 .. (p263 and "&cursor=" .. p263 or "")))
        end
        local nextPageCursor, v210
        repeat
            local v211 = v207(nextPageCursor)
            v210 = v211.data[1]
            nextPageCursor = v211.nextPageCursor
        until v210
        TeleportService:TeleportToPlaceInstance(game.PlaceId, v210.id, plr)
    end
})

do
    GRP_Misc_Server_Function:AddButton({
        Title = "Hop to Lowest Pings Server",
        Description = "Chuyển Tới Server Ping Thấp",
        Callback = function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")
            local v214 = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local function v215(p264)
                return HttpService:JSONDecode(game:HttpGet(v214 .. (p264 and "&cursor=" .. p264 or "")))
            end
            local nextPageCursor, v220
            repeat
                local v221 = v215(nextPageCursor)
                v220 = v221.data[1]
                nextPageCursor = v221.nextPageCursor
            until v220
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v220.id, plr)
        end
    })
end

GRP_Misc_Server_Function:AddInput("Input_Job_Id", {
    Title = "Input Job Id",
    Description = "Nhập Job Id",
    Default = "",
    Placeholder = "Job ID",
    Callback = function(p265)
        getgenv().Job = p265
    end
})

GRP_Misc_Server_Function:AddButton({
    Title = "Teleport Job ID",
    Description = "Dịch Chuyển Bằng Job ID",
    Callback = function()
        if getgenv().Job and getgenv().Job ~= "" then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, getgenv().Job, game.Players.LocalPlayer)
        end
    end
})

GRP_Misc_Server_Function:AddButton({
    Title = "Copy Job ID",
    Description = "Sao Chép Job ID",
    Callback = function()
        setclipboard(tostring(game.JobId))
    end
})

GRP_Misc_Player_Gui_Others = t1.Misc:AddSection("GUI", "Giao Diện")

do
    GRP_Misc_Player_Gui_Others:AddButton({
        Title = "Open Awakenings Expert",
        Description = "Mở Bảng Thức Tỉnh",
        Callback = function()
            if plr and plr.PlayerGui and plr.PlayerGui.Main then
                if plr.PlayerGui.Main:FindFirstChild("AwakeningToggler") then
                    plr.PlayerGui.Main.AwakeningToggler.Visible = true
                end
            end
        end
    })
end

GRP_Misc_Player_Gui_Others:AddButton({
    Title = "Open Title Selection",
    Description = "Mở Bảng Danh Hiệu",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("getTitles", true)
        if plr and plr.PlayerGui and plr.PlayerGui.Main then
            if plr.PlayerGui.Main:FindFirstChild("Titles") then
                plr.PlayerGui.Main.Titles.Visible = true
            end
        end
    end
})

DisbleChat = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Chat_GUI", {
    Title = "Disable Chat GUI",
    Description = "Tắt Chat",
    Default = false,
    Callback = function(p266)
        _G.Rechat = p266
        local StarterGui = game:GetService("StarterGui")
        if _G.Rechat == true then
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        else
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        end
    end
})

DisbleLeaderB = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Leader_Board_GUI", {
    Title = "Disable Leader Board GUI",
    Description = "Tắt Bảng Xếp Hạng",
    Default = false,
    Callback = function(p267)
        ReLeader = p267
        local StarterGui = game:GetService("StarterGui")
        if ReLeader == true then
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
        elseif ReLeader == false then
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end
})

GRP_Boost_FPS = t1.Misc:AddSection("Boost FPS", "Tăng FPS")

rtxM = GRP_Boost_FPS:AddToggle("Turn_on_RTX_Mode", {
    Title = "Turn on RTX Mode",
    Description = "Bật Chế Độ RTX",
    Default = false,
    Callback = function(p268)
        _G.RTXMode = p268
        for _, child in pairs(game.Lighting:GetChildren()) do
            if child.Name == "RTXColorCorrection" or child.Name == "RTXTint" then
                child:Destroy()
            end
        end
        if _G.RTXMode then
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting)
            ColorCorrectionEffect.Name = "RTXColorCorrection"
            local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect", game.Lighting)
            ColorCorrectionEffect2.Name = "RTXTint"
            OldAmbient = game.Lighting.Ambient
            OldBrightness = game.Lighting.Brightness
            OldColorShift_Top = game.Lighting.ColorShift_Top
            ColorCorrectionEffect.Brightness = 0.176
            ColorCorrectionEffect.Contrast = 0.39
            ColorCorrectionEffect.TintColor = Color3.fromRGB(217, 145, 57)
            ColorCorrectionEffect2.TintColor = Color3.fromRGB(217, 145, 57)
            game.Lighting.FogEnd = 999
            spawn(function()
                while _G.RTXMode do
                    wait()
                    game.Lighting.Ambient = Color3.fromRGB(33, 33, 33)
                    game.Lighting.Brightness = 0.3
                    if not _G.RTXMode then
                        break
                    end
                    if plr.Character then
                        if plr.Character:FindFirstChild("HumanoidRootPart") then
                            if not plr.Character.HumanoidRootPart:FindFirstChild("RTXPointLight") then
                                local PointLight = Instance.new("PointLight")
                                PointLight.Name = "RTXPointLight"
                                PointLight.Parent = plr.Character.HumanoidRootPart
                                PointLight.Range = 15
                                PointLight.Color = Color3.fromRGB(217, 145, 57)
                            end
                        end
                    end
                end
            end)
        else
            pcall(function()
                if OldAmbient then
                    game.Lighting.Ambient = OldAmbient
                end
                if OldBrightness then
                    game.Lighting.Brightness = OldBrightness
                end
                if OldColorShift_Top then
                    game.Lighting.ColorShift_Top = OldColorShift_Top
                end
                game.Lighting.FogEnd = 2500
            end)
            for _, child in pairs(game.Lighting:GetChildren()) do
                if child.Name == "RTXColorCorrection" or child.Name == "RTXTint" then
                    child:Destroy()
                end
            end
            if plr.Character then
                if plr.Character:FindFirstChild("HumanoidRootPart") then
                    local RTXPointLight = plr.Character.HumanoidRootPart:FindFirstChild("RTXPointLight")
                    if RTXPointLight then
                        RTXPointLight:Destroy()
                    end
                end
            end
        end
    end
})

GRP_Boost_FPS:AddButton({
    Title = "Turn on Fast Mode",
    Description = "Bật Chế Độ Nhanh",
    Callback = function()
        local descendants, v233 = workspace:GetDescendants()
        for _, v in next, descendants, v233 do
            if table.find(Past, v.ClassName) then
                v.Material = "Plastic"
            end
        end
    end
})

do
    GRP_Boost_FPS:AddButton({
        Title = "Turn on Low CPU",
        Description = "Bật Chế Độ Ít CPU",
        Callback = function()
            if LowCpu then
                LowCpu()
            end
        end
    })
end

do
    GRP_Boost_FPS:AddButton({
        Title = "Remove Sky Fog",
        Description = "Xóa Sương Mù",
        Callback = function()
            for _, child in pairs(game.Lighting:GetChildren()) do
                if child.Name == "Sky" or child.Name == "LightingLayers" or child.Name == "SeaTerrorCC" or child.Name == "FantasySky" then
                    child:Destroy()
                end
            end
        end
    })
end

GRP_Misc_Configure_God = t1.Misc:AddSection("Other", "Khác")

GRP_Misc_Configure_God:AddButton({
    Title = "Rain Fruits (Client)",
    Description = "Mưa Trái Ác Quỷ",
    Callback = function()
        for _, child in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
            child.Parent = game.Workspace.Map
            child:MoveTo(plr.Character.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
            if child.Fruit:FindFirstChild("AnimationController") then
                child.Fruit:FindFirstChild("AnimationController"):LoadAnimation(child.Fruit:FindFirstChild("Idle")):Play()
            end
            child.Handle.Touched:Connect(function(part)
                if part.Parent == plr.Character then
                    child.Parent = plr.Backpack
                end
            end)
        end
    end
})

do
    briggt1 = GRP_Misc_Configure_God:AddToggle("Turn_on_Full_Bright", {
        Title = "Turn on Full Bright",
        Description = "Bật Ánh Sáng Tối Đa",
        Default = false,
        Callback = function(p269)
            _G.SelectDN = p269
            if p269 then
                Lighting.Ambient = Color3.new(1, 1, 1)
                Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
                Lighting.ColorShift_Top = Color3.new(1, 1, 1)
            else
                Lighting.Ambient = Color3.new(0, 0, 0)
                Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
                Lighting.ColorShift_Top = Color3.new(0, 0, 0)
            end
        end
    })
end

GRP_Misc_Configure_God:AddButton({
    Title = "Increase Boat Speed",
    Description = "Tăng Tốc Thuyền",
    Callback = function()
        for _, descendant in pairs(workspace.Boats:GetDescendants()) do
            if table.find(t5, descendant.Name) and tostring(descendant.Owner.Value) == tostring(plr.Name) then
                descendant.VehicleSeat.MaxSpeed = 350
                descendant.VehicleSeat.Torque = 0.2
                descendant.VehicleSeat.TurnSpeed = 5
                descendant.VehicleSeat.HeadsUpDisplay = true
            end
        end
    end
})

GRP_Misc_Configure_God:AddButton({
    Title = "Set Pirate Team",
    Description = "Chọn Phe Hải Tặc",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
})

GRP_Misc_Configure_God:AddButton({
    Title = "Set Marine Team",
    Description = "Chọn Phe Hải Quân",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
})

UnPortal = GRP_Misc_Configure_God:AddToggle("Unlock_All_Portals", {
    Title = "Unlock All Portals",
    Description = "Mở Khóa Tất Cả Cổng",
    Default = false,
    Callback = function(p270)
        _G.PortalUnLock = p270
    end
})

HakiSt = { "State 0", "State 1", "State 2", "State 3", "State 4", "State 5" }

HakiStat = GRP_Misc_Configure_God:AddDropdown("Select_Haki_States", {
    Title = "Select Haki States",
    Description = "Chọn Cấp Haki",
    Values = HakiSt,
    Default = 1,
    Callback = function(p271)
        _G.SelectStateHaki = p271
    end
})

GRP_Misc_Configure_God:AddButton({
    Title = "Change Buso Stage",
    Description = "Đổi Cấp Buso",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", ({
            ["State 0"] = 0,
            ["State 1"] = 1,
            ["State 2"] = 2,
            ["State 3"] = 3,
            ["State 4"] = 4,
            ["State 5"] = 5
        })[_G.SelectStateHaki] or 0)
    end
})

do
    DayN = GRP_Misc_Configure_God:AddDropdown("Select_Time", {
        Title = "Select Time",
        Description = "Chọn Thời Gian",
        Values = { "Day", "Night" },
        Default = 1,
        Callback = function(p272)
            _G.SelectDN = p272
        end
    })
end

dayornight = GRP_Misc_Configure_God:AddToggle("Turn_on_Time", {
    Title = "Turn on Time",
    Description = "Bật Chỉnh Thời Gian",
    Default = false,
    Callback = function(p273)
        _G.daylightN = p273
    end
})

walkWater = GRP_Misc_Configure_God:AddToggle("Turn_on_Walk_on_Water", {
    Title = "Turn on Walk on Water",
    Description = "Đi Trên Nước",
    Default = true,
    Callback = function(p274)
        _G.WalkWater_Part = p274
        pcall(function()
            if _G.WalkWater_Part then
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
            else
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
            end
        end)
    end
})

iceWalk = GRP_Misc_Configure_God:AddToggle("Turn_on_Ice_Walk", {
    Title = "Turn on Ice Walk",
    Description = "Đi Trên Băng",
    Default = false,
    Callback = function(p275)
        _G.WalkWater = p275
    end
})

lib:Notify({
    Title = "Meow Hub",
    Content = "The script has been completely turn on!",
    Duration = 8
})
