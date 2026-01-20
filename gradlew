#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  Gradle startup script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar


# Determine the Java version to ensure that the wrapper works with
# Java versions 9+.
JAVA_VERSION=$("$JAVA_HOME/bin/java" -version 2>&1 | head -n 1 | sed 's/^.*version "\([0-9]*\)\(\.[0-9]*\)\{0,1\}\(.*\)*$/\1\2/; 1q')
JAVA_VERSION_MAJOR="${JAVA_VERSION%%.*}"

if [ "$JAVA_VERSION_MAJOR" -lt "8" ]; then
    die "ERROR: Java 8 or later is required to run Gradle. Your Java version is $JAVA_VERSION."
fi

# For Cygwin, ensure paths are in UNIX format before anything is touched.
if $cygwin ; then
    [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

if [ -z "$JAVA_HOME" ] ; then
    JAVACMD="java"
else
    JAVACMD="$JAVA_HOME/bin/java"
fi

# Increase the maximum file descriptors if we can.
if [ "$os400" = false ] ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ $? -eq 0 ] ; then
        if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ] ; then
            MAX_FD="$MAX_FD_LIMIT"
        fi
        ulimit -n $MAX_FD
        if [ $? -ne 0 ] ; then
            warn "Could not set maximum file descriptor limit: $MAX_FD"
        fi
    else
        warn "Could not query maximum file descriptor limit: $MAX_FD_LIMIT"
    fi
fi

# For Darwin, add options to specify how the application appears in the dock
if $darwin ; then
    GRADLE_OPTS="$GRADLE_OPTS \"-Xdock:name=$APP_NAME\" \"-Xdock:icon=$APP_HOME/media/gradle.icns\""
fi

# For Cygwin or MSYS, switch paths to Windows format before running java
if $cygwin || $msys ; then
    APP_HOME=`cygpath --path --mixed "$APP_HOME"`
    CLASSPATH=`cygpath --path --mixed "$CLASSPATH"`
    
    JAVACMD=`cygpath --unix "$JAVACMD"`

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=`find -L / -maxdepth 1 -mindepth 1 -type d 2>/dev/null`
    SEP=""
    for dir in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$SEP$dir"
        SEP="|"
    done
    OURCYGPATTERN="(^($ROOTDIRS))"
    # Add a user-defined pattern to the cygpath arguments
    if [ "$GRADLE_CYGPATTERN" != "" ] ; then
        OURCYGPATTERN="$OURCYGPATTERN|($GRADLE_CYGPATTERN)"
    fi
    # Now convert the arguments via cygpath
    for i do
        # Skip arguments that are meant for sh and not java
        if [ "$i" = '-exec' ] ; then
            shift
            break
        fi
        arg=`echo "$1" | sed "s|$OURCYGPATTERN||g"`
        if echo "$arg" | grep -q '^-' ; then
            # Skip options
            shift
            continue
        fi
        # Process non-option arguments.
        if [ -z "$result" ] ; then
            result="$arg"
        else
            result="$result"\
"
$arg"
        fi
        shift
    done
    result=`echo "$result" | sed "s|$OURCYGPATTERN||g"`
    # Restore arguments that were meant for sh
    if [ -n "$sh_args" ] ; then
        result="$result"\
"
$sh_args"
    fi
    # Print the result
    echo "$result"
fi

# Collect all arguments for the java command;
#   * $DEFAULT_JVM_OPTS, $JAVA_OPTS, and $GRADLE_OPTS can contain fragments of
#     shell script including quotes and variable substitutions, so put them in
#     double quotes to make sure that they get re-expanded; and
#   * put everything else in single quotes, so that it's not re-expanded.
set -- \
        "-Dorg.gradle.appname=$APP_BASE_NAME" \
        -classpath "$CLASSPATH" \
        org.gradle.wrapper.GradleWrapperMain \
        "$@"

# Stop when "xargs" is not available.
if ! command -v xargs >/dev/null 2>&1
then
    die "xargs is not available"
fi

# Use "xargs" to parse quoted args.
#
# With -n1 it outputs one arg per line, with the quotes and backslashes removed.
#
# In Bash you could simply go:
#
#   readarray ARGS < <( xargs -n1 <<<"$var" ) &&
#   set -- "${ARGS[@]}" "$@"
#
# but POSIX shell has neither arrays nor command substitution, so instead we
# post-process each arg (as a line of input to sed) to strip quotes and
# backslashes, then eval the whole thing.
#
# The argument to sed is a regex that matches a quoted arg, with capture groups
# for the string between the quotes and any escaped characters.
#
# The outer loop processes each arg, the inner loop processes each character in
# the arg, using sed to strip quotes and backslashes.
#
# The sed command is:
#   s/'"'/'\\''/g          # escape single quotes
#   s/^'//                 # remove opening quote
#   s/'$//                 # remove closing quote
#   s/\\\\\\\/\\/g         # replace escaped backslashes with single backslashes
#   s/\\"/"/g              # replace escaped double quotes with regular double quotes
#
# In non-Bash shells, "eval" the result of the sed script to reconstruct the
# args.
#
# Explanation of the sed script:
#   The first command escapes single quotes by replacing each ' with '\''
#   The second command removes the opening quote
#   The third command removes the closing quote
#   The fourth command replaces escaped backslashes with single backslashes
#   The fifth command replaces escaped double quotes with regular double quotes
#
# Example:
#   Input: 'arg1' 'arg2 with \"quotes\"' 'arg3 with \\backslashes\\'
#   Output: arg1 arg2 with "quotes" arg3 with \backslashes\
#
eval "set -- $(
        printf '%s\n' "$@" |
        xargs -n1 |
        sed ' s/'"'"'/'"'"'\\\\'"'"''"'"'/g;
              s/^'"'"'//;
              s/'"'"'$//;
              s/\\\\\\\\/\\\\/g;
              s/\\\\"/"/g;
            '
    )" "$@"

exec "$JAVACMD" "$@"
