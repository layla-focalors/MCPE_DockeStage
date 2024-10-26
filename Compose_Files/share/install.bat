@echo off

:install_docker_windows
powershell -Command "Invoke-WebRequest -Uri https://download.docker.com/win/stable/Docker%20Desktop%20Installer.exe -OutFile DockerDesktopInstaller.exe"
start /wait DockerDesktopInstaller.exe install
del DockerDesktopInstaller.exe
goto :eof

:install_docker_compose_windows
powershell -Command "Invoke-WebRequest -Uri https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Windows-x86_64.exe -OutFile %ProgramFiles%\Docker\Docker\resources\bin\docker-compose.exe"
goto :eof

ver | findstr /i "10." >nul
if %errorlevel% equ 0 (
    call :install_docker_windows
    call :install_docker_compose_windows
    echo 설치를 완료했습니다.
) else (
    echo ERR13: 미지원 OS 이거나 감지에 실패했습니다.
    exit /b 1
)