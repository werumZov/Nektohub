local ESPLib = {}

function ESPLib:CreateESPTag(params)
	local RunService = game:GetService("RunService")
	local player = game.Players.LocalPlayer
	local camera = game:GetService("Workspace").CurrentCamera

	local Text = params.Text
	local Part = params.Part
	local TextSize = params.TextSize
	local TextColor = params.TextColor
	local BoxColor = params.BoxColor
	local TracerColor = params.TracerColor or Color3.new(255, 255, 255)
	local TracerWidth = params.TracerWidth or 3
	local TrailMode = params.TrailMode or false
	local TrailColor = params.TrailColor or {Color3.new(255, 0, 0)} 
	local TrailWidth = params.TrailWidth or {2}

	if #TrailColor < 2 then
		TrailColor[2] = TrailColor[1]
	end

	if #TrailWidth < 2 then
		TrailWidth[2] = TrailWidth[1] -- Duplicate the width if only one is provided
	end

	local esp = Instance.new("BillboardGui")
	esp.Name = "esp"
	esp.Size = UDim2.new(0, 200, 0, 50)
	esp.StudsOffset = Vector3.new(0, Part.Size.Y + 2, 0) -- Adjusted offset for the label above the head
	esp.Adornee = Part
	esp.Parent = Part
	esp.AlwaysOnTop = true

	local esplabelfr = Instance.new("TextLabel")
	esplabelfr.Name = "esplabelfr"
	esplabelfr.Size = UDim2.new(1, 0, 0, 70)
	esplabelfr.BackgroundColor3 = Color3.new(0, 0, 0)
	esplabelfr.TextColor3 = TextColor or Color3.fromRGB(255, 255, 255)
	esplabelfr.BackgroundTransparency = 1
	esplabelfr.TextStrokeTransparency = 0
	esplabelfr.TextStrokeColor3 = Color3.new(0, 0, 0)
	esplabelfr.TextSize = TextSize
	esplabelfr.TextScaled = false
	esplabelfr.Font = "Arcade"
	esplabelfr.Parent = esp

	local box = Instance.new("BoxHandleAdornment")
	box.Name = "box"
	box.Size = Part.Size + Vector3.new(0.5, 0.5, 0.5)
	box.Adornee = Part
	box.AlwaysOnTop = true
	box.Transparency = 0.6
	box.Color3 = BoxColor or Color3.new(0, 0, 255)
	box.ZIndex = 0
	box.Parent = Part

	local tracerLine = Drawing.new("Line")
	tracerLine.Visible = false

	local trail = Instance.new("Trail")
	trail.Texture = "rbxassetid://188166667"
	trail.Attachment0 = Instance.new("Attachment", game.Players.LocalPlayer.Character.Torso)
	trail.Attachment1 = Instance.new("Attachment", Part)
	trail.Enabled = false
	trail.Color = ColorSequence.new(TrailColor[1], TrailColor[2])
	trail.WidthScale = NumberSequence.new(TrailWidth[1], TrailWidth[2])
	trail.Parent = Part
	trail.Lifetime = 0.5

	local function updateesplabelfr()
		if not Part or not Part:IsA("BasePart") or not Part.Parent then
			-- Part no longer exists, delete ESP elements
			esp:Destroy()
			tracerLine:Remove()
			trail:Destroy()
			return
		end

		local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if playerPosition then
			local distance = (playerPosition.Position - Part.Position).Magnitude
			esplabelfr.Text = string.format(Text .. ": %.2f", distance)

			local headPosition = Part.Position + Vector3.new(0, Part.Size.Y / 2, 0)
			local screenPosition, onScreen = camera:WorldToScreenPoint(headPosition)

			if onScreen or playerPosition.Position.Y > Part.Position.Y then
				esp.Adornee = Part
				esp.Enabled = true
				box.Adornee = Part
				box.Visible = true

				-- Update tracer line points
				local tracerStart = camera:WorldToViewportPoint(player.Character.Head.Position)
				local tracerEnd = camera:WorldToViewportPoint(Part.Position)
				tracerLine.From = Vector2.new(tracerStart.X, tracerStart.Y)
				tracerLine.To = Vector2.new(tracerEnd.X, tracerEnd.Y)
				tracerLine.Color = TracerColor
				tracerLine.Thickness = TracerWidth-- Adjust the thickness of the line (increased from 1)
				tracerLine.Visible = not TrailMode

				-- Update trail
				trail.Attachment1 = Part.Attachment
				trail.Lifetime = 0.3
				trail.Enabled = TrailMode
				trail.Color = ColorSequence.new(TrailColor[1], TrailColor[2])
				trail.WidthScale = NumberSequence.new(TrailWidth[1], TrailWidth[2])
			else
				esp.Enabled = false
				box.Visible = false
				tracerLine.Visible = false
				trail.Enabled = false
			end
		else
			esp.Enabled = false
			box.Visible = false
			tracerLine.Visible = false
			trail.Enabled = false
		end
	end

	RunService.RenderStepped:Connect(updateesplabelfr)
