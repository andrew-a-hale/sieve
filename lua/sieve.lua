local function sieve_run(n)
	local limit = n / 2
	local arr = {}
	for i = 0, limit - 1 do
		arr[i] = false
	end

	local q = math.floor(math.sqrt(limit / 2)) + 1
	local factor = 1

	while factor < q do
		for i = factor, q do
			if not arr[i] then
				factor = i
				break
			end
		end

		local start = 2 * factor * (factor + 1)
		local step = 2 * factor + 1
		for i = start, limit, step do
			arr[i] = true
		end

		factor = factor + 1
	end

	local sum = 0
	for i = 0, #arr do
		if not arr[i] then
			sum = sum + 1
		end
	end

	return sum
end

local n = tonumber(string.gsub(arg[1], "_", ""), 10)
local start = os.clock()
local count = sieve_run(n)

local duration = math.floor((os.clock() - start) * 1000)
print(string.format("Lua           -- Duration: %dms -- Count: %d\n", duration, count))
