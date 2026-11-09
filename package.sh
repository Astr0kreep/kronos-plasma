#!/usr/bin/env bash
# Build a .plasmoid archive for the KDE Store (and for manual installs).
#
#   ./package.sh            -> dist/kronos-clock-<version>.plasmoid
#
# The archive is a plain zip with metadata.json at the top level, which is
# what KPackage (and therefore "Get New Widgets") expects.
set -euo pipefail

cd "$(dirname "$0")"
PKG=org.kronos.clock
VERSION=$(python3 -c 'import json;print(json.load(open("'"$PKG"'/metadata.json"))["KPlugin"]["Version"])')
OUT="dist/kronos-clock-${VERSION}.plasmoid"

mkdir -p dist
rm -f "$OUT"
( cd "$PKG" && zip -r -q "../$OUT" metadata.json LICENSE contents -x '*~' -x '*.orig' )

echo "built $OUT ($(stat -c%s "$OUT") bytes)"
echo
echo "sanity check:"
rm -rf .pkgcheck && mkdir -p .pkgcheck
kpackagetool6 --type Plasma/Applet --install "$OUT" --packageroot .pkgcheck >/dev/null
echo "  installs cleanly via kpackagetool6"
rm -rf .pkgcheck
