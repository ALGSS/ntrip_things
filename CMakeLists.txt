cmake_minimum_required(VERSION 3.6)
project(ntrip_things)
set(CMAKE_C_STANDARD 99)

# using git version
find_package(Git)
execute_process(COMMAND ${GIT_EXECUTABLE} describe --abbrev=6 --dirty --always --tags
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE  GIT_REPO_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(COMMAND ${GIT_EXECUTABLE} log -1 --format=%cd --date=short
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE  GIT_REPO_DATE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
file(WRITE ${PROJECT_BINARY_DIR}/repo_version.h
    "#define REPO_VERSION \"${GIT_REPO_VERSION}\"\n#define REPO_DATE \"${GIT_REPO_DATE}\"\n"
)
include_directories(${PROJECT_BINARY_DIR})

add_subdirectory(wsocket)
add_subdirectory(libfort)
add_subdirectory(ulog)

if(WIN32)
	set(SRC src/ntripcaster.c src/base64.c src/proxy_cluster.c src/geohash.c src/tokens.c src/evwrap.c)

	# for windows platform's sqlite3. 20.5.14
	# change
	# set(LIBS wsocket fort ulog sqlite3)
	# to
	add_library(sqlite3_win STATIC ${CMAKE_SOURCE_DIR}/sqlite3_for_win/sqlite3.c sqlite3_for_win/shell.c)
	target_include_directories(sqlite3_win PUBLIC sqlite3_for_win)
	include_directories(sqlite3_for_win)

	set(LIBS wsocket fort ulog sqlite3_win)

else()
	set(SRC src/ntripcaster.c src/base64.c src/proxy_cluster.c src/geohash.c src/tokens.c)
	set(LIBS wsocket fort ulog sqlite3 ev m)
endif()

add_executable(ntrip_caster ${SRC})
target_link_libraries(ntrip_caster ${LIBS})

# ntrip server
add_subdirectory(src_ntrip_server)
