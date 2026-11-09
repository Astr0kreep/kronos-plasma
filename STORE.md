# KDE Store listing

Everything needed to fill in the "Add Product" form on
<https://store.kde.org>. Copy/paste territory — nothing here is used at
runtime.

## Why the category matters

Plasma's **Get New Widgets** dialog does not browse the whole store. It
asks for exactly one category, set in `/usr/share/knsrcfiles/plasmoids.knsrc`:

```ini
[KNewStuff]
Name=Plasma Widgets
Categories=Plasma 6 Extensions
Uncompress=kpackage
KPackageStructure=Plasma/Applet
```

So the listing **must** be filed under **Plasma 6 Extensions**. Anything
filed under a Plasma 5 category, or under a generic "Clocks" category, is
reachable by web browsing only and will never appear in the widget
installer.

`Uncompress=kpackage` is also why the uploaded file has to be a real
KPackage archive (`metadata.json` at the top level) rather than a tarball
of the project folder. `./package.sh` produces exactly that.

## Form fields

| Field | Value |
| --- | --- |
| Category | `Plasma 6 Extensions` |
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

> Kronos is an orbital desktop clock: a large hour readout wrapped in two
> rotating rings of dots, one marking minutes and one marking seconds.
> It sits on the wallpaper, behind everything else, and it is readable at
> a glance from across the room.
>
> **Credit where it belongs.** Kronos was designed and written by
> **MASH2RAFI** for Omarchy, as a Quickshell widget for Hyprland:
> https://github.com/MASH2RAFI/omarchy-kronos — all of the clock's
> design, geometry and rendering are their work. This package is a port
> that swaps the Wayland layer-shell host for a Plasma applet shell so the
> same clock runs on a Plasma 6 desktop. The drawing code is carried over
> essentially unchanged.
>
> **Rendering.** Each ring's sixty dots and labels are rasterised once
> into a texture; a fragment shader then rotates that texture and
> multiplies it by a baked alpha lookup. That is a single draw call per
> ring with nothing re-uploaded per frame, so the animation stays smooth
> without burning CPU. On hardware or drivers where the shader path is
> unavailable it falls back to a plain canvas renderer automatically.
>
> **Configurable.** Around fifty settings in the widget's own
> configuration dialog — native Plasma config pages, not a custom panel.
> Ring radii, dot sizes, tick density, fonts, the time capsule, the date
> column, colours, 12/24-hour, seconds on or off.
>
> **Requirements.** Plasma 6.0 or newer. A Nerd Font (JetBrainsMono Nerd
> Font is the default) for the glyphs in the time capsule; without one
> those few characters render as boxes while the rest of the clock is
> fine.
>
> **Install.** Add it to the desktop, not to a panel — it is a wallpaper
> clock and wants room. Right-click the desktop, Add Widgets, drag Kronos
> Clock out.
>
> MIT licensed. Source, porting notes and a changelog:
> https://github.com/Astr0kreep/kronos-plasma

## After submitting

* New products sit in a moderation queue; approval is manual and not
  instant.
* Once approved, it can still take a while to surface in **Get New
  Widgets** — that dialog talks to the store through an OCS provider list
  (`https://autoconfig.kde.org/ocs/providers.xml`) and results are
  cached.
* To check visibility without waiting on the dialog, browse the
  Plasma 6 Extensions category on the store directly.

## Publishing an update

1. Bump `Version` in `org.kronos.clock/metadata.json`.
2. `./package.sh`
3. Upload the new `.plasmoid` as a new file on the existing product page
   and set the version string to match. Keep the old file if you want
   people on older Plasma to stay put; otherwise remove it.

Version strings use the form `<upstream version>-plasma<n>`, so
`1.2.0-plasma1` is the first Plasma packaging of upstream's 1.2.0.
