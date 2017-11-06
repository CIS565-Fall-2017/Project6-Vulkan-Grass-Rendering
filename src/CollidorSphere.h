#pragma once

#include <glm/glm.hpp>
#include "Device.h"

struct CollidorSphereObject {
	glm::vec4 collidorSphereInfo;
};

class CollidorSphere {
private:
	Device* device;

	CollidorSphereObject collidorSphereObject;

	VkBuffer buffer;
	VkDeviceMemory bufferMemory;

	void* mappedData;


public:
	CollidorSphere(Device* device, glm::vec3 centroid_pos, float radius);
	~CollidorSphere();

	VkBuffer GetBuffer() const;

	void UpdatePosition(glm::vec3 moveDir);
};
