#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tescv0[];
layout(location = 1) in vec4 tescv1[];
layout(location = 2) in vec4 tescv2[];
layout(location = 3) in vec4 tescvup[];

layout(location = 0) patch out vec4 tesev0;
layout(location = 1) patch out vec4 tesev1;
layout(location = 2) patch out vec4 tesev2;
layout(location = 3) patch out vec4 teseup;


void main() {
	
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	tesev0 = tescv0[0];
	tesev1 = tescv1[0];
	tesev2 = tescv2[0];
	teseup = tescvup[0];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 2;
    gl_TessLevelInner[1] = 8;
    gl_TessLevelOuter[0] = 8;
    gl_TessLevelOuter[1] = 2;
    gl_TessLevelOuter[2] = 8;
    gl_TessLevelOuter[3] = 2;
}
