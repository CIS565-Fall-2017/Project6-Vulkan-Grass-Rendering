#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) patch in vec4 tv1;
layout(location = 1) patch in vec4 tv2;
layout(location = 2) patch in vec4 tup;
layout(location = 3) patch in vec4 twd;

layout(location = 0) out vec4 Position;
layout(location = 1) out vec3 Normal;
layout(location = 2) out vec3 Wind;
layout(location = 3) out vec2 UV;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	mat4 viewProj = camera.proj * camera.view;
	vec3 pos = gl_in[0].gl_Position.xyz;

	vec3 t0 = pos + v * (tv1.xyz - pos);
	vec3 t1 = tv1.xyz + v * (tv2.xyz - tv1.xyz);
	vec3 t2 = t0 + v * (t1 - t0);

	vec3 wbt = 0.5 * twd.xyz * tv2.w;

	float t = 0.5 * v + u - u * v;
	vec4 pos_t = vec4(t * (t2 + wbt) + (1.0 - t) * (t2 - wbt), 1.0);
	

	Position = viewProj * pos_t;
	UV = vec2(u, v);
	Normal = normalize(cross(twd.xyz, normalize(t1 - t0)));
	Wind = twd.xyz;

	gl_Position = Position;

	Position.w = twd.w;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}
