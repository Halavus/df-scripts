-- pull_lever_before_autumn.lua
-- Usage: pull_lever_before_autumn <lever_id>

if not dfhack.isMapLoaded() then
    qerror('Load a fort first.')
end

local arg = ...
if not arg then
    qerror('Usage: pull_lever_before_autumn <lever_id>')
end

local lever_id = tonumber(arg)
if not lever_id then
    qerror('lever_id must be a number')
end

local TARGET_TICK = 6 * 28 * 1200 - 3 * 1200  -- 3 days before autumn
local TICKS_PER_YEAR = 12 * 28 * 1200

local scheduled_year

local function queue_pull()
    dfhack.println(
        ('Queueing pull for lever %d for year %d (current year %d, tick %d)')
            :format(lever_id, scheduled_year, df.global.cur_year, df.global.cur_year_tick))
    dfhack.run_command('lever', 'pull', tostring(lever_id))
end

local function schedule_yearly()
    dfhack.timeout(TICKS_PER_YEAR, 'ticks', function()
        scheduled_year = scheduled_year + 1
        queue_pull()
        schedule_yearly()
    end)
end

local now_year = dfhack.world.ReadCurrentYear()
local now_tick = dfhack.world.ReadCurrentTick()

local first_delay
if now_tick < TARGET_TICK then
    first_delay = TARGET_TICK - now_tick
    scheduled_year = now_year
else
    first_delay = TICKS_PER_YEAR - now_tick + TARGET_TICK
    scheduled_year = now_year + 1
end

dfhack.println(
    ('First pull for lever %d scheduled for year %d at tick %d (in %d ticks)')
        :format(lever_id, scheduled_year, TARGET_TICK, first_delay))

dfhack.timeout(first_delay, 'ticks', function()
    queue_pull()
    schedule_yearly()
end)
