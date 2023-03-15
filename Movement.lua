local mouseLockController = game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule").CameraModule.MouseLockController

local obj = mouseLockController:FindFirstChild("BoundKeys")
local Player = game.Players.LocalPlayer
local Animations = game.ReplicatedStorage.CharacterAnimations.Run
local TrailEvent = game.ReplicatedStorage.RemoteEvents.Trail

local Character = Player.Character or Player.CharacterAdded:Wait()
local LoadedAnim = Character:WaitForChild("Humanoid"):LoadAnimation(script.RunAnimation)


if obj then -- changing shift to lock to control
	obj.Value = "LeftControl"
else
	obj = Instance.new("StringValue")
	obj.Name = "BoundKeys"
	obj.Value = "LeftControl"
	obj.Parent = mouseLockController
end

function Sprint(AN, UIS, IO)
	if UIS == Enum.UserInputState.Begin then -- start sprinting
		Character.Humanoid.WalkSpeed = 35
		LoadedAnim:Play()
	else -- stops sprinting
		Character.Humanoid.WalkSpeed = 16
		LoadedAnim:Stop()
	end
end

Player.CharacterAdded:Connect(function(char)
	Character = char
	LoadedAnim = char:WaitForChild("Humanoid"):LoadAnimation(script.RunAnimation)
end)

game.ContextActionService:BindAction("Sprint", Sprint, true, Enum.KeyCode.LeftShift)
game.ContextActionService:SetPosition("Sprint", UDim2.new(0.65,0,-0.125,0))
game.ContextActionService:SetTitle("Sprint", "Run")
if game.UserInputService.TouchEnabled then -- if touch is enabled (mobile players), make the button bigger so its easier to press.
	button = game.ContextActionService:GetButton("Sprint")
	button.Size = UDim2.new(0.25,0,0.25,0)
end
