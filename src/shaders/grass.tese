#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 tse_v1;
layout(location = 1) patch in vec4 tse_v2;
layout(location = 2) patch in vec4 tse_up;
layout(location = 3) patch in vec4 tse_t1;

// Outputs: Fragment Shader Input
layout(location = 0) out vec2 uv;
layout(location = 1) out vec4 pos;
layout(location = 2) out vec4 nor;
layout(location = 3) out vec3 wind;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	vec3 v0 = gl_in[0].gl_Position.xyz;
	//Width
	float w = tse_v2.w;

    // TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	// Just the stuff from section 6.3
	vec3 a = v0 + v * (tse_v1.xyz - v0);
	vec3 b = tse_v1.xyz + v * (tse_v2.xyz - tse_v1.xyz);
	vec3 c = a + v * (b - a);

	vec3 c0 = c - w * tse_t1.xyz;
	vec3 c1 = c + w * tse_t1.xyz;

	vec3 t0 = normalize(b - a);

	nor = vec4(normalize(cross(vec3(t0), vec3(tse_t1))),0);

	//Position p is dependent on interpolating between c0 and c1 using t:
	float t = u - (u*v*v);
	pos = vec4((1 - t) * c0 + t * c1,1);

	pos = (camera.proj * camera.view) * pos;

	gl_Position = pos;
	uv = vec2(u,v);
}