#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec4 inNormal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	
	// Shade with a gradient going from brownish green at the bottom to grass green on the top
	vec3 brownishGreen = vec3(0.41, 0.38, 0.3);
	vec3 grassGreen = vec3(0.3, 0.7, 0.0);
	vec3 blendColor = mix(brownishGreen, grassGreen, inNormal.w);

	// Lambertian Shading
	vec3 lightPosition = vec3(10.0, 0.0, -1.0);
	vec3 lightDirection = normalize(lightPosition - inPosition.xyz);
	float dot = dot(inNormal.xyz, lightDirection);

    outColor = vec4(blendColor * abs(dot), 1.0);
}
