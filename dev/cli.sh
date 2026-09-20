export CARGO_NET_GIT_FETCH_WITH_CLI="true"
export VSCODE_CLI_APP_NAME="codeeditor"
export VSCODE_CLI_BINARY_NAME="codeeditor-server-insiders"
export VSCODE_CLI_DOWNLOAD_URL="https://github.com/Mutantcat-Working-Group/CodeEditor-insiders/releases"
export VSCODE_CLI_QUALITY="insider"
export VSCODE_CLI_UPDATE_URL="https://raw.githubusercontent.com/VSCodium/versions/refs/heads/master"

cargo build --release --target aarch64-apple-darwin --bin=code

cp target/aarch64-apple-darwin/release/code "../../VSCode-darwin-arm64/CodeEditor - Insiders.app/Contents/Resources/app/bin/codeeditor-tunnel-insiders"

"../../VSCode-darwin-arm64/CodeEditor - Insiders.app/Contents/Resources/app/bin/codeeditor-insiders" serve-web
