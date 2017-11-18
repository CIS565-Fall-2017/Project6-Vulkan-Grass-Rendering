#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
//from .tesc
layout(location = 0) in vec4[] v0_in;
layout(location = 1) in vec4[] v1_in;
layout(location = 2) in vec4[] v2_in;
layout(location = 3) in vec4[] vUp_in;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	float height = v1_in[0].w;
	float width = v2_in[0].w;
	float angle = v0_in[0].w;

	vec3 v0 = vec3(v0_in[0]);
	vec3 v1 = vec3(v1_in[0]);
	vec3 v2 = vec3(v2_in[0]);
	vec3 dir = vec3(sin(angle), 0.0, cos(angle));

	vec3 a = v0 + v * (v1 - v0); //scaled up
	vec3 b = v1 + v * (v2 - v1); //scaled forward
	vec3 c = a + v * (b - a); //mid

	vec3 c0 = c - width * dir;
	vec3 c1 = c + width * dir;
	float t = u + 0.5 * v - u * v;
	vec3 pos = (1 - t) * c0 + t * c1;

	gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
