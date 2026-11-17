# Agent notes for orca-nushell-syntax

Project-specific instructions for AI assistants working in this repo. What the plugin is and
does is in [README.md](README.md).

## Shape

An Orca data plugin (`"execution": "data"`): no code, no build. It follows Orca's official
Gleam plugin (`stablyai/orca-plugins`, `plugins/gleam`).

```
orca-plugin.json                      manifest; id "nushell-syntax", never "orca-…"
syntaxes/nushell.tmLanguage.json      upstream grammar, verbatim
syntaxes/nushell-LICENSE.txt          upstream's license, verbatim
syntaxes/language-configuration.json  comments, brackets, auto-closing and surrounding pairs
scripts/sync-grammar.nu               fetches the grammar at an upstream commit
samples/sample.nu, sample.nuon        the files to open in Orca and look at
tests/                                token snapshots of the samples (Node, development only)
.github/workflows/check.yml           what runs on every pull request and push to main
.github/workflows/upstream.yml        weekly: opens an issue when upstream changes the grammar
```

The Orca reference is `docs/reference/plugin-authoring.md` and `plugin-syntax.md` in
`stablyai/orca`.

## Language

Everything in the repository is English: files, commit messages, branch names, pull requests.

## Git

- One short branch and one pull request per subject, named for the work. Several commits are
  welcome, each one decision with its reason in the message.
- An agent opens the pull request; the maintainer merges, with a **rebase**. The branch is
  deleted at merge.
- A small fix that changes nothing in the plugin (a typo, a wording) may go straight to `main`
  when the maintainer asks for it. Without that request, an agent opens a pull request.
- Never force-push `main`.

## Checking a change

Needs Orca 1.4.246 or newer (`orca --version`): older versions have no `orca plugin` commands.

```bash
orca plugin validate .     # the manifest checks Orca runs, strictly
orca plugin dev load .     # loads the folder as local.nushell-syntax
```

Then open the samples and look: keywords, strings, interpolation, comments, records, tables,
closures. Toggle a comment and type a bracket. Orca reloads on save; `orca plugin dev unload .`
removes it. Add to the samples whatever a change touches.

The samples are also tokenized in CI and compared with `tests/snapshots/*.snap`, so a change in
how they are colored shows as a diff:

```bash
cd tests && npm ci --ignore-scripts
npm test          # fails when the tokens differ from the snapshots
npm run update    # rewrites the snapshots; read the diff before committing it
```

A snapshot records what the grammar does, right or wrong. It catches a change, not a mistake:
looking at the samples in Orca stays the check that the colors are right.

CI (`.github/workflows/check.yml`) also runs Orca's own validator at a pinned Orca commit, and
`scripts/sync-grammar.nu --check`, which fails when the grammar or its license is not upstream's
file at the commit the README names.

`orca plugin inspect .` refuses a checkout that holds the `meta` and `docs` links ("symlink not
allowed in plugin content"). They are never committed, so an install from Git never sees them;
`validate` and `dev load` accept the checkout as it is.

## The grammar

- `syntaxes/nushell.tmLanguage.json` and `syntaxes/nushell-LICENSE.txt` are upstream's files,
  unchanged. Update them only with `scripts/sync-grammar.nu`, in a commit of its own whose
  message names the upstream commit. Update the token snapshots in the commit after it, so
  their diff shows what the sync changed.
- Whether to patch it locally is not decided yet. Until then, don't edit it by hand: report
  what looks wrong, with the sample line that shows it.
- Keep the attribution: upstream's license beside the grammar, and the README's credits.
  `LICENSE` holds the plugin's own MIT text only, so that GitHub recognizes it.

## Release

Listed on Orca's plugin directory when the repository is public, has the `orca-plugin` topic,
and carries a `vX.Y.Z` tag on a commit whose `orca-plugin.json` says `X.Y.Z`. Those three steps
are the maintainer's.

- Leave `publisher` out of the manifest; Orca takes the repository owner.
- A change someone who installs the plugin would notice gets a line in `CHANGELOG.md`, under
  "Unreleased", in the pull request that makes it.
- The release commit changes only the `version` and turns the changelog's "Unreleased" into
  `X.Y.Z (date)`, with the message `Bump to X.Y.Z`.
- Cover and screenshot (`images/`, with `cover.alt`) come with the first release, in a commit
  before the bump.
