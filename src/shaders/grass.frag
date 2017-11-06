#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 inPos;
layout(location = 1) in vec4 inNor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 green1 = vec3(0.0, 0.36, 0.035);
	vec3 green2 = vec3(0.0039, 0.65, 0.067);

	vec3 lightPos = vec3(5.0, 20.0, 0.0);
	vec3 lightDir = (lightPos - inPos.xyz) / distance(lightPos, inPos.xyz);

	float lambert = max(dot(inNor.xyz, lightDir), 0.0);
	float lightIntensity = 1.5f;

	vec3 col = lambert * lightIntensity * green2 + green2;
    outColor = vec4(col, 1.0);
}
