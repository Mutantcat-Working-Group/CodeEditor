#!/usr/bin/env bash
set -eu

APP_NAME="${APP_NAME:-CodeEditor}"
APP_VERSION="${RELEASE_VERSION%-insider}"
APP_ARCH="${VSCODE_ARCH:-x64}"
NSIS_BIN="${NSIS_BIN:-makensis}"
# The .nsi carries a UTF-8 display name, so tell makensis to read it as UTF-8
# instead of the machine's ANSI code page.
SCRIPT_CHARSET="${SCRIPT_CHARSET:-UTF8}"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "${SCRIPT_DIR}/../../.." && pwd )"

if ! command -v "${NSIS_BIN}" >/dev/null 2>&1; then
  echo "NSIS (makensis) not found on PATH" >&2
  exit 1
fi

if [[ ! -d "${ROOT_DIR}/VSCode-win32-${APP_ARCH}" ]]; then
  echo "Build output not found: ${ROOT_DIR}/VSCode-win32-${APP_ARCH}" >&2
  exit 1
fi

if [[ -z "${APP_EXE_NAME:-}" ]]; then
  # the build renames the main executable after the product, but keep the
  # upstream name as a fallback so the shortcuts stay valid either way
  for CANDIDATE in "${APP_NAME}.exe" "${APP_NAME} - OSS.exe" "Code.exe"; do
    if [[ -f "${ROOT_DIR}/VSCode-win32-${APP_ARCH}/${CANDIDATE}" ]]; then
      APP_EXE_NAME="${CANDIDATE}"
      break
    fi
  done
fi

if [[ -z "${APP_EXE_NAME:-}" ]]; then
  echo "No executable found in ${ROOT_DIR}/VSCode-win32-${APP_ARCH}" >&2
  exit 1
fi

APP_SRC_DIR="${APP_SRC_DIR:-../../../VSCode-win32-${APP_ARCH}}"

# NSIS resolves a "File /r" argument by splitting it at the last platform path
# separator. On Windows that separator is a backslash, so a trailing "/*" leaves
# the wildcard glued to the directory name and the parent gets read instead of
# the payload. Attach it with a backslash whenever makensis is the Windows build.
case "$(uname -s)" in
  MINGW* | MSYS* | CYGWIN*)
    APP_SRC_PATTERN="${APP_SRC_DIR//\//\\}\\*"
    ;;
  *)
    APP_SRC_PATTERN="${APP_SRC_DIR}/*"
    ;;
esac

mkdir -p "${ROOT_DIR}/assets"

# Git for Windows rewrites arguments that look like Unix paths, so a plain
# `/DAPP_NAME=...` reaches makensis as `C:/Program Files/Git/DAPP_NAME=...`.
# Turn that conversion off; NSIS accepts a `-D` spelling too (IS_OPT in
# Source/Platform.h treats `/` and `-` the same on Windows), and that form
# survives the rewrite untouched, so try it second.
export MSYS_NO_PATHCONV=1
export MSYS2_ARG_CONV_EXCL="*"

run_makensis() {
  local switch="$1"

  "${NSIS_BIN}" \
    "${switch}INPUTCHARSET" "${SCRIPT_CHARSET}" \
    "${switch}DAPP_NAME=${APP_NAME}" \
    "${switch}DAPP_VERSION=${APP_VERSION}" \
    "${switch}DAPP_ARCH=${APP_ARCH}" \
    "${switch}DAPP_EXE_NAME=${APP_EXE_NAME}" \
    "${switch}DAPP_SRC_PATTERN=${APP_SRC_PATTERN}" \
    codeeditor.nsi
}

# makensis resolves relative paths against its working directory, so compile
# from the script directory; the defaults in the .nsi file stay repository
# relative and therefore resolve to the same places.
cd "${SCRIPT_DIR}"

if ! run_makensis "/" && ! run_makensis "-"; then
  echo "makensis rejected both the /D and -D switch spellings" >&2
  echo "tried: ${NSIS_BIN} /INPUTCHARSET ${SCRIPT_CHARSET} /DAPP_NAME=${APP_NAME} /DAPP_VERSION=${APP_VERSION} /DAPP_ARCH=${APP_ARCH} /DAPP_EXE_NAME=${APP_EXE_NAME} /DAPP_SRC_PATTERN=${APP_SRC_PATTERN} codeeditor.nsi" >&2
  exit 1
fi

INSTALLER="${ROOT_DIR}/assets/${APP_NAME}Setup-${APP_ARCH}-${APP_VERSION}.exe"

if [[ ! -f "${INSTALLER}" ]]; then
  echo "NSIS did not produce ${INSTALLER}" >&2
  exit 1
fi

echo "Built ${INSTALLER}"
