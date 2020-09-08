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
		ncm=$(expr $(git log | wc -l) / 6)
		git reset --soft HEAD~$ncm
		cd $root
	fi
done
