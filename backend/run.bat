@echo off
echo Starting Windfall Backend...

REM Check if JAVA_HOME is set
if "%JAVA_HOME%" == "" (
    echo WARNING: JAVA_HOME is not set. This may cause issues.
    echo Please set JAVA_HOME to your JDK installation directory.
    echo Example: set JAVA_HOME=C:\Program Files\Java\jdk-17
    echo.
    echo Attempting to run anyway...
)

REM Check for command line arguments
set PROFILE=
set PORT=8080
set DEBUG=false

:parse
if "%~1" == "" goto :execute
if /i "%~1" == "--mysql" set PROFILE=mysql& shift & goto :parse
if /i "%~1" == "--port" set PORT=%~2& shift & shift & goto :parse
if /i "%~1" == "--debug" set DEBUG=true& shift & goto :parse
shift
goto :parse

:execute
echo.
echo Configuration:
if "%PROFILE%" == "mysql" (
    echo - Database: MySQL
) else (
    echo - Database: H2 (in-memory)
)
echo - Port: %PORT%
if "%DEBUG%" == "true" (
    echo - Debug mode: Enabled (port 8000)
) else (
    echo - Debug mode: Disabled
)
echo.

REM Build the command
set CMD=mvnw.cmd spring-boot:run -Dserver.port=%PORT% -Dspring.docker.compose.enabled=false

if "%PROFILE%" == "mysql" (
    set CMD=%CMD% -Dspring-boot.run.profiles=mysql
)

if "%DEBUG%" == "true" (
    set CMD=%CMD% -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000"
)

echo Executing: %CMD%
echo.
echo Once started, access the application at:
echo - API: http://localhost:%PORT%/api/hello
if not "%PROFILE%" == "mysql" (
    echo - H2 Console: http://localhost:%PORT%/h2-console
)
echo.
echo Press Ctrl+C to stop the application
echo.

REM Execute the command
%CMD%
