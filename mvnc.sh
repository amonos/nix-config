#!/bin/bash

java -version

export MAVEN_OPTS="--add-exports jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED --add-exports jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED"

mvn $@

RC=${PIPESTATUS[0]}
if [ $RC != 0 ]; then
	notify-send 'Maven compilation failed' -i dialog-error;
else
	notify-send 'Maven compilation finished successfully' -i dialog-information;
fi

exit $RC
