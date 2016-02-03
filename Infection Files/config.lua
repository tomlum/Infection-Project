--Set shorter namespaces
lg = love.graphics
lm = love.mouse
lk = love.keyboard

--Set Window Size
love.window.setMode(1080,900, {resizable = true})

--Set the application Icon
icon = love.image.newImageData("icon.png")
love.window.setIcon(icon)

--Set Random Seed
math.randomseed(os.clock())

--Border Buffer
borderBuffer = 100

--Student Ratio
studentRatio = .3

--Number of Nodes
numberOfNodes = 30