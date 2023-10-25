-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local AutoParry = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local FpsMain = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local FPS = Instance.new("TextLabel")
local ImageLabel = Instance.new("ImageLabel")
local UICorner_5 = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")

--Properties:

ScreenGui.Parent = game.CoreGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.498766959, 0, 0.5, 0)
Frame.Size = UDim2.new(0.610357583, 5, 0.732558131, 0)

UICorner.Parent = Frame

Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.00199209596, 0, 0, 0)
Frame_2.Size = UDim2.new(0, 500, 0, 25)

UICorner_2.Parent = Frame_2

AutoParry.Name = "Auto Parry"
AutoParry.Parent = Frame
AutoParry.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AutoParry.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoParry.BorderSizePixel = 0
AutoParry.Position = UDim2.new(0.444000006, 0, 0.141093478, 0)
AutoParry.Size = UDim2.new(0, 260, 0, 26)
AutoParry.Font = Enum.Font.SourceSans
AutoParry.Text = "AutoParry"
AutoParry.TextColor3 = Color3.fromRGB(0, 0, 0)
AutoParry.TextSize = 14.000

UICorner_3.Parent = AutoParry

FpsMain.Name = "Fps Main"
FpsMain.Parent = Frame
FpsMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FpsMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
FpsMain.BorderSizePixel = 0
FpsMain.Position = UDim2.new(0.444000006, 0, 0.282186955, 0)
FpsMain.Size = UDim2.new(0, 260, 0, 26)
FpsMain.Font = Enum.Font.SourceSans
FpsMain.Text = "Fps Viewer"
FpsMain.TextColor3 = Color3.fromRGB(0, 0, 0)
FpsMain.TextSize = 14.000

UICorner_4.Parent = FpsMain

FPS.Name = "FPS"
FPS.Parent = Frame
FPS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FPS.BackgroundTransparency = 1.000
FPS.BorderColor3 = Color3.fromRGB(0, 0, 0)
FPS.BorderSizePixel = 0
FPS.Position = UDim2.new(-0.310000002, 0, 0.327632189, 0)
FPS.Size = UDim2.new(0, 155, 0, 50)
FPS.Visible = false
FPS.Font = Enum.Font.SourceSansBold
FPS.Text = "FPS:"
FPS.TextColor3 = Color3.fromRGB(0, 0, 0)
FPS.TextSize = 20.000

ImageLabel.Parent = Frame
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.0425499268, 0, 0.139903992, 0)
ImageLabel.Size = UDim2.new(0, 180, 0, 221)
ImageLabel.Image = "rbxassetid://15049905325"

UICorner_5.Parent = ImageLabel

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0214525145, 0, 0.0203026943, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 13)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "Supreme"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextSize = 25.000

-- Scripts:

local function KGBCR_fake_script() -- AutoParry.Script 
	local script = Instance.new('Script', AutoParry)

	
	local function startAutoParry()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local replicatedStorage = game:GetService("ReplicatedStorage")
		local runService = game:GetService("RunService")
		local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
		local ballsFolder = workspace:WaitForChild("Balls")
	
		print("Script successfully ran.")
	
		local function onCharacterAdded(newCharacter)
			character = newCharacter
		end
	
		player.CharacterAdded:Connect(onCharacterAdded)
	
		local focusedBall = nil  
	
		local function chooseNewFocusedBall()
			local balls = ballsFolder:GetChildren()
			focusedBall = nil
			for _, ball in ipairs(balls) do
				if ball:GetAttribute("realBall") == true then
					focusedBall = ball
					break
				end
			end
		end
	
		chooseNewFocusedBall()
	
		local function timeUntilImpact(ballVelocity, distanceToPlayer, playerVelocity)
			local directionToPlayer = (character.HumanoidRootPart.Position - focusedBall.Position).Unit
			local velocityTowardsPlayer = ballVelocity:Dot(directionToPlayer) - playerVelocity:Dot(directionToPlayer)
	
			if velocityTowardsPlayer <= 0 then
				return math.huge
			end
	
			local distanceToBeCovered = distanceToPlayer - 15
			return distanceToBeCovered / velocityTowardsPlayer
		end
	
		local BASE_THRESHOLD = 0.15
		local VELOCITY_SCALING_FACTOR = 0.002
	
		local function getDynamicThreshold(ballVelocityMagnitude)
			local adjustedThreshold = BASE_THRESHOLD - (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR)
			return math.max(0.12, adjustedThreshold)
		end
	
		local function checkBallDistance()
			if not character:FindFirstChild("Highlight") then return end
			local charPos = character.PrimaryPart.Position
			local charVel = character.PrimaryPart.Velocity
	
			if focusedBall and not focusedBall.Parent then
				chooseNewFocusedBall()
			end
	
			if not focusedBall then return end
	
			local ball = focusedBall
			local distanceToPlayer = (ball.Position - charPos).Magnitude
	
			if distanceToPlayer < 5 then
				parryButtonPress:Fire()
				return
			end
	
			local timeToImpact = timeUntilImpact(ball.Velocity, distanceToPlayer, charVel)
			local dynamicThreshold = getDynamicThreshold(ball.Velocity.Magnitude)
	
			if timeToImpact < dynamicThreshold then
				parryButtonPress:Fire()
			end
		end
		heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
			checkBallDistance()
		end)
	end
	
	local function stopAutoParry()
		if heartbeatConnection then
			heartbeatConnection:Disconnect()
			heartbeatConnection = nil
		end
	end
end
coroutine.wrap(KGBCR_fake_script)()
local function PHPAFHJ_fake_script() -- FpsMain.LocalScript 
	local script = Instance.new('LocalScript', FpsMain)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.FPS.Visible = true
	end)
end
coroutine.wrap(PHPAFHJ_fake_script)()
local function SKWU_fake_script() -- FPS.LocalScript 
	local script = Instance.new('LocalScript', FPS)

	while wait() do
		local amount = math.floor(workspace:GetRealPhysicsFPS())
		script.Parent.Text = "FPS:"..amount
	end
end
coroutine.wrap(SKWU_fake_script)()
local function FLAUQ_fake_script() -- Frame.DragScript 
	local script = Instance.new('LocalScript', Frame)

	--Not made by me, check out this video: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
	--Put this inside of your Frame and configure the speed if you would like.
	--Enjoy! Credits go to: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
	
	local UIS = game:GetService('UserInputService')
	local frame = script.Parent
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil
	
	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end
	
	frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
	
end
coroutine.wrap(FLAUQ_fake_script)()
