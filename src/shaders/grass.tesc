#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare tessellation control shader inputs and outputs
// Input: Vertex Shader Outputs
layout(location = 0) in vec4 ts_v1[];
layout(location = 1) in vec4 ts_v2[];
layout(location = 2) in vec4 ts_up[];
layout(location = 3) in vec4 ts_t1[];

// Output: Vertex Shader Inputs
layout(location = 0) patch out vec4 tse_v1;
layout(location = 1) patch out vec4 tse_v2;
layout(location = 2) patch out vec4 tse_up;
layout(location = 3) patch out vec4 tse_t1;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// DONE: Write any shader outputs
    // We can pack all this data into four vec4s, 
	// such that v0.w holds orientation, v1.w holds height, 
	// v2.w holds width, and up.w holds the stiffness coefficient.

	tse_v1 = ts_v1[0];
    tse_v2 = ts_v2[0];
    tse_up = ts_up[0];
    tse_t1 = ts_t1[0];

	//DONE: Set level of tesselation
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 3;

	// Left Edge
    gl_TessLevelOuter[0] = 3.0;
	//Top Edge
    gl_TessLevelOuter[1] = 1;
	//Right Edge
    gl_TessLevelOuter[2] = 3.0;
	// Bottom Edge
    gl_TessLevelOuter[3] = 1.0;
}
