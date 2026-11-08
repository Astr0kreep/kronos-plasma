import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import "qs/Commons"

// Plasma 6 host for the upstream Kronos ClockFace.
// Replaces Omarchy's Service.qml (Quickshell layer-shell surface + shell.json)
// with a plasmoid on the desktop containment, which already gives us the
// wallpaper layer, per-screen placement and persistent configuration.
PlasmoidItem {
    id: root

    readonly property var cfg: Plasmoid.configuration

    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    // --- live Plasma colour scheme -> Kronos palette -------------------
    // Complementary is Plasma's light-on-dark set, which is what a clock
    // sitting on a wallpaper wants.
    Item {
        id: themeProbe
        visible: false
        width: 0; height: 0
        Kirigami.Theme.inherit: false
        Kirigami.Theme.colorSet: Kirigami.Theme.Complementary
    }
    Binding {
        target: Color; property: "foreground"
        value: themeProbe.Kirigami.Theme.textColor
        when: root.cfg.followPlasmaColors
    }
    Binding {
        target: Color; property: "background"
        value: themeProbe.Kirigami.Theme.backgroundColor
        when: root.cfg.followPlasmaColors
    }
    Binding {
        target: Color; property: "muted"
        value: themeProbe.Kirigami.Theme.disabledTextColor
        when: root.cfg.followPlasmaColors
    }
    Binding {
        target: Color; property: "accent"
        value: themeProbe.Kirigami.Theme.highlightColor
        when: root.cfg.followPlasmaColors
    }

    fullRepresentation: Item {
        id: stage

        // The applet IS the surface: it takes the face's natural size, the way
        // upstream's compact layer surface does. Ring size comes from the
        // screen, not from the applet, so there is no binding loop here.
        implicitWidth:          face.implicitWidth
        implicitHeight:         face.implicitHeight
        Layout.preferredWidth:  face.implicitWidth
        Layout.preferredHeight: face.implicitHeight
        Layout.minimumWidth:    face.implicitWidth
        Layout.minimumHeight:   face.implicitHeight

        ClockFace {
            id: face
            width:  implicitWidth
            height: implicitHeight

            active:             root.visible
            availableWidth:     Screen.width
            availableHeight:    Screen.height
            screenMargin:       root.cfg.margin
            screenInsets:       ({ top: 0, right: 0, bottom: 0, left: 0 })
            // QML's Screen attached property exposes no refresh rate; the
            // ring tick is capped at this and 60 Hz is the safe assumption.
            screenRefreshRate:  60

            position:           root.cfg.position
            centerLayout:       root.cfg.centerLayout
            accentMode:         root.cfg.accentMode
            renderer:           root.cfg.renderer
            lowPower:           root.cfg.lowPower

            use24h:             root.cfg.use24h
            showSeconds:        root.cfg.showSeconds
            showDate:           root.cfg.showDate
            showHour:           root.cfg.showHour
            showRings:          root.cfg.showRings
            showRingLabels:     root.cfg.showRingLabels
            showMinuteCapsule:  root.cfg.showMinuteCapsule
            showSecondCapsule:  root.cfg.showSecondCapsule

            scaleFactor:              root.cfg.scale
            hourScaleFactor:          root.cfg.hourScale
            dateScaleFactor:          root.cfg.dateScale
            subtimeScaleFactor:       root.cfg.subtimeScale
            ringLabelScaleFactor:     root.cfg.ringLabelScale
            minuteCapsuleScaleFactor: root.cfg.minuteCapsuleScale
            secondCapsuleScaleFactor: root.cfg.secondCapsuleScale

            ringDiameter:       root.cfg.ringDiameter
            ringGap:            root.cfg.ringGap
            ringArcDegrees:     root.cfg.ringArcDegrees
            ringTransparency:   root.cfg.ringTransparency
            ringRotationOffset: root.cfg.ringRotationOffset

            clockFont:          root.cfg.clockFont
            labelFont:          root.cfg.labelFont
            hourFont:           root.cfg.hourFont
            dateFont:           root.cfg.dateFont
            minuteCapsuleFont:  root.cfg.minuteCapsuleFont
            secondCapsuleFont:  root.cfg.secondCapsuleFont

            hourColor:          root.cfg.hourColor
            dateColor:          root.cfg.dateColor
            minuteCapsuleColor: root.cfg.minuteCapsuleColor
            secondCapsuleColor: root.cfg.secondCapsuleColor
            minuteRingColor:    root.cfg.minuteRingColor
            secondRingColor:    root.cfg.secondRingColor
            ringLabelColor:     root.cfg.ringLabelColor

            hourOffsetX:                root.cfg.hourOffsetX
            hourOffsetY:                root.cfg.hourOffsetY
            dateOffsetX:                root.cfg.dateOffsetX
            dateOffsetY:                root.cfg.dateOffsetY
            minuteCapsuleAngleOffset:   root.cfg.minuteCapsuleAngleOffset
            minuteCapsuleRadiusOffset:  root.cfg.minuteCapsuleRadiusOffset
            secondCapsuleAngleOffset:   root.cfg.secondCapsuleAngleOffset
            secondCapsuleRadiusOffset:  root.cfg.secondCapsuleRadiusOffset
        }
    }
}
