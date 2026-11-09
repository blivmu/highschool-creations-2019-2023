-- sound effects
-- Blivmu, March 2021

local SoundService = game:GetService("SoundService")
local player = game.Players.LocalPlayer
local character = player.Character

end1 = workspace.end1
end2 = workspace.end2

local function playLocalSound()
	wait(.1)
	if character.Humanoid.MaxHealth == 400 then
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://4916510941"
		sound.Volume = 1
		SoundService:PlayLocalSound(sound)
		sound.Ended:Wait()
		sound:Destroy()
	end
end	


end1.Touched:connect(playLocalSound)
end2.Touched:connect(playLocalSound)

wait()
