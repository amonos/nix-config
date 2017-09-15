#!/bin/bash

#JAVA_HOME=/usr/lib/jvm/java-6-jdk
#JAVA_HOME=/usr/lib/jvm/java-7-openjdk
#JAVA_HOME=/usr/lib/jvm/java-7-jdk
#JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#JAVA_HOME=/usr/lib/jvm/java-8-jdk

PATH=$JAVA_HOME/bin:$PATH

java -version
 
RESET="\e[0m"
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"
CYAN="\e[0;36m"
WHITE="\e[0;37m"
B_BLACK="\e[1;30m"
B_RED="\e[1;31m"
B_GREEN="\e[1;32m"
B_YELLOW="\e[1;33m"
B_BLUE="\e[1;34m"
B_MAGENTA="\e[1;35m"
B_CYAN="\e[1;36m"
B_WHITE="\e[1;37m"
 
PHASE1="$B_BLACK"
PHASE2="$B_BLUE"
PHASE_NAME="$B_CYAN"
TEST_PASS="$GREEN"
TEST_FAILURE="\e[43;1;33m"
#TEST_FAILURE="\e[7;40;1;33m"
TEST_ERROR="\e[41;1;37m"
 
# Don't run releases with this script else stdin becomes unavailable and is needed for GPG, etc.
[[ "$*" =~ release: ]] && exec mvn "$@"
 
[ -z "$NO_CLEAR" ] && tty -s <&1 
command mvn "$@" \
	| perl -pe "
s/(?<=\[INFO\] )(?=Building )/${B_MAGENTA}/;
s/(?<=\[INFO\] )(--- )(\S+?)(:\S+?:)(\S+?)( \()(.+?)(\).* ---)$/$PHASE1\1$PHASE2\2$PHASE1\3$PHASE2\4$PHASE1\5$PHASE_NAME\6$PHASE1\7/;
s/(\[WARNING\].*)$/${YELLOW}\1/;
s/(?<=\[INFO\] )(?=BUILD SUCCESS)/${B_GREEN}/;
s/(?<=\[INFO\] )(?=BUILD FAILURE)/${B_RED}/;
 
s/(?<=Tests run: )(\d{2,}|[1-9])/${TEST_PASS}\1${RESET}/;
 
s/(,\s+?Failures: )(\d{2,}|[1-9])/\1${TEST_FAILURE}\2${RESET}/;
s/^(?!Tests run: )(.+ <<< FAILURE!)$/${TEST_FAILURE}\1/;
s/^(.+?] {5})(?=FAILURE:)/\1${TEST_FAILURE}/;
s/^(Failed tests:)/${TEST_FAILURE}\1${RESET}/;
 
s/(,\s+?Errors: )(\d{2,}|[1-9])/\1${TEST_ERROR}\2${RESET}/;
s/^(?!Tests run: )(.+ <<< ERROR!)$/${TEST_ERROR}\1/;
s/^(.+?] {5})(?=ERROR:)/\1${TEST_ERROR}/;
s/^(Tests in error:)/${TEST_ERROR}\1${RESET}/;
 
s/^\[ERROR\]\s*$//;
s/^\[ERROR\] To see the full stack trace of the errors, re-run Maven with the -e switch.[\r\n]+$//;
s/^\[ERROR\] Re-run Maven using the -X switch to enable full debug logging.[\r\n]+$//;
s/^\[ERROR\] For more information about the errors and possible solutions, please read the following articles:[\r\n]+$//;
s/^\[ERROR\] -> .Help .*[\r\n]+$//;
s@^\[ERROR\] .Help .. http://cwiki.apache.org/.*[\r\n]+\$@@;
s/(\[ERROR\].*)$/${B_RED}\1/;
 
s/$/${RESET}/;
"
RC=${PIPESTATUS[0]}
if [ $RC != 0 ]; then
	notify-send 'Maven compilation failed' -i dialog-error;
else
	notify-send 'Maven compilation finished successfully' -i dialog-information;
fi

exit $RC
