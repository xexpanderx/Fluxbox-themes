--[[
---------------- USER CONFIGURATION ----------------
Change the parameters below to fit your needs.
]]--

-- Colors

HTML_color_drive_1 = "#717171"
HTML_color_drive_2 = "#717171"
HTML_color_BORDER = "#0f1013"
HTML_color_circle = "#0f1013"
HTML_color_inside_circle_used = "#2a7e4d"
HTML_color_inside_circle_used_panic = "#ff0006"
HTML_color_inside_circle = "#222222"
transparency_drive_1 = 1
transparency_drive_2 = 1
transparency_border = 0.1
transparency_circle = 1
transparency_circle_inside = 1

-- Path of drives for free space status.
drive_paths = {"/home", "/"}

-- Names of drives for free space status.
drive_names = {"Home", "Root"}

-- Number of drives to show free space status. Adjust the conky "height"-parameter in config manually to adjust for the increase in Conky height when adding more drives.
drives = 2

-- Normal border size
border_size = 4

-- Hide percent text in circular conky mode
hide = true

-- Distance between each conky area.
gap_x_distance = 50

--[[
-- DON'T EDIT BELOW IF YOU DO NOT KNOW WHAT YOU ARE DOING!!!
]]--


require 'cairo'

operator = {CAIRO_OPERATOR_SOURCE,
			CAIRO_OPERATOR_CLEAR
		   }
		   
operator_transpose = {CAIRO_OPERATOR_CLEAR,
			CAIRO_OPERATOR_SOURCE
		   }

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return (tonumber("0x"..hex:sub(1,2))/255), (tonumber("0x"..hex:sub(3,4))/255), tonumber(("0x"..hex:sub(5,6))/255)
end

r_border, g_border, b_border = hex2rgb(HTML_color_BORDER)

r_drive_1, g_drive_1, b_drive_1 = hex2rgb(HTML_color_drive_1)
r_drive_2, g_drive_2, b_drive_2 = hex2rgb(HTML_color_drive_2)
r_circle, g_circle, b_circle = hex2rgb(HTML_color_circle)
r_circle_used, g_circle_used, b_circle_used = hex2rgb(HTML_color_inside_circle_used)
r_circle_used_panic, g_circle_used_panic, b_circle_used_panic = hex2rgb(HTML_color_inside_circle_used_panic)
r_circle_inside, g_circle_inside, b_circle_inside = hex2rgb(HTML_color_inside_circle)

drive_colors = {{r_drive_1, g_drive_1, b_drive_1,transparency_drive_1},
				{r_drive_2, g_drive_2, b_drive_2,transparency_drive_2}}


function fix_text(text)
	if string.len(text) == 1 then
		new_text = "0" .. text .. "%"
		return new_text
	else
		new_text = text .. "%"
		return new_text
	end
end

function draw_circle(cr,pos_x,pos_y,color1,color2,color3,trans, parameter)
	cairo_set_source_rgba(cr, color1,color2,color3,trans)
	cairo_set_line_width(cr, 2)
	
	cairo_arc(cr,pos_x+10+34,(88/2)+pos_y,54,0*math.pi/180,360*math.pi/180)
	cairo_fill(cr)
	
	cairo_set_line_width(cr, border_size)
	cairo_set_source_rgba(cr, r_border,g_border,b_border,transparency_border)
	cairo_arc(cr,pos_x+10+34,(88/2)+pos_y,54,0*math.pi/180,360*math.pi/180)
	cairo_stroke(cr)
	
	if not hide then
		cairo_set_source_rgba(cr,r_circle_used,g_circle_used,b_circle_used,transparency_circle)
		ct = cairo_text_extents_t:create()
		cairo_set_font_size(cr,12)	
		cairo_text_extents(cr,fix_text(parameter),ct)
		cairo_move_to(cr,pos_x+10+34-ct.width/2,pos_y+88/2-54+25/2+ct.height/2-3)
		cairo_show_text(cr,fix_text(parameter))
		cairo_close_path(cr)
	end
end

function draw_folder(cr,x_pos,y_pos,start_rect_height,hdd,folder_name,r_color_drive,g_color_drive,b_color_drive,transparency_drive)
-- Draw indicator
	cairo_set_source_rgba(cr,r_circle_inside,g_circle_inside,b_circle_inside,transparency_circle_inside)
	
	local distance_between_arcs = 0
	local number_of_arcs = 20
	local arcs_length = (360 - (number_of_arcs*distance_between_arcs)) / number_of_arcs
	local start_angel = 270
	local used_blocks = math.floor((number_of_arcs / 100) * tonumber(conky_parse('${fs_free_perc ' .. hdd .. '}')))
	local radius_outer = 34
	local radius_inner = 24
	local radius = 29

	cairo_set_line_width(cr, 6)
	cairo_arc(cr,x_pos+10+34,(start_rect_height/2)+y_pos,radius,start_angel*math.pi/180,(start_angel+360)*math.pi/180)
	cairo_stroke(cr)
	
	
	cairo_set_line_width(cr, 6)
	if tonumber(conky_parse('${fs_free_perc ' .. hdd .. '}')) > 10 then
		cairo_set_source_rgba(cr,r_circle_used,g_circle_used,b_circle_used,transparency_circle)
	else
		cairo_set_source_rgba(cr,r_circle_used_panic,g_circle_used_panic,b_circle_used_panic,transparency_circle)
	end
	
	for i=1, used_blocks do
		cairo_arc(cr, x_pos+10+34,(start_rect_height/2)+y_pos,radius,start_angel*math.pi/180,(start_angel+arcs_length)*math.pi/180)
		cairo_stroke(cr)
		start_angel = start_angel+arcs_length+distance_between_arcs-0.5
	end
	
	cairo_set_source_rgba(cr,r_color_drive,g_color_drive,b_color_drive,transparency_drive)
	ct_text = cairo_text_extents_t:create()
	cairo_set_font_size(cr,14)
	cairo_text_extents(cr,folder_name,ct_text)
	cairo_move_to(cr,x_pos+10+34-ct_text.width/2,(start_rect_height/2)+y_pos+ct_text.height/2-2) 		
	cairo_show_text(cr,folder_name)
end

function draw_function(cr)
	local w,h=conky_window.width,conky_window.height	
	cairo_select_font_face (cr, "Ubuntu Nerd Font", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);

   	local start_rect_height = 88
    -- Start with 172
    local start_rect_width = 108
    local gap_y_text = (start_rect_height/2)-7
    local gap_x = 10
	local gap_y = 10
	local gap_x_fix = 15
   	local gap_y_fix = 15
	local start_rect_width_no_battery = 66.5
	local radius = 10
    
	
	for i=1,drives do
		draw_circle(cr,gap_x_fix,(start_rect_width_no_battery)+gap_y_fix,r_circle, g_circle, b_circle, transparency_circle,conky_parse('${fs_free_perc ' .. drive_paths[i] .. '}'))
		draw_folder(cr,gap_x_fix,(start_rect_width_no_battery)+gap_y_fix,start_rect_height,drive_paths[i],drive_names[i],drive_colors[i][1], drive_colors[i][2], drive_colors[i][3], drive_colors[i][4])
		start_rect_width_no_battery = start_rect_width_no_battery + gap_x_distance + 70
	end

end

function conky_start_widgets()
	local function draw_conky_function(cr)
		local str=''
		local value=0		
		draw_function(cr)
	end

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	
	local cr=cairo_create(cs)	
	draw_conky_function(cr)
	cairo_surface_destroy(cs)
	cairo_destroy(cr)
end
