#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 4) in vec2 bladeDimensions[];

layout(location = 5) out vec2 bD[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;
	// TODO: Write any shader outputs
	bD[gl_InvocationID] = bladeDimensions[gl_InvocationID];


	 //TODO: Set level of tesselation
     gl_TessLevelInner[0] = 2.0;
     gl_TessLevelInner[1] = 2.0;
     gl_TessLevelOuter[0] = 2.0;
     gl_TessLevelOuter[1] = 2.0;
     gl_TessLevelOuter[2] = 2.0;
     gl_TessLevelOuter[3] = 2.0;
}
