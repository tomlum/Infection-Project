--Web Class Declaraition
Web = Object:extend()

function Web:new(version)
	self.count = 1
	self.version = User.versions[version] or User.versions[-1]
end