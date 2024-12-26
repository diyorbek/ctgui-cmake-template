# CTGUI CMake Template

This repository is a template for setting up a [CTGUI](https://github.com/texus/CTGUI) project with CMake. The dependencies are loaded via `FetchContent`.

- Easy setup for CTGUI projects
- Cross-platform support

## Dependency versions

- **CTGUI**: 1.6
- **TGUI**: 1.6.0
- **CSFML**: 2.6.1
- **SFML**: 2.6.2

## Getting Started

1. **Clone the repository:**

```sh
git clone https://github.com/diyorbek/ctgui-cmake-template.git
cd ctgui-cmake-template
```

2. **Configure the project:**

```sh
cmake -S . -B build
```

3. **Build the project:**

```sh
cmake --build build
```

4. **Run the application:**

```sh
./build/ctgui_project
```

## Acknowledgements

- [https://github.com/texus/CTGUI](https://github.com/texus/CTGUI)
