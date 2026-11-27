# Changelog

What changed for someone who installs the plugin, newest first. Versions follow
[semantic versioning](https://semver.org).

## Unreleased

- Nushell 0.117: type aliases (`type Name = <type>`, `export type`) and flags on `extern`, such
  as `--strict`, are highlighted. The grammar is now upstream's commit `5d42e9a7c533`.

## 0.1.1 (2026-11-17)

- The grammar's license ships beside it as `syntaxes/nushell-LICENSE.txt`.
- The manifest names the plugin's author.
- A sharper cover and screenshot on the plugin's page, showing two different parts of a script.

## 0.1.0 (2026-11-08)

First release.

- Highlighting for `.nu` and `.nuon` files, with the grammar of
  [nushell/vscode-nushell-lang](https://github.com/nushell/vscode-nushell-lang) at commit
  `ffd0e93105a9`.
- Comment toggling with `#`, bracket matching, and auto-closing brackets and quotes.
