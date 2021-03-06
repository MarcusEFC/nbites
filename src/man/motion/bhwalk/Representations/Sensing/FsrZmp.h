#pragma once

#include "Tools/Math/Vector2.h"
#include "Tools/Streams/AutoStreamable.h"

STREAMABLE(FsrZmpBH,
{,
  (Vector3BH<float>) cop, /**< center of pressure calculated over both feet relativ to robot origin */
  (Vector2BH<float>) copLeft, /**< center of pressure of left foot relative to left ankle without z coordinate */
  (Vector2BH<float>) copRight, /**< center of pressure of right foot relative to right ankle without z coordinate */
  (float) pressure, /**< total pressure on all sensors (cannot be zero, at least FLT_EPSILON) */
  (float) pressureLeft, /**< total pressure on the left foot  (cannot be zero, at least FLT_EPSILON)*/
  (float) pressureRight, /**< total pressure on the right foot (cannot be zero, at least FLT_EPSILON)*/
});
