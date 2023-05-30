
cmake_minimum_required(VERSION 2.8)
project(sqlite3 C)

option(WITH_SQLITE_DEBUG    "Build SQLite debug features" OFF)
option(WITH_SQLITE_MEMDEBUG "Build SQLite memory debug features" OFF)
option(WITH_SQLITE_RTREE    "Build R*Tree index extension" OFF)

find_package(Threads REQUIRED)

set(prefix ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir ${CMAKE_INSTALL_PREFIX}/lib)
set(includedir ${CMAKE_INSTALL_PREFIX}/include)
configure_file(sqlite3.pc.in sqlite3.pc @ONLY)

if(WITH_SQLITE_DEBUG)
    add_definitions(-DSQLITE_DEBUG)
endif()
if(WITH_SQLITE_MEMDEBUG)
    add_definitions(-DSQLITE_MEMDEBUG)
endif()
if(WITH_SQLITE_RTREE)
    add_definitions(-DSQLITE_ENABLE_RTREE)
endif()

include_directories(${CMAKE_SOURCE_DIR})
add_library(sqlite3 sqlite3.c)

add_executable(shell shell.c)
target_link_libraries(shell sqlite3 ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS})
set_target_properties(shell PROPERTIES OUTPUT_NAME sqlite3)

install(FILES sqlite3.h sqlite3ext.h DESTINATION include)
install(FILES ${CMAKE_BINARY_DIR}/sqlite3.pc DESTINATION lib/pkgconfig)
install(TARGETS sqlite3 DESTINATION lib)
install(TARGETS shell DESTINATION bin)
