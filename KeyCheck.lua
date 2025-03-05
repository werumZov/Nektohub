 --Key system)
 local Player = game.Players.LocalPlayer
 local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
 local target = loadstring(game:HttpGet("https://raw.githubusercontent.com/werumZov/Nektohub/refs/heads/zovchik/NektoHub.lua"))()   


-- Main
 
 



 local Window = OrionLib:MakeWindow({Name = "KeySystem", HidePremium = false, SaveConfig = true, ConfigFolder = "OKeyTEst", IntroText = "Welcome!"})

 OrionLib:MakeNotification({
	Name = "Logged!",
	Content = "Succfully logged in as "..Player.Name.." . ",
	Image = "rbxassetid://4483345998",
	Time = 5
})


function NektoHub()
repeat task.wait() until game:IsLoaded()
local TablePlace = {14437001043}
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Loading...", -- Required
        Text = "Wait...", -- Required
        Icon = "rbxassetid://9709149431", -- Optional
        Duration = 15
    })

    if table.find(TablePlace,game.PlaceId) then
        getgenv().Game = "RM"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/werumZov/Nektohub/refs/heads/zovchik/NektoHub.lua"))()   
 
    
    else
        game.Players.LocalPlayer:Kick("not Support")
    end
end

function CorrectKeyNotif()
    OrionLib:MakeNotification({
        Name = "Valid Key!",
        Content = "Valid Key detecded!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end
function InCorrectKeyNotif()
    OrionLib:MakeNotification({
        Name = "Invalid Key!",
        Content = "Invalid Key detecded!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end


_G.Key = "NektoHub"
_G.KeyInput = 'string'


 local CheckKeyTab = Window:MakeTab({
	Name = "Check Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

CheckKeyTab:AddTextbox({
	Name = "Enter Key",
	Default = "Enter Key",
	TextDisappear = true,
	Callback = function(Value)
		_G.KeyInput = Value
        
	end	  
})

CheckKeyTab:AddButton({
	Name = "Check Key",
	Callback = function()
      		if _G.KeyInput == _G.Key then 
                NektoHub()
                CorrectKeyNotif()
                else
                    InCorrectKeyNotif()
            end
                
  	end    
})
