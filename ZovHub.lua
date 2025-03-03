local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
--Zov Hub Test :D




local Window = OrionLib:MakeWindow({Name = "Zov Hub(t0.3)", HidePremium = false, SaveConfig = true, ConfigFolder = "ZovTest", IntroText = "Zov Hub"})

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
      		game.StarterGui:SetCore("SendNotification", {
			Title = "Nothing!",
			Text = "This is button?",
			Duration = 15
		})
  	end    
})

AboutTab:AddButton({
	Name = "Telegram",
	Callback = function()
		game.StarterGui:SetCore("SendNotification", {
			Title = "@TwoHubs",
			Text = "This is telegram :D",
			Duration = 15
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
