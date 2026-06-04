#!/usr/bin/env lua

local start = os.time({
    year = 2026,
    month = 1,
    day = 1,
    hour = 0,
    min = 0,
    sec = 0,
    isdst = false
})

local now = os.time()

local hours = math.floor((now - start) / 3600)
local frame = hours + 1

print(frame)