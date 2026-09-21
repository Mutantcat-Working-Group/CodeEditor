## Source

`codeeditor-icon.png` is the single source image for CodeEditor branding.
`build_icons.sh` generates the platform icons (`.icns`, `.ico`, `.png`, `.xpm`,
SVG media) from it.

## Watermark

`watermark/letterpress-*.svg` are the lizard silhouettes shown in the middle of
an empty editor group, one colour per theme (light, dark, and both high
contrast variants). They are traced from `codeeditor-icon.png` and copied over
the upstream files by `prepare_vscode.sh`.
