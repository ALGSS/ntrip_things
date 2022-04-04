# Determine project compiler.
if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    set(IS_MSVC TRUE)
endif()

if(IS_MSVC)
    add_definitions(-O3)
    add_definitions(-DWINDOWSVERSION)
    add_definitions(-DNDEBUG)
    add_definitions(-Wall)
    set(CMAKE_CXX_STANDARD 14)

    # for getopt_library target
    add_compile_options(/wd4668 /wd4820 /wd4273 /wd4131 /wd4242)
    # add static libray based sources file.
    add_library(getopt_library STATIC win_include/getopt.c)
    # include referenced header files dir.
    target_include_directories(getopt_library PUBLIC win_include)

    # disable warnnings
    # this will effect the following exe or libs not up target project
    add_compile_options(/wd4820 /wd668 /wd4005 /wd4996 /wd4245 /wd4242 /wd4244 /wd4068 /wd4133 /wd4744 /wd4100)
    add_compile_options(/wd4244 /wd4267 /wd4668 /wd4459 /wd4255 /wd4456 /wd4706 /wd5045 /wd4100 )

    # link the static proejcet and ws2_32
    link_libraries(getopt_library ws2_32.lib)
endif()

# create executable file
add_executable(ntripserver ntripserver.c)


