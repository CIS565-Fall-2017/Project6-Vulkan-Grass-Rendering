#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 tess1;
layout(location = 1) patch in vec4 tess2;
layout(location = 2) patch in vec4 tessup;
layout(location = 3) patch in vec4 tesswdir;

layout(location = 0) out vec4 pos;
layout(location = 1) out vec3 nor;
layout(location = 2) out vec3 winddir;
layout(location = 3) out vec2 UV;


void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = tess1.xyz;
	vec3 a = v0 + v * (v1 - v0);

	vec3 v2 = tess2.xyz;
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v*(b - a);

	vec3 t1 = tesswdir.xyz;
	vec3 wt1 = t1 * tess2.w / 2.0;
    vec3 c0 = c - wt1;
	vec3 c1 = c + wt1;
    vec3 t0 = normalize(b - a);
	nor = normalize(cross(t1, t0));
    UV = vec2(u, v);

	mat4 pview = camera.proj * camera.view;
	float t = u + 0.5*v -u*v;
    pos.xyz = (1.0 - t)*c0 + t*c1;
	pos = pview * vec4(pos.xyz, 1.0);
    gl_Position = pos;
}
