#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 position;
layout(location = 1) in vec4 normal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec4 darkG = vec4(0.01, 0.05, 0.01, 1.0);
    vec4 brightG = vec4(0.01, 0.5, 0.01, 1.0);
	vec3 lightPos= vec3(0.0,10.0,0.0);
	vec3 lightDir = normalize(lightPos - position.xyz);

	float cosValue = clamp(dot(normal.xyz, lightDir), 0.0, 1.0);
	vec4 mixed_col = mix(darkG, brightG, clamp(normal.w, 0.0, 1.0));
    vec4 ambient_col = vec4(vec3(0.1), 1.0);

    outColor = ambient_col + cosValue*mixed_col;
}
