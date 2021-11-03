-- -- -- -- -- -- -- -- -- -- -- -- --
--TOGFox common functions module 
--v0.01
--v0.02 Added tf_SecondsToClockFormat function
--v0.03 Added tf_GetArraySize
--		Refactored tf_SecondsToClockFormat to include a new optional parameter
--v0.04 Added the DIV function
--v0.05 Added LocalToWorld and WorldToLocal functions
--v0.06 Added some GPS waypoint stuff
--v2.0 Breaking change - renamed functions for consistency

-- -- -- -- -- -- -- -- -- -- -- -- --
module(..., package.seeall);

function tf_DIV(a,b)
    return (a - a % b) / b
end

function tf_AddNMToLatLong(fltLat1, fltLong1, fltDistanceNM, fltBearing)
	--Input: Lat1/Long1 is the co-ordinate starting point
	--		 Distance is the NM that needs to be added to the lat/long
	--		 Bearing is the compass bearing (direction) to move towards
	--Output: an array containing the new lat/long

	if fltLat1 > 0 then
		--northern hemisphere - nothing to do
	else
		--southern hemisphere - flip the bearing
		fltBearing = 360 - fltBearing
		if fltBearing > 359 then 
			fltBearing = fltBearing - 360
		end
		if fltBearing < 0 then
			fltBearing = 360 + fltBearing
		end
	end
	
	local fltRadians = 6378.14
	
	--convert nm to kilometers
	local fltDistanceKM = fltDistanceNM * 1.852	-- convert to km	

	local fltLat2 = math.deg((fltDistanceKM/fltRadians) * math.cos(math.rad(fltBearing))) + fltLat1
	local fltLong2 = math.deg((fltDistanceKM/(fltRadians*math.sin(math.rad(fltLat2)))) * math.sin(math.rad(fltBearing))) + fltLong1
	
	local arrLatLong = {}
	arrLatLong["Lat"] = fltLat2
	arrLatLong["Long"] = fltLong2
	return arrLatLong
end

function tf_GetDistanceToICAO(strICAO)
	--get distance from current position to the specified ICAO
	--Input: airport ICAO
	--Output: distance in nm
	
	local navtype, destinationlat, destionationlon, _, _, _, _, name = XPLMGetNavAidInfo(XPLMFindNavAid(nil, strICAO, LATITUDE, LONGITUDE, nil, xplm_Nav_Airport))

	return tf_distanceInNM(LATITUDE, LONGITUDE, destinationlat, destionationlon)

end

function tfpp_GetClosestAirport()
    -- get airport info
	-- sets global variable tfpp_strCurrentAirport
	local navref
    navref = XPLMFindNavAid( nil, nil, LATITUDE, LONGITUDE, nil, xplm_Nav_Airport)
	
    -- all output we are not intereted in can be send to variable _ (a dummy variable)
	_, _, _, _, _, _, tfpp_strCurrentAirport, _ = XPLMGetNavAidInfo(navref)
	
	--print("Closest airport = " .. tfpp_strCurrentAirport)

end

function tf_GetClosestAirportInformation(fltLat,fltLong) --, AirportArray)
    -- get airport info
	-- sets global variable strClosestAirport
	local AirportArray = {}
	local navref
	local strClosestAirport
	
	--print(fltLat)
	--print(fltLong)
	
    navref = XPLMFindNavAid( nil, nil, fltLat, fltLong, nil, xplm_Nav_Airport)

    -- all output we are not intereted in can be send to variable _ (a dummy variable)
	aa, bb, cc, dd, ee, ff, gg, hh = XPLMGetNavAidInfo(navref)

	AirportArray["Lat"] = bb
	AirportArray["Long"] = cc
	AirportArray["Height"] = dd -- metres above mean sea level
	AirportArray["Frequency"] = ee
	AirportArray["Heading"] = ff
	AirportArray["ICAO"] = gg
	AirportArray["Name"] = hh

	return AirportArray
	
end

