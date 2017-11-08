#version 450
#extension GL_ARB_separate_shader_objects : enable

// TESS. EVAL = CONFIGURE VERTICES' WORLD POSITIONS
// https://www.khronos.org/opengl/wiki/Tessellation_Evaluation_Shader

// This layout qualifier controls how Tessellator generates verts 
// primitive mode, vertex spacing, and ordering 
// http://prideout.net/blog/?p=48 
layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

// Input from tess. control
layout (location = 0) in vec4 tc_v0[];
layout (location = 1) in vec4 tc_v1[];
layout (location = 2) in vec4 tc_v2[];

// Output from tess. eval to frag shader (make sure they're in clip space!)
layout (location = 0) out vec4 te_position;
layout (location = 1) out vec4 te_normal;
layout (location = 2) out vec2 te_uv;


void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

	// Direction vector along width of the blade
	float width = tc_v2[0].w;
	float theta = tc_v0[0].w;
	vec3 bitangent = vec3(sin(theta), 0.0, cos(theta));

	vec3 a = tc_v0[0].xyz + v * (tc_v1[0].xyz - tc_v0[0].xyz);
	vec3 b = tc_v1[0].xyz + v * (tc_v2[0].xyz - tc_v1[0].xyz);
	vec3 c = a + v * (b - a);

	// Create the curve points along bezier curve
	vec3 c0 = c - width * bitangent;
	vec3 c1 = c + width * bitangent;

	vec3 tangent = normalize(b - a);
	vec3 normal = normalize(cross(tangent, bitangent));

	// Create grass shape ------------------------------

	// Quad
	// float t = u;

	// Triangle
	float t = u + (0.5 * v) - (u * v);

	// Quadratic
	// float t = u - pow(u * v, 2);

	// Triangle-tip
	// float tau = 0.5;
	// float t = 0.5 + (u - 0.5) * (1.0 - (max(v - tau, 0.0) / (1.0 - tau)));

	vec3 position = mix(c0, c1, t);
	te_position = vec4(position.xyz, 1.0);
	te_normal = vec4(normal, 1.0);
	te_uv = vec2(u, v);

	gl_Position = camera.proj * camera.view * te_position;

}
