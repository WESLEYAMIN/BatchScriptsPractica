@echo off
setlocal enabledelayedexpansion

:menu_principal
cls
echo Menu Principal
echo 1. Registrarse
echo 2. Iniciar Sesion
echo 3. Salir

set /p opcion="Seleccione una opcion:(1-3)="

if "%opcion%" equ "1" (
    call :registro_usuario
) else if "%opcion%" equ "2" (
    call :inicio_sesion
) else if "%opcion%" equ "3" (
    exit
) else (
    echo Opcion no valida. Inteetelo de nuevo.
    timeout /nobreak /t 2 >nul
    goto :menu_principal
)

:---------registro_usuario----------
cls
echo ==============Registro de Usuario==============
set /p username="Ingrese un nombre de usuario: "
set /p password="Ingrese una contrasena: "
set /p verify_password="Repita la contrasena: "

if not "%password%" equ "%verify_password%" (
    echo Las contraseñas no coinciden. Intentelo de nuevo.
    timeout /nobreak /t 2 >nul
    goto :registro_usuario
)

echo !username!;!password!>>Wesley_Rosa.txt

echo Usuario registrado con exito.
timeout /nobreak /t 2 >nul
goto :menu_principal

:inicio_sesion
cls
echo ================Inicio de Sesion=============
set /p username="Ingrese su nombre de usuario: "
set /p password="Ingrese su contrasena: "

set "user_found="
set "correct_password="

for /f "tokens=1,* delims=;" %%a in (Wesley_Rosa.txt) do (
    if "%%a" equ "!username!" (
        set "user_found=true"
        if "%%b" equ "!password!" set "correct_password=true"
    )
)

if not defined user_found (
    echo Nombre de usuario no encontrado.
    timeout /nobreak /t 2 >nul
    goto :menu_principal
)

if not defined correct_password (
    echo Contrasena incorrecta.
    timeout /nobreak /t 2 >nul
    goto :menu_principal
)

echo ¡Bienvenido, !username"!
call :opciones_usuario
goto :menu_principal

:opciones_usuario
cls
echo Opciones despues de iniciar sesion
echo a. Modificar contrasena
echo b. Eliminar usuario
echo c. Cerrar sesión

set /p opcion="Seleccione una opcion: "

if "%opcion%" equ "a" (
    call :modificar_contrasena
) else if "%opcion%" equ "b" (
    call :eliminar_usuario
) else if "%opcion%" equ "c" (
    goto :menu_principal
) else (
    echo Opcion no valida. Intentelo de nuevo.
    timeout /nobreak /t 2 >nul
    goto :opciones_usuario
)

:modificar_contrasena
cls
set /p new_password="Ingrese la nueva contrasena: "
set /p verify_new_password="Repita la nueva contrasena: "

if not "!new_password!" equ "!verify_new_password!" (
    echo Las contrasenas no coinciden.
    timeout /nobreak /t 2 >nul
    goto :opciones_usuario
)

set "temp_file=temp.txt"

(for /f "tokens=1,* delims=;" %%a in (Wesley_Rosa.txt) do (
    if "%%a" equ "!username!" (
        echo !username!;!new_password!
    ) else (
        echo %%a;%%b
    )
)) >!temp_file!

move /y !temp_file! Wesley_Rosa.txt

echo Contrasena modificada con exito.
timeout /nobreak /t 2 >nul
goto :menu_principal

:eliminar_usuario
cls
set /p confirmation="¿Esta seguro de que desea eliminar su cuenta? (Si/No): "

if /i "%confirmation%" equ "Si" (
    findstr /v /c:"!username!" Wesley_Rosa.txt >temp.txt
    move /y temp.txt Wesley_Rosa.txt
    echo Usuario eliminado con exito.
) else (
    echo Operacion cancelada.
)

timeout /nobreak /t 2 >nul
goto :opciones_usuario
pause