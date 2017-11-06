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

vec3 color(float r, float g, float b)
{
	return vec3(r / 255.0, g / 255.0, b / 255.0);
}

void main() {
    // TODO: Compute fragment color

	vec3 green1 = color(0.0, 92.0, 0.0);
	vec3 green2 = color(0.0, 104.0, 10.0);

	vec3 lightPos = vec3(5.0, 20.0, 0.0);
	vec3 lightDir = (lightPos - inPos.xyz) / distance(lightPos, inPos.xyz);

	float lambert = max(dot(inNor.xyz, lightDir), 0.0);
	float lightIntensity = 1.5f;

	vec3 col = lambert * lightIntensity * green2 + green1;
    outColor = vec4(col, 1.0);
}
