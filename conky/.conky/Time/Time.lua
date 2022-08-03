conky.config = {
	use_xft = true,
	font = 'Cantarell:size=130:weight=50',
	xftalpha = 0.1,
	update_interval = 1,
	total_run_times = 0,

	own_window = true,
	own_window_class = 'Conky',
	own_window_type = 'override',
	own_window_transparent = false,
	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
	own_window_colour = '#000205',
	own_window_argb_visual = true,
	own_window_argb_value = 210,

	double_buffer = true,
	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,
	default_color = 'white',
	default_shade_color = 'red',
	default_outline_color = 'green',
	alignment = 'middle_middle',
	gap_x = -2260,
	gap_y = -185,
	no_buffers = true,
	uppercase = false,
	cpu_avg_samples = 2,
	net_avg_samples = 1,
	override_utf8_locale = true,
	use_spacer = 'left',

	minimum_width = 0, minimum_height = 0,
};

conky.text = [[
 ${time %H:%M} 
]];
