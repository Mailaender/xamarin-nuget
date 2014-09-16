@echo Off
SETLOCAL
set config=%1

if "%config%" == "" (
   set config=debug
)

REM Some unit-tests may leave nuget.config files in %TEMP% which leads to hard-to-debug failures
FOR /F "tokens=*" %%I IN ('dir /s /b "%TEMP%\nuget.config" 2^>NUL') DO DEL "%%I"

set EnableNuGetPackageRestore=true 
"%ProgramFiles(x86)%\MSBuild\12.0\bin\msbuild" Build\Build.proj /p:Configuration="%config%" /p:Platform="Any CPU" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Detailed /nr:false 
ENDLOCAL