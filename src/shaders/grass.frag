#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 1) in vec3 Normal;
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 color = vec3(0.1, 0.7, 0.1);
	vec3 lightDirection = normalize(vec3(1.0, 5.0, -5.0));
	float NdotL = clamp(dot(Normal, lightDirection), 0.1, 1.0);
	outColor = vec4(color * NdotL, 1.0);
}
