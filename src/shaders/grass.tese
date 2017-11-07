#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
//if no patch designation need []
//ins
layout(location = 0) patch in vec4 v1tese;
layout(location = 1) patch in vec4 v2tese;
layout(location = 2) patch in vec3 uptese;
layout(location = 3) patch in vec3 bitantese;

//outs
layout(location = 0) out vec3 nortese;
layout(location = 1) out float uvtese_v;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
	uvtese_v = v;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	mat4 viewproj = camera.proj*camera.view;
	vec3 v0 = gl_in[0].gl_Position.xyz;
	float w = v2tese.w;//width
	vec3 t1 = bitantese.xyz;//bitan
	vec3 a = v0 + v*(v1tese.xyz - v0);
	vec3 b = v1tese.xyz + v*(v2tese.xyz - v1tese.xyz);
	vec3 c = a + v*(b - a);
	vec3 c0 = c - 0.5f*w*t1;
	vec3 c1 = c + 0.5f*w*t1;
	vec3 t0 = normalize(b-a);//tan
	nortese = normalize(cross(t0,t1));

	float t = 0.5 + (u-0.5)*(1.0-max(v-0.5,0)/(1.0-0.5));
	vec4 interppos = vec4((1.0 - t)*c0 + t*c1, 1.0);
	gl_Position = viewproj*interppos;
}
