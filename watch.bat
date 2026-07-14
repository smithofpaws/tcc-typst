@echo off
echo ========================================================
echo Iniciando a compilacao automatica (watch mode) do Typst
echo ========================================================
echo.
echo O Typst esta monitorando o arquivo main.typ...
echo Deixe esta janela aberta. Para parar, pressione Ctrl+C.
echo.

typst.exe watch main.typ

pause
