--UserNode Class Declaraition (Note, node and UserNode are used interchangeably)
UserNode = User:extend()

--Static Node Diameter
UserNode.diam = 20
--Static Animation/Oscillation values
UserNode.oscillationTimer = 1
UserNode.OSCILLATION_INTERVAL = 30

--User Node Constructor
function UserNode:new(students, coaches, name, version, UNIQUE_HASH)
	UserNode.super.new(self, students, coaches, name, version, UNIQUE_HASH)
	self.x = lg.getWidth()/2
	self.y = lg.getHeight()/2
	self:scramble()
end

--Static: Animates the nodes in a table of UserNodes
function UserNode.animateNodes(nodeTable)
	UserNode.oscillationTimer = (UserNode.oscillationTimer+1)%UserNode.OSCILLATION_INTERVAL
	for k,node in pairs(nodeTable) do 
		node:updateAnimation()
	end
end

--Static: Re-Scrambles the positions of nodes in a table of UserNodes
--Also resets the oscillation timer
function UserNode.scrambleNodes(nodeTable)
	UserNode.oscillationTimer = 1
	for k,node in pairs(nodeTable) do 
		node:scramble()
	end
end

--Static: Draws a table of UserNodes
function UserNode.drawNodes(nodeTable)
	for k,node in pairs(nodeTable) do
		node:draw()
	end
end

--Scramble a UserNode's position
--Places in center and gives it a random launching velocity
function UserNode:scramble()
	self.x = lg.getWidth()/2
	self.y = lg.getHeight()/2
	--Initial Launch Velocities
	--(xv = horizontal velocity, yv = vertical velocity)
	self.xv = randFloat(lg.getWidth()+ UserNode.diam/2 - borderBuffer)/
	UserNode.OSCILLATION_INTERVAL/2
	self.yv = randFloat(lg.getHeight()+ UserNode.diam/2 - borderBuffer)/
	UserNode.OSCILLATION_INTERVAL/2
end

--Draws a node and the arrows to its children according to its version color
function UserNode:draw()
	for h,student in pairs(self.students) do
		if student.webHash == self.webHash then
			self:setColor()
			--If webHashes don't match, draw a red arrow
		else
			lg.setColor(255,0,0)
		end
		lg.arrow(self.x, self.y, student.x, student.y)
	end
	self:setColor()
	lg.circle("fill", self.x, self.y, UserNode.diam/2)
	lg.setColor(255,255,255)
	lg.circle("line", self.x, self.y, UserNode.diam/2+3)
end

--Updates a node's animation
function UserNode:updateAnimation()
	if UserNode.oscillationTimer == 0 then
		self.xv = math.random(-1,1)/10
		self.yv = math.random(-1,1)/10
	end
	self.x = self.x + self.xv
	self.y = self.y + self.yv
end

--Set color according to a node's web's version
function UserNode:setColor()
	lg.setColor(User.webs[self:getWebHash()].version.color[1],
		User.webs[self:getWebHash()].version.color[2],
		User.webs[self:getWebHash()].version.color[3])
end

--Detects if user has clicked on a node and changes the corresponding web
function UserNode:handleClick(x, y, versionNumber, buttonNum)
	if pointDis(x, y,self.x,self.y) < UserNode.diam then

		if buttonNum == 1 then
			totalInfection(self, versionNumber)
		elseif buttonNum == 2 then
			--self:delete()
		end
		return true
	else
		return false
	end
end

-- function UserNode:delete(nodeTable)
-- 	nodeTable[self.UNIQUE_HASH] = nil
-- 	self = nil
-- end