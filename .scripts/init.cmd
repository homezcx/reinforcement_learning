REM Integration points for toolchain customization
IF NOT DEFINED nugetPath (
    SET nugetPath=nuget
)

IF NOT DEFINED msbuildPath (
    CALL %~dp0find-vs2017.cmd
)

IF NOT DEFINED vstestPath (
    CALL %~dp0find-vs2017.cmd
)

IF NOT DEFINED msbuildPath (
    IF NOT EXIST "%VsInstallDir%\MSBuild\15.0\Bin\MSBuild.exe" (
        ECHO ERROR: MsBuild couldn't be found
        EXIT /b 1
    ) ELSE (
        SET "msBuildPath=%VsInstallDir%\MSBuild\15.0\Bin\MSBuild.exe"
    )
)

IF NOT DEFINED vstestPath (
    IF NOT EXIST "%VsInstallDir%\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" (
        ECHO ERROR: vstest.console couldn't be found
        EXIT /b 1
    ) ELSE (
        SET "vstestPath=%VsInstallDir%\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"
    )
)

IF NOT DEFINED dotnetPath (
    SET dotnetPath=dotnet
)

IF NOT DEFINED vcpkgPath (
    IF NOT DEFINED VcpkgInstallRoot (
        ECHO ERROR: vcpkgPath is not configured, but VcpkgInstallRoot is also not configured. Cannot find vcpkg.
        EXIT /b 1
    )

    SET "vcpkgPath=%VcpkgInstallRoot%vcpkg.exe"
    SET "VcpkgIntegration=%VcpkgInstallRoot%scripts\buildsystems\msbuild\vcpkg.targets"
)

REM The correct way to integrate this is to use msbuild targets and contribute them back to flatbuff, 
REM rather than a command line execution
IF NOT DEFINED flatcPath (
    IF NOT DEFINED VcpkgInstallRoot (
        ECHO ERROR: flatcPath is not configured, but VcpkgInstallRoot is also not configured. Cannot find vcpkg.
        EXIT /b 1
    )

    SET "flatcPath=%VcpkgInstallRoot%installed\x64-windows\tools\flatbuffers\flatc.exe"
)

REM Repo-specific paths
IF NOT DEFINED rlRoot (
    SET rlRoot=%~dp0..
)