end


local function noclip()
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA"Part" then
			v.CanCollide = false0
		end
	end
end



local function FullBright()
	while wait() do
		local Lighting = game:GetService("Lighting")
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end
end


local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "NektoHub", HidePremium = false, SaveConfig = true, ConfigFolder = "MineSim", IntroText = "Nekto Hub v1.24"})


local Tab = Window:MakeTab({Name = "Residence", Icon = "rbxassetid://4483345998", PremiumOnly = false })

local Section = Tab:AddSection({
	Name = "Dildasik"
})


Tab:AddButton({
	Name = "Larry ESP",
	Callback = function()
		ESPLib:CreateESPTag({
			Text = "Mutant",
			Part = game.Workspace:WaitForChild("Mutant").DeathHitbox,
			TextSize = 9,
			TextColor = Color3.new(255,0,0),
			BoxColor = Color3.new(255,0,0),
			TracerColor = Color3.new(255,0,0),
			TracerWidth = 3
		}) 
	end
})

Tab:AddButton({
	Name = "AutoWin (use after night start, dont work)",
	Callback = function()
		noclip()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-78.8145981, 19.2749767, -134.283234, 0.806505084, 0, -0.591227174, 0, 1, 0, 0.591227174, 0, 0.806505084)
	end
})

local Clip = false
_G.Noclip = false

local function NoclipLoop()
	local speaker = game.Players.LocalPlayer
	
	
		if speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
					child.CanCollide = false
			end
		end
	end
end


Tab:AddButton({
	Name = "Fullbright",
	Callback = function()
		FullBright()
	end
})

Tab:AddButton({
	Name = "3rd Person View In-House",
	Callback = function()
		game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
	end
})

Tab:AddToggle({
	Name = "Noclip (jump after disabling)",
	Default = false,
	Callback = function(v)
		_G.Noclip = v
	end
})

spawn(function()
	while wait() do
		if _G.Noclip then
			NoclipLoop()
		end
	end
end)

Tab:AddButton({
	Name = "Unlimited FlashLight battery",
	Callback = function()
		local plr = game.Players.LocalPlayer.Character
		
		plr.Flashlight.Battery.Value = 999999
		plr.Flashlight.Charges.Value = 999999
	end
})


_G.InfStam = false
_G.InfO2 = false
_G.AntiFreeze = false

Tab:AddToggle({
	Name = "Infinite Stam",
	Default = false,
	Callback = function(v)
		_G.InfStam = v
	end
})

Tab:AddToggle({
	Name = "Infinite Oxygen",
	Default = false,
	Callback = function(v)
		_G.InfO2 = v
	end
})

spawn(function()
	while wait() do
		if _G.InfO2 then
			game.Players.LocalPlayer.Character.Breath.Value = 20
		elseif not _G.InfO2 then
			
		end
	end
end)

spawn(function()
	while wait() do
		if _G.InfStam then
			game.Players.LocalPlayer.Character.Sprint.Overdrive.Value = 9999
		elseif not _G.InfStam then
			
		end
	end
end)


local Tab = Window:MakeTab({Name = "Teleports", Icon = "rbxassetid://4483345998", PremiumOnly = false })

