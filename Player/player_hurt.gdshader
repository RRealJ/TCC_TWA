shader_type canvas_item;

uniform bool pisca = false;

void fragment() {
	vec4 cor_textura = texture(TEXTURE, UV);
	if (pisca) {
		vec3 branco = vec3(1,1,1);
		vec3 branco_alt = mix(cor_textura.rgb, branco, 0.6);
		COLOR = vec4(branco_alt, cor_textura.a);
	} 	else {
		COLOR = cor_textura;
	}
		
}
