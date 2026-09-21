<div align=center>
<img src="./icon.png" style="width:100px;" width="100"/>
<h2>蜥蜴编辑器</h2>
<p>CodeEditor</p>
</div>

语言：<a href="#zh-cn">中文</a> ｜ <a href="#english">English</a>

## <a id="zh-cn"></a>中文

### 一、项目简介
- CodeEditor（中文名：蜥蜴编辑器）是一套构建脚本，它把 [Microsoft 的 vscode 仓库](https://github.com/microsoft/vscode) 打包成自由许可的二进制文件，并配好一套开箱可用的默认配置。
- 本项目由 Mutantcat Working Group 维护，包名统一为 `org.mutantcat.*`，图标为 [`icon.png`](./icon.png)。
- 当前版本 `1.0.20260922`，记录在 [`version.json`](version.json) 中，修改该文件即可升级版本号。

### 二、功能特性
- 默认关闭遥测与追踪，扩展市场指向 [open-vsx.org](https://open-vsx.org)
- 覆盖三大平台、全部主流架构，下载后双击即可使用
- Windows 提供 NSIS 安装包，每用户安装，不需要管理员权限
- macOS 提供 ad-hoc 签名的 DMG，同时支持 Intel 与 Apple Silicon
- Linux 提供 AppImage，无需安装即可运行
- 发布 Release 或推送版本 tag 时，由 GitHub Actions 自动构建并上传安装包

### 三、界面语言
- 界面默认使用简体中文，语言包随安装包一起分发，不需要额外安装
- 语言包位于安装目录的 `resources/app/out/languagepacks/`，源码仓库中对应 [`languagepacks/`](languagepacks/) 目录
- 想临时换回英文，启动时加 `--locale=en`；想永久切换，在用户目录的 `argv.json` 里写入 `"locale": "en"`
- 也可以用命令面板（`Ctrl+Shift+P`）执行“配置显示语言”，选中 English 后重启即可

```
CodeEditor.exe --locale=en                                     # Windows 临时切换
open -a 蜥蜴编辑器 --args --locale=en                          # macOS 临时切换
./CodeEditor-1.0.20260922-anylinux-x86_64.AppImage --locale=en # Linux 临时切换
```

### 四、下载与安装
1. 打开 [Releases](https://github.com/Mutantcat-Working-Group/CodeEditor/releases/latest) 页面
2. 按下表选择自己平台和架构对应的文件
3. 下载后直接运行，无需额外依赖

```
Windows
   下载 CodeEditorSetup-x64-1.0.20260922.exe 或 CodeEditorSetup-arm64-1.0.20260922.exe，双击运行。
   默认安装到 %LOCALAPPDATA%\Programs\CodeEditor，不需要管理员权限，可在系统设置中正常卸载。

macOS
   下载 CodeEditor.x64.1.0.20260922.dmg（Intel）或 CodeEditor.arm64.1.0.20260922.dmg（Apple Silicon）。
   打开后把「蜥蜴编辑器」拖到 Applications，两个 DMG 都带有 ad-hoc 签名。

Linux
   下载 CodeEditor-1.0.20260922-anylinux-x86_64.AppImage 或 CodeEditor-1.0.20260922-anylinux-aarch64.AppImage。
   chmod +x CodeEditor-1.0.20260922-anylinux-x86_64.AppImage
   ./CodeEditor-1.0.20260922-anylinux-x86_64.AppImage
```

### 五、安装包一览

| 平台 | 架构 | 文件 | 格式 |
| --- | --- | --- | --- |
| Windows | x64 | `CodeEditorSetup-x64-1.0.20260922.exe` | NSIS 安装包 |
| Windows | arm64 | `CodeEditorSetup-arm64-1.0.20260922.exe` | NSIS 安装包 |
| macOS | x64（Intel） | `CodeEditor.x64.1.0.20260922.dmg` | ad-hoc 签名 DMG |
| macOS | arm64（Apple Silicon） | `CodeEditor.arm64.1.0.20260922.dmg` | ad-hoc 签名 DMG |
| Linux | x86_64 | `CodeEditor-1.0.20260922-anylinux-x86_64.AppImage` | AppImage |
| Linux | aarch64 | `CodeEditor-1.0.20260922-anylinux-aarch64.AppImage` | AppImage |

每个文件都会同时上传 `.sha1` 与 `.sha256` 校验和，可用于核对下载内容。

### 六、macOS 首次启动
1. 由于 DMG 使用 ad-hoc 签名而非 Apple 开发者证书，首次打开时 Gatekeeper 可能提示无法验证开发者
2. 右键点击「蜥蜴编辑器」选择“打开”即可
3. 也可以在终端执行下面这行命令移除隔离属性

```
xattr -dr com.apple.quarantine "/Applications/蜥蜴编辑器.app"
```

### 七、从源码构建
1. 构建脚本会克隆 Microsoft 的 vscode 仓库并执行官方构建流程，因此需要 Node.js、Python 与 Git
2. 依次执行下面三条命令

```
git clone https://github.com/Mutantcat-Working-Group/CodeEditor.git
cd CodeEditor

./get_repo.sh       # 克隆对应版本的 vscode
./build.sh          # 构建编辑器
./prepare_assets.sh # 打包当前平台的产物
```

更详细的说明见 [docs/howto-build.md](docs/howto-build.md)。

### 八、自动发布
1. 工作流定义见 [`.github/workflows/release-packages.yml`](.github/workflows/release-packages.yml)
2. 触发方式有三种：发布 Release、推送 `v*` 或 `[0-9]*` 开头的 tag、在 Actions 页面手动触发
3. 触发后并行构建 Linux、Windows 与 macOS 三个平台的安装包，并上传到对应的 Release 中

### 九、许可证
- 本项目构建脚本基于 [MIT](LICENSE) 许可发布，构建产物同样以 MIT 许可分发。

## <a id="english"></a>English

### 1. About
- CodeEditor (蜥蜴编辑器) is a repository of build scripts that turns [Microsoft's vscode repository](https://github.com/microsoft/vscode) into freely licensed binaries with a community-driven default configuration.
- It is maintained by the Mutantcat Working Group, uses `org.mutantcat.*` package identifiers, and ships with [`icon.png`](./icon.png).
- The current version is `1.0.20260922` and lives in [`version.json`](version.json); edit that file to bump the version.

### 2. Features
- Telemetry and tracking disabled by default, extensions served from [open-vsx.org](https://open-vsx.org)
- Installers for three platforms and every mainstream architecture, ready to run after download
- Windows installers built with NSIS, per-user install, no administrator rights required
- macOS DMGs with an ad-hoc code signature for both Intel and Apple Silicon
- Linux AppImages that run without installation
- GitHub Actions builds and uploads every package when a release is published or a version tag is pushed

### 3. Interface language
- The interface defaults to Simplified Chinese, and the language pack ships inside the installer, so there is nothing extra to install
- It lives at `resources/app/out/languagepacks/` inside the install directory and comes from [`languagepacks/`](languagepacks/) in this repository
- Pass `--locale=en` for a one-off switch back to English, or write `"locale": "en"` into `argv.json` in your user directory to make it permanent
- The command palette (`Ctrl+Shift+P`) also has a "Configure Display Language" entry, which writes `argv.json` for you

```
CodeEditor.exe --locale=en                                     # Windows, one-off switch
open -a 蜥蜴编辑器 --args --locale=en                          # macOS, one-off switch
./CodeEditor-1.0.20260922-anylinux-x86_64.AppImage --locale=en # Linux, one-off switch
```

### 4. Download and install
1. Open the [Releases](https://github.com/Mutantcat-Working-Group/CodeEditor/releases/latest) page
2. Pick the file that matches your platform and architecture from the table below
3. Download it and run it, no extra dependencies required

```
Windows
   Download CodeEditorSetup-x64-1.0.20260922.exe or CodeEditorSetup-arm64-1.0.20260922.exe and run it.
   It installs into %LOCALAPPDATA%\Programs\CodeEditor without asking for administrator rights,
   and can be removed from Windows Settings.

macOS
   Download CodeEditor.x64.1.0.20260922.dmg (Intel) or CodeEditor.arm64.1.0.20260922.dmg (Apple Silicon).
   Drag 蜥蜴编辑器 into Applications. Both DMGs carry an ad-hoc signature.

Linux
   Download CodeEditor-1.0.20260922-anylinux-x86_64.AppImage or CodeEditor-1.0.20260922-anylinux-aarch64.AppImage.
   chmod +x CodeEditor-1.0.20260922-anylinux-x86_64.AppImage
   ./CodeEditor-1.0.20260922-anylinux-x86_64.AppImage
```

### 5. Packages

| Platform | Architecture | File | Format |
| --- | --- | --- | --- |
| Windows | x64 | `CodeEditorSetup-x64-1.0.20260922.exe` | NSIS installer |
| Windows | arm64 | `CodeEditorSetup-arm64-1.0.20260922.exe` | NSIS installer |
| macOS | x64 (Intel) | `CodeEditor.x64.1.0.20260922.dmg` | ad-hoc signed DMG |
| macOS | arm64 (Apple Silicon) | `CodeEditor.arm64.1.0.20260922.dmg` | ad-hoc signed DMG |
| Linux | x86_64 | `CodeEditor-1.0.20260922-anylinux-x86_64.AppImage` | AppImage |
| Linux | aarch64 | `CodeEditor-1.0.20260922-anylinux-aarch64.AppImage` | AppImage |

Every file is published together with `.sha1` and `.sha256` checksums.

### 6. First launch on macOS
1. Because the DMGs use an ad-hoc signature instead of an Apple developer certificate, Gatekeeper may warn that the developer cannot be verified
2. Right-click 蜥蜴编辑器 and choose Open
3. Or strip the quarantine attribute from a terminal

```
xattr -dr com.apple.quarantine "/Applications/蜥蜴编辑器.app"
```

### 7. Build from source
1. The scripts clone Microsoft's vscode repository and run the official build, so you need Node.js, Python and Git
2. Run the three commands below

```
git clone https://github.com/Mutantcat-Working-Group/CodeEditor.git
cd CodeEditor

./get_repo.sh       # clone the matching vscode revision
./build.sh          # build the editor
./prepare_assets.sh # package artifacts for the current platform
```

See [docs/howto-build.md](docs/howto-build.md) for details.

### 8. Automated releases
1. The workflow lives in [`.github/workflows/release-packages.yml`](.github/workflows/release-packages.yml)
2. It runs when a release is published, when a `v*` or `[0-9]*` tag is pushed, or when triggered manually from the Actions page
3. It then builds the Linux, Windows and macOS packages in parallel and uploads them to the matching release

### 9. License
- The build scripts are released under the [MIT](LICENSE) license, and so are the binaries they produce.
