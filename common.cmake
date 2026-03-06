cmake_minimum_required(VERSION 3.13)

# --- Store workspace root directory (directory of this file) ---
set(WORKSPACE_ROOT ${CMAKE_CURRENT_LIST_DIR})

# --- Disable newlib nano ---
set(PICO_USE_NEWLIB_NANO OFF)

# --- Pico SDK ---
set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
include(${PICO_SDK_PATH}/external/pico_sdk_import.cmake)

# --- FreeRTOS Kernel ---
set(FREERTOS_KERNEL_PATH $ENV{FREERTOS_KERNEL_PATH})
include(${FREERTOS_KERNEL_PATH}/portable/ThirdParty/GCC/RP2040/FreeRTOS_Kernel_import.cmake)

# --- Common compile options ---
add_library(common_compile_options INTERFACE)

target_compile_options(common_compile_options INTERFACE
    -Wall
    -Wno-format
    -Wno-unused-function
    -Werror=implicit-function-declaration#PRIVATE aways ERROR
)

if (CMAKE_C_COMPILER_ID STREQUAL "GNU")
    target_compile_options(common_compile_options INTERFACE
        -Wno-maybe-uninitialized
    )
endif()

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

#function that makes: add_subdirectory(${WORKSPACE_ROOT}/libs/LIB_NAME ${CMAKE_BINARY_DIR}/libs/LIB_NAME)
function(workspace_add_lib LIB_NAME)
    set(LIB_SOURCE_DIR ${WORKSPACE_ROOT}/libs/${LIB_NAME})

    if(NOT EXISTS ${LIB_SOURCE_DIR}/CMakeLists.txt)
        message(FATAL_ERROR "Library '${LIB_NAME}' not found in ${WORKSPACE_ROOT}/libs")
    endif()

    set(LIB_BINARY_DIR ${CMAKE_BINARY_DIR}/libs/${LIB_NAME})

    if(NOT TARGET ${LIB_NAME})
        add_subdirectory(${LIB_SOURCE_DIR} ${LIB_BINARY_DIR})
    endif()
endfunction()