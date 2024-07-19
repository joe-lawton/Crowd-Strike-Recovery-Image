@echo off
setlocal enabledelayedexpansion

echo [+] Starting file deletion script...

rem Find the correct drive letter for the Windows partition
set "windrive="
for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%i:\Windows\System32\drivers\CrowdStrike (
        set "windrive=%%i:"
        echo [+] Windows drive found: !windrive!
        goto :found_drive
    )
)

:found_drive
if not defined windrive (
    echo [!] Windows drive not found
    goto :error
)

rem Navigate to the directory
cd /d !windrive!\Windows\System32\drivers\CrowdStrike
if errorlevel 1 (
    echo [!] Failed to navigate to !windrive!\Windows\System32\drivers\CrowdStrike
    goto :error
)

echo [+] Navigated to !windrive!\Windows\System32\drivers\CrowdStrike

rem Check for and delete files matching the pattern
set "file_found=false"
for %%f in (C-00000291*) do (
    if exist "%%f" (
        echo [+] Found file: %%f
        del "%%f" 2>nul
        if exist "%%f" (
            echo [!] Failed to delete file: %%f. It may be in use or protected.
        ) else (
            echo [+] File deleted successfully: %%f
        )
        set "file_found=true"
    )
)

if !file_found! == false (
    echo [?] No files matching the pattern C-00000291* were found.
)

goto :end

:error
echo [!] An error occurred during the operation
exit /b 1

:end
echo [+] Script execution completed
pause
exit /b 0
