@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ============================================
echo   Dota 2 Tracker - запуск приложения
echo ============================================
echo.

where flutter >nul 2>&1
if errorlevel 1 (
    echo Flutter не найден в PATH.
    echo Установите Flutter SDK и проверьте команду flutter doctor.
    pause
    exit /b 1
)

echo Проверка устройств...
flutter devices

echo.
echo Установка зависимостей...
flutter pub get
if errorlevel 1 (
    echo Не удалось установить зависимости.
    pause
    exit /b 1
)

echo.
echo Запуск приложения...
flutter run

pause
