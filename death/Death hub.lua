-- Carregar a Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Settings = {
    AutoTP = false,
    Intervalo = 5 -- segundos entre cada TP
}

-- Criar a interface Rayfield
local Window = Rayfield:CreateWindow({
    Name = "Death Hub - Teleporte",
    LoadingTitle = "Death Hub",
    LoadingSubtitle = "by Emperordeath",
    ConfigurationSaving = {
        Enabled = false
    }
})

local Main = Window:CreateTab("Principal", 4483362458)
local Config = Window:CreateTab("Configurações", 4483362458)

-- Toggle Auto Teleport
Main:CreateToggle({
    Name = "Auto TP pro RewardChest",
    CurrentValue = false,
    Callback = function(val)
        Settings.AutoTP = val
    end
})

-- Slider de intervalo entre TPs
Config:CreateSlider({
    Name = "Intervalo (segundos)",
    Range = {1, 30},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(val)
        Settings.Intervalo = val
    end
})

-- Função de teleport
local function Teleportar()
    local chest = Workspace:FindFirstChild("RewardChest")
    local char = LocalPlayer.Character
    if chest and chest:IsA("BasePart") and char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = chest.CFrame + Vector3.new(0, 5, 0)
    end
end

-- Loop para teleportar se ativado
task.spawn(function()
    while true do
        if Settings.AutoTP then
            pcall(Teleportar)
        end
        task.wait(Settings.Intervalo)
    end
end)