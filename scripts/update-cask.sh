#!/usr/bin/env bash
# Reescribe Casks/rfirma.rb con la última Release estable de rFirma que trae el .dmg.
set -euo pipefail

repo=sgomez/rfirma
cask="$(dirname "$0")/../Casks/rfirma.rb"

release=$(gh api "repos/$repo/releases/latest")
tag=$(jq -r .tag_name <<<"$release")
version=${tag#v}
dmg="rfirma_${version}_aarch64.dmg"

if ! jq -e --arg dmg "$dmg" '.assets[] | select(.name == $dmg)' <<<"$release" >/dev/null; then
    echo "$tag no trae $dmg: el cask no cambia"
    exit 0
fi

current=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$cask")
if [ "$current" = "$version" ]; then
    echo "el cask ya está en $version"
    exit 0
fi

dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT
gh release download "$tag" --repo "$repo" --pattern "$dmg" --dir "$dir"
sha=$(shasum -a 256 "$dir/$dmg" | cut -d' ' -f1)

sed -i.bak \
    -e "s/^  version \".*\"$/  version \"$version\"/" \
    -e "s/^  sha256 \".*\"$/  sha256 \"$sha\"/" \
    "$cask"
rm -f "$cask.bak"
echo "cask: $current -> $version"
