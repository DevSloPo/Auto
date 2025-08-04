        local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
        local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()    
        local autoTugOfWarThread = nil
        Notification:Notify(
        {Title = "XK Hub定制", Description = "按照客户的想法制作的功能"},
        {OutlineColor = Color3.fromRGB(255, 0, 0),Time = 15, Type = "image"},
        {Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 0, 0)})
        local sound = Instance.new("Sound", game:GetService("SoundService"))
        sound.SoundId = "rbxassetid://4590662766"
        sound.Volume = 10
        sound:Play()
        sound.Ended:Connect(sound.Destroy)
        local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/renlua/UI-lib/refs/heads/main/Ware_UI"))()--用的123fa98的UI库
        local window = library:new("最大速度丨定制")
        local XK = window:Tab("主要",'6035145364'):section("主要",true)
        local runningLoops = {}
XK:Toggle("自动点击速度", "AutoFarmToggle", false, function(enabled)
        if enabled then
            autoTugOfWarThread = task.spawn(function()
                local vim = game:GetService("VirtualInputManager")
                while true do
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then                   
                        pcall(function()
                            game:GetService("ReplicatedStorage").Remotes.TemporaryReachedBindable:FireServer({
                                PerfectQTE = true
                            })
                        end)                       
                        local viewportSize = workspace.CurrentCamera.ViewportSize
                        local centerX, centerY = viewportSize.X / 2, viewportSize.Y / 2
                        pcall(function()
                            vim:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
                            task.wait(0.05)
                            vim:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0) 
                        end)
                    end
                    task.wait(0)
                end
            end)
        else
            if autoTugOfWarThread then
                task.cancel(autoTugOfWarThread)
                autoTugOfWarThread = nil
            end
        end
    end)
XK:Textbox("奖杯数量丨这是排行榜的", "", "输入", function(Value)
    local player = game:GetService("Players")["hanxiyue521"]
    local trophiesStat = player.leaderstats.Trophies    
    if runningLoops["trophies"] then
        runningLoops["trophies"] = false
    end   
    runningLoops["trophies"] = true
    spawn(function()
        while runningLoops["trophies"] do
            trophiesStat.Value = Value
            wait(0.5)
        end
    end)
end)
XK:Textbox("奖杯数量丨这是商店上面那个", "", "输入", function(Value)
    local player = game:GetService("Players")["hanxiyue521"]
    local currencyText = player.PlayerGui.MainUI.UI.RightMenu.currency.Text    
    if runningLoops["currency"] then
        runningLoops["currency"] = false
    end    
    runningLoops["currency"] = true
    spawn(function()
        while runningLoops["currency"] do
            currencyText.Text = Value
            wait(0.5)
        end
    end)
end)
XK:Toggle("开启速度", "ViewSpeedToggle", false, function(v)
    if v == true then
        sudu = game:GetService("RunService").Heartbeat:Connect(function()
            if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid and game:GetService("Players").LocalPlayer.Character.Humanoid.Parent then
                if game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
                    game:GetService("Players").LocalPlayer.Character:TranslateBy(game:GetService("Players").LocalPlayer.Character.Humanoid.MoveDirection * Speed / 20)
                end
            end
        end)
    elseif not v and sudu then
        sudu:Disconnect()
        sudu = nil
    end
end)
XK:Slider("速度", "", 16, 0, 999999999999, false, function(v)
    Speed = v
end)