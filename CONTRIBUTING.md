# Contributing

Thanks for looking. This plugin is small on purpose: it packages the Nushell grammar for Orca
and keeps it in step with upstream.

## Where a fix belongs

- **A wrong color.** The grammar is
  [nushell/vscode-nushell-lang](https://github.com/nushell/vscode-nushell-lang)'s file,
  unchanged. Open the same code in VS Code with the Nushell extension: if the color is wrong
  there too, report it upstream. Once it is fixed there, a sync brings it here.
- **Anything else.** A file that is not highlighted, comment toggling, brackets, auto-closing,
  the plugin's page: open an issue here, with the line that shows it.

## Checking a change

Needs Orca 1.4.246 or newer.

```sh
orca plugin validate .     # the manifest checks Orca runs
orca plugin dev load .     # loads the folder as local.nushell-syntax
```

Open `samples/sample.nu` and `samples/sample.nuon` in Orca and look. If your change touches a
construct the samples do not show, add it to them. `orca plugin dev unload .` removes the
plugin.

CI tokenizes the samples and compares the result with `tests/snapshots/`. After changing a
sample, update them and read the diff:

```sh
cd tests && npm ci --ignore-scripts && npm run update
```

## Pull requests

- One pull request per subject, with one commit per decision and its reason in the message.
- Do not edit `syntaxes/nushell.tmLanguage.json` by hand. `scripts/sync-grammar.nu` updates it
  from upstream.
- Add a line to `CHANGELOG.md` under "Unreleased" when the change is visible to someone who
  installs the plugin.
