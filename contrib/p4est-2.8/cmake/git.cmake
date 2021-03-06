# --- extract version from Git

set(PROJECT_VERSION 0.0.0)
find_program(GIT_VERSION_GEN NAMES git-version-gen
             PATHS ${CMAKE_SOURCE_DIR}/build-aux NO_DEFAULT_PATH)
if(GIT_VERSION_GEN)
  execute_process(COMMAND ${GIT_VERSION_GEN} .tarball_version
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    RESULT_VARIABLE _err
    OUTPUT_VARIABLE git_version
    OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()
if(_err EQUAL 0)
  if(git_version MATCHES
                 "^(0|[1-9][0-9]*)[.](0|[1-9][0-9]*)[.](0|[1-9][0-9]*)[.].*")
    set(_major "${CMAKE_MATCH_1}")
    set(_minor "${CMAKE_MATCH_2}")
    set(_patch "${CMAKE_MATCH_3}")
    set(PROJECT_VERSION ${_major}.${_minor}.${_patch}.999)
  elseif(git_version MATCHES
                 "^(0|[1-9][0-9]*)[.](0|[1-9][0-9]*)[.](0|[1-9][0-9]*)")
    set(_major "${CMAKE_MATCH_1}")
    set(_minor "${CMAKE_MATCH_2}")
    set(_patch "${CMAKE_MATCH_3}")
    set(PROJECT_VERSION ${_major}.${_minor}.${_patch})
  elseif(git_version MATCHES
                 "^(0|[1-9][0-9]*)[.](0|[1-9][0-9]*)")
    set(_major "${CMAKE_MATCH_1}")
    set(_minor "${CMAKE_MATCH_2}")
    set(PROJECT_VERSION ${_major}.${_minor})
  elseif(git_version MATCHES
                 "^(0|[1-9][0-9]*)")
    set(_major "${CMAKE_MATCH_1}")
    set(PROJECT_VERSION ${_major})
  endif()
endif()
