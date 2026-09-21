update vscode to [@@MS_TAG@@](@@MS_URL@@)

@@RELEASE_NOTES@@

## 下载 / Downloads

### Windows

| 架构 Architecture | 安装包 Installer |
| --- | --- |
| x64 | [@@APP_NAME@@Setup-x64-@@VERSION@@.exe](https://github.com/@@ASSETS_REPOSITORY@@/releases/download/@@RELEASE_TAG@@/@@APP_NAME@@Setup-x64-@@VERSION@@.exe) |
| arm64 | [@@APP_NAME@@Setup-arm64-@@VERSION@@.exe](https://github.com/@@ASSETS_REPOSITORY@@/releases/download/@@RELEASE_TAG@@/@@APP_NAME@@Setup-arm64-@@VERSION@@.exe) |

安装包按当前用户安装到 `%LOCALAPPDATA%\Programs\@@APP_NAME@@`，无需管理员权限。
The installer is per-user and does not require administrator rights.

### macOS

| 架构 Architecture | 磁盘映像 Disk image |
| --- | --- |
| Intel (x64) | [@@APP_NAME@@.x64.@@VERSION@@.dmg](https://github.com/@@ASSETS_REPOSITORY@@/releases/download/@@RELEASE_TAG@@/@@APP_NAME@@.x64.@@VERSION@@.dmg) |
| Apple Silicon (arm64) | [@@APP_NAME@@.arm64.@@VERSION@@.dmg](https://github.com/@@ASSETS_REPOSITORY@@/releases/download/@@RELEASE_TAG@@/@@APP_NAME@@.arm64.@@VERSION@@.dmg) |

两个架构均为 ad-hoc 签名，首次启动如被 Gatekeeper 拦截，请右键点按应用后选择"打开"。
Both builds are ad-hoc signed; if Gatekeeper blocks the first launch, right-click the app and choose Open.

### Linux

| 架构 Architecture | AppImage |
| --- | --- |
| x86_64 | [@@APP_NAME@@-@@VERSION@@-anylinux-x86_64.AppImage](https://github.com/@@ASSETS_REPOSITORY@@/releases/download/@@RELEASE_TAG@@/@@APP_NAME@@-@@VERSION@@-anylinux-x86_64.AppImage) |
| aarch64 | [@@APP_NAME@@-@@VERSION@@-anylinux-aarch64.AppImage](https://github.com/@@ASSETS_REPOSITORY@@/releases/download/@@RELEASE_TAG@@/@@APP_NAME@@-@@VERSION@@-anylinux-aarch64.AppImage) |

AppImage 为便携格式，下载即可运行；如系统未自动标记为可执行文件，请先执行 `chmod +x`。
AppImages are portable; if the executable bit is missing, run `chmod +x` first.

所有安装包均附带 `.sha1` 与 `.sha256` 校验文件。
Every package ships with matching `.sha1` and `.sha256` checksum files.
