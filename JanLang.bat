@echo off
setlocal enabledelayedexpansion

rem Arquivo onde o código será salvo
set "filename=codigo.jan"

:menu
cls
echo ----------------------------------------------------
echo       Editor e Interpretador de JanLang
echo ----------------------------------------------------
echo 1. Criar Novo Arquivo
echo 2. Editar Arquivo Existente
echo 3. Visualizar Arquivo
echo 4. Interpretar e Executar Arquivo
echo 5. Sair
echo.
set /p choice=Escolha uma opcao (1-5): 
if "%choice%"=="1" goto novo
if "%choice%"=="2" goto editar
if "%choice%"=="3" goto visualizar
if "%choice%"=="4" goto interpretar
if "%choice%"=="5" exit

:novo
del %filename% 2>nul
echo Arquivo %filename% criado.
pause
goto editar

:editar
cls
echo ----------------------------------------------------
echo Editando %filename%
echo ----------------------------------------------------
echo (Digite 'sair' para voltar ao menu principal)
echo.
set /p linha=>> %filename% 
if "%linha%"=="sair" goto menu
echo %linha% >> %filename%
goto editar

:visualizar
cls
echo ----------------------------------------------------
echo Conteudo de %filename%
echo ----------------------------------------------------
type %filename%
echo ----------------------------------------------------
pause
goto menu

:interpretar
cls
echo ----------------------------------
for /f "delims=" %%i in (%filename%) do (
    set "linha=%%i"
    call :interpretarLinha "!linha!"
)
echo ----------------------------------
pause
goto menu

:interpretarLinha
set "cmd=%~1"
if "!cmd:~0,5!"=="print" goto :printCmd
if "!cmd:~0,3!"=="add" goto :addCmd
if "!cmd:~0,8!"=="subtract" goto :subtractCmd
if "!cmd:~0,8!"=="multiply" goto :multiplyCmd
if "!cmd:~0,6!"=="divide" goto :divideCmd
if "!cmd:~0,7!"=="modulus" goto :modulusCmd
if "!cmd:~0,5!"=="power" goto :powerCmd
goto :eof

:printCmd
echo %cmd:~6%
goto :eof

:addCmd
for /f "tokens=2,3" %%a in ("!cmd!") do (
    set /a result=%%a+%%b
    echo !result!
)
goto :eof

:subtractCmd
for /f "tokens=2,3" %%a in ("!cmd!") do (
    set /a result=%%a-%%b
    echo !result!
)
goto :eof

:multiplyCmd
for /f "tokens=2,3" %%a in ("!cmd!") do (
    set /a result=%%a*%%b
    echo !result!
)
goto :eof

:divideCmd
for /f "tokens=2,3" %%a in ("!cmd!") do (
    set /a result=%%a/%%b
    echo !result!
)
goto :eof

:modulusCmd
for /f "tokens=2,3" %%a in ("!cmd!") do (
    set /a result=%%a%%%%b
    echo !result!
)
goto :eof

:powerCmd
for /f "tokens=2,3" %%a in ("!cmd!") do (
    set "result=1"
    set /a "exp=%%b"
    set /a "base=%%a"
    :powerLoop
    if "!exp!"=="0" goto :donePower
    set /a "result=!result! * !base!"
    set /a "exp=!exp! - 1"
    goto :powerLoop
    :donePower
    echo !result!
)
goto :eof
:eof
exit /b
