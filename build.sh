mode=Debug # Release

if [[ "$OS" == *Windows* ]]; then
    cmake -S . -B build -DCMAKE_BUILD_TYPE=$mode -G "MinGW Makefiles"
    
    # Build CSFML static library by modifying below files
    cp -f support/Config.h build/_deps/csfml-src/include/SFML/Config.h
    cp -f support/Macros.cmake.in build/_deps/csfml-src/cmake/Macros.cmake 

    cmake --build build --config $mode

    # find build/_deps/*-build -name '*.dll' | xargs cp -t build
else
    cmake -S . -B build -DCMAKE_BUILD_TYPE=$mode
    cmake --build build --config $mode
fi
