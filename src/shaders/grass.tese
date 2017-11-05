#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec2 teseDimensions[];
layout(location = 1) in vec3 teseOrientation[];
layout(location = 2) in vec4 teseV0[];
layout(location = 3) in vec4 teseV1[];
layout(location = 4) in vec4 teseV2[];
layout(location = 5) in vec4 teseUp[];

layout(location = 0) out float colorHeight[];

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	vec3 orientation = teseOrientation[0];
	vec4 v0 = teseV0[0];
	vec4 v1 = teseV1[0];
	vec4 v2 = teseV2[0];
	vec4 Up = teseUp[0];

	vec3 a = v0.xyz + v * (v1.xyz - v0.xyz);
	vec3 b = v1.xyz + v * (v2.xyz - v1.xyz);
	vec3 c = a + v * (b - a);
	vec3 c0 = c - teseDimensions[0].x * 0.5 * orientation;
	vec3 c1 = c + teseDimensions[0].x * 0.5 * orientation;
	vec3 t0 = normalize(b - a);
	vec3 n = normalize(cross(t0, orientation));
	float t = u + 0.5 * v - u * v;
	vec3 finalPosition = (1.0 - t) * c0 + t * c1;

	//vec3 B0 = vec3(0.0, 0.0, 0.0);
	//vec3 B1 = v1.xyz - v0.xyz;
	//vec3 B2 = v2.xyz - v0.xyz;
	//vec3 curveTranslation = B0 * (1.0 - v) * (1.0 - v) + B1 * 2 * v * (1.0 - v) + B2 * v * v;

	//vec3 vAxis = teseV2[0].xyz - vec3(gl_in[0].gl_Position);
	//vec3 uAxis = normalize(cross(vAxis, orientation)) * teseDimensions[0].x;

	gl_Position = camera.proj * camera.view * vec4(finalPosition, 1.0);
	colorHeight[0] = v * 0.5 + 0.25;
}
