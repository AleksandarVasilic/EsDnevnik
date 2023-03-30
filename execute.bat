@echo off

REM URL stranice koji hoces da ti se otvori ako ti chrome nije otvoren.
set URL=https://esdnevnik.rs/

:start

REM Proveri da li je chrome pokrenut
tasklist /fi "imagename eq chrome.exe" | findstr chrome.exe > nul 
if %errorlevel%==0 (
  REM Ako jeste ide na prvi tab u chromu i osvezava je.
  echo "Chrome je pokrenut, osvezavam prvu stranicu..."
  
  REM 
  powershell -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.SendKeys]::SendWait('^1'); [System.Windows.Forms.SendKeys]::SendWait('{F5}');}"

) else (
  REM Chrome nije pokrenut, pokrece ga i ide na esdnevnik.
  echo "Pokrecem novu chrome instancu..."
  setlocal EnableDelayedExpansion
  
  REM Promenljive koje cuvaju vrednosti usename i password. Rucno se zadaju vrednosti.
  set username=
  set password=
  
  REM Pokrece chrome sa zadatim URL
  start chrome "%URL%"

  REM Stavio sam mu da saceka neko vreme cisto da stigne da ucita stranicu i da prikaze polja.
  timeout /t 3 /nobreak > nul
  
  REM Krece da unosi podatke, i nakon svakog unosa ceka do jedan sekund kako ne bi doslo do greski.
  powershell -Command "& {[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms'); [System.Windows.Forms.SendKeys]::SendWait('!username!{TAB}'); Start-Sleep -s 1; [System.Windows.Forms.SendKeys]::SendWait('!password!'); Start-Sleep -s 1; [System.Windows.Forms.SendKeys]::SendWait('{TAB}{ENTER}');}")

REM Ceka 30 minuta i ponovo se izvrsava
timeout /t 1800 /nobreak > nul
goto start