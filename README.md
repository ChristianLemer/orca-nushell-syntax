# orca-nushell-syntax

Nushell syntax highlighting for [Orca](https://www.onorca.dev): `.nu` scripts and `.nuon` data files.

## What it adds

- Highlighting for `.nu` and `.nuon` files in Orca's editor.
- Comment toggling with `#`, bracket matching, and auto-closing brackets and quotes.

It is a data plugin: it runs no code, and installs in one click.

## Install

Needs Orca 1.4.246 or newer.

```sh
orca plugin install ChristianLemer/orca-nushell-syntax
```

Its page in Orca's plugin directory is
[onorca.dev/plugins/ChristianLemer/orca-nushell-syntax](https://www.onorca.dev/plugins/ChristianLemer/orca-nushell-syntax).

It installs as `christianlemer.nushell-syntax`, and colors every open `.nu` and `.nuon` file at
once, without a reload. To remove it: `orca plugin uninstall christianlemer.nushell-syntax`.

## Credits

The grammar is `syntaxes/nushell.tmLanguage.json` from
[nushell/vscode-nushell-lang](https://github.com/nushell/vscode-nushell-lang), by the Nushell
Project Developers, under the MIT license. It is copied unchanged, currently from
upstream commit `ffd0e93105a9bad1303583a43f47eae7d0e34dab`.
This plugin packages it for Orca; `scripts/sync-grammar.nu` brings it in step with upstream.

## License

MIT. See [LICENSE](LICENSE), which also carries the grammar's notice.
