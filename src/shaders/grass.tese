#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) patch in vec4 tese_v1;
layout(location = 1) patch in vec4 tese_v2;
layout(location = 2) patch in vec4 tese_up;
layout(location = 3) patch in vec4 tese_width_dir;

layout(location = 0) out vec4 world_pos;
layout(location = 1) out vec3 world_normal;
layout(location = 2) out vec2 tex_coords;

// TODO: Declare tessellation evaluation shader inputs and outputs

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	//Camera Matrix
	mat4 vp = camera.proj * camera.view;

	//"Responsive Real-Time Grass Rendering for General 3D Scenes" 6.3 Blade Geometry
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 a = v0 + v * (tese_v1.xyz - v0);
	vec3 b = tese_v1.xyz + v * (tese_v2.xyz - tese_v1.xyz);
	vec3 c = a + v * (b - a);
	vec3 t1 = tese_width_dir.xyz; // bitangent
	float w = tese_v2.w;
	vec3 c0 = c - w * t1 * 0.5;
	vec3 c1 = c + w * t1 * 0.5;
	vec3 t0 = normalize(b-a);
	vec3 n = normalize(cross(t0,t1));

	// quad
	//float t = u;
	
	// triangle
	//float t = u + 0.5 * v - u * v;
	
	// quadratic
	//float t = u - u * v * v;

	// triangle-tip
	// border threshold between quad and triangle
	float threshold = 0.35;
	float t = 0.5 + (u - 0.5) * (1 - max(v - threshold, 0)/(1 - threshold));

	vec3 p = (1 - t) * c0 + t * c1;
	gl_Position = vp * vec4(p, 1.0);

	// out
	world_pos = vec4(p, 1.0);
	world_normal = n;
	tex_coords = vec2(u,v);
	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}