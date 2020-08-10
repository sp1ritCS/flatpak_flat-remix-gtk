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
    		git checkout -B "$name"
		rm -f ./*
		cp "../flatpak_packages/$fname/$name.json" .
		cp "../flatpak_packages/$fname/$name.appdata.xml" .
		#git add "$name.json" "$name.appdata.xml"
		git add .
		git commit -m "Added $name"
		git push -u origin $name
		cd $root
	fi
done
