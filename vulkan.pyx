cimport c_layer

from libc.stdint cimport uint32_t 
from enum import IntEnum

cdef class GLFWWindow:
    cdef c_layer.GLFWwindow* window

    def create(self, width, height, title):
        self.window = c_layer.glfwCreateWindow(width, height, title, NULL, NULL)

    def should_close(self):
        return c_layer.glfwWindowShouldClose(self.window) == 1

    def destroy(self):
        c_layer.glfwDestroyWindow(self.window)
    
    def make_context_current(self):
        c_layer.glfwMakeContextCurrent(self.window)
        

cdef class GLFWUtil:

    def init(self):
        return c_layer.glfwInit()

    def poll_events(self):
        c_layer.glfwPollEvents()

    def terminate(self):
        c_layer.glfwTerminate()


cdef class VulkanInstance:    

    def create(self):   
        cdef c_layer.VkInstance vk_instance
        cdef c_layer.VkAllocationCallbacks* allocation_callbacks
        
        cdef c_layer.VkApplicationInfo app_info = c_layer.VkApplicationInfo()
        app_info.sType = c_layer.VkStructureType.VK_STRUCTURE_TYPE_APPLICATION_INFO
        app_info.pApplicationName = "Hello, World!"
        app_info.applicationVersion = c_layer.VK_MAKE_API_VERSION(1, 0, 0, 0)
        app_info.pNext = NULL
        app_info.pEngineName = "No Engine"
        app_info.engineVersion = c_layer.VK_MAKE_API_VERSION(1, 0, 0, 0)
        app_info.apiVersion = c_layer.VK_MAKE_API_VERSION(0, 1, 2, 0)

        cdef c_layer.VkInstanceCreateInfo create_info = c_layer.VkInstanceCreateInfo()
        create_info.sType = c_layer.VkStructureType.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO
        create_info.pApplicationInfo = &app_info

        cdef uint32_t enable_extension_count
        cdef const char** enabled_extensions = c_layer.glfwGetRequiredInstanceExtensions(&enable_extension_count)

        create_info.enabledExtensionCount = enable_extension_count
        create_info.ppEnabledExtensionNames = enabled_extensions
        create_info.enabledLayerCount = 0

        # result = c_layer.vkCreateInstance(&create_info, NULL, &vk_instance)
        # return result
        cdef c_layer.VkResult result = c_layer.vkCreateInstance(&create_info, NULL, &vk_instance)
        return <int>result


cdef class VulkanSurface:
    cdef c_layer.VkSurfaceKHR vk_surface  
    # VulkanInstance instance  
    # GLFWWindow window

    # def set(self, VulkanInstance instance, GLFWWindow window):
    #     self.instance = instance
    #     self.window = window

    # def create(self): 
    #     cdef c_layer.VkInstance instance = self.instance.get()
    #     cdef c_layer.GLFWwindow* window = self.window.get()

    #     c_layer.glfwCreateWindowSurface(instance, window, NULL, &self.vk_surface)

