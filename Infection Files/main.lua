--This representation of users and webs benefits version changes, adding new students, and the limitedInfection Algorithm
--Not great for merging webs or decoupling from webs and deleting nodes, also not great on space, but not terrible

--Things to Implement:
--Node deletion and decoupling
--Manual node connection
--Have limitedInfection elaborate on its results (e.g. infected x nodes, next largest web is y)

require "utilities/config"
require "utilities/utilities"
--Object Oriented Library
Object = require "utilities/classic"
--Objects
require "Web"
require "User"
require "UserNode"
--Infection Functions
require "infection"
--Input Functions
require "input"

function love.load()
	userNodes = createNodes()
end

function love.keypressed(key)
	checkKeyboardInput(key, userNodes)
end

function love.update()
	mouseInput()
	UserNode.animateNodes(userNodes)
end

function love.draw()

	--Draw Nodes
	UserNode.drawNodes(userNodes)

	--Draw instructions
	lg.setNewFont(30)
	lg.printf({
		{255,255,255}, "Press 0-9 to Select a Version  |||Selected Version: ",
		User.versions[selectedVersion].color,User.versions[selectedVersion].name,
		{255,255,255}, "|||\nClick a Node to Change Web its version to the Selected Version.\nOr Press Enter to enter a specific number of nodes to change"},
	10, 10, lg.getWidth())
	lg.printf("Press S to scramble the webs\nPress R to generate new webs\nPress Escape to quit",
		10, lg.getHeight()-120, 2000)

	--Draw instructions for specific infection mode
	if limitedInfectionMode then
		lg.setColor(255,255,255)
		lg.rectangle("line", 5, lg.getHeight()/3-5, lg.getWidth()-10, 130+10)
		lg.setColor(255 - User.versions[selectedVersion].color[1],
			255-User.versions[selectedVersion].color[2],
			255-User.versions[selectedVersion].color[3])
		lg.rectangle("fill", 10, lg.getHeight()/3, lg.getWidth()-20, 130)
		lg.setNewFont(70)
		lg.setColor(255,255,255)
		lg.printf({
			User.versions[selectedVersion].color,specificInfectionNumber},
			0, lg.getHeight()/3, lg.getWidth(), "center")
		lg.setNewFont(30)
		lg.setColor(255,255,255)
		lg.printf({
			User.versions[selectedVersion].color,"Hit Enter When Ready or Escape to cancel"},
			0, lg.getHeight()/3+70, lg.getWidth(), "center")
		lg.setNewFont(30)
	end
end