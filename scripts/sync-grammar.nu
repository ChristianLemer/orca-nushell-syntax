#!/usr/bin/env nu

# Bring syntaxes/nushell.tmLanguage.json in step with nushell/vscode-nushell-lang.
#
# The grammar is copied byte for byte. The upstream commit it comes from is written into
# the README's credits, and printed so the sync commit's message can name it.
def main [
  ref: string = "main"  # upstream branch, tag or commit to sync from
] {
  let repo = "nushell/vscode-nushell-lang"
  let root = $env.FILE_PWD | path dirname

  # Check the credits can be updated before touching anything.
  let readme = $root | path join README.md
  let marker = 'upstream commit `[0-9a-f]{40}`'
  let text = open --raw $readme
  if ($text | find --regex $marker | is-empty) {
    error make { msg: $"README.md has no line matching ($marker): the credits would go stale" }
  }

  # Resolve the ref first, so the file and the record name the same commit even if
  # upstream moves while this runs.
  let sha = http get $"https://api.github.com/repos/($repo)/commits/($ref)" | get sha
  http get --raw $"https://raw.githubusercontent.com/($repo)/($sha)/syntaxes/nushell.tmLanguage.json"
  | save --raw --force ($root | path join syntaxes nushell.tmLanguage.json)

  $text
  | str replace --regex $marker $"upstream commit `($sha)`"
  | save --raw --force $readme

  print $"Synced the grammar from ($repo)@($sha)"
  print $"Commit message: Sync the grammar from upstream ($sha | str substring 0..<12)"
}
