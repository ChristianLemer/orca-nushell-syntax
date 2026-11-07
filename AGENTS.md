# Agent notes for orca-nushell-syntax

Project-specific instructions for AI assistants working in this repo. What the plugin is and
does is in [README.md](README.md).

## Shape

An Orca data plugin (`"execution": "data"`): no code, no build. It follows Orca's official
Gleam plugin (`stablyai/orca-plugins`, `plugins/gleam`).

```
orca-plugin.json                      manifest; id "nushell-syntax", never "orca-…"
syntaxes/nushell.tmLanguage.json      upstream grammar, verbatim
syntaxes/language-configuration.json  comments, brackets, auto-closing and surrounding pairs
scripts/sync-grammar.nu               fetches the grammar at an upstream commit
samples/sample.nu, sample.nuon        the files to open in Orca and look at
```

The Orca reference is `docs/reference/plugin-authoring.md` and `plugin-syntax.md` in
`stablyai/orca`.

## Language

Everything in the repository is English: files, commit messages, branch names, pull requests.

## Git

- `main` moves only through pull requests. Never commit to it directly or force-push it.
- One short branch per change, named for the work, merged with a **rebase**, deleted at merge.
- Each commit is one decision with its reason in the message.
- An agent opens the pull request; the maintainer merges.

## Checking a change

Needs Orca 1.4.246 or newer (`orca --version`): older versions have no `orca plugin` commands.

```bash
orca plugin validate .     # the manifest checks Orca runs, strictly
orca plugin dev load .     # loads the folder as local.nushell-syntax
```

Then open the samples and look: keywords, strings, interpolation, comments, records, tables,
closures. Toggle a comment and type a bracket. Orca reloads on save; `orca plugin dev unload .`
removes it. Add to the samples whatever a change touches: they are the only regression check.

## The grammar

- `syntaxes/nushell.tmLanguage.json` is upstream's file, unchanged. Update it only with
  `scripts/sync-grammar.nu`, in a commit of its own whose message names the upstream commit.
- Whether to patch it locally is not decided yet. Until then, don't edit it by hand: report
  what looks wrong, with the sample line that shows it.
- Keep the attribution in `LICENSE` and the README's credits.

## Release

Listed on Orca's plugin directory when the repository is public, has the `orca-plugin` topic,
and carries a `vX.Y.Z` tag on a commit whose `orca-plugin.json` says `X.Y.Z`. Those three steps
are the maintainer's.

- Leave `publisher` out of the manifest; Orca takes the repository owner.
- The release commit changes only the `version`, with the message `Bump to X.Y.Z`.
- Cover and screenshot (`images/`, with `cover.alt`) come with the first release, in a commit
  before the bump.
