#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

// Input from tess. eval
layout (location = 0) in vec4 te_position;
layout (location = 1) in vec4 te_normal;
layout (location = 2) in vec2 te_uv;

layout(location = 0) out vec4 outColor;


// Cubic approximation of gaussian curve so we falloff to exactly 0 at the light radius
float cubicGaussian(float h) {
	if (h < 1.0) {
		return 0.25 * pow(2.0 - h, 3.0) - pow(1.0 - h, 3.0);
	} else if (h < 2.0) {
		return 0.25 * pow(2.0 - h, 3.0);
	} else {
		return 0.0;
	}
}

void main() {
    // TODO: Compute fragment color

	// Lambert
	vec3 lightPosition = vec3(0.0, 5.0, 0.0);
	vec3 fixedView = normalize(-te_position.xyz);
	vec3 fixedNormal = faceforward(te_normal.xyz, fixedView, -te_normal.xyz);
	float lambertTerm = clamp( dot( fixedNormal, normalize(lightPosition - te_position.xyz) ), 0.0, 1.0 );

	vec4 ambientLight = vec4(1.25);
	vec4 albedo = vec4(0.13, 0.56, 0.13, 1.0);
    outColor = ambientLight * albedo * lambertTerm;
}
