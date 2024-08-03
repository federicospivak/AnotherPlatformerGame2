shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest, repeat_enable;

void vertex() {
	
}

void fragment() {
	vec2 uv = vec2(UV.x + TIME * 0.1, UV.y);
	vec2 distorted_uv = SCREEN_UV + texture(TEXTURE, uv).a * 0.1;
	vec4 screen_color = texture(TEXTURE, uv);
	screen_color.a = 0.05;
	COLOR = screen_color;
}

