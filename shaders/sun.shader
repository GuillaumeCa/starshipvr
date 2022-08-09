shader_type spatial;
render_mode specular_schlick_ggx, unshaded;

uniform float Glow_Power : hint_range(0,10) = 3;
uniform float Lightness_Difference : hint_range(0,10) = 3;
uniform vec4 Sun_Color : hint_color;

uniform float fresnel : hint_range(0,2) = 1.0;

void fragment() {
	// Fresnel
	float fresnel_out = pow(fresnel - clamp(dot(NORMAL, VIEW), 0.0, fresnel), fresnel);

	vec3 cloud_tex_with_light = vec3(Lightness_Difference);
	vec3 cloud_tex_with_light_with_color = Sun_Color.rgb;
	vec3 cloud_tex_with_light_with_color_with_glow = vec3(Glow_Power) * cloud_tex_with_light_with_color;

	vec3 result = cloud_tex_with_light_with_color_with_glow;

	ALBEDO = (1.0 - vec3(fresnel_out)) + result;
}