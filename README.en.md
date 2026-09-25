<div align=center>
<img src="./icon.png" style="width:100px;" width="100"/>
<h2>CodeEditor</h2>
<p>蜥蜴编辑器</p>
</div>

[中文](README.md)

### 1. About
- CodeEditor (蜥蜴编辑器) is a freely licensed editor distribution: a Simplified Chinese interface out of the box, telemetry and tracking off by default, extensions served from [open-vsx.org](https://open-vsx.org), and installers for every mainstream architecture on three platforms.
- Package identifiers use `org.mutantcat.*`, and the app ships with [`icon.png`](./icon.png).
- The current version is `1.0.20260922` and lives in [`version.json`](version.json); edit that file to bump the version.
- Versions look like `major.minor.YYYYMMDD`. Iterating in CI never appends a `-1` or `-2` suffix: when the day is already taken, the date simply moves on, so `1.0.20260922` is followed by `1.0.20260923`.
- **Publisher** Mutantcat Working Group (mutantcat.org) · GitHub: https://github.com/Mutantcat-Working-Group

### 2. Features
- Windows installers built with NSIS, per-user install, no administrator rights required
- macOS DMGs with an ad-hoc code signature for both Intel and Apple Silicon
- Linux AppImages that run without installation
- GitHub Actions builds and uploads every package when a release is published or a version tag is pushed

### 3. Interface language
- The interface defaults to Simplified Chinese, and the language pack ships inside the installer, so there is nothing extra to install
- It lives at `resources/app/out/languagepacks/` inside the install directory and comes from [`languagepacks/`](languagepacks/) in this repository
- The `workbench.language` setting controls the interface language; search for "language" in Settings to find it. It takes `auto`, `zh-cn` or `en`
- `auto` follows the operating system, so a Chinese system opens in Chinese and anything else opens in English; picking another value asks for a restart, and cancelling falls back to the language that is still in effect
- Pass `--locale=en` for a one-off switch; it takes precedence over the setting
- The command palette (`Ctrl+Shift+P`) also has a "Configure Display Language" entry

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

### 7. Build from Source and Release
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


1. The workflow lives in [`.github/workflows/release-packages.yml`](.github/workflows/release-packages.yml)
2. It runs when a release is published, when a `v*` or `[0-9]*` tag is pushed, or when triggered manually from the Actions page
3. It then builds the Linux, Windows and macOS packages in parallel and uploads them to the matching release

### 8. License
- The build scripts are released under the [MIT](LICENSE) license, and so are the binaries they produce.
