cmake_minimum_required(VERSION 3.14)
project(ctgui_project)

include(FetchContent)

set(SFML_VERSION "3.0.0")
# set(SFML_BUILD_AUDIO FALSE)
# set(SFML_BUILD_NETWORK FALSE)
# set(CSFML_BUILD_AUDIO FALSE)
# set(CSFML_BUILD_NETWORK FALSE)

# set(CTGUI_LINK_TGUI_STATICALLY TRUE)
# set(CSFML_LINK_SFML_STATICALLY TRUE)
set(TGUI_BACKEND SFML_GRAPHICS)
set(TGUI_BUILD_FRAMEWORK FALSE)
set(CTGUI_USE_CSFML_VERSION 3)
set(CTGUI_HAS_BACKEND_CSFML_GRAPHICS 1)
set(BUILD_SHARED_LIBS FALSE)

# Remove C++ stdlib flag for C compilation
if(APPLE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unused-command-line-argument")
endif()

# Fetch SFML
FetchContent_Declare(
    SFML
    GIT_REPOSITORY https://github.com/SFML/SFML.git
    GIT_TAG "${SFML_VERSION}"
)
FetchContent_MakeAvailable(SFML)

# Configure paths before fetching CSFML
set(SFML_ROOT "${sfml_SOURCE_DIR}")
set(SFML_DIR "${sfml_BINARY_DIR}")
set(SFML_PATH "${sfml_SOURCE_DIR}")
set(SFML_INCLUDE_DIR "${sfml_SOURCE_DIR}/include")
set(SFML_LIBRARY_DIR "${sfml_BINARY_DIR}/lib")
set(SFML_DEPENDENCIES_DIR "${sfml_SOURCE_DIR}/extlibs")

# Create SFML config file that CSFML can find. This overwrites the already existing one because the original one causes conflict.
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
    GIT_TAG "origin/master"
)
FetchContent_MakeAvailable(CSFML)

FetchContent_Declare(
    TGUI
    GIT_REPOSITORY https://github.com/texus/TGUI.git
    GIT_TAG v1.7.0
)
FetchContent_MakeAvailable(TGUI)

FetchContent_Declare(
    CTGUI
    GIT_REPOSITORY https://github.com/texus/CTGUI.git
    GIT_TAG 1.x
)

set(CSFML_INCLUDE_DIR ${CSFML_SOURCE_DIR}/include)
# set(CSFML_LIBRARY_DIR ${CSFML_BINARY_DIR}/lib)
FetchContent_MakeAvailable(CTGUI)

# Add executable with main.c in root directory
add_executable(${PROJECT_NAME} main.c)

# Link all CSFML libraries
target_link_libraries(${PROJECT_NAME} PRIVATE SFML::Graphics csfml-graphics ctgui)

# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE
    ${csfml_SOURCE_DIR}/include
)
