; CodeEditor NSIS installer.
; Payload directory, output path and version are overridable from CI via
; /DAPP_NAME /DAPP_VERSION /DAPP_ARCH /DAPP_EXE_NAME /DAPP_SRC_PATTERN
; (see build/windows/nsis/build.sh).

Unicode true
ManifestDPIAware true

!include "MUI2.nsh"

!ifndef APP_NAME
  !define APP_NAME "CodeEditor"
!endif
; User-facing name. APP_NAME above stays ASCII because it also builds install
; paths, registry keys and the output file name; this one is only ever shown.
!ifndef APP_DISPLAY_NAME
  !define APP_DISPLAY_NAME "蜥蜴编辑器"
!endif
!ifndef APP_VERSION
  !define APP_VERSION "1.0.0"
!endif
!ifndef APP_ARCH
  !define APP_ARCH "x64"
!endif
!ifndef APP_EXE_NAME
  !define APP_EXE_NAME "${APP_NAME}.exe"
!endif
!define APP_EXE "${APP_EXE_NAME}"
!define APP_INSTALL_DIR "$PROGRAMFILES64\${APP_NAME}"
!define APP_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
!define APP_UNINST_EXE "$INSTDIR\uninstall.exe"
; "File /r" is split at the last platform path separator, and that separator is
; a backslash on Windows even when the rest of the path uses forward slashes, so
; the wildcard has to hang off a backslash there. build.sh passes the pattern in;
; this default assumes a native Windows makensis.
!ifndef APP_SRC_PATTERN
  !define APP_SRC_PATTERN "..\..\..\VSCode-win32-${APP_ARCH}\*"
!endif
!ifndef APP_OUT_FILE
  !define APP_OUT_FILE "..\..\..\assets\${APP_NAME}Setup-${APP_ARCH}-${APP_VERSION}.exe"
!endif
!ifndef APP_ICON
  !define APP_ICON "..\..\..\src\stable\resources\win32\code.ico"
!endif

Name "${APP_DISPLAY_NAME} ${APP_VERSION} (${APP_ARCH})"
OutFile "${APP_OUT_FILE}"
InstallDir "${APP_INSTALL_DIR}"
InstallDirRegKey HKLM "${APP_UNINST_KEY}" "InstallLocation"

RequestExecutionLevel admin
SetCompressor /SOLID lzma
SetCompressorDictSize 64
SetDatablockOptimize on
SetOverwrite on
ShowInstDetails show
ShowUnInstDetails show

Icon "${APP_ICON}"
UninstallIcon "${APP_ICON}"

VIProductVersion "${APP_VERSION}.0"
VIAddVersionKey "ProductName" "${APP_DISPLAY_NAME}"
VIAddVersionKey "ProductVersion" "${APP_VERSION}"
VIAddVersionKey "FileVersion" "${APP_VERSION}.0"
VIAddVersionKey "FileDescription" "${APP_DISPLAY_NAME} Installer"
VIAddVersionKey "LegalCopyright" "CodeEditor Contributors - Mutantcat Working Group"
VIAddVersionKey "OriginalFilename" "${APP_NAME}Setup-${APP_ARCH}-${APP_VERSION}.exe"

; Name the product in the footer where NSIS would otherwise show its own
; toolkit name and version.
BrandingText "${APP_DISPLAY_NAME} ${APP_VERSION} (${APP_ARCH}) 安装程序 - 异猫工作群"

!define MUI_ABORTWARNING
!define MUI_ICON "${APP_ICON}"
!define MUI_UNICON "${APP_ICON}"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\${APP_EXE}"
!define MUI_FINISHPAGE_RUN_TEXT "$(FINISH_RUN_APP)"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; SimpChinese leads so a fresh install opens in Chinese; English stays
; selectable for non-Chinese machines.
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"

