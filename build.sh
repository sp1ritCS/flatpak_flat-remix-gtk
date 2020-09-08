#!/bin/bash
set -e

if [[ ! -d "./temp" ]]; then
    git clone  https://github.com/sp1ritCS/flat-remix-gtk.git ./temp
fi

mkdir -p ./flatpak_packages
for p in ./temp/*; do
    if [[ -d "$p" ]] && [[ "$p" == ./temp/Flat-Remix-GTK-* ]]; then
        theme_name=$(grep "Name=" $p/index.theme | sed 's/Name=//')
        mkdir -p ./flatpak_packages/$theme_name
        sed -e "s/µtheme_name/$theme_name/g" ./template/org.gtk.Gtk3theme.template.json > ./flatpak_packages/$theme_name/org.gtk.Gtk3theme.$theme_name.json
        sed -e "s/µtheme_name/$theme_name/g" ./template/org.gtk.Gtk3theme.template.appdata.xml > ./flatpak_packages/$theme_name/org.gtk.Gtk3theme.$theme_name.appdata.xml
	sed -e "s/µtheme_name/$theme_name/g" ./template/flathub.json > ./flatpak_packages/$theme_name/flathub.json
        #flatpak-builder --repo="Flat-Remix-GTK" --force-clean build ./flatpak_packages/$theme_name/org.gtk.Gtk3theme.$theme_name.json
    fi
done
