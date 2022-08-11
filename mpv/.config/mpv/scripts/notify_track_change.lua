local utils = require "mp.utils"

local cover_filenames = { ".cover.png","cover.png", "cover.jpg", "cover.jpeg",
"folder.jpg", "folder.png", "folder.jpeg",
"AlbumArtwork.png", "AlbumArtwork.jpg", "AlbumArtwork.jpeg" }

function notify_media(title, origin, thumbnail)
	return mp.command_native({
		"run",
		"dunstify",
		"--replace=3333",
		"--icon="..(thumbnail or "mpv"),
		"Currently playing",
		(title) .. "",
	})
end

function file_exists(path)
	local info, _ = utils.file_info(path)
	return info ~= nil
end

function find_cover(dir, filePath)
	-- make dir an absolute path
	if dir[1] ~= "/" then
		dir = utils.join_path(utils.getcwd(), dir)
	end

	-- find a cover file in the directory
	for _, file in ipairs(cover_filenames) do
		local path = utils.join_path(dir, file)
		if file_exists(path) then
			return path
		end
	end

	local tempPath = '/tmp/.mpv-shot-thumb'
	mp.commandv('screenshot-to-file',tempPath)
	if file_exists(tempPath) then
		return tempPath
	end

	return nil
end

local music_formats = {
	".opus",
	".mp3",
	".flac",
	".wav",
	".ogg",
	".m4a",
	".raw",
}

function notify_current_media()
	os.execute("sleep " .. tonumber(0.1))

	local path = mp.get_property_native("path")

	local dir, file = utils.split_path(path)


	local isMusic = false
	-- if file is not music - exit
	for k,v in pairs(music_formats) do
		if (file:sub(-string.len(v)) == v) then
			isMusic = true
			break
		end
	end	

	if ( isMusic == false ) then
		return 0
	end

	local thumbnail = find_cover(dir, file)

	local title = file
	local origin = dir

	local metadata = mp.get_property_native("metadata")
	if metadata then
		function tag(name)
			return metadata[string.upper(name)] or metadata[name]
		end

		title = tag("title") or title
		origin = tag("artist_credit") or tag("artist") or ""

		local album = tag("album")
		if album then
			origin = string.format("%s — %s", origin, album)
		end

		local year = tag("original_year") or tag("year")
		if year then
			origin = string.format("%s (%s)", origin, year)
		end
	end

	return notify_media(title, origin, thumbnail)
end

mp.register_event("file-loaded", notify_current_media)

