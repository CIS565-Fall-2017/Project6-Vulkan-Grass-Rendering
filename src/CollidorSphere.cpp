#include <iostream>

#define GLM_FORCE_RADIANS
// Use Vulkan depth range of 0.0 to 1.0 instead of OpenGL
#define GLM_FORCE_DEPTH_ZERO_TO_ONE

#include "CollidorSphere.h"
#include "BufferUtils.h"

CollidorSphere::CollidorSphere(Device* device, glm::vec3 centroid_pos, float radius) : device(device) {
	
	collidorSphereObject.collidorSphereInfo = glm::vec4(centroid_pos, radius);


	BufferUtils::CreateBuffer(device, sizeof(CollidorSphereObject), VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT, buffer, bufferMemory);
	vkMapMemory(device->GetVkDevice(), bufferMemory, 0, sizeof(CollidorSphereObject), 0, &mappedData);
	memcpy(mappedData, &collidorSphereObject, sizeof(CollidorSphereObject));
}

VkBuffer CollidorSphere::GetBuffer() const {
	return buffer;
}

void CollidorSphere::UpdatePosition(glm::vec3 moveDir) {

	glm::vec4 originInfo = collidorSphereObject.collidorSphereInfo;
	glm::vec3 originPos = glm::vec3(originInfo);

	float moveSpeed = 0.2f;
	
	glm::vec3 newPos = originPos + moveSpeed * moveDir;
	newPos.x = glm::clamp(newPos.x, -25.0f, 25.0f);
	newPos.z = glm::clamp(newPos.z, -25.0f, 25.0f);

	collidorSphereObject.collidorSphereInfo = glm::vec4(newPos, originInfo.w);

	memcpy(mappedData, &collidorSphereObject, sizeof(CollidorSphereObject));
}

CollidorSphere::~CollidorSphere() {
	vkUnmapMemory(device->GetVkDevice(), bufferMemory);
	vkDestroyBuffer(device->GetVkDevice(), buffer, nullptr);
	vkFreeMemory(device->GetVkDevice(), bufferMemory, nullptr);
}
