local opts = {
    enabled = false,
    firstload = true,

    name = "avectorscope",
    -- off
    -- showcqt
    -- avectorscope
    -- showspectrum
    -- showcqtbar
    -- showwaves

    quality = "custom",
    -- verylow
    -- low
    -- medium
    -- high
    -- veryhigh

    height = 9,
    -- [4 .. 12]
}

-- key bindings
-- cycle visualizer
local cycle_key = "a"

if not (mp.get_property("options/lavfi-complex", "") == "") then
    return
end

local visualizer_name_list = {
    -- "off",
    -- "showcqt",
    "avectorscope",
    -- "showspectrum",
    -- "showcqtbar",
    -- "showwaves",
}

local options = require 'mp.options'
local msg     = require 'mp.msg'

options.read_options(opts)
opts.height = math.min(12, math.max(4, opts.height))
opts.height = math.floor(opts.height)

local function get_visualizer(name, quality, vtrack, albumart)
    local w, h, fps

    if quality == "verylow" then
        w = 640
        fps = 30
    elseif quality == "low" then
        w = 960
        fps = 30
    elseif quality == "medium" then
        w = 1280
        fps = 60
    elseif quality == "high" then
        w = 1920
        fps = 60
    elseif quality == "veryhigh" then
        w = 2560
        fps = 60
    elseif quality == "custom" then
        w = 2560 
        fps = 60
    else
        msg.log("error", "invalid quality")
        return ""
    end

    h = w * opts.height / 16

    return "[aid1] asplit [ao]," ..
            "afifo," ..
            "aformat            =" ..
                "sample_rates   = 192000," ..
            "avectorscope       =" ..
                "size           =" .. w .. "x" .. h .. ":" ..
                "mode           =" .. "lissajous_xy" .. ":" ..
                "scale           =" .. "lin" .. ":" ..
                "mirror           =" .. "y" .. ":" ..
                "rf           =" .. "255" .. ":" ..
                "gf           =" .. "255" .. ":" ..
                "bf           =" .. "255" .. ":" ..
                "af           =" .. "255" .. ":" ..

                "rc           =" .. "40" .. ":" ..
                "gc           =" .. "160" .. ":" ..
                "bc           =" .. "80" .. ":" ..
                "ac           =" .. "255" .. ":" ..

                "draw           =" .. "line" .. ":" ..
                "r              =" .. fps .. "," ..
            "format             = rgb0 [vo]"
end

local function select_visualizer(atrack, vtrack, albumart)
  if opts.enabled then
    mp.set_property("options/glsl-shaders", "")
    return get_visualizer(opts.name, opts.quality, vtrack, albumart)
  end
    return "[vid1]thumbnail[vo];[aid1]amix=inputs=1[ao]"
end

local function visualizer_hook()
    local visualizer = select_visualizer(atrack, vtrack, albumart)
    mp.set_property("options/lavfi-complex", visualizer)
end

mp.add_hook("on_preloaded", 50, visualizer_hook)

local function cycle_visualizer()
    opts.enabled = not opts.enabled
    visualizer_hook()
end

mp.add_key_binding(cycle_key, "cycle-visualizer", cycle_visualizer)
