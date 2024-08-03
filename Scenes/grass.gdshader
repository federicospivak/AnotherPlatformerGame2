shader_type canvas_item;

uniform bool activate_movement = false;

void vertex() {
	if(activate_movement){
		if (VERTEX.y < 0.0){
			VERTEX += vec2(sin(TIME * 6.00) * 3.00 , 0);
		}
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
}
