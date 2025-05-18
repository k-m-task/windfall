#!/bin/bash

echo "Starting Windfall Backend..."

# Check if JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
    echo "WARNING: JAVA_HOME is not set. This may cause issues."
    echo "Please set JAVA_HOME to your JDK installation directory."
    echo "Example: export JAVA_HOME=/usr/lib/jvm/java-17-openjdk"
    echo ""
    echo "Attempting to run anyway..."
fi

# Default values
PROFILE=""
PORT=8080
DEBUG=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --mysql)
            PROFILE="mysql"
            shift
            ;;
        --port)
            PORT="$2"
            shift 2
            ;;
        --debug)
            DEBUG=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: ./run.sh [--mysql] [--port PORT] [--debug]"
            exit 1
            ;;
    esac
done

# Display configuration
echo ""
echo "Configuration:"
if [ "$PROFILE" = "mysql" ]; then
    echo "- Database: MySQL"
else
    echo "- Database: H2 (in-memory)"
fi
echo "- Port: $PORT"
if [ "$DEBUG" = "true" ]; then
    echo "- Debug mode: Enabled (port 8000)"
else
    echo "- Debug mode: Disabled"
fi
echo ""

# Build the command
CMD="./mvnw spring-boot:run -Dserver.port=$PORT -Dspring.docker.compose.enabled=false"

if [ "$PROFILE" = "mysql" ]; then
    CMD="$CMD -Dspring-boot.run.profiles=mysql"
fi

if [ "$DEBUG" = "true" ]; then
    CMD="$CMD -Dspring-boot.run.jvmArguments=\"-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000\""
fi

echo "Executing: $CMD"
echo ""
echo "Once started, access the application at:"
echo "- API: http://localhost:$PORT/api/hello"
if [ "$PROFILE" != "mysql" ]; then
    echo "- H2 Console: http://localhost:$PORT/h2-console"
fi
echo ""
echo "Press Ctrl+C to stop the application"
echo ""

# Make the script executable if it isn't already
chmod +x ./mvnw

# Execute the command
if [ "$DEBUG" = "true" ]; then
    ./mvnw spring-boot:run -Dserver.port=$PORT ${PROFILE:+-Dspring-boot.run.profiles=$PROFILE} -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"
else
    ./mvnw spring-boot:run -Dserver.port=$PORT ${PROFILE:+-Dspring-boot.run.profiles=$PROFILE}
fi
