--Changes the version of an entire web
--Only guaranteed to work if everyone in the web is already version and webHash synced
function totalInfection(user, versionNumber)
	User.webs[user:getWebHash()].version = User.versions[versionNumber]
end

--Attempts to change an additional 'goal' number of users to a version
--Will always make sure that webs maintain the same version
--Only guaranteed to work if everyone in the web is already version and webHash synced
function limitedInfection(goal, versionNumber)
	--Exclude pre-existing webs of this version
	local applicableWebs = {}
	for webHash,web in pairs(User.webs) do
		if web.version.number ~= versionNumber then
			--Place the webHash and the size of the web into the applicableWebs list
			table.insert(applicableWebs, {hash = webHash, size = web.count})
		end
	end

	--Sort the list based on decreasing
	table.sort(applicableWebs, function(a,b) return a.size > b.size end)

	local tally = 0
	--Find the largest web smaller than the goal
	for i,webData in ipairs(applicableWebs) do 
		if tally + webData.size <= goal then
			tally = tally + webData.size
			--Because webHashes are derived from UNIQUE_HASHes, it is guaranteed
			--to be a UNIQUE_HASH of a node within the web
			totalInfection(userNodes[webData.hash],versionNumber)
		else
			break
		end
	end
end