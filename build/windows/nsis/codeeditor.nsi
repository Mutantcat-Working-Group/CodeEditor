Unicode true
ManifestDPIAware true

!ifndef APP_NAME
  !define APP_NAME "CodeEditor"
!endif
; User-facing name. APP_NAME above stays ASCII because it also builds install
; paths, registry keys and the output file name; this one is only ever shown.
!ifndef APP_DISPLAY_NAME
  !define APP_DISPLAY_NAME "CodeEditor 蜥蜴编辑器"
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
!define APP_INSTALL_DIR "$LOCALAPPDATA\Programs\${APP_NAME}"
!define APP_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
!ifndef APP_SRC_DIR
  !define APP_SRC_DIR "..\..\..\VSCode-win32-${APP_ARCH}"
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
InstallDirRegKey HKCU "${APP_UNINST_KEY}" "InstallLocation"

RequestExecutionLevel user
SetCompressor /SOLID lzma
SetCompressorDictSize 64
SetDatablockOptimize on
SetOverwrite on

Icon "${APP_ICON}"

VIProductVersion "${APP_VERSION}.0"
VIAddVersionKey "ProductName" "${APP_DISPLAY_NAME}"
VIAddVersionKey "ProductVersion" "${APP_VERSION}"
VIAddVersionKey "FileVersion" "${APP_VERSION}.0"
VIAddVersionKey "FileDescription" "${APP_DISPLAY_NAME} Installer"
VIAddVersionKey "LegalCopyright" "CodeEditor Contributors"

Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "Install"
  SetOutPath "$INSTDIR"
  File /r "${APP_SRC_DIR}/*"

  WriteUninstaller "$INSTDIR\uninstall.exe"

  CreateDirectory "$SMPROGRAMS\${APP_DISPLAY_NAME}"
  CreateShortcut "$SMPROGRAMS\${APP_DISPLAY_NAME}\${APP_DISPLAY_NAME}.lnk" "$INSTDIR\${APP_EXE}"
  CreateShortcut "$DESKTOP\${APP_DISPLAY_NAME}.lnk" "$INSTDIR\${APP_EXE}"

  WriteRegStr HKCU "${APP_UNINST_KEY}" "DisplayName" "${APP_DISPLAY_NAME}"
  WriteRegStr HKCU "${APP_UNINST_KEY}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKCU "${APP_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKCU "${APP_UNINST_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "${APP_UNINST_KEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKCU "${APP_UNINST_KEY}" "QuietUninstallString" '"$INSTDIR\uninstall.exe" /S'
  WriteRegDWORD HKCU "${APP_UNINST_KEY}" "NoModify" 1
  WriteRegDWORD HKCU "${APP_UNINST_KEY}" "NoRepair" 1
SectionEnd

Section "Uninstall"
  Delete "$DESKTOP\${APP_DISPLAY_NAME}.lnk"
  Delete "$SMPROGRAMS\${APP_DISPLAY_NAME}\${APP_DISPLAY_NAME}.lnk"
  RMDir "$SMPROGRAMS\${APP_DISPLAY_NAME}"
  DeleteRegKey HKCU "${APP_UNINST_KEY}"
  RMDir /r "$INSTDIR"
SectionEnd
