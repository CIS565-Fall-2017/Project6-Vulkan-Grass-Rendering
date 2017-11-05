
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

// TODO: Declare vertex shader inputs and outputs

out gl_PerVertex {
    vec4 gl_Position;
};

layout (location = 0) out vec2 dimensions;
layout (location = 1) out vec3 orientation;

layout (location = 2) out vec4 tescV0;
layout (location = 3) out vec4 tescV1;
layout (location = 4) out vec4 tescV2;
layout (location = 5) out vec4 tescUp;

void main() {
	// TODO: Write gl_Position and any other shader outputs
	gl_Position = vec4(v0.xyz, 1.0);
	dimensions.x = v2.w;
	dimensions.y = v1.w;
	tescV0 = v0;
	tescV1 = v1;
	tescV2 = v2;
	tescUp = up;
	
	orientation = vec3(sin(v0.w), 0.0, cos(v0.w));
}
