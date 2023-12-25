# Basil's Overlay
## Installation
To add the overlay to your gentoo system, just run:
```
eselect repository add basil-overlay git https://codeberg.org/BasilBasil/basil-overlay.git
```

Then run the following to synchronize the repository:
```
emaint sync -r basil-overlay
```

## Usage
After adding the repository it's a good practice to mask the entire overlay and individually unmask packages one by one because there are some packages here that replace packages from the official Gentoo overlay.
You can mask the overlay with the following:
```
echo "*/*::basil-overlay" /etc/portage/package.mask
```

## Overlay features
Tools for managing a gentoo system easier
OpenRC services for things that dont already have them in their officiaul package
~~Moves app-editors/vscode and app-editors/vscodium to app-editors/vscode-bin and app-editors/vscodium-bin~~ (next update)
~~Replaces app-editors/vscode and app-editors/vscodium with actual source pakages instead of binary packages~~ (next update)

## Contributing
Check out [TODO.md](./TODO.md) to see where you can help!
