shader_type spatial;
render_mode specular_disabled;

uniform vec4 base_color : source_color = vec4(0.19, 0.25, 0.28, 1.0);
uniform vec4 line_color : source_color = vec4(0.27, 0.34, 0.36, 1.0);
uniform float tile_size = 2.0;
varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 grid = world_position.xz / tile_size;
	vec2 distance_to_line = abs(fract(grid - 0.5) - 0.5);
	vec2 lines = 1.0 - smoothstep(vec2(0.012), vec2(0.012) + fwidth(grid), distance_to_line);
	ALBEDO = mix(base_color.rgb, line_color.rgb, max(lines.x, lines.y));
	ROUGHNESS = 0.95;
}
