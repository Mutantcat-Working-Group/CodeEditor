<div align=center>
<img src="./icon.png" style="width:100px;" width="100"/>
<h2>蜥蜴编辑器</h2>
<p>CodeEditor</p>
</div>

[English](README.en.md)

### 一、产品概述
- CodeEditor（中文名：蜥蜴编辑器）是一套构建脚本，它把 [Microsoft 的 vscode 仓库](https://github.com/microsoft/vscode) 打包成自由许可的二进制文件，并配好一套开箱可用的默认配置。
- 本项目由 Mutantcat Working Group 维护，包名统一为 `org.mutantcat.*`，图标为 [`icon.png`](./icon.png)。
- 当前版本 `1.0.20260922`，记录在 [`version.json`](version.json) 中，修改该文件即可升级版本号。
- 版本号形如 `主版本.次版本.年月日`。CI 迭代时不会追加 `-1`、`-2` 这样的后缀：如果当天版本已被占用，就把日期往后推一天，例如 `1.0.20260922` 之后是 `1.0.20260923`。

核心价值：装的是一份默认关掉遥测、扩展市场指向 open-vsx.org、界面直接就是中文的 VS Code，三个平台全部主流架构都有开箱即用的安装包。

### 二、功能说明

#### 默认中文界面

- 界面默认使用简体中文，语言包随安装包一起分发，不需要额外安装
- 语言包位于安装目录的 `resources/app/out/languagepacks/`，源码仓库中对应 [`languagepacks/`](languagepacks/) 目录
- 设置项 `workbench.language` 控制界面语言，在设置界面搜索「语言」即可找到，可选 `auto`、`zh-cn`、`en`
- `auto` 跟随操作系统：中文系统进中文，其他系统进英文；改成其他取值会弹出重启确认，取消则回退到当前生效的语言
- 想临时换一种语言，启动时加 `--locale=en`，参数优先级高于设置项
- 命令面板（`Ctrl+Shift+P`）里也有「配置显示语言」

```
CodeEditor.exe --locale=en                                     # Windows 临时切换
open -a 蜥蜴编辑器 --args --locale=en                          # macOS 临时切换
./CodeEditor-1.0.20260922-anylinux-x86_64.AppImage --locale=en # Linux 临时切换
```

#### 平台与许可

- 默认关闭遥测与追踪，扩展市场指向 [open-vsx.org](https://open-vsx.org)
- 覆盖三大平台、全部主流架构，下载后双击即可使用
- Windows 提供 NSIS 安装包，每用户安装，不需要管理员权限
- macOS 提供 ad-hoc 签名的 DMG，同时支持 Intel 与 Apple Silicon
- Linux 提供 AppImage，无需安装即可运行

### 三、安装与下载

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

#### 安装包一览

| 平台 | 架构 | 文件 | 格式 |
| --- | --- | --- | --- |
| Windows | x64 | `CodeEditorSetup-x64-1.0.20260922.exe` | NSIS 安装包 |
| Windows | arm64 | `CodeEditorSetup-arm64-1.0.20260922.exe` | NSIS 安装包 |
| macOS | x64（Intel） | `CodeEditor.x64.1.0.20260922.dmg` | ad-hoc 签名 DMG |
| macOS | arm64（Apple Silicon） | `CodeEditor.arm64.1.0.20260922.dmg` | ad-hoc 签名 DMG |
| Linux | x86_64 | `CodeEditor-1.0.20260922-anylinux-x86_64.AppImage` | AppImage |
| Linux | aarch64 | `CodeEditor-1.0.20260922-anylinux-aarch64.AppImage` | AppImage |

每个文件都会同时上传 `.sha1` 与 `.sha256` 校验和，可用于核对下载内容。

#### macOS 首次启动

1. 由于 DMG 使用 ad-hoc 签名而非 Apple 开发者证书，首次打开时 Gatekeeper 可能提示无法验证开发者
2. 右键点击「蜥蜴编辑器」选择「打开」即可
3. 也可以在终端执行下面这行命令移除隔离属性

```
xattr -dr com.apple.quarantine "/Applications/蜥蜴编辑器.app"
```

#### 自动发布

发布 Release 或推送版本 tag 时，由 GitHub Actions 自动构建并上传安装包。工作流定义见 [`.github/workflows/release-packages.yml`](.github/workflows/release-packages.yml)，触发方式有三种：发布 Release、推送 `v*` 或 `[0-9]*` 开头的 tag、在 Actions 页面手动触发。触发后并行构建 Linux、Windows 与 macOS 三个平台的安装包，并上传到对应的 Release 中。

### 四、从源码构建

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

### 五、开源协议

- 本项目构建脚本基于 [MIT](LICENSE) 许可发布，构建产物同样以 MIT 许可分发。

---

## 致谢

本项目是 [VSCodium/vscodium](https://github.com/VSCodium/vscodium) 的 Fork，感谢原仓库及其作者的优秀开源工作，本仓库在其基础上继续维护与改进。
