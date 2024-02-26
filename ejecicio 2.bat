@echo off
echo Tabla de multiplicar del 5:
for /L %%i in (1,1,10) do (
    set /a resultado=5*%%i
    echo 5 x %%i = !resultado!
)
pause

