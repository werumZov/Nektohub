local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
--Zov Hub Test :D




local Window = OrionLib:MakeWindow({Name = "Zov Hub(v0.2)", HidePremium = false, SaveConfig = true, ConfigFolder = "ZovTest", IntroText = "Zov Hub"})

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local AboutTab = Window:MakeTab({
	Name = "About",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


local RandomTab = Window:MakeTab({
	Name = "Random",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
RandomTab:AddButton({
	Name = "Press me!",
	Callback = function()
      		print("button pressed")
  	end    
})

AboutTab:AddButton({
	Name = "Telegram",
	Callback = function()
      		OrionLib:MakeNotification({
	Name = "Telegram",
	Content = "t.me/TwoHubss",
	Image = "rbxassetid://4483345998",
	Time = 5
})

  	end    
})





local Section = PlayerTab:AddSection({
	Name = "Movement"
})

PlayerTab:AddSlider({
	Name = "WalkSpeed",
	Min = 0,
	Max = 20,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "WS",
	Callback = function(Value)
		game.Player.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})
