mode=Debug # Release


if [[ "$OS" == *Windows* ]]; then
    cmake -S . -B build -DCMAKE_BUILD_TYPE=$mode -G "MinGW Makefiles"
    cmake --build build --config $mode

    # find build/_deps/*-build -name '*.dll' | xargs cp -t build
else
    cmake -S . -B build -DCMAKE_BUILD_TYPE=$mode
    cmake --build build --config $mode
fi