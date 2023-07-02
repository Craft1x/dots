-- DEBUGGING
--
-- Debug messages will be printed to stdout with mpv command line option
-- `--msg-level='locatefile=debug'`

local msg = require('mp.msg')

--// Extract file dir from url
function GetFileName(url)
  return url:match("^.+/([^/]+)$")
end

-- for ubuntu
url_browser_linux_cmd = "xdg-open \"$url\""
file_browser_linux_cmd = "nemo \"$path\""

--// check if it's a url/stream
function is_url(path)
  if path ~= nil and string.sub(path,1,4) == "http" then
    return true
  else
    return false
  end
end

--// create temporary script
function create_temp_file(content)
  local tmp_filename = os.tmpname()
  local tmp_file = io.open(tmp_filename, "wb")
  tmp_file:write(content)
  io.close(tmp_file)
  return tmp_filename
end

--// handle "locate-current-file" function triggered by a key in "input.conf"
mp.register_script_message("locate-current-file", function()
  local path = mp.get_property("path")
  if path ~= nil then
    local cmd = ""
    if is_url(path) then
      msg.debug("Url detected '" .. path .. "', your OS web browser will be launched.")
      msg.debug("Linux detected.")
      cmd = url_browser_linux_cmd
      cmd = cmd:gsub("$url", path)
    else
      msg.debug("File detected '" .. path .. "', your OS file browser will be launched.")
      msg.debug("Linux detected.")
      cmd = file_browser_linux_cmd
      cmd = cmd:gsub("$path", path)
    end
    msg.debug("Command to be executed: '" .. cmd .. "'")
    -- mp.osd_message('Browse \n' .. path)
    os.execute(cmd)
  else
    msg.debug("'path' property was empty, no media has been loaded.")
  end
end)