; The toolkit translates its own pages, but everything this script names itself
; has to carry both languages of its own.
LangString FINISH_RUN_APP ${LANG_SIMPCHINESE} "运行 ${APP_DISPLAY_NAME}"
LangString FINISH_RUN_APP ${LANG_ENGLISH} "Run ${APP_DISPLAY_NAME}"
LangString SEC_APP ${LANG_SIMPCHINESE} "${APP_DISPLAY_NAME}（必需）"
LangString SEC_APP ${LANG_ENGLISH} "${APP_DISPLAY_NAME} (required)"
LangString SEC_DESKTOP ${LANG_SIMPCHINESE} "桌面快捷方式"
LangString SEC_DESKTOP ${LANG_ENGLISH} "Desktop shortcut"
LangString SEC_STARTMENU ${LANG_SIMPCHINESE} "开始菜单快捷方式"
LangString SEC_STARTMENU ${LANG_ENGLISH} "Start menu shortcuts"
LangString DESC_SEC_APP ${LANG_SIMPCHINESE} "安装 ${APP_DISPLAY_NAME} 应用程序。"
LangString DESC_SEC_APP ${LANG_ENGLISH} "Installs the ${APP_DISPLAY_NAME} application."
LangString DESC_SEC_DESKTOP ${LANG_SIMPCHINESE} "在桌面上添加 ${APP_DISPLAY_NAME} 快捷方式。"
LangString DESC_SEC_DESKTOP ${LANG_ENGLISH} "Adds a ${APP_DISPLAY_NAME} shortcut to your desktop."
LangString DESC_SEC_STARTMENU ${LANG_SIMPCHINESE} "在开始菜单中添加 ${APP_DISPLAY_NAME} 快捷方式。"
LangString DESC_SEC_STARTMENU ${LANG_ENGLISH} "Adds ${APP_DISPLAY_NAME} shortcuts to the Start Menu."

Section "$(SEC_APP)" SEC_APP
  SectionIn RO
  SetShellVarContext all
  SetOutPath "$INSTDIR"
  File /r "${APP_SRC_PATTERN}"

  WriteUninstaller "${APP_UNINST_EXE}"

  WriteRegStr HKLM "${APP_UNINST_KEY}" "DisplayName" "${APP_DISPLAY_NAME}"
  WriteRegStr HKLM "${APP_UNINST_KEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "${APP_UNINST_KEY}" "Publisher" "Mutantcat Working Group"
  WriteRegStr HKLM "${APP_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKLM "${APP_UNINST_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${APP_UNINST_KEY}" "UninstallString" '"${APP_UNINST_EXE}"'
  WriteRegStr HKLM "${APP_UNINST_KEY}" "QuietUninstallString" '"${APP_UNINST_EXE}" /S'
  WriteRegDWORD HKLM "${APP_UNINST_KEY}" "NoModify" 1
  WriteRegDWORD HKLM "${APP_UNINST_KEY}" "NoRepair" 1
SectionEnd

Section "$(SEC_DESKTOP)" SEC_DESKTOP
  SetShellVarContext all
  CreateShortcut "$DESKTOP\${APP_DISPLAY_NAME}.lnk" "$INSTDIR\${APP_EXE}"
SectionEnd

Section "$(SEC_STARTMENU)" SEC_STARTMENU
  SetShellVarContext all
  CreateDirectory "$SMPROGRAMS\${APP_DISPLAY_NAME}"
  CreateShortcut "$SMPROGRAMS\${APP_DISPLAY_NAME}\${APP_DISPLAY_NAME}.lnk" "$INSTDIR\${APP_EXE}"
  CreateShortcut "$SMPROGRAMS\${APP_DISPLAY_NAME}\卸载 ${APP_DISPLAY_NAME}.lnk" "${APP_UNINST_EXE}"
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_APP} "$(DESC_SEC_APP)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DESKTOP} "$(DESC_SEC_DESKTOP)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC_STARTMENU} "$(DESC_SEC_STARTMENU)"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "Uninstall"
  SetShellVarContext all

  Delete "$DESKTOP\${APP_DISPLAY_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_DISPLAY_NAME}\${APP_DISPLAY_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_DISPLAY_NAME}\卸载 ${APP_DISPLAY_NAME}.lnk"
  RMDir "$SMPROGRAMS\${APP_DISPLAY_NAME}"

  DeleteRegKey HKLM "${APP_UNINST_KEY}"
  RMDir /r "$INSTDIR"
SectionEnd
