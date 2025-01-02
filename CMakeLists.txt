cmake_minimum_required(VERSION 3.14)
project(ctgui_project)

include(FetchContent)

# Global settings
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build static libraries") # Build all libraries as static
set(SFML_VERSION "2.6.2")
set(TGUI_BACKEND SFML_GRAPHICS)
set(TGUI_BUILD_FRAMEWORK FALSE)
set(CTGUI_HAS_BACKEND_CSFML_GRAPHICS 1)

# Remove C++ stdlib flag for C compilation
if(APPLE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-command-line-argument")
endif()

# Add necessary preprocessor definitions for static linking
add_definitions(-DSFML_STATIC -DTGUI_STATIC)

# Fetch SFML
FetchContent_Declare(
    SFML
    GIT_REPOSITORY https://github.com/SFML/SFML.git
    GIT_TAG "${SFML_VERSION}"
)
set(SFML_BUILD_SHARED_LIBS OFF CACHE BOOL "Build SFML as static library")
FetchContent_MakeAvailable(SFML)

# Configure paths for SFML
set(SFML_ROOT "${sfml_SOURCE_DIR}")
set(SFML_DIR "${sfml_BINARY_DIR}")
set(SFML_PATH "${sfml_SOURCE_DIR}")
set(SFML_INCLUDE_DIR "${sfml_SOURCE_DIR}/include")
set(SFML_LIBRARY_DIR "${sfml_BINARY_DIR}/lib")
set(SFML_DEPENDENCIES_DIR "${sfml_SOURCE_DIR}/extlibs")

# Create SFML config file for CSFML
file(WRITE "${sfml_BINARY_DIR}/SFMLConfig.cmake" 
"set(SFML_VERSION ${SFML_VERSION})
set(SFML_INCLUDE_DIR \"${SFML_INCLUDE_DIR}\")
set(SFML_LIBRARY_DIR \"${SFML_LIBRARY_DIR}\")
set(SFML_DEPENDENCIES_DIR \"${SFML_DEPENDENCIES_DIR}\")
set(SFML_FOUND TRUE)
")

# Fetch CSFML
FetchContent_Declare(
    CSFML
    GIT_REPOSITORY https://github.com/SFML/CSFML.git
    GIT_TAG "2.6.1"
)
set(SFML_STATIC_LIBRARIES ON CACHE BOOL "Use static SFML libraries")
FetchContent_MakeAvailable(CSFML)

# Fetch TGUI
FetchContent_Declare(
    TGUI
    GIT_REPOSITORY https://github.com/texus/TGUI.git
    GIT_TAG "v1.6.0"
)
set(TGUI_BUILD_SHARED_LIBS OFF CACHE BOOL "Build TGUI as static library")
FetchContent_MakeAvailable(TGUI)

# Fetch CTGUI
FetchContent_Declare(
    CTGUI
    GIT_REPOSITORY https://github.com/texus/CTGUI.git
    GIT_TAG "v1.6"
)
set(CSFML_INCLUDE_DIR ${CSFML_SOURCE_DIR}/include)
# set(CSFML_LIBRARY_DIR ${CSFML_BINARY_DIR}/lib)
FetchContent_MakeAvailable(CTGUI)

# Include directories
include_directories(
    ${CSFML_SOURCE_DIR}/include
    ${TGUI_SOURCE_DIR}/include
    ${CTGUI_SOURCE_DIR}/include
    ${SFML_INCLUDE_DIR}
)

# Add library target
add_executable(${PROJECT_NAME} main.c)

# Link all static libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    ctgui
    tgui
    csfml-graphics
    csfml-window
    csfml-system
    sfml-graphics
    sfml-window
    sfml-system
    # openal32
    # winmm
    # gdi32
)

# Include directories for the target
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CSFML_INCLUDE_DIR}
    ${TGUI_INCLUDE_DIR}
    ${SFML_INCLUDE_DIR}
)
