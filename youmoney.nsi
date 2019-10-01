!include "MUI2.nsh"

Name "YouMoney"
OutFile "YouMoney-0.9.5.exe"

InstallDir "$PROGRAMFILES\YouMoney"

InstallDirRegKey HKCU "Software\YouMoney" ""

RequestExecutionLevel user

Var StartMenuFolder

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY

!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\YouMoney" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "SIMPCHINESE"

Section "YouMoney������" SecYouMoney

    SetOutPath "$INSTDIR"
    
    File /r "dist\*.*"
     
    WriteRegStr HKCU "Software\YouMoney" "" $INSTDIR
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\YouMoney.lnk" "$INSTDIR\YouMoney.exe"
    CreateShortCut "$DESKTOP\��Ǯ����YouMoney.lnk" "$INSTDIR\YouMoney.exe"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

LangString DESC_SecDummy ${LANG_SIMPCHINESE} "YouMoney��װ."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecYouMoney} $(DESC_SecDummy)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "Uninstall"
    ;ADD YOUR OWN FILES HERE...
	StrCpy $StartMenuFolder "YouMoney"

    Delete "$INSTDIR\Uninstall.exe"

    RMDir /r "$INSTDIR\images"
    RMDir /r "$INSTDIR\lang"
    RMDir /r "$INSTDIR\ui"
    Delete "$INSTDIR\*"

    DeleteRegKey /ifempty HKCU "Software\YouMoney"

    Delete "$DESKTOP\��Ǯ����YouMoney.lnk"

    RMDir /r  "$SMPROGRAMS\$StartMenuFolder"
SectionEnd


