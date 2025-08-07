        local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
        local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()    
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        Notification:Notify(
        {Title = "XK Hub定制", Description = "按照客户的想法制作的功能"},
        {OutlineColor = Color3.fromRGB(255, 0, 0),Time = 15, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 0, 0)})
        local sound = Instance.new("Sound", game:GetService("SoundService"))
        sound.SoundId = "rbxassetid://4590662766"
        sound.Volume = 10
        sound:Play()
        sound.Ended:Connect(sound.Destroy)
        local StartPosition = CFrame.new(-34567.375, 34.895652770996094, -32846.046875)
        local EndPosition = CFrame.new(-31448.3515625, 34.925010681152344, -26616.25)
        local HeightOffset = Vector3.new(0, -5, 0)
        function GetCurrentVehicle()
        if not LocalPlayer.Character then return nil end
        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
        if not humanoid then return nil end
        if not humanoid.SeatPart then return nil end
        return humanoid.SeatPart.Parent
        end
        local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/renlua/UI-lib/refs/heads/main/Ware_UI"))()--用的123fa98的UI库
        local window = library:new("驾驶帝国丨定制")
        local XK = window:Tab("主要",'6035145364'):section("主要",true)
        XK:Toggle("自动刷钱", "AutoFarmToggle", false, function(Value)
            if Value then
                coroutine.resume(AutoFarmFunc)
            end
        end)
        function Teleport(cframe)
        local vehicle = GetCurrentVehicle()
        if vehicle then
        vehicle:SetPrimaryPartCFrame(cframe)
        end
        end
        function VelocityTeleport(cframe)
        local vehicle = GetCurrentVehicle()
        if not vehicle then return end    
        local speed = 600
        local primaryPart = vehicle.PrimaryPart        
        local gyro = Instance.new("BodyGyro")
        gyro.P = 5000
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.CFrame = primaryPart.CFrame
        gyro.Parent = primaryPart    
        local velocity = Instance.new("BodyVelocity")
        velocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        velocity.Velocity = (cframe.p - primaryPart.Position).Unit * speed
        velocity.Parent = primaryPart    
        local distance = (primaryPart.Position - cframe.p).Magnitude
        task.wait(distance / speed)    
        velocity:Destroy()
        gyro:Destroy()
        end
        local AutoFarmFunc = coroutine.create(function()
            while true do
                local vehicle = GetCurrentVehicle()
                if vehicle then
                    Teleport(StartPosition + HeightOffset)
                    VelocityTeleport(EndPosition + HeightOffset)
                    Teleport(EndPosition + HeightOffset)
                    VelocityTeleport(StartPosition + HeightOffset)
                else
                    Notification:Notify(
                {Title = "XK Hub警告", Description = "请上车，否则无法进行"},
                {OutlineColor = Color3.fromRGB(255, 0, 0),Time = 15, Type = "image"},
                {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 0, 0)})
                local sound = Instance.new("Sound", game:GetService("SoundService"))
                sound.SoundId = "rbxassetid://4590662766"
                sound.Volume = 10
                sound:Play()
                sound.Ended:Connect(sound.Destroy)
                    task.wait(5)
                end
                task.wait()
            end
        end)