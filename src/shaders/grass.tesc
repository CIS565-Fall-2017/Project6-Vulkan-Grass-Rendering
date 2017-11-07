#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUP[];

layout(location = 0) patch out vec4 outV0;
layout(location = 1) patch out vec4 outV1;
layout(location = 2) patch out vec4 outV2;
layout(location = 3) patch out vec4 outUP;

void main() {
	// Don't move the origin location of the patch
	// World Position V0
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	outV0 = inV0[gl_InvocationID];
	outV1 = inV1[gl_InvocationID];
	outV2 = inV2[gl_InvocationID];
	outUP = inUP[gl_InvocationID];

	// LOD


	// TODO: Set level of tesselation 
	// Horizontal tesselation
	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[3] = 1.0;
    
	// Vertical tesselation
	gl_TessLevelInner[1] = 4.0;
    gl_TessLevelOuter[0] = 4.0;
    gl_TessLevelOuter[2] = 4.0;
}
