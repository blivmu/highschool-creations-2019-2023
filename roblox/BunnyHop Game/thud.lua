-- sound effects
-- Blivmu, March 2021

--local sound = Instance.new("Sound", game.Workspace)
--sound.SoundId = "rbxassetid://5814620491"
--local sound = Instance.new("Sound")
local SoundService = game:GetService("SoundService")
local player = game.Players.LocalPlayer
local character = player.Character


--[[if not sound.IsLoaded then
	sound.Loaded:wait()
end]]

Brick1 = workspace.fail1.Part1
Brick2 = workspace.fail1.Part2
Brick3 = workspace.fail2.Part1
Brick4 = workspace.fail2.Part2
Brick5 = workspace.fail3.Part1
Brick6 = workspace.fail3.Part2
Brick7 = workspace.fail3.Part3
Brick8 = workspace.fail4.Part1
Brick9 = workspace.fail4.Part2
Brick10 = workspace.fail4.Part3
Brick11 = workspace.fail5

local function playLocalSound()
	wait(.2)
	if character.Humanoid.MaxHealth == 200 then
		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://5382576606"
		sound.Volume = 0.7
		SoundService:PlayLocalSound(sound)
		sound.Ended:Wait()
		sound:Destroy()
	end
end	


--[[function onTouched(part)
	sound:Play()
end

Brick1.Touched:connect(onTouched)
Brick2.Touched:connect(onTouched)
Brick3.Touched:connect(onTouched)
Brick4.Touched:connect(onTouched)
Brick5.Touched:connect(onTouched)
Brick6.Touched:connect(onTouched)
Brick7.Touched:connect(onTouched)
Brick8.Touched:connect(onTouched)
Brick9.Touched:connect(onTouched)
Brick10.Touched:connect(onTouched)
Brick11.Touched:connect(onTouched)

wait()]]

Brick1.Touched:connect(playLocalSound)
Brick2.Touched:connect(playLocalSound)
Brick3.Touched:connect(playLocalSound)
Brick4.Touched:connect(playLocalSound)
Brick5.Touched:connect(playLocalSound)
Brick6.Touched:connect(playLocalSound)
Brick7.Touched:connect(playLocalSound)
Brick8.Touched:connect(playLocalSound)
Brick9.Touched:connect(playLocalSound)
Brick10.Touched:connect(playLocalSound)
Brick11.Touched:connect(playLocalSound)

wait()
