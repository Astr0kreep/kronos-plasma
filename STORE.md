# KDE Store listing

Everything needed to fill in the "Add Product" form on
<https://store.kde.org>. Copy/paste territory — nothing here is used at
runtime.

## Why the category matters

Plasma's **Get New Widgets** dialog does not browse the whole store. It asks
for exactly one category, set in `/usr/share/knsrcfiles/plasmoids.knsrc`:

```ini
[KNewStuff]
Name=Plasma Widgets
Categories=Plasma 6 Extensions
Uncompress=kpackage
KPackageStructure=Plasma/Applet
```

"Plasma 6 Extensions" (OCS category id 705) is an umbrella, not a leaf. Its
children include **Plasma 6 Clocks** (708), and the store's OCS API returns
child items for a parent query — verified against the live API:

```
GET /ocs/v1/content/data?categories=705&search=Xenoglyph+Sigil+Clock
  -> 1 hit, typeid 708 "Plasma 6 Clocks"
```

So filing under **Plasma 6 Clocks** keeps the widget visible in Get New
Widgets *and* puts it in a bucket people actually browse: 87 items instead of
the 637 in Plasma 6 Applets, and it is in fact a clock.

What would break it is filing under a Plasma 5 category, or a generic clock
category outside the Plasma 6 tree — then it is reachable by web browsing
only and never appears in the widget installer.

`Uncompress=kpackage` is also why the uploaded file has to be a real KPackage
archive (`metadata.json` at the top level) rather than a tarball of the
project folder. `./package.sh` produces exactly that.

## Form fields

| Field | Value |
| --- | --- |
| Category | `Plasma 6 Extensions` -> `Plasma 6 Clocks` (OCS id 708) |
| Title | `Kronos Clock` |
| Version | `1.2.0-plasma1` |
| License | `MIT` |
| Summary / tagline | `Orbital wallpaper clock — rotating minute and second dot rings, drawn on the GPU.` |
| Tags | `clock, plasma6, plasmoid, widget, desktop, wallpaper, minimal, shader, qml, time` |
| Link | `https://github.com/Astr0kreep/kronos-plasma` |
| File to upload | `dist/kronos-clock-1.2.0-plasma1.plasmoid` |

Screenshots, in this order (first one becomes the listing thumbnail):

1. `docs/forest-dark.jpg`
2. `docs/lake-dusk.jpg`
3. `docs/kubuntu-light.jpg`

## Description

Short on purpose — people hunting for a widget skim the store and read the
repo. Credits and the full rundown live on GitHub, linked at the bottom.

> A big hour readout wrapped in two rotating rings of dots: minutes on one,
> seconds on the other. It sits on the wallpaper behind your windows, draws on
> the GPU, and has around fifty settings in the normal Plasma config dialog.
>
> Originally built for Omarchy/Hyprland by **MASH2RAFI**. This is a Plasma 6
> port of their work — the clock is theirs, the shell around it is new.
>
> Needs Plasma 6 and a Nerd Font (JetBrainsMono Nerd Font by default). Add it
> to the desktop rather than a panel; it wants the room.
>
> Full details, credits and source:
> https://github.com/Astr0kreep/kronos-plasma

## After submitting

* New products sit in a moderation queue; approval is manual and not
  instant.
* Once approved, it can still take a while to surface in **Get New
  Widgets** — that dialog talks to the store through an OCS provider list
  (`https://autoconfig.kde.org/ocs/providers.xml`) and results are
  cached.
* To check visibility without waiting on the dialog, query the API
  directly:
  `https://api.kde-look.org/ocs/v1/content/data?categories=705&search=Kronos`

## Publishing an update

1. Bump `Version` in `org.kronos.clock/metadata.json`.
2. `./package.sh`
3. Upload the new `.plasmoid` as a new file on the existing product page
   and set the version string to match. Keep the old file if you want
   people on older Plasma to stay put; otherwise remove it.

Version strings use the form `<upstream version>-plasma<n>`, so
`1.2.0-plasma1` is the first Plasma packaging of upstream's 1.2.0.
