#!/usr/bin/env fish
# Points this repo's git hooks at .githooks/. Run once after cloning.

set -l repo (realpath (dirname (status filename)))
git -C $repo config core.hooksPath .githooks
echo "core.hooksPath set to .githooks"
