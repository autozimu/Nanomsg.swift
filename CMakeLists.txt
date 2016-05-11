cmake_minimum_required(VERSION 3.5)
project(Nanomsg)

add_custom_target(${PROJECT_NAME}
        COMMAND swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
