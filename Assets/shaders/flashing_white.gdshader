shader_type canvas_item;	

uniform vec4 flash_color: source_color = vec4(1.0);
uniform float flash_mofidifier: hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, flash_color.rbg, flash_mofidifier); 
	COLOR = color;
}

void vertex() {
	// Called for every vertex the material is visible on.
}


