@echo off
chcp 65001 > nul
title Gerador de Base de Sazonalidade — Agroquima
color 0A

echo.
echo  ╔═══════════════════════════════════════════════════╗
echo  ║    GERADOR DE BASE DE SAZONALIDADE — AGROQUIMA   ║
echo  ╚═══════════════════════════════════════════════════╝
echo.

:: Vai para a pasta onde este .bat está
cd /d "%~dp0"

:: Verifica se o Python está instalado
py --version > nul 2>&1
if errorlevel 1 (
    echo  [ERRO] Python nao encontrado!
    echo.
    echo  Instale o Python em: https://www.python.org/downloads/
    echo  IMPORTANTE: marque a opcao "Add Python to PATH" durante a instalacao.
    echo.
    pause
    exit /b 1
)

:: Verifica se o script .py existe
if not exist "gerar_base_sazonalidade.py" (
    echo  [ERRO] Arquivo gerar_base_sazonalidade.py nao encontrado!
    echo  Coloque este .bat na mesma pasta que o script .py
    echo.
    pause
    exit /b 1
)

:: Procura o arquivo .xls ou .xlsx do relatorio
set ARQUIVO=
for %%f in (relatorioResumoMovimentacaoCfop*.xls relatorioResumoMovimentacaoCfop*.xlsx) do (
    if not defined ARQUIVO set ARQUIVO=%%f
)

:: Se nao achou pelo nome padrao, lista todos os .xls/.xlsx para o usuario escolher
if not defined ARQUIVO (
    echo  Nenhum arquivo relatorioResumoMovimentacaoCfop*.xls encontrado.
    echo  Arquivos .xls e .xlsx encontrados nesta pasta:
    echo.
    dir /b *.xls *.xlsx 2>nul
    echo.
    set /p ARQUIVO=  Digite o nome do arquivo (com extensao): 
    echo.
)

if not defined ARQUIVO (
    echo  [ERRO] Nenhum arquivo informado.
    pause
    exit /b 1
)

echo  Arquivo encontrado: %ARQUIVO%
echo.
echo  Instalando dependencias (pode demorar 1-2 min na primeira vez)...
py -m pip install pandas openpyxl lxml xlrd -q --disable-pip-version-check
echo  Dependencias ok.
echo.
echo  Processando... aguarde.
echo  ─────────────────────────────────────────────────────
echo.

py gerar_base_sazonalidade.py "%ARQUIVO%" --sim

echo.
echo  ─────────────────────────────────────────────────────
if exist "sazonal_base.json" (
    echo  [OK] Arquivo gerado com sucesso: sazonal_base.json
    echo  Carregue esse arquivo no painel pelo botao "Atualizar base".
) else (
    echo  [AVISO] sazonal_base.json nao foi gerado. Veja o erro acima.
)
echo.
pause
