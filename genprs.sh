#!/bin/bash
set -e
root=$(pwd)
if [[ ! -d "./flathub" ]]; then
	echo "No repo found"
	exit 1
fi

for p in ./flatpak_packages/*; do
	echo $p
	if [[ -d "$p" ]] && [[ "$p" == ./flatpak_packages/Flat-Remix-GTK-* ]]; then
		fname=$(echo $p | sed 's/\.\/flatpak_packages\///')
		name=$(cat "$p/org.gtk.Gtk3theme.$fname.json" |  jq ".id" | tr -d \" )
		echo $name			
		cd ./flathub	
    		git checkout "$name"
		gh pr create -B new-pr --title "Add $name" --body "This is an automated PR, I'm not going to create 40 PRs by myself. For more info see [discourse.flathub.org/t/packaging-multiple-variations-of-a-gtk-theme/623](https://discourse.flathub.org/t/packaging-multiple-variations-of-a-gtk-theme/623), [github.com/sp1ritCS/flatpak_flat-remix-gtk](https://github.com/sp1ritCS/flatpak_flat-remix-gtk) & [github.com/daniruiz/flat-remix-gtk/issues/99](https://github.com/daniruiz/flat-remix-gtk/issues/99)"
		cd $root
	fi
done
