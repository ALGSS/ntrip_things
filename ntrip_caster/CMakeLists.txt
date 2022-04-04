add_subdirectory(../thirdparties/wsocket)
add_subdirectory(../thirdparties/libfort)
add_subdirectory(../thirdparties/ulog)

if(WIN32)
    set(SRC src/ntripcaster.c src/base64.c src/proxy_cluster.c src/geohash.c src/tokens.c src/evwrap.c)

    # for windows platform's sqlite3. 20.5.14
    # change
    # set(LIBS wsocket fort ulog sqlite3)
    # to
    add_library(sqlite3_win STATIC ${CMAKE_SOURCE_DIR}/thirdparties/sqlite3_for_win/sqlite3.c
            ${CMAKE_SOURCE_DIR}/thirdparties/sqlite3_for_win/shell.c)
    target_include_directories(sqlite3_win PUBLIC ../thirdparties/sqlite3_for_win)
    include_directories(../thirdparties/sqlite3_for_win)

    set(LIBS wsocket fort ulog sqlite3_win)

else()
    set(SRC src/ntripcaster.c src/base64.c src/proxy_cluster.c src/geohash.c src/tokens.c)
    set(LIBS wsocket fort ulog sqlite3 ev m)
endif()

add_executable(ntrip_caster ${SRC})
target_link_libraries(ntrip_caster ${LIBS})