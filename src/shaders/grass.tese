#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 e_v1[];
layout(location = 1) in vec4 e_v2[];
layout(location = 2) in vec4 e_orthogonal[]; // normalized orthogonal direction to blade and width

layout(location = 0) out vec3 f_pos;
layout(location = 1) out vec3 f_nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	vec3 p0 = gl_in[0].gl_Position.xyz;
	vec3 p1 = e_v1[0].xyz; // 0?
	vec3 p2 = e_v2[0].xyz;
	vec4 e_o = e_orthogonal[0];

	// bezier curve location
	vec3 a = p0 + v * (p1 - p0);
	vec3 b = p1 + v * (p2 - p1);
	vec3 pBezier = a + v * (b - a);

	// triangular width offset
	// full at base, none at top, direction dependent on offset from center
	vec3 pOrtho = (1.0 - v) * e_o.w * 2.0 * (u - 0.5) * e_o.xyz;
	
	f_pos = (camera.view * vec4(pBezier + pOrtho, 1.0)).xyz;

	// normals
	vec3 bezTangent = normalize(b - a);

	f_nor = (camera.view * vec4(normalize(cross(normalize(bezTangent), e_o.xyz)), 0.0)).xyz;

	// clip space position
	gl_Position = camera.proj * vec4(f_pos, 1.0); 

	//gl_Position = camera.proj * camera.view * (gl_in[0].gl_Position + vec4(1.0 - u, v, 0.0, 0.0));
}
