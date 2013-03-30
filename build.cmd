@echo off

if "%~1"=="" ( 
 call :Usage
 goto :EOF
)

pushd "%~dp0"
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set VisualStudioCmd=%ProgramFiles%\Microsoft Visual Studio 10.0\VC\vcvarsall.bat

if EXIST "%VisualStudioCmd%" ( 
 call "%VisualStudioCmd%"
)

set FrameworkVersion=v3.5
set FrameworkDir=%SystemRoot%\Microsoft.NET\Framework

PATH=%FrameworkDir%\%FrameworkVersion%;%SvnDir%;%PATH%
msbuild.exe Svn2Svn.proj /t:%*
if NOT %ERRORLEVEL%==0 exit /b %ERRORLEVEL%
popd
endlocal
exit /b 0
goto :EOF

:Usage
echo  Syntax:
echo.
echo   build [target] /p:Configuration=[Debug (default),Release]
echo.
echo  Target:
echo.
echo   all : build everything
echo.
echo  Examples:
echo.
echo   build all
echo   build all /p:Configuration=Release
goto :EOF
