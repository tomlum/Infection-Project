--Draws an arrow
function lg.arrow(x1, y1, x2, y2) 
	local slope = (y1-y2)/(x1-x2)
	local angle = math.atan(slope)
	local perpAngle = math.atan(-1/slope)	
	local direction = (y1-y2)/math.abs((y1-y2))
	lg.polygon("fill",
		x2-(UserNode.diam/2*math.cos(perpAngle)*direction),
		y2-(UserNode.diam/2*math.sin(perpAngle)*direction),
		x1-(UserNode.diam/2*math.cos(perpAngle)*direction),
		y1-(UserNode.diam/2*math.sin(perpAngle)*direction),
		x1-(UserNode.diam/7*math.cos(perpAngle)*direction),
		y1-(UserNode.diam/7*math.sin(perpAngle)*direction)
		)
end

--Returns a list of randomly associated UserNodes and refreshes User static fields
function createNodes()
	User.webs = {}
	UserNode.oscillationTimer = 1
	--List of Users
	local nodeList = {}
	--User hash list only used for random student assignment
	local userHashes = {}

	--Create Users
	for i=1, numberOfNodes do
		local UNIQUE_HASH = generateHash()
		nodeList[UNIQUE_HASH] = UserNode({}, {}, "name", 1, UNIQUE_HASH)
		table.insert(userHashes, UNIQUE_HASH)
	end

	--Randomly Assign Students
	for k,node in pairs(nodeList) do
		while math.random() < studentRatio do 
				randomNodeHash = userHashes[math.random(1,#userHashes)]
				node:addStudent(nodeList[randomNodeHash])
		end
	end

	return nodeList
end

--Return distance between two points
function pointDis(x1, y1, x2, y2)
	return math.sqrt((y1-y2)^2 + (x1-x2)^2)
end

function randFloat(low, up)
	return math.random(low,up)*math.random()
end

function randFloat(up)
	return math.random(-up,up)*math.random()
end

function generateHash()
	return tostring(math.random())
end