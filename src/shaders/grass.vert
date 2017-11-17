
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare vertex shader inputs and outputs

layout (location = 0) in vec4 v0In;
layout (location = 1) in vec4 v1In;
layout (location = 2) in vec4 v2In;

layout (location = 0) out vec4 v1;
layout (location = 1) out vec4 v2;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    // pass stuff that we will need later in the pipeline aka tesselation shaders
    v1 = v1In;
    v1.w = v0In.w;
    v2 = v2In;
    gl_Position = vec4(v0In.xyz, 1.0);
}
