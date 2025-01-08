mode=Release # Release

if [[ "$OS" == *Windows* ]]; then
    cmake -S . -B build -DCMAKE_BUILD_TYPE=$mode -G "MinGW Makefiles"
    # Make ctgui static
    sed -i 's/ctgui SHARED/ctgui/' build/_deps/ctgui-src/src/CTGUI/CMakeLists.txt
    cmake --build build --config $mode

    # find build/_deps/*-build -name '*.dll' | xargs cp -t build
else
    cmake -S . -B build -DCMAKE_BUILD_TYPE=$mode
    # Make ctgui static
    sed -i '' 's/ctgui SHARED/ctgui/' build/_deps/ctgui-src/src/CTGUI/CMakeLists.txt
    cmake --build build --config $mode
fi
