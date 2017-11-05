#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_i[];
layout(location = 1) in vec4 v1_i[];
layout(location = 2) in vec4 v2_i[];
//layout(location = 3) in vec4 up_i[]; // not used

layout(location = 0) out vec4 position;
layout(location = 1) out vec4 normal;

float rand(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    position.w = u;
	normal.w = v;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 a = v0_i[0].xyz + v * (v1_i[0].xyz - v0_i[0].xyz);
	vec3 b = v1_i[0].xyz + v * (v2_i[0].xyz - v1_i[0].xyz);
	vec3 center = a + v * (b - a);
	float width = v2_i[0].w;
	float theta = v0_i[0].w;
	vec3 bitangent = vec3(cos(theta), 0.0, sin(theta));

	vec3 c0 = center - width * bitangent;
	vec3 c1 = center + width * bitangent;

	vec3 tangent = normalize(b - a);
	normal.xyz = normalize(cross(bitangent, tangent));

	float t = u - u * v * v;
	vec3 p = mix(c0, c1, t);

	position.xyz =  p;
	gl_Position = camera.proj * camera.view * vec4(p, 1.0);;
	
}
