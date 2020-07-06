## Flatpak

# Flat-Remix-GTK

Build [Flat-Remix-GTK](https://github.com/daniruiz/flat-remix-gtk) for flatpak.

At the moment, this pulls it's "sources" from [github.com/sp1ritCS/flat-remix-gtk](https://github.com/sp1ritCS/flat-remix-gtk) and not from [upstream](https://github.com/daniruiz/flat-remix-gtk), because of an unresolvable gitmodule.

### How to build?

By running
```sh
cd <repository root>
bash build.sh
```
it'll package every variation of the Flat-Remix-GTK theme, and push them into a local "Flat-Remix-GTK" repository located in the `<repository root>`.

To add the local repository:
```sh
cd <repositroy root>
flatpak remote-add --no-gpg-verify "Flat-Remix-GTK" "Flat-Remix-GTK"
```

Now you are able to install all packages in the local "Flat-Remix-GTK" repository (to see all `flatpak remote-ls Flat-Remix-GTK`)

```sh
flatpak install Flat-Remix-GTK org.gtk.Gtk3theme.Flat-Remix-GTK-Blue
flatpak install Flat-Remix-GTK org.gtk.Gtk3theme.Flat-Remix-GTK-Blue-Dark
```

Full credits to @daniruiz for his beautiful GTK theme & to [org.gtk.Gtk3theme.Breeze](https://github.com/flathub/org.gtk.Gtk3theme.Breeze) from where I *stole* the sources & modified them 🤔.
