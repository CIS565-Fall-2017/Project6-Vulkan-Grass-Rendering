#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 v1;
layout(location = 1) patch in vec4 v2;
layout(location = 2) patch in vec4 up;
layout(location = 3) patch in vec4 bladeBit;

layout(location = 0) out vec4 Position;
layout(location = 1) out vec4 Normal;
layout(location = 2) out vec4 bladeBit_out;
void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	//v0.w holds orientation, v1.w holds height, v2.w holds width, and up.w holds the stiffness coefficient
	vec3 t1 = bladeBit.xyz; 
	vec3 a = gl_in[0].gl_Position.xyz + v*(v1.xyz -  gl_in[0].gl_Position.xyz);
	vec3 b = v1.xyz + v*(v2.xyz - v1.xyz);
	vec3 c = a + v*(b - a);	
	vec3 wt1 = t1 * v2.w * 0.5;
	vec3 c0 = c - wt1;
	vec3 c1 = c + wt1;

    vec3 t0 = normalize(b - a);
	Normal = vec4(normalize(cross(t1, t0)),v);
	bladeBit_out=bladeBit;

	float t = u + 0.5*v-u*v  ;
    Position.xyz = (1.0 - t)*c0 + t*c1;
 	Position = camera.proj * camera.view * vec4(Position.xyz, 1.0);
    gl_Position = Position;
}
