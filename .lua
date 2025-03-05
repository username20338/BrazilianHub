# BrazilianHub          -- Carregar a library do RedzHub
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

-- Criar a Janela Principal
local Window = redzlib:MakeWindow({
    Title = "Blox Fruits Hub",
    SubTitle = "By CarlosHenriqueEditz",
    SaveFolder = "Redz Config"
})

-- Criar Tabs
local AutoFarmTab = Window:MakeTab({"Auto Farm", "Farm de NPCs e Bosses"})
local ESPTab = Window:MakeTab({"ESP", "Localização de Jogadores, Baús e Frutas"})
local TeleportTab = Window:MakeTab({"Teleport", "Vá para qualquer ilha"})
local CombatTab = Window:MakeTab({"Combat", "Ultra Fast Attack"})

-- --------------- Auto Farm ---------------
local AutoFarmToggle = false

AutoFarmTab:AddToggle({
    Name = "Auto Farm",
    Description = "Farme NPCs automaticamente",
    Default = false,
    Callback = function(state)
        AutoFarmToggle = state
        while AutoFarmToggle do
            task.wait(0.1)

            -- Código para encontrar NPCs e atacar
            for _, npc in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    local player = game.Players.LocalPlayer
                    player.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) -- Move o player perto do NPC
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame) -- Simula um ataque
                end
            end
        end
    end
})

-- --------------- ESP ---------------
local function CreateESP(Object, Color)
    if Object:FindFirstChild("ESP") then
        return
    end

    local ESP = Instance.new("Highlight")
    ESP.Name = "ESP"
    ESP.Parent = Object
    ESP.FillColor = Color
    ESP.OutlineColor = Color
    ESP.FillTransparency = 0.5
    ESP.OutlineTransparency = 0
end

local ESPToggle = false

ESPTab:AddToggle({
    Name = "Ativar ESP",
    Description = "Mostra jogadores, baús e frutas",
    Default = false,
    Callback = function(state)
        ESPToggle = state
        while ESPToggle do
            task.wait(1)

            -- ESP para jogadores
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    CreateESP(player.Character, Color3.fromRGB(255, 0, 0)) -- Vermelho para jogadores
                end
            end

            -- ESP para baús
            for _, chest in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.find(chest.Name:lower(), "chest") then
                    CreateESP(chest, Color3.fromRGB(255, 255, 0)) -- Amarelo para baús
                end
            end

            -- ESP para frutas
            for _, fruit in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.find(fruit.Name:lower(), "fruit") then
                    CreateESP(fruit, Color3.fromRGB(0, 255, 0)) -- Verde para frutas
                end
            end
        end
    end
})

-- --------------- Teleport para Ilhas ---------------
local ilhas = {
    ["Starter Island"] = CFrame.new(1000, 50, 1000),
    ["Jungle"] = CFrame.new(-1200, 50, -1500),
    ["Pirate Village"] = CFrame.new(-1100, 40, 3850),
    ["Desert"] = CFrame.new(930, 15, 4500),
    ["Frozen Village"] = CFrame.new(1200, 50, -5000),
    ["Marine Fortress"] = CFrame.new(-5000, 50, 4250),
    ["Sky Islands"] = CFrame.new(-5000, 300, -2750),
    ["Colosseum"] = CFrame.new(-1500, 50, -3000),
    ["Magma Village"] = CFrame.new(-5000, 50, 8500),
    ["Underwater City"] = CFrame.new(61500, 50, 1200),
    ["Fountain City"] = CFrame.new(5500, 50, 4000),
}

for nome, cframe in pairs(ilhas) do
    TeleportTab:AddButton({
        Name = nome,
        Description = "Teleporta para " .. nome,
        Callback = function()
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = cframe
            end
        end
    })
end

-- --------------- Ultra Fast Attack ---------------
local UltraFastAttack = false

CombatTab:AddToggle({
    Name = "Ultra Fast Attack",
    Description = "Ativa ataques super rápidos",
    Default = false,
    Callback = function(state)
        UltraFastAttack = state
        while UltraFastAttack do
            task.wait(0.05) -- Diminui o tempo entre ataques

            -- Simula ataque rápido
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end
})
