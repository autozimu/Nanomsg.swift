cmake_minimum_required(VERSION 3.5)
project(Nanomsg)

add_custom_target(Nanomsg
        COMMAND swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
