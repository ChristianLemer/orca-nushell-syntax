#!/usr/bin/env nu

# Bring syntaxes/nushell.tmLanguage.json in step with nushell/vscode-nushell-lang.
#
# The grammar and upstream's license are copied byte for byte, from the same commit. That
# commit is written into the README's credits, and printed so the sync commit's message can
# name it.
#
# With --check nothing is written: the two files are compared with upstream at the commit
# the README names, and the script fails when one of them differs.

const REPO = "nushell/vscode-nushell-lang"
const MARKER = 'upstream commit `(?<sha>[0-9a-f]{40})`'

# What is copied: path here, path upstream.
const FILES = [
  [local upstream];
  [syntaxes/nushell.tmLanguage.json syntaxes/nushell.tmLanguage.json]
  [syntaxes/nushell-LICENSE.txt LICENSE]
]

def upstream-bytes [sha: string, path: string]: nothing -> binary {
  http get --raw $"https://raw.githubusercontent.com/($REPO)/($sha)/($path)" | into binary
}

def main [
  ref: string = "main"  # upstream branch, tag or commit to sync from
  --check               # compare with the commit the README names, and write nothing
] {
  let root = $env.FILE_PWD | path dirname

  # Check the credits can be read and updated before touching anything.
  let readme = $root | path join README.md
  let text = open --raw $readme
  let pinned = $text | parse --regex $MARKER
  if ($pinned | is-empty) {
    error make { msg: $"README.md has no line matching ($MARKER): the credits would go stale" }
  }

  if $check {
    let sha = $pinned.sha.0
    let changed = $FILES | where {|f|
      (upstream-bytes $sha $f.upstream) != (open --raw ($root | path join $f.local) | into binary)
    }
    if ($changed | is-not-empty) {
      error make { msg: $"Not upstream's bytes at ($sha): ($changed.local | str join ', ')" }
    }
    print $"The grammar and its license are ($REPO)@($sha), unchanged"
    return
  }

  # Resolve the ref first, so the files and the record name the same commit even if
  # upstream moves while this runs.
  let sha = http get $"https://api.github.com/repos/($REPO)/commits/($ref)" | get sha
  for f in $FILES {
    upstream-bytes $sha $f.upstream | save --raw --force ($root | path join $f.local)
  }

  $text
  | str replace --regex 'upstream commit `[0-9a-f]{40}`' $"upstream commit `($sha)`"
  | save --raw --force $readme

  print $"Synced the grammar from ($REPO)@($sha)"
  print $"Commit message: Sync the grammar from upstream ($sha | str substring 0..<12)"
}
