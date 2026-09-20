<div align="center">
   <br />
   <img src="./icon.png" alt="CodeEditor" width="120"/>
   <h1>CodeEditor</h1>
   <h3>Free and open source binaries of Visual Studio Code, rebranded for the Mutantcat Working Group</h3>
</div>

<p align="center">
   <a href="https://github.com/Mutantcat-Working-Group/CodeEditor/releases/latest"><img src="https://img.shields.io/github/v/release/Mutantcat-Working-Group/CodeEditor?label=release" alt="current release"/></a>
   <a href="https://github.com/Mutantcat-Working-Group/CodeEditor/blob/master/LICENSE"><img src="https://img.shields.io/github/license/Mutantcat-Working-Group/CodeEditor" alt="license"/></a>
   <img src="https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-blue" alt="platforms"/>
</p>

Language: <a href="#zh-cn">Chinese</a> | <a href="#english">English</a>

## <a id="zh-cn"></a>中文

### 简介

CodeEditor 是一套构建脚本，它把 [Microsoft 的 `vscode` 仓库](https://github.com/microsoft/vscode) 打包成自由许可的二进制文件，并使用社区驱动的默认配置。本项目由 Mutantcat Working Group 维护，包名统一为 `org.mutantcat.*`，图标为 [`icon.png`](./icon.png)。

### 特性

- 默认关闭遥测与追踪，扩展市场指向 [open-vsx.org](https://open-vsx.org)
- 三大平台、全部主流架构的安装包，下载后双击即可使用
- Windows 提供 NSIS 安装包，支持每用户安装，无需管理员权限
- macOS 提供 ad-hoc 签名的 DMG，同时覆盖 Intel 与 Apple Silicon
- Linux 提供 AppImage，无需安装即可运行
- 发布 Release 或推送版本 tag 时，由 GitHub Actions 自动构建并上传安装包

### 下载与安装

最新版本请前往 [Releases](https://github.com/Mutantcat-Working-Group/CodeEditor/releases/latest) 页面下载。

#### Windows

下载 `CodeEditorSetup-x64-1.0.20260921.exe` 或 `CodeEditorSetup-arm64-1.0.20260921.exe`，双击运行。安装程序为 NSIS 安装包，默认安装到 `%LOCALAPPDATA%\Programs\CodeEditor`，不需要管理员权限，可在系统设置中正常卸载。

#### macOS

下载 `CodeEditor.x64.1.0.20260921.dmg`（Intel）或 `CodeEditor.arm64.1.0.20260921.dmg`（Apple Silicon），打开后把 CodeEditor 拖到 Applications。两个 DMG 都带有 ad-hoc 签名。

#### Linux

下载 `CodeEditor-1.0.20260921-anylinux-x86_64.AppImage` 或 `CodeEditor-1.0.20260921-anylinux-aarch64.AppImage`，然后：

```bash
chmod +x CodeEditor-1.0.20260921-anylinux-x86_64.AppImage
./CodeEditor-1.0.20260921-anylinux-x86_64.AppImage
```

### 安装包一览

| 平台 | 架构 | 文件 | 格式 |
| --- | --- | --- | --- |
| Windows | x64 / arm64 | `CodeEditorSetup-<arch>-<version>.exe` | NSIS 安装包 |
| macOS | x64 (Intel) | `CodeEditor.x64.<version>.dmg` | ad-hoc 签名 DMG |
| macOS | arm64 (Apple Silicon) | `CodeEditor.arm64.<version>.dmg` | ad-hoc 签名 DMG |
| Linux | x86_64 | `CodeEditor-<version>-anylinux-x86_64.AppImage` | AppImage |
| Linux | aarch64 | `CodeEditor-<version>-anylinux-aarch64.AppImage` | AppImage |

每个文件都会同时上传 `.sha1` 与 `.sha256` 校验和，可用于核对下载内容。

### 从源码构建

构建脚本会克隆 Microsoft 的 `vscode` 仓库并执行官方构建流程，因此需要 Node.js、Python 与 Git：

```bash
git clone https://github.com/Mutantcat-Working-Group/CodeEditor.git
cd CodeEditor

./get_repo.sh       # 克隆对应版本的 vscode
./build.sh          # 构建编辑器
./prepare_assets.sh # 打包当前平台的产物
```

更详细的说明见 [docs/howto-build.md](docs/howto-build.md)。

### 版本号

当前版本为 `1.0.20260921`，记录在 [`version.json`](version.json) 中。升级版本时只需修改该文件，CI 会读取它作为发布版本号。

### 自动发布

工作流定义见 [`.github/workflows/release-packages.yml`](.github/workflows/release-packages.yml)。当发布 Release、推送 `v*` 或 `[0-9]*` 开头的 tag，或手动触发时，它会并行构建 Linux、Windows 与 macOS 三个平台的安装包，并上传到对应的 Release 中。

### macOS 首次启动

由于 DMG 使用 ad-hoc 签名而非 Apple 开发者证书，首次打开时 Gatekeeper 可能提示无法验证开发者。右键点击 CodeEditor 选择“打开”，或在终端执行：

```bash
xattr -dr com.apple.quarantine /Applications/CodeEditor.app
```

### 许可证

本项目构建脚本基于 [MIT](LICENSE) 许可发布，构建产物同样以 MIT 许可分发。

## <a id="english"></a>English

### About

CodeEditor is a repository of build scripts that turns [Microsoft's `vscode` repository](https://github.com/microsoft/vscode) into freely licensed binaries with a community-driven default configuration. It is maintained by the Mutantcat Working Group, uses `org.mutantcat.*` package identifiers, and ships with [`icon.png`](./icon.png).

### Features

- Telemetry and tracking disabled by default, extensions served from [open-vsx.org](https://open-vsx.org)
- Installers for three platforms and every mainstream architecture, ready to run after download
- Windows installers built with NSIS, per-user install, no administrator rights required
- macOS DMGs with an ad-hoc code signature for both Intel and Apple Silicon
- Linux AppImages that run without installation
- GitHub Actions builds and uploads every package when a release is published or a version tag is pushed

### Download and install

Grab the latest files from the [Releases](https://github.com/Mutantcat-Working-Group/CodeEditor/releases/latest) page.

#### Windows

Download `CodeEditorSetup-x64-1.0.20260921.exe` or `CodeEditorSetup-arm64-1.0.20260921.exe` and run it. The NSIS installer puts CodeEditor into `%LOCALAPPDATA%\Programs\CodeEditor` without asking for administrator rights, and it can be removed from Windows Settings.

#### macOS

Download `CodeEditor.x64.1.0.20260921.dmg` (Intel) or `CodeEditor.arm64.1.0.20260921.dmg` (Apple Silicon), then drag CodeEditor into Applications. Both DMGs carry an ad-hoc signature.

#### Linux

Download `CodeEditor-1.0.20260921-anylinux-x86_64.AppImage` or `CodeEditor-1.0.20260921-anylinux-aarch64.AppImage`, then:

```bash
chmod +x CodeEditor-1.0.20260921-anylinux-x86_64.AppImage
./CodeEditor-1.0.20260921-anylinux-x86_64.AppImage
```

### Packages

| Platform | Architecture | File | Format |
| --- | --- | --- | --- |
| Windows | x64 / arm64 | `CodeEditorSetup-<arch>-<version>.exe` | NSIS installer |
| macOS | x64 (Intel) | `CodeEditor.x64.<version>.dmg` | ad-hoc signed DMG |
| macOS | arm64 (Apple Silicon) | `CodeEditor.arm64.<version>.dmg` | ad-hoc signed DMG |
| Linux | x86_64 | `CodeEditor-<version>-anylinux-x86_64.AppImage` | AppImage |
| Linux | aarch64 | `CodeEditor-<version>-anylinux-aarch64.AppImage` | AppImage |

Every file is published together with `.sha1` and `.sha256` checksums.

### Build from source

The scripts clone Microsoft's `vscode` repository and run the official build, so you need Node.js, Python and Git:

```bash
git clone https://github.com/Mutantcat-Working-Group/CodeEditor.git
cd CodeEditor

./get_repo.sh       # clone the matching vscode revision
./build.sh          # build the editor
./prepare_assets.sh # package artifacts for the current platform
```

See [docs/howto-build.md](docs/howto-build.md) for details.

### Versioning

The current version is `1.0.20260921` and lives in [`version.json`](version.json). Change that file to bump the version; the workflow reads it as the release version.

### Automated releases

The workflow lives in [`.github/workflows/release-packages.yml`](.github/workflows/release-packages.yml). It runs when a release is published, when a `v*` or `[0-9]*` tag is pushed, or when it is triggered manually, and it builds the Linux, Windows and macOS packages in parallel before uploading them to the matching release.

### First launch on macOS

Because the DMGs use an ad-hoc signature instead of an Apple developer certificate, Gatekeeper may warn that the developer cannot be verified. Right-click CodeEditor and choose Open, or run:

```bash
xattr -dr com.apple.quarantine /Applications/CodeEditor.app
```

### License

The build scripts are released under the [MIT](LICENSE) license, and so are the binaries they produce.
