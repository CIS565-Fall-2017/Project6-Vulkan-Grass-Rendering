
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 inV0;
layout (location = 1) in vec4 inV1;
layout (location = 2) in vec4 inV2;

layout(location = 0) out vec4 tescIn_v0;
layout(location = 1) out vec4 tescIn_v1;
layout(location = 2) out vec4 tescIn_v2;
out gl_PerVertex {
    vec4 gl_Position;
};


void main() {
	// TODO: Write gl_Position and any other shader outputs
    tescIn_v0 = inV0;
	tescIn_v1 = inV1;
	tescIn_v2 = inV2;

	gl_Position = vec4(inV0.x,inV0.y,inV0.z,1.0);
}