local function b(t,c)
	Tab:AddButton({
		Name = t,
		Callback = c
	})
end

local function tp(cframe)
	game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(cframe)
end

b("TP to Bedroom", function()
	tp(CFrame.new(-26.4822197, 25.2999763, -70.1086578, 0.0224343352, -3.52125333e-08, 0.999748349, 1.10617968e-08, 1, 3.49731728e-08, -0.999748349, 1.02744133e-08, 0.0224343352))
end)

b("TP to Bathroom", function()
	tp(CFrame.new(-30.7616272, 25.2665825, -52.872654, -0.88530308, -0.00215160637, -0.46500957, -9.70951419e-07, 0.999989271, -0.00462511973, 0.465014547, -0.00409418205, -0.885293603))
end)

b("TP to Ladder", function()
	tp(CFrame.new(-0.173666388, 9.29997444, -81.3216171, 0.71976018, 4.61229028e-08, -0.694222808, 2.05241513e-08, 1, 8.7717325e-08, 0.694222808, -7.73837669e-08, 0.71976018))
end)

b("TP to Living room", function()
	tp(CFrame.new(-30.4597397, 9.54158783, -48.7385521, -0.716877401, -3.08829655e-08, -0.697199285, 5.5513663e-08, 1, -1.01376258e-07, 0.697199285, -1.11378434e-07, -0.716877401))
end)

b("TP to generator", function()
	tp(CFrame.new(-79.0926361, 6.17452288, -132.726837, 0.999816597, 1.17400432e-05, 0.0191521458, -1.32483137e-07, 0.999999821, -0.000605979934, -0.0191521496, 0.000605866197, 0.999816418))
end)

b("TP to power console", function()
	tp(CFrame.new(-2.41564226, 6.19921589, -92.5593948, -0.98161006, 0.000280018401, -0.190896764, -1.27568831e-06, 0.999998927, 0.00147344405, 0.190896958, 0.00144659204, -0.981608987))
end)

local mn = Window:MakeTab({
	Name = "Monster Gamemode",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local InfBlood = false

mn:AddToggle({
	Name = "Infinite Blood",
	Default = false,
	Callback = function(v)
		InfBlood = v
	end
})

spawn(function()
	game.RunService.RenderStepped:Connect(function()
		if InfBlood then
			task.wait()
			game.Players.LocalPlayer.Character:WaitForChild("Blood").Value = 999998927
		end
	end)
end)

mn:AddButton({
	Name = "Large Hitbox",
	Callback = function()
		for i,v in pairs(game.Players:GetChildren()) do
			if v:IsA("Player") and v.Name ~= game.Players.LocalPlayer.Name then
				v.Character.HumanoidRootPart.Size = Vector3.new(100,100,100)
			end
		end
	end
})

local misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local itemgrab = false

misc:AddToggle({
	Name = "GrabItem Aura",
	Default = false,
	Callback = function(v)
		itemgrab = v
	end
})

spawn(function()
	game.RunService.RenderStepped:Connect(function()
		if itemgrab then
			task.wait(1)
			for i,v in pairs(game.Workspace:GetDescendants()) do
				if v:IsA("Tool") or table.find({"Flashlight", "FlashLight", "Battery"}, v.Name) then
					fireclickdetector(v:FindFirstChild("ClickDetector"))
				end
			end
		end
	end)
end)

local plr = Window:MakeTab({
	Name = "Players",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local players = {}

local playersDropdown = plr:AddDropdown({
	Name = "Players",
	Default = "PlayerName",
	Options = players,
	Callback = function(selectedPlayer)
		targ = selectedPlayer
	end
})

function UpdatePlayersTable()
	players = {}
	for _, player in pairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			table.insert(players, player.Name)
		end
	end

	playersDropdown:Refresh(players, true)
end

spawn(function()
	while wait(0.5) do
		UpdatePlayersTable()
	end
end)

plr:AddButton({
	Name = "TP to Player",
	Callback = function()
		if targ == nil or targ == "" or targ == " " then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Player is nil!",
				Text = "Target not selected",
				Duration = 5
			})
		else
			game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Players[targ].Character.PrimaryPart.CFrame)
		end
	end
})

plr:AddButton({
	Name = "ESP to Player",
	Callback = function()
		if targ == nil or targ == "" or targ == " " then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Player is nil!",
				Text = "Target not selected",
				Duration = 5
			})
		else
			local bi = Instance.new("BillboardGui", game.Players[targ].Character.HumanoidRootPart)
			bi.Name = "ESP"
			bi.StudsOffset = Vector3.new(0, game.Players[targ].Character.HumanoidRootPart.Size.Y + 6, 0)
			bi.Adornee = game.Players[targ].Character.HumanoidRootPart
			bi.AlwaysOnTop = true
			bi.Size = UDim2.new(0, 200, 0, 50)

			local esplabelfr = Instance.new("TextLabel")
			esplabelfr.Name = "esplabelfr"
			esplabelfr.Text = targ
			esplabelfr.Size = UDim2.new(1, 0, 0, 70)
			esplabelfr.BackgroundColor3 = Color3.new(0, 0, 0)
			esplabelfr.TextColor3 = TextColor or Color3.fromRGB(255, 255, 255)
			esplabelfr.BackgroundTransparency = 1
			esplabelfr.TextStrokeTransparency = 0
			esplabelfr.TextStrokeColor3 = Color3.new(0, 0, 0)
			esplabelfr.TextSize = 12
			esplabelfr.TextScaled = false
			esplabelfr.Font = "Arcade"
			esplabelfr.Parent = bi
		end
	end
})

