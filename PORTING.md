# Kronos → Plasma 6 port

Upstream: https://github.com/MASH2RAFI/omarchy-kronos (MIT, © MASH2RAFI)
Target:   Plasma 6.6.6 / Qt 6.10 / Wayland, Ubuntu 26.04

Upstream is an Omarchy shell plugin: a Quickshell `WlrLayershell` surface driven
by Hyprland IPC, configured through `~/.config/omarchy/shell.json`. This port
keeps the renderer and drops the host.

## Files taken from upstream verbatim

    ClockFace.qml  TimeCapsule.qml  DateColumn.qml
    RingCanvas.qml  ShaderRingCanvas.qml  LegacyRingCanvas.qml
    ClockModel.js  ClockTheme.js  FontOptions.js
    shaders/ringmask.frag.qsb

The only edit applied to any of them is one import line:

    -import qs.Commons
    +import "qs/Commons"

Qt 6 will not resolve a dotted module import from a subdirectory next to the
importing file; a quoted directory import works and reads that dir's `qmldir`.
All three `.js` files are `.pragma library`, so they needed nothing.

The shipped `ringmask.frag.qsb` loads as-is on Qt 6.10 — no `qsb` rebuild and
no `qt6-shadertools` needed. `RingCanvas.qml` still falls back to
`LegacyRingCanvas.qml` (per-tick Canvas) if the shader ever fails.

## Files written for this port

    contents/ui/main.qml              replaces upstream Service.qml
    contents/ui/qs/Commons/*          3-file shim for Omarchy's qs.Commons
    contents/config/main.xml          KConfig schema (48 keys)
    contents/config/config.qml        config categories
    contents/ui/config*.qml           General / Rings / Components pages

`qs.Commons` only ever supplied `Color.{foreground,background,muted,accent}`
and `Style.font.family` to the rendering code, so the shim is ~25 lines.
`Style.bar.*` is zero here: a Plasma panel never overlaps the desktop
containment, so there is no bar clearance to inset.

## Dropped, and why

- `Service.qml` — the layer surface. The desktop containment already puts a
  plasmoid below windows, one instance per screen, with persistent config.
- `BarWidget.qml`, `ShellConfigWatcher.qml`, `shell.json` plumbing.
- `SettingsPanel.qml` (1625 lines) — replaced by native Plasma config pages.
- `Quickshell.Hyprland` — it was used only for monitor names and refresh rate.
- Config keys `screenMode`, `perMonitorScale`, `scaleReferenceHeight`,
  `barPadding`, `compactSurface`, `clockEnabled`: all Omarchy-host concerns.
- `minuteRingOpacity` / `secondRingOpacity`: Service-level upstream, not
  properties of `ClockFace`. `ringTransparency` covers both rings.

## Two things upstream does that this does not

- **Refresh rate.** Upstream reads each monitor's Hz from Hyprland to cap the
  ring tick. QML's `Screen` attached property exposes no refresh rate, so
  `main.qml` hardcodes 60. On a high-refresh monitor the rings still animate,
  just capped at 60 Hz.
- **`availableWidth`/`availableHeight` must be the SCREEN, not the applet.**
  That is what sizes the rings (`fitOuterRadius`). The face is then laid out at
  its own `implicitWidth`/`implicitHeight` and never stretched — upstream sizes
  its surface to the face the same way. Anchoring the face with `anchors.fill`
  instead collapses the layout into a corner.

## Rebuild / reinstall

    kpackagetool6 --type Plasma/Applet --upgrade ~/Projects/kronos-plasma/org.kronos.clock
