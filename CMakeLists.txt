################################################################################
#
# MIT License
#
# Copyright (c) 2017 - 2022 Advanced Micro Devices, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
################################################################################
cmake_minimum_required( VERSION 2.8 )

project(rocm-recipes)

macro(get_directory_base OUTPUT_VAR DIR)
    if(CMAKE_VERSION VERSION_LESS "3.0")
        get_filename_component(${OUTPUT_VAR} ${DIR} PATH ${ARGN})
    else()
        get_filename_component(${OUTPUT_VAR} ${DIR} DIRECTORY ${ARGN})
    endif()
endmacro()

# file(GLOB RECIPES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} recipes/*)
function(install_recipes)
    file(GLOB RECIPES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} ${ARGN})

    foreach(RECIPE ${RECIPES})
        get_directory_base(RECIPE_DIR ${RECIPE})
        install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${RECIPE} DESTINATION etc/cget/recipes/)
        # message(STATUS "RECIPE: ${RECIPE}")
        # message(STATUS "RECIPE_DIR: ${RECIPE_DIR}")
    endforeach()
endfunction()

install_recipes(recipes/*)
if(DEFINED ENV{ROCM_USE_INTERNAL_DEPS})
install_recipes(internal/*)
endif()

if(DEFINED ENV{ROCM_USE_MIOPEN_DEPS})
install_recipes(miopen/*)
endif()

install(DIRECTORY cmake DESTINATION share/)

enable_testing()
