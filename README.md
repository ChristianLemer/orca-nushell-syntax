# orca-nushell-syntax

Nushell syntax highlighting for [Orca](https://www.onorca.dev): `.nu` scripts and `.nuon` data files.

> **Status: in design.** Nothing is released yet.

## What it adds

- Highlighting for `.nu` and `.nuon` files in Orca's editor.
- Comment toggling with `#`, bracket matching, and auto-closing brackets and quotes.

It is a data plugin: it runs no code, and installs in one click.

## Credits

The grammar is `syntaxes/nushell.tmLanguage.json` from
[nushell/vscode-nushell-lang](https://github.com/nushell/vscode-nushell-lang), by the Nushell
Project Developers, under the MIT license. This plugin packages it for Orca and keeps it in
step with upstream.

## License

MIT. See [LICENSE](LICENSE).
