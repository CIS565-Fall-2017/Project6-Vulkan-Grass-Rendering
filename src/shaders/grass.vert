
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v_v0;
layout (location = 1) in vec4 v_v1;
layout (location = 2) in vec4 v_v2;
//layout (location = 3) in vec4 v_up; //?

layout (location = 0) out vec4 c_v1;
layout (location = 1) out vec4 c_v2;


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	c_v1 = v_v1;
	c_v2 = v_v2;
	gl_Position = vec4(v_v0.xyz, 1.0);
}
