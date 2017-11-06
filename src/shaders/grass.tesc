#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tescIn_v0[];
layout(location = 1) in vec4 tescIn_v1[];
layout(location = 2) in vec4 tescIn_v2[];
layout(location = 3) in vec4 tescIn_Up[];

layout(location = 0) out vec4 teseIn_v0[];
layout(location = 1) out vec4 teseIn_v1[];
layout(location = 2) out vec4 teseIn_v2[];
layout(location = 3) out vec4 teseIn_Up[];


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader output
	teseIn_v0[gl_InvocationID] = tescIn_v0[gl_InvocationID];
	teseIn_v1[gl_InvocationID] = tescIn_v1[gl_InvocationID];
	teseIn_v2[gl_InvocationID] = tescIn_v2[gl_InvocationID];
    teseIn_Up[gl_InvocationID] = tescIn_Up[gl_InvocationID];

	// TODO: Set level of tesselation
     gl_TessLevelInner[0] = 1.0;
     gl_TessLevelInner[1] = 6.0;
     gl_TessLevelOuter[0] = 6.0;
     gl_TessLevelOuter[1] = 1.0;
     gl_TessLevelOuter[2] = 6.0;
     gl_TessLevelOuter[3] = 1.0;
}
