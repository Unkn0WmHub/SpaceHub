local pcall, getgenv, next, setmetatable, Vector2new, CFramenew, Color3fromRGB, Drawingnew, TweenInfonew, stringupper, mousemoverel = pcall, getgenv, next, setmetatable, Vector2.new, CFrame.new, Color3.fromRGB, Drawing.new, TweenInfo.new, string.upper, mousemoverel or (Input and Input.MouseMove)

--// Cache

local pcall, getgenv, next, setmetatable, Vector2new, CFramenew, Color3fromRGB, Drawingnew, TweenInfonew, stringupper, mousemoverel = pcall, getgenv, next, setmetatable, Vector2.new, CFrame.new, Color3.fromRGB, Drawing.new, TweenInfo.new, string.upper, mousemoverel or (Input and Input.MouseMove)

--// Launching checks

if not getgenv().AirHub or getgenv().AirHub.Aimbot then return end

local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)() -- Pepsi's UI Library
local Aimbot, WallHack = getgenv().AirHub.Aimbot, getgenv().AirHub.WallHack
local Parts, Fonts, TracersType = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}, {"UI", "System", "Plex", "Monospace"}, {"Bottom", "Center", "Mouse"}

local autoFarmConnection = nil

-- Функция для нажатия на ClickDetector под игроком
local function clickUnderCharacter()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if not character.PrimaryPart then
        warn("PrimaryPart не установлен у персонажа.")
        return
    end

    -- Получаем позицию под персонажем
    local characterPosition = character.PrimaryPart.Position
    -- Создаем луч (Ray) вниз от персонажа
    local ray = Ray.new(characterPosition, Vector3.new(0, -5, 0)) -- Луч вниз на 5 единиц
    local hit, position = workspace:FindPartOnRay(ray, character) -- Находим часть, на которую указывает луч

    if hit then
        -- Проверяем, есть ли ClickDetector на найденной части
        local clickDetector = hit:FindFirstChild("ClickDetector")
        if clickDetector and clickDetector:IsA("ClickDetector") then
            clickDetector:FireServer() -- Нажимаем на ClickDetector
            print("Нажато на ClickDetector:", hit.Name)
        else
            print("На найденной части нет ClickDetector.")
        end
    else
        print("Ничего не найдено под персонажем.")
    end
end

-- Функция для поиска Hitbox и нажатия на него
local function teleportAndClick()
    local targetPath = game.Workspace:FindFirstChild("__THINGS"):FindFirstChild("Breakables")

    if targetPath then
        for _, folder in ipairs(targetPath:GetChildren()) do
            -- Проверяем, что имя папки является числом
            if tonumber(folder.Name) then
                local baseFolder = folder:FindFirstChild("base")
                local oneFolder = folder:FindFirstChild("1")

                -- Проверяем Hitbox и ClickDetector в base
                if baseFolder then
                    local hitbox = baseFolder:FindFirstChild("Hitbox")
                    if hitbox and hitbox:IsA("BasePart") then
                        -- Телепортация к Hitbox
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()

                        character:SetPrimaryPartCFrame(hitbox.CFrame)
                        wait(0.1) -- Задержка перед нажатием
                        clickUnderCharacter() -- Нажимаем на ClickDetector под игроком

                        -- Ждем, пока Hitbox не будет сломан
                        while hitbox and hitbox.Parent do
                            wait(0.5) -- Проверяем каждые 0.5 секунды
                        end
                        print("Hitbox сломан.")
                    end
                end

                -- Проверяем Hitbox и ClickDetector в папке 1
                if oneFolder then
                    local hitbox = oneFolder:FindFirstChild("Hitbox")
                    if hitbox and hitbox:IsA("BasePart") then
                        -- Телепортация к Hitbox
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()

                        character:SetPrimaryPartCFrame(hitbox.CFrame)
                        wait(0.1) -- Задержка перед нажатием
                        clickUnderCharacter() -- Нажимаем на ClickDetector под игроком

                        -- Ждем, пока Hitbox не будет сломан
                        while hitbox and hitbox.Parent do
                            wait(0.5) -- Проверяем каждые 0.5 секунды
                        end
                        print("Hitbox сломан.")
                    end
                end
            end
        end
    else
        warn("Путь __THINGS.Breakables не найден.")
    end
end
