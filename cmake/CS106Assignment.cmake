include_guard(GLOBAL)

function(cs106_configure_assignment target)
    set(_cs106_default_root "$ENV{LOCALAPPDATA}/cs106")
    if(EXISTS "${_cs106_default_root}/lib/libcs106.a")
        set(_cs106_root "${_cs106_default_root}")
    elseif(DEFINED ENV{CS106B_ROOT} AND EXISTS "$ENV{CS106B_ROOT}/lib/libcs106.a")
        set(_cs106_root "$ENV{CS106B_ROOT}")
    else()
        set(_cs106_root "${_cs106_default_root}")
    endif()
    set(CS106_ROOT "${_cs106_root}" CACHE PATH
        "Stanford CS106 library installation directory")
    set(CS106_INCLUDE_DIR "${CS106_ROOT}/include")
    set(CS106_LIBRARY "${CS106_ROOT}/lib/libcs106.a")
    set(CS106_VERSION_FILE "${CS106_ROOT}/lib/version2021.1")

    if(NOT EXISTS "${CS106_LIBRARY}")
        message(FATAL_ERROR
            "Cannot find Stanford CS106 library: ${CS106_LIBRARY}\n"
            "Install the CS106 package, or configure with -DCS106_ROOT=<directory>.")
    endif()
    if(NOT EXISTS "${CS106_VERSION_FILE}")
        message(FATAL_ERROR
            "Cannot find CS106 library version 2021.1: ${CS106_VERSION_FILE}\n"
            "Install the matching CS106 package, or configure with -DCS106_ROOT=<directory>.")
    endif()

    find_package(Qt6 6.0 REQUIRED COMPONENTS Core Gui Widgets Network)
    find_package(Threads REQUIRED)

    file(GLOB_RECURSE assignment_sources CONFIGURE_DEPENDS
        "${PROJECT_SOURCE_DIR}/*.cpp")
    list(FILTER assignment_sources EXCLUDE REGEX "/(build|out)/")

    # 在此公共函数中显式完成 Qt 收尾，避免 Qt 的延迟收尾离开函数作用域后
    # 丢失其 Windows 清单与插件模板路径。
    qt_add_executable(${target} WIN32 MANUAL_FINALIZATION ${assignment_sources})
    target_include_directories(${target} PRIVATE
        "${PROJECT_SOURCE_DIR}"
        "${CS106_INCLUDE_DIR}"
    )

    # 与课程提供的 qmake 配置保持一致：libcs106 提供入口点，
    # 作业框架中的 main() 会被重命名为 studentMain()。
    target_compile_definitions(${target} PRIVATE
        main=qMain
        qMain=studentMain
    )
    target_compile_options(${target} PRIVATE
        -Wall
        -Wextra
        -Werror=return-type
        -Werror=uninitialized
        -Wunused-parameter
        -Wmissing-field-initializers
        -Wno-old-style-cast
        -Wno-sign-compare
        -Wno-sign-conversion
        -Wno-unused-const-variable
    )
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        target_compile_options(${target} PRIVATE -Wlogical-op)
    endif()

    target_link_libraries(${target} PRIVATE
        "${CS106_LIBRARY}"
        Threads::Threads
        Qt6::Core
        Qt6::Gui
        Qt6::Widgets
        Qt6::Network
    )
    qt_finalize_executable(${target})
endfunction()



