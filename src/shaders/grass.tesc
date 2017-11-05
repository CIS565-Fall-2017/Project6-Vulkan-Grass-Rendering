#version 450
#extension GL_ARB_separate_shader_objects : enable

// TESS. CONTROL = CONFIGURE TESSELLATION PARAMETERS HERE


// Number of vertices per patch according to (aka output patch size)
// http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3/
layout(vertices = 1) out;


layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;


// TODO: Declare tessellation control shader inputs and outputs

// Input from vert shader
layout (location = 0) in vec4 v_v1[];
layout (location = 1) in vec4 v_v2[];
layout (location = 2) in vec4 v_up[];

// Output from tess. control to the tess. eval shader
// Output as vertices or patches? -- > https://www.khronos.org/opengl/wiki/Tessellation_Control_Shader
layout (location = 0) out vec4 tc_v1[];
layout (location = 1) out vec4 tc_v2[];
layout (location = 2) out vec4 tc_up[];


/*
	NOTES:
	* gl_out and gl_in are arrays of vertices 
	* gl_InvocationID = identify each vertex
	* gl_Position = position of vertex in vec4
*/

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;


	// TODO: Write any shader outputs
	tc_v1[gl_InvocationID] = v_v1[0];
	tc_v2[gl_InvocationID] = v_v2[0];
	tc_up[gl_InvocationID] = v_up[0];

	// TODO: Set level of tessellation
	// Note: These are per-patch outputs, only need to be written once
	// QUESTION: Why not put it in "if(gl_InvocationID == 0)"???
	// Then you only write them from a single execution thread (http://prideout.net/blog/?p=48)
    gl_TessLevelInner[0] = 1;
    gl_TessLevelInner[1] = 2;
    gl_TessLevelOuter[0] = 2;
    gl_TessLevelOuter[1] = 2;
    gl_TessLevelOuter[2] = 2;
    gl_TessLevelOuter[3] = 2;
}
