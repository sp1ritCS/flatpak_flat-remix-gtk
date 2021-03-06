#!/bin/bash
set -e
root=$(pwd)
if [[ ! -d "./flathub" ]]; then
	git clone --branch=new-pr git@github.com:sp1ritCS/flathub.git  
fi

for p in ./flatpak_packages/*; do
	echo $p
	if [[ -d "$p" ]] && [[ "$p" == ./flatpak_packages/Flat-Remix-GTK-* ]]; then
		fname=$(echo $p | sed 's/\.\/flatpak_packages\///')
		name=$(cat "$p/org.gtk.Gtk3theme.$fname.json" |  jq ".id" | tr -d \" )
		echo $name			
		cd ./flathub	
		git checkout new-pr
    		git checkout "$name"
		cp "../flatpak_packages/$fname/$name.json" .
		cp "../flatpak_packages/$fname/$name.appdata.xml" .
		cp "../flatpak_packages/$fname/flathub.json" .
		#git add "$name.json" "$name.appdata.xml"
		git add .
		git commit -m "Cleaned commits from $name"
		git push --force origin $name
		cd $root
	fi
done
