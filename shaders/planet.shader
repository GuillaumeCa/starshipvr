// NOTE: Shader automatically converted from Godot Engine 3.4.4.stable's SpatialMaterial.

shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);

float fresnel(float amount, vec3 normal, vec3 view) {
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void fragment() {
	vec2 base_uv = UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	float atmo = fresnel(4.0, NORMAL, VIEW);
	
	ALBEDO = albedo.rgb * albedo_tex.rgb + atmo * vec3(.0, .3, .8);
	
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}

void light() {
	
}