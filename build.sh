#!/bin/bash
VENDOR="
vendor/underscore.js
vendor/microevent.js
"

SRC="
src/Common.js
src/Stage.js
src/Compose.js
src/Camera.js
src/RenderTarget.js
src/ScreenGeometry.js
src/FragmentMaterial.js
src/DownsampleMaterial.js
src/RaytraceMaterial.js
"

TQUERY="
src/tQuery/World.js
src/tQuery/RenderQueue.js
src/tQuery/tQuery.js
"

SHADERS="
shaders/builtin.glsl.html
"

cat $VENDOR $SRC > build/ThreeRTT.js
cat $VENDOR $SRC $TQUERY > build/ThreeRTT-tquery.js
cat $SRC > build/ThreeRTT-core.js
cat $SRC $TQUERY > build/ThreeRTT-core-tquery.js
cat $SHADERS > build/ThreeRTT.glsl.html

curl --data-urlencode "js_code@build/ThreeRTT.js" 	\
	-d "output_format=text&output_info=compiled_code&compilation_level=SIMPLE_OPTIMIZATIONS" \
	http://closure-compiler.appspot.com/compile	\
	> build/ThreeRTT.min.js

curl --data-urlencode "js_code@build/ThreeRTT-tquery.js" 	\
	-d "output_format=text&output_info=compiled_code&compilation_level=SIMPLE_OPTIMIZATIONS" \
	http://closure-compiler.appspot.com/compile	\
	> build/ThreeRTT-tquery.min.js

curl --data-urlencode "js_code@build/ThreeRTT-core.js" 	\
	-d "output_format=text&output_info=compiled_code&compilation_level=SIMPLE_OPTIMIZATIONS" \
	http://closure-compiler.appspot.com/compile	\
	> build/ThreeRTT-core.min.js

curl --data-urlencode "js_code@build/ThreeRTT-core-tquery.js" 	\
	-d "output_format=text&output_info=compiled_code&compilation_level=SIMPLE_OPTIMIZATIONS" \
	http://closure-compiler.appspot.com/compile	\
	> build/ThreeRTT-core-tquery.min.js
