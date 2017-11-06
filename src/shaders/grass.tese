#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 teseIn_v0[];
layout(location = 1) in vec4 teseIn_v1[];
layout(location = 2) in vec4 teseIn_v2[];

layout(location = 0) out vec3 pos;
layout(location = 1) out vec3 nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 p0 = mix(teseIn_v1[0].xyz,teseIn_v0[0].xyz, u);
	vec3 p1 = mix(teseIn_v2[0].xyz,teseIn_v2[0].xyz, u);

	pos = mix(p0,p1,v);
	nor = vec3(1.0,0.0,0.0);
	gl_Position = camera.proj*camera.view*vec4(pos,1.0);
}
