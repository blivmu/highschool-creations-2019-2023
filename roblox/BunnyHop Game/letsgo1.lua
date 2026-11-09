-- sound effects
-- Blivmu, March 2021

local SoundService = game:GetService("SoundService")
local player = game.Players.LocalPlayer
local character = player.Character

checkpoint1 = workspace.checkpoint1
checkpoint2 = workspace.checkpoint2
checkpoint3 = workspace.checkpoint3

local function playLocalSound()
	wait(.1)
	if character.Humanoid.MaxHealth == 300 then
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://6559380085"
		sound.Volume = 1
		SoundService:PlayLocalSound(sound)
		sound.Ended:Wait()
		sound:Destroy()
	end
end	


checkpoint1.Touched:connect(playLocalSound)
checkpoint2.Touched:connect(playLocalSound)
checkpoint3.Touched:connect(playLocalSound)

wait()
