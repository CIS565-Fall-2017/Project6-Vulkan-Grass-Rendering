#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_tese[];
layout(location = 1) in vec4 v1_tese[];
layout(location = 2) in vec4 v2_tese[];

layout(location = 0) out vec4 frag_normal;
layout(location = 1) out vec3 frag_position;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 a = v0_tese[0].xyz + v * (v1_tese[0].xyz - v0_tese[0].xyz);
	vec3 b = v1_tese[0].xyz + v * (v2_tese[0].xyz - v1_tese[0].xyz);
	vec3 c = a + v * (b - a);

	float width = v2_tese[0].w;
	float direction = v0_tese[0].w;
	vec3 bitangent = vec3(cos(direction), 0.0, sin(direction));

	vec3 c0 = c - width * bitangent;
	vec3 c1 = c + width * bitangent;

	vec3 tangent = normalize(b - a);
	frag_normal.xyz = normalize(cross(bitangent, tangent));

	float t = u + 0.5 * v - u * v; // triangular shape

	frag_position = mix(c0, c1, t);

	gl_Position = camera.proj * camera.view * vec4(frag_position, 1.0);
}
