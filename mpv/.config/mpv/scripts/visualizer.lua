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

    h = w

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

was_enabled = false

local function select_visualizer(atrack, vtrack, albumart)
  if opts.enabled then
    was_enabled = true;
    mp.set_property("options/glsl-shaders", "")
    return get_visualizer(opts.name, opts.quality, vtrack, albumart)
  end
  return ""
end

local function visualizer_hook()
    local visualizer = select_visualizer(atrack, vtrack, albumart)

    if not was_enabled then
      return
    end

    mp.set_property("options/lavfi-complex", visualizer)

    if visualizer == "" then
       mp.commandv("set", "aid", "1")
       mp.commandv("set", "vid", "1")
       mp.commandv("set", "aid", "auto")
       mp.commandv("set", "vid", "auto")
    end
end

mp.add_hook("on_preloaded", 50, visualizer_hook)

local function cycle_visualizer()
    opts.enabled = not opts.enabled
    visualizer_hook()
end

mp.add_key_binding(cycle_key, "cycle-visualizer", cycle_visualizer)