plr:AddButton({
    Name = "Tween to Player",
    Callback = function()
        if targ == nil or targ == "" or targ == " " then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Player is nil!",
                Text = "Target not selected",
                Duration = 5
            })
        else
            local ts = game:GetService("TweenService")
            
            local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
            local targetHumanoidRootPart = game.Players[targ].Character.HumanoidRootPart

            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

            local propertyGoals = {
                CFrame = targetHumanoidRootPart.CFrame
            }

            local tween = ts:Create(humanoidRootPart, tweenInfo, propertyGoals)
            tween:Play()
        end
    end
})

local cbring = false

plr:AddToggle({
	Name = "Client-Bring Player",
	Default = false,
	Callback = function(v)
		cbring = v
		
		if targ == nil or targ == "" or targ == " " then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Player is nil!",
				Text = "Target not selected",
				Duration = 5
			})
		else
			while task.wait(.1) do
				if cbring then
					game.Players[targ].Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
				end
			end
		end
	end
})

plr:AddButton({
	Name = "Increase Player Hitbox",
	Callback = function()
		if targ == nil or targ == "" or targ == " " then
			game.StarterGui:SetCore("SendNotification", {
				Title = "Player is nil!",
				Text = "Target not selected",
				Duration = 5
			})
		else
			while task.wait(.1) do
				game.Players[targ].Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
			end
		end
	end
})

--VISUAL
local RandomTab = Window:MakeTab({
	Name = "Visual",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
RandomTab:AddButton({
	Name = "Press me!",
	Callback = function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "Nothing!",
			Text = "This is button?",
			Duration = 15
		})
  	end    
})
RandomTab:AddButton({
	Name = "Destroy Doors(click it 6 times)",           --Only you see that
	Callback = function()
      		game.Workspace.Doors.Door:Destroy()
  	end    
})
RandomTab:AddButton({
	Name = "Destroy Jeeps(works in lobby)",
	Callback = function()
      		game.Workspace.Jeep:Destroy()
  	end    
})
RandomTab:AddButton({
	Name = "Destroy Upd Board(works in lobby)",
	Callback = function()
      		game.Workspace.UpdateBoard:Destroy()
  	end    
})
RandomTab:AddButton({
	Name = "Destroy Larry",
	Callback = function()
      		game.ReplicatedStorage.Mutant:Destroy()
  	end    
})
--VISUAL!!!


local AboutTab = Window:MakeTab({
	Name = "About",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


AboutTab:AddButton({
	Name = "Telegram",
	Callback = function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "@TwoHubs",
			Text = "This is telegram :D",
			Duration = 7
		})
  	end    
})



