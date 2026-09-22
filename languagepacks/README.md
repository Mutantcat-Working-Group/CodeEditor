# 内置语言包

CodeEditor 的界面默认使用简体中文，靠的就是这里面的语言包。构建时 `prepare_vscode.sh` 会把整个目录复制进 vscode 源码树，打包任务再把它放进应用的 `out/languagepacks/` 目录，主进程的 `resolveNLSConfiguration` 从那里读取，因此不需要用户额外安装任何扩展。

## 文件布局

```
languagepacks/
   languagepacks.json
   zh-hans/translations/main.i18n.json
   zh-hans/translations/extensions/*.i18n.json
   zh-hans/LICENSE.md
   zh-hans/ThirdPartyNotices.txt
```

各文件的用途：

- `languagepacks.json`：语言包索引，键是 locale，值是 `hash`、`label`、`extensions` 与 `translations`
- `zh-hans/translations/main.i18n.json`：核心界面翻译，覆盖两千多个模块
- `zh-hans/translations/extensions/*.i18n.json`：内置扩展的翻译
- `zh-hans/LICENSE.md` 与 `zh-hans/ThirdPartyNotices.txt`：上游 MIT 许可与第三方声明

`languagepacks.json` 里的 `translations` 使用相对路径，基址是应用内的 `<应用>/out/languagepacks`。主进程会在启动时把它们转换成绝对路径，所以整个目录可以随便搬动。

打包时 `languagepacks/README.md` 不会进应用，只有语言包数据和许可文件会。

## 来源

语言包取自 Marketplace 上的 `MS-CEINTL.vscode-language-pack-zh-hans`，版本 `1.131.2026090407`，只保留了翻译文件、许可与第三方声明，去掉了图标和说明文件。上游以 MIT 许可发布，因此随本仓库一并分发。

## 更新语言包

1. 从 Marketplace 下载新版 `MS-CEINTL.vscode-language-pack-zh-hans` 的 VSIX 并解压
2. 用解压出的 `translations/`、`LICENSE.md`、`ThirdPartyNotices.txt` 覆盖 `zh-hans/` 下的同名文件
3. 按新版的 `contributes.localizations[0].translations` 重新生成 `languagepacks.json`，`translations` 各项的路径要去掉开头的 `./`
4. 本地跑一遍 `ecformat check --verbose --ignore-file .ecformat_ignore`，确认没有格式问题

## 切换界面语言

界面语言由设置项 `workbench.language` 控制，设置界面里搜"语言"即可找到。它有三个取值：

- `auto`（默认）：跟随操作系统，中文系统进中文，其他系统进英文
- `zh-cn`：简体中文
- `en`：英文

选择非 `auto` 的值时会弹出重启确认；确认后 `patches/00-ui-language-setting.patch` 把目标 locale 写进 argv.json 的 `locale` 键（`auto` 则删掉这个键）并重启编辑器。取消重启时设置值会被还原成当前实际生效的语言，下拉框里看到的永远是真实状态。argv.json 被手工改过或被还原时，启动阶段会以它为准反向校正设置项。

`--locale` 命令行参数依然有效且优先级最高，但它不回写设置项，此时下拉框仍以 argv.json 的现状为准。

新增字符串要汉化，就在 `zh-hans/translations/main.i18n.json` 的 `contents` 下找到对应模块 id（形如 `vs/workbench/contrib/localization/electron-browser/localization.contribution`），按 `localize(key, "...")` 里的 key 补一条中文即可；没补的 key 会退回英文原文。
