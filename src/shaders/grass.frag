#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 normal;
layout(location = 2) in float colorScale;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	// Add some very simple shading.
	vec3 lightPosition = vec3(0, 20, 0);
	vec3 lightDirection = normalize(lightPosition - position.xyz);

	// Clamp the lambert factor to add some minimum ambient light.
	float lambert = dot(normal.xyz, lightDirection);
	lambert = clamp(lambert, 0.1, 1.0);
	float intensity = 0.3;
	vec4 shade = lambert * vec4(intensity, intensity, intensity, intensity);

	// Output the color; use the color scale to make individual blades more distinct.
	vec4 baseColor = vec4(0.4, 0.6, 0.3, 1);
	vec4 grassColor = baseColor / (1 + (colorScale * 1.5));
	outColor = shade + grassColor;
}
