import pyximport
pyximport.install()
import os
os.add_dll_directory(r"D:\ws\cython-poc\lib")

from vulkan_module import GLFWUtil, GLFWWindow, VulkanInstance, VkResultPy

util = GLFWUtil()
if not util.init():
    raise Exception("unable to initialize GLFW")

win_obj = GLFWWindow()

win_obj.create(800, 600, b"Cython GLFW")

vk_instance = VulkanInstance()
create_result = vk_instance.create()
enum_result = VkResultPy(int(create_result))
print(enum_result.name)

# win_obj.make_context_current()

while not win_obj.should_close():
    util.poll_events()

win_obj.destroy()
util.terminate()