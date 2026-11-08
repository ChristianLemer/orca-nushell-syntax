#!/usr/bin/env nu

# A sample covering the constructs the grammar should color.
# Open it in Orca with the plugin loaded and look.

use std/log
const DEFAULT_LIMIT = 10

# Custom command with typed, optional and rest parameters, a flag and a doc comment
export def "repo summary" [
  path: path = .         # where to look
  --limit (-l): int = 10 # how many rows
  --verbose (-v)         # a switch
  ...extra: string       # rest parameters
]: nothing -> table {
  let files = ls $path | where type == file | sort-by size --reverse
  mut total = 0
  for f in $files { $total += $f.size }
  if $verbose { log info $"($files | length) files, ($total) in total" }
  $files | first $limit | select name size modified
}

# Strings: double, single, backtick, raw, and interpolated
let name = "Nushell"
let quoted = 'single quoted'
let bare = `with spaces`
let raw = r#'a raw string with 'quotes' inside'#
print $"Hello, ($name)! 2 + 2 = (2 + 2)"
print $'single interpolation: ($quoted)'
print "escapes: \t tab \n newline \" quote"

# Numbers, durations, file sizes, dates, booleans, null, ranges
let n = 42
let pi = 3.14159
let hex = 0xff
let wait = 1.5sec
let big = 2GiB
let when = 2026-11-08T10:30:00+01:00
let flags = [true false null]
let r = 1..10
let stepped = 0..2..10

# Records, lists and tables
let config = {
  name: "orca-nushell-syntax"
  version: "0.1.0"
  tags: [orca nushell syntax]
  nested: { enabled: true, count: 3 }
}
let people = [[name age]; [Alice 31] [Bob 27]]
$config.nested.count
$config | get tags.0
$people | where age > 30 | get name

# Closures, pipelines and blocks
[1 2 3] | each {|x| $x * 2 } | reduce {|it, acc| $acc + $it }
ls | where size > 1kb | sort-by modified | last 3
$people | par-each {|p| $"($p.name) is ($p.age)" }

# Control flow
match $n {
  0 => "zero"
  1..9 => "small"
  _ => "large"
}
while $n > 40 { break }
loop { break }
try { error make { msg: "boom" } } catch {|e| print $e.msg }

# Operators
let ok = ($n mod 2 == 0) and not ($name starts-with "X") or ($name =~ "shell")
let joined = [a b] ++ [c d]

# External commands, environment, redirection, subexpressions
^git status --short
$env.PATH = ($env.PATH | prepend ~/.local/bin)
$env.config.show_banner = false
let today = (date now | format date "%Y-%m-%d")
cargo build o+e> build.log
let count = ($people | length)

# Aliases, modules, overlays, exports
alias ll = ls -l
module greetings {
  export def hello [who: string] { $"hello ($who)" }
}
use greetings hello
overlay use greetings

# Table and record types in signatures
def typed [data: record<name: string, age: int>, rows: list<string>]: table -> list<any> {
  $data | values
}
