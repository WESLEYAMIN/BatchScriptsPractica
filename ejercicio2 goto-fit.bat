@echo off
:menu
cls
set /a n=%RANDOM% %% 100 + 1
set intentos=0

echo Bienvenido al juego de adivinanzas!
echo.
:adivina
set /p adivinanza=Introduce tu adivinanza (entre 1 y 100): 
set /a intentos+=1

if %adivinanza% LSS %n% (
    echo Demasiado bajo. Intenta de nuevo.
    goto adivina
) else if %adivinanza% GTR %n% (
    echo Demasiado alto. Intenta de nuevo.
    goto adivina
) else (
    echo ¡Felicidades! Adivinaste el numero en %intentos% intentos.
    echo.
)
pause