function tf_GetSpecificAirportInformation(strICAO)
	local AirportArray = {}
	local navref

	navref = XPLMFindNavAid(nil, strICAO, nil, nil, nil, xplm_Nav_Airport)
	
	aa, bb, cc, dd, ee, ff, gg, hh = XPLMGetNavAidInfo(navref)
	
	AirportArray["Lat"] = bb
	AirportArray["Long"] = cc
	AirportArray["Height"] = dd -- metres above mean sea level
	AirportArray["Frequency"] = ee
	AirportArray["Heading"] = ff
	AirportArray["ICAO"] = gg
	AirportArray["Name"] = hh

	return AirportArray	
	

end

function tf_round(num, idp)
	--Input: number to round; decimal places required
	return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end	

function tf_deg2rad(deg)
    return deg * (math.pi/180)
end

function tf_distanceInNM(lat1, lon1, lat2, lon2)
    local R = 6371 -- Radius of the earth in km
    local dLat = tf_deg2rad(lat2-lat1)
    local dLon = tf_deg2rad(lon2-lon1);
    local a = math.sin(dLat/2) * math.sin(dLat/2) +
        math.cos(tf_deg2rad(lat1)) * math.cos(tf_deg2rad(lat2)) * 
        math.sin(dLon/2) * math.sin(dLon/2)
    local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
    local d = R * c * 0.539956803 -- distance in nm
    return d
end

function tf_GetArraySize(MyArray)
	--Input: an array/table with key/value pairs
	--Output: an integer value.
    local count = 0
    for _, __ in pairs(MyArray) do
        count = count + 1
    end
    return count
end

function tf_SecondsToClockFormat(intSeconds, bolJustShowDays)
	--Input: seconds as an integer, usually as a result of some clock/time operation
	--		 bolJustShowDays is a 0/1 setting that lets you hide hours and minutes
	--Note: v0.03 introduced the bolJustShowDays parameter. For backwards compatibility, it will default to 0 meaning days do not show by default
	local intSeconds = tonumber(intSeconds)
	local strTemp = ""
	
	-- print(intSeconds)
	
	if intSeconds <= 0 then
		return "00:00:00";
	else
		local days = string.format("%02.f", math.floor(intSeconds/86400))
		local hours = string.format("%02.f", math.floor(intSeconds/3600))
		local mins = string.format("%02.f", math.floor(intSeconds/60 - (hours*60)))
		local secs = string.format("%02.f", math.floor(intSeconds - hours*3600 - mins *60))
		
		--print(bolJustShowDays)
		--print(days .. hours .. mins .. secs)
		
		strTemp = days
		if bolJustShowDays == 0 then
			strTemp = strTemp .. ":" .. hours ..":" .. mins .. ":" .. secs
		end
		return strTemp
	end

end

function tf_LocalToLatLongAlt(MyArray)
	--Input: MyArray has 3 input values, x,y,z and 3 output values - lat, long and altitude
	--	   : The array indexes are 1,2,3,4,5,6
	--Output: MyArray where indexes 4,5,6 reflect lat, long and altitude
	
	local navref
	
	print("MyArray[1]=" .. MyArray[1])
	print("MyArray[1]=" .. MyArray[2])
	print("MyArray[1]=" .. MyArray[3])
	print("MyArray[1]=" .. MyArray[4])
	print("MyArray[1]=" .. MyArray[5])
	print("MyArray[1]=" .. MyArray[6])
	
	local valuefour
	local valuefive
	local valuesix
	
	someresult = XPLMLocalToWorld(a, b, c, d, e, f)
end

function tf_DetermineCurrentGlideSlopeZone(degAToA)	
	-- Input: Angle to airport in degrees
	-- Zone 1 = below glideslope
	-- Zone 2 = just below glideslope
	-- Zone 3 = on glideslope
	-- Zone 4 = just above gs
	-- Zone 5 = above gs
	
	--print("A to A: " .. degAToA)
	
	local Zone2Limits = 2.8	-- lower limit
	local Zone3Limits = 3.00 -- lower limit
	local Zone4Lmits = 3.4	-- lower limit
	local Zone5Limits = 3.6 -- lower limit
	-- Zone 1 limit is the ground!
	
	if degAToA < Zone2Limits then
		--print("Zone = 1")
		return 1
	end
	if degAToA < Zone3Limits then
		return 2
	end
	if degAToA < Zone4Lmits then
		return 3
	end
	if degAToA < Zone5Limits then
		return 4
	end
	-- else
	return 5
end











