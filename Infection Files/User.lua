--User Class Declaraition
User = Object:extend()

--Static Table holding versions for Users
User.versions = {}
User.versions[-1] = {name = "No Version", color = {255,0,0}, number = -1}
User.versions[0] = {name = "Release", color = {200,200,200}, number = 0}
User.versions[1] = {name = "1.0", color = {0,255,0}, number = 1}
User.versions[2] = {name = "2.0", color = {50,50,255}, number = 2}
User.versions[3] = {name = "3.0", color = {200,100,255}, number = 3}
User.versions[4] = {name = "4.0", color = {0,100,20}, number = 4}
User.versions[5] = {name = "5.0", color = {120,50,255}, number = 5}
User.versions[6] = {name = "6.0", color = {255,255,0}, number = 6}
User.versions[7] = {name = "7.0", color = {255,0,255}, number = 7}
User.versions[8] = {name = "8.0", color = {120,50,50}, number = 8}
User.versions[9] = {name = "9.0", color = {255,100,0}, number = 9}

--Static Table holding all webs
User.webs = {}

--User Constructor
function User:new(students, coaches, name, versionNumber, UNIQUE_HASH)
	self.students = students or {}
	self.coaches = coaches or {}
	--Unused, just an example parameter
	self.name = name or "No Name"
	--A User's unique hash identity, should never change
	self.UNIQUE_HASH = UNIQUE_HASH
	self.webHash = self.UNIQUE_HASH
	--Initialize a new WebHash in User.webs
	User.webs[self.webHash] = Web(versionNumber)
end

--Return the webHash value
function User:getWebHash()
	return self.webHash
end

--Propogates the user's WebHash to 
function User:propogateWebHash()

	--Propogate to all Students
	for k,student in pairs(self.students) do 
		if student.webHash ~= self.webHash then 
			User.webs[student.webHash] = nil
			student.webHash = self.webHash
			--Increment the webHash count
			User.webs[student.webHash].count = User.webs[student.webHash].count + 1
			--Recursive Call
			student:propogateWebHash()
		end
	end

	--Propogate to all Coaches
	for k,coach in pairs(self.coaches) do 
		if coach.webHash ~= self.webHash then 
			User.webs[coach.webHash] = nil
			coach.webHash = self.webHash
			--Increment the webHash count
			User.webs[coach.webHash].count = User.webs[coach.webHash].count + 1
			--Recursive Call
			coach:propogateWebHash()
		end
	end
end

function User:addStudent(student)
	if student.webHash ~= self.webHash then
		self.students[student.UNIQUE_HASH] = student
		self:propogateWebHash()
		student.coaches[self.UNIQUE_HASH] = self
	end
end

--Not Yet Implemented, but should work in theory
--
-- function User:detachStudent(student)
-- 	if student.webHash == self.webHash then
-- 		student.webHash = student.UNIQUE_HASH
-- 		student:propogateWebHash(self.webHash)
-- 		table.remove(self.students, student)
-- 		table.insert(student.coaches, self)
-- 		self:propogateWebHash(student.webHash)
-- 	end
-- end

-- function User:delete()
-- 	local deleteHash = self.webHash
-- 	local versionNumber = User.webs[deleteHash].version.number
-- 	for k,student in pairs(self.students) do 
-- 		if student.webHash == deleteHash then
-- 			student.webHash = student.UNIQUE_HASH
-- 			User.webs[student.webHash] = Web(versionNumber)
-- 			student:propogateWebHash()
-- 		end
-- 	end
-- 	User.webs[deleteHash] = nil
-- 	self = nil
-- end

