// cloudy skies shader
// inspired from shadertoy shader made by Drift (https://www.shadertoy.com/view/4tdSWr) 

shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D noise;
uniform float scale = 1.0;
uniform float cloudcover = 1.0;
uniform float cloudspeed = 0.5;
uniform vec4 cloudcolor: hint_color;

void fragment() {
	vec4 cloud = texture(noise, UV * scale + TIME * 0.01 * cloudspeed);	
	float val = exp(1.0 - distance(UV, vec2(0.5, 0.5))) - 1.7;
	
	ALBEDO.rgb = cloudcolor.rgb;
	ALPHA = cloud.r * cloudcover * val;
}
