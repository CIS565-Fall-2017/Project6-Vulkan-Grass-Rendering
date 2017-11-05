
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
	mat4 proj;
} camera;

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 tescv0;
layout(location = 1) out vec4 tescv1;
layout(location = 2) out vec4 tescv2;
layout(location = 3) out vec4 tescvup;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	vec3 inPosition = vec3(v0);
	//gl_Position = camera.proj * camera.view * model * vec4(inPosition, 1.0);
	gl_Position = model * vec4(inPosition, 1.0);
    tescv0 = v0;
	tescv1 = v1;
	tescv2 = v2;
	tescvup = up;
}
