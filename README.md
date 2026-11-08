# orca-nushell-syntax

Nushell syntax highlighting for [Orca](https://www.onorca.dev): `.nu` scripts and `.nuon` data files.

> **Status: not released yet.** It can be loaded from a checkout; see [AGENTS.md](AGENTS.md#checking-a-change).

## What it adds

- Highlighting for `.nu` and `.nuon` files in Orca's editor.
- Comment toggling with `#`, bracket matching, and auto-closing brackets and quotes.

It is a data plugin: it runs no code, and installs in one click.

## Credits

The grammar is `syntaxes/nushell.tmLanguage.json` from
[nushell/vscode-nushell-lang](https://github.com/nushell/vscode-nushell-lang), by the Nushell
Project Developers, under the MIT license. It is copied unchanged, currently from
upstream commit `ffd0e93105a9bad1303583a43f47eae7d0e34dab`.
This plugin packages it for Orca; `scripts/sync-grammar.nu` brings it in step with upstream.

## License

MIT. See [LICENSE](LICENSE), which also carries the grammar's notice.
