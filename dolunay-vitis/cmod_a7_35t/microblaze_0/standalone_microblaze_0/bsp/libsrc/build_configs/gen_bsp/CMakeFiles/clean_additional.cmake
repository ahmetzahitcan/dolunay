# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/azc/Belgeler/dolunay/dolunay-vitis/cmod_a7_35t/microblaze_0/standalone_microblaze_0/bsp/include/sleep.h"
  "/home/azc/Belgeler/dolunay/dolunay-vitis/cmod_a7_35t/microblaze_0/standalone_microblaze_0/bsp/include/xiltimer.h"
  "/home/azc/Belgeler/dolunay/dolunay-vitis/cmod_a7_35t/microblaze_0/standalone_microblaze_0/bsp/include/xtimer_config.h"
  "/home/azc/Belgeler/dolunay/dolunay-vitis/cmod_a7_35t/microblaze_0/standalone_microblaze_0/bsp/lib/libxiltimer.a"
  )
endif()