class VkResultPy(IntEnum):
    VK_SUCCESS = c_layer.VK_SUCCESS
    VK_NOT_READY = c_layer.VK_NOT_READY
    VK_TIMEOUT = c_layer.VK_TIMEOUT
    VK_EVENT_SET = c_layer.VK_EVENT_SET
    VK_EVENT_RESET = c_layer.VK_EVENT_RESET
    VK_INCOMPLETE = c_layer.VK_INCOMPLETE
    VK_ERROR_OUT_OF_HOST_MEMORY = c_layer.VK_ERROR_OUT_OF_HOST_MEMORY
    VK_ERROR_OUT_OF_DEVICE_MEMORY = c_layer.VK_ERROR_OUT_OF_DEVICE_MEMORY
    VK_ERROR_INITIALIZATION_FAILED = c_layer.VK_ERROR_INITIALIZATION_FAILED
    VK_ERROR_DEVICE_LOST = c_layer.VK_ERROR_DEVICE_LOST
    VK_ERROR_MEMORY_MAP_FAILED = c_layer.VK_ERROR_MEMORY_MAP_FAILED
    VK_ERROR_LAYER_NOT_PRESENT = c_layer.VK_ERROR_LAYER_NOT_PRESENT
    VK_ERROR_EXTENSION_NOT_PRESENT = c_layer.VK_ERROR_EXTENSION_NOT_PRESENT
    VK_ERROR_FEATURE_NOT_PRESENT = c_layer.VK_ERROR_FEATURE_NOT_PRESENT
    VK_ERROR_INCOMPATIBLE_DRIVER = c_layer.VK_ERROR_INCOMPATIBLE_DRIVER
    VK_ERROR_TOO_MANY_OBJECTS = c_layer.VK_ERROR_TOO_MANY_OBJECTS
    VK_ERROR_FORMAT_NOT_SUPPORTED = c_layer.VK_ERROR_FORMAT_NOT_SUPPORTED
    VK_ERROR_FRAGMENTED_POOL = c_layer.VK_ERROR_FRAGMENTED_POOL
    VK_ERROR_UNKNOWN = c_layer.VK_ERROR_UNKNOWN
    VK_ERROR_OUT_OF_POOL_MEMORY = c_layer.VK_ERROR_OUT_OF_POOL_MEMORY
    VK_ERROR_INVALID_EXTERNAL_HANDLE = c_layer.VK_ERROR_INVALID_EXTERNAL_HANDLE
    VK_ERROR_FRAGMENTATION = c_layer.VK_ERROR_FRAGMENTATION
    VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS = c_layer.VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS
    VK_PIPELINE_COMPILE_REQUIRED = c_layer.VK_PIPELINE_COMPILE_REQUIRED
    VK_ERROR_NOT_PERMITTED = c_layer.VK_ERROR_NOT_PERMITTED
    VK_ERROR_SURFACE_LOST_KHR = c_layer.VK_ERROR_SURFACE_LOST_KHR
    VK_ERROR_NATIVE_WINDOW_IN_USE_KHR = c_layer.VK_ERROR_NATIVE_WINDOW_IN_USE_KHR
    VK_SUBOPTIMAL_KHR = c_layer.VK_SUBOPTIMAL_KHR
    VK_ERROR_OUT_OF_DATE_KHR = c_layer.VK_ERROR_OUT_OF_DATE_KHR
    VK_ERROR_INCOMPATIBLE_DISPLAY_KHR = c_layer.VK_ERROR_INCOMPATIBLE_DISPLAY_KHR
    VK_ERROR_VALIDATION_FAILED_EXT = c_layer.VK_ERROR_VALIDATION_FAILED_EXT
    VK_ERROR_INVALID_SHADER_NV = c_layer.VK_ERROR_INVALID_SHADER_NV
    VK_ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR = c_layer.VK_ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR
    VK_ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR = c_layer.VK_ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR
    VK_ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR = c_layer.VK_ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR
    VK_ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR = c_layer.VK_ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR
    VK_ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR = c_layer.VK_ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR
    VK_ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR = c_layer.VK_ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR
    VK_ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT = c_layer.VK_ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT
    VK_ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT = c_layer.VK_ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT
    VK_THREAD_IDLE_KHR = c_layer.VK_THREAD_IDLE_KHR
    VK_THREAD_DONE_KHR = c_layer.VK_THREAD_DONE_KHR
    VK_OPERATION_DEFERRED_KHR = c_layer.VK_OPERATION_DEFERRED_KHR
    VK_OPERATION_NOT_DEFERRED_KHR = c_layer.VK_OPERATION_NOT_DEFERRED_KHR
    VK_ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR = c_layer.VK_ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR
    VK_ERROR_COMPRESSION_EXHAUSTED_EXT = c_layer.VK_ERROR_COMPRESSION_EXHAUSTED_EXT
    VK_INCOMPATIBLE_SHADER_BINARY_EXT = c_layer.VK_INCOMPATIBLE_SHADER_BINARY_EXT
    VK_PIPELINE_BINARY_MISSING_KHR = c_layer.VK_PIPELINE_BINARY_MISSING_KHR
    VK_ERROR_NOT_ENOUGH_SPACE_KHR = c_layer.VK_ERROR_NOT_ENOUGH_SPACE_KHR
    VK_ERROR_OUT_OF_POOL_MEMORY_KHR = c_layer.VK_ERROR_OUT_OF_POOL_MEMORY_KHR
    VK_ERROR_INVALID_EXTERNAL_HANDLE_KHR = c_layer.VK_ERROR_INVALID_EXTERNAL_HANDLE_KHR
    VK_ERROR_FRAGMENTATION_EXT = c_layer.VK_ERROR_FRAGMENTATION_EXT
    VK_ERROR_NOT_PERMITTED_EXT = c_layer.VK_ERROR_NOT_PERMITTED_EXT
    VK_ERROR_NOT_PERMITTED_KHR = c_layer.VK_ERROR_NOT_PERMITTED_KHR
    VK_ERROR_INVALID_DEVICE_ADDRESS_EXT = c_layer.VK_ERROR_INVALID_DEVICE_ADDRESS_EXT
    VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS_KHR = c_layer.VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS_KHR
    VK_PIPELINE_COMPILE_REQUIRED_EXT = c_layer.VK_PIPELINE_COMPILE_REQUIRED_EXT
    VK_ERROR_PIPELINE_COMPILE_REQUIRED_EXT = c_layer.VK_ERROR_PIPELINE_COMPILE_REQUIRED_EXT
    VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT = c_layer.VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT
