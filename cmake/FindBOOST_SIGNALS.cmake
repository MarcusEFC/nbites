
##
# Includes
##

INCLUDE( ${CMAKE_MODULE_PATH}/base_definitions.cmake )

##
# Clear variables/caches
##

SET( BOOST_SIGNALS_DEFINITIONS "" )
SET( BOOST_SIGNALS_INCLUDE_DIR "BOOST_SIGNALS_INCLUDE_DIR-NOTFOUND" CACHE FILEPATH "Cleared." FORCE)
SET( BOOST_SIGNALS_LIBRARIES "BOOST_SIGNALS_LIBRARIES-NOTFOUND" CACHE FILEPATH "Cleared." FORCE)


##
# Defined package variable
##

IF( WIN32 )
  IF( OE_CROSS_BUILD )
    SET( BOOST_SIGNALS_INCLUDE_DIR ${AL_DIR}/crosstoolchain/staging/i486-linux/usr/include )
    SET( BOOST_SIGNALS_LIBRARIES ${AL_DIR}/crosstoolchain/staging/i486-linux/usr/lib/libboost_signals-mt.so )
  ELSE( OE_CROSS_BUILD )
    SET( BOOST_SIGNALS_INCLUDE_DIR /usr/include/boost )
    SET( BOOST_SIGNALS_LIBRARIES /bin/cygboost_signals-gcc-mt-1_33_1.dll )
  ENDIF( OE_CROSS_BUILD )
ELSE( WIN32 )
  IF( OE_CROSS_BUILD )
    SET( BOOST_SIGNALS_INCLUDE_DIR ${AL_DIR}/crosstoolchain/staging/i486-linux/usr/include )
    SET( BOOST_SIGNALS_LIBRARIES ${AL_DIR}/crosstoolchain/staging/i486-linux/usr/lib/libboost_signals-mt.so )
  ELSE( OE_CROSS_BUILD )
    IF ( APPLE )
      SET( BOOST_SIGNALS_INCLUDE_DIR /sw/include/ )
      SET( BOOST_SIGNALS_LIBRARIES /sw/lib/libboost_signals.dylib )
    ELSE ( APPLE )
      SET( BOOST_SIGNALS_INCLUDE_DIR /usr/include/ )
      SET( BOOST_SIGNALS_LIBRARIES /usr/lib/libboost_signals.so )
    ENDIF( APPLE )
  ENDIF( OE_CROSS_BUILD )
ENDIF( WIN32 )



IF( BOOST_SIGNALS_INCLUDE_DIR AND BOOST_SIGNALS_LIBRARIES )
  IF ( EXISTS BOOST_SIGNALS_INCLUDE_DIR AND EXISTS BOOST_SIGNALS_LIBRARIES )
    SET( BOOST_SIGNALS_FOUND TRUE )
  ENDIF ( EXISTS BOOST_SIGNALS_INCLUDE_DIR AND EXISTS BOOST_SIGNALS_LIBRARIES )
ENDIF( BOOST_SIGNALS_INCLUDE_DIR AND BOOST_SIGNALS_LIBRARIES )

IF( NOT BOOST_SIGNALS_FOUND AND BOOST_SIGNALS_FIND_REQUIRED )
  IF( NOT BOOST_SIGNALS_INCLUDE_DIR OR NOT EXISTS ${BOOST_SIGNALS_INCLUDE_DIR} )
    MESSAGE( STATUS "Required include not found" )
    MESSAGE( FATAL_ERROR "Could not find BOOST_SIGNALS include!" )
  ENDIF( NOT BOOST_SIGNALS_INCLUDE_DIR OR NOT EXISTS ${BOOST_SIGNALS_INCLUDE_DIR} )
  IF( NOT BOOST_SIGNALS_LIBRARIES OR NOT EXISTS ${BOOST_SIGNALS_LIBRARIES} )
    MESSAGE( STATUS "Required libraries not found" )
    MESSAGE( FATAL_ERROR "Could not find BOOST_SIGNALS libraries!" )
  ENDIF( NOT BOOST_SIGNALS_LIBRARIES OR NOT EXISTS ${BOOST_SIGNALS_LIBRARIES} )
ENDIF( NOT BOOST_SIGNALS_FOUND AND BOOST_SIGNALS_FIND_REQUIRED )

# Finally, display informations if not in quiet mode
IF( NOT BOOST_SIGNALS_FIND_QUIETLY )
  MESSAGE( STATUS "BOOST_SIGNALS found " )
  MESSAGE( STATUS "  includes   : ${BOOST_SIGNALS_INCLUDE_DIR}" )
  MESSAGE( STATUS "  libraries  : ${BOOST_SIGNALS_LIBRARIES}" )
  MESSAGE( STATUS "  definitions: ${BOOST_SIGNALS_DEFINITIONS}" )
ENDIF( NOT BOOST_SIGNALS_FIND_QUIETLY )



MARK_AS_ADVANCED(
  BOOST_SIGNALS_DEFINITIONS
  BOOST_SIGNALS_INCLUDE_DIR
  BOOST_SIGNALS_LIBRARIES
)
