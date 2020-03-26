require 'cairo'

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return (tonumber("0x"..hex:sub(1,2))/255), (tonumber("0x"..hex:sub(3,4))/255), tonumber(("0x"..hex:sub(5,6))/255)
end

-- HTML colors
black="#000000"
color0="#1B1216"
color1="#933130"
color2="#A45534"
color3="#D86536"
color4="#598C34"
color5="#699437"
color6="#71AB38"
color7="#BFBFBF"
color8="#7b9169"
color9="#933130"
color10="#A45534"
color11="#D86536"
color12="#598C34"
color13="#699437"
color14="#71AB38"
color15="#b1d096"
color66="#000000"
t0= 1
t0_border= 0.3
r0, g0, b0 = hex2rgb(color0)
t1= 1
r1, g1, b1 = hex2rgb(color66)
t2= 1
r2, g2, b2 = hex2rgb(color7)
t3= 1
r3, g3, b3 = hex2rgb(color8)

function fix_text(text)
	if string.len(text) == 1 then
		new_text = "0" .. text .. "%"
		return new_text
	else
		new_text = text .. "%"
		return new_text
	end
end

function draw_background(cr, w, h)
	cairo_set_source_rgba(cr, r1, g1, b1, 0.2)
	cairo_rectangle (cr, 0, 0, w, h);
    cairo_fill(cr)
    cairo_set_source_rgba(cr, r0, g0, b0, t0)
    r=24
    cairo_arc(cr,0,r,r,270*math.pi/180,340*math.pi/180)
    cairo_rel_line_to(cr,2,5)
    cairo_arc_negative(cr,r*2,h-r,r,160*math.pi/180,90*math.pi/180)
    cairo_rel_line_to(cr,-(r*2+3),0)
    cairo_close_path(cr)
    cairo_fill(cr)
    cairo_set_source_rgba(cr, r0, g0, b0, 0.2)
    cairo_move_to(cr,0,0)
    cairo_rel_line_to(cr,w,0)
    cairo_stroke(cr)
    
    --CPU temp
	temp0 = conky_parse("${execi 5 sensors | grep 'Core 0:' | awk -F+ '{print $2}' | awk -F° '{print $1}'}")
	temp1 = conky_parse("${execi 5 sensors | grep 'Core 1:' | awk -F+ '{print $2}' | awk -F° '{print $1}'}")
	cairo_set_source_rgba(cr, r2, g2, b2, t2)
	ct = cairo_text_extents_t:create()
	cairo_text_extents(cr,temp0 .. "°C",ct)
    cairo_move_to(cr,w/2-ct.width/2-10,h/2+ct.height/2)
    cairo_show_text(cr,temp0 .. "°C")
    
	ct1 = cairo_text_extents_t:create()
	cairo_text_extents(cr,temp1 .. "°C",ct1)
    cairo_move_to(cr,w/2+ct.width-ct1.width/2+10,h/2+ct1.height/2)
    cairo_show_text(cr,temp1 .. "°C")
end

function draw_background_border(cr, w, h)
	cairo_set_source_rgba(cr, r0, g0, b0, t0_border)
	cairo_set_line_width(cr, 2)
	cairo_arc(cr,w/2,h/2,52,0*math.pi/180,360*math.pi/180)
    cairo_stroke(cr)
end

function draw_widgets(cr)
	local w,h=conky_window.width,conky_window.height
	cairo_select_font_face (cr, "Ubuntu", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
	cairo_set_font_size(cr, 10)
	
	--Draw background
	draw_background(cr, w, h)
	--draw_circle_background_border(cr, w, h)
end

function conky_start_widgets()

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	local cr=cairo_create(cs)	
	local ok, err = pcall(function () draw_widgets(cr) end)
	cairo_surface_destroy(cs)
	cairo_destroy(cr)
end
