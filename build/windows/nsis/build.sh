#!/usr/bin/env bash
set -eu

APP_NAME="${APP_NAME:-CodeEditor}"
APP_VERSION="${RELEASE_VERSION%-insider}"
APP_ARCH="${VSCODE_ARCH:-x64}"
NSIS_BIN="${NSIS_BIN:-makensis}"

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

if [[ -z "${APP_EXE_NAME}" ]]; then
  # the build renames the main executable after the product, but keep the
  # upstream name as a fallback so the shortcuts stay valid either way
  for CANDIDATE in "${APP_NAME}.exe" "Code.exe"; do
    if [[ -f "${ROOT_DIR}/VSCode-win32-${APP_ARCH}/${CANDIDATE}" ]]; then
      APP_EXE_NAME="${CANDIDATE}"
      break
    fi
  done
fi

if [[ -z "${APP_EXE_NAME}" ]]; then
  echo "No executable found in ${ROOT_DIR}/VSCode-win32-${APP_ARCH}" >&2
  exit 1
fi

mkdir -p "${ROOT_DIR}/assets"

# makensis resolves relative paths against its working directory, so compile
# from the script directory; the defaults in the .nsi file stay repository
# relative and therefore resolve to the same places.
cd "${SCRIPT_DIR}"

"${NSIS_BIN}" \
  /DAPP_NAME="${APP_NAME}" \
  /DAPP_VERSION="${APP_VERSION}" \
  /DAPP_ARCH="${APP_ARCH}" \
  /DAPP_EXE_NAME="${APP_EXE_NAME}" \
  codeeditor.nsi

INSTALLER="${ROOT_DIR}/assets/${APP_NAME}Setup-${APP_ARCH}-${APP_VERSION}.exe"

if [[ ! -f "${INSTALLER}" ]]; then
  echo "NSIS did not produce ${INSTALLER}" >&2
  exit 1
fi

echo "Built ${INSTALLER}"
