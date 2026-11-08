import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_showRings: showRings.checked
    property alias cfg_showRingLabels: showRingLabels.checked
    property alias cfg_ringDiameter: ringDiameter.value
    property alias cfg_ringGap: ringGap.value
    property alias cfg_ringArcDegrees: ringArc.value
    property alias cfg_ringTransparency: ringTransparency.value
    property alias cfg_ringRotationOffset: ringRotation.value
    property alias cfg_ringLabelScale: ringLabelScale.value
    property alias cfg_minuteRingColor: minuteRingColor.text
    property alias cfg_secondRingColor: secondRingColor.text
    property alias cfg_ringLabelColor: ringLabelColor.text

    component SliderRow: RowLayout {
        property alias value: s.value
        property alias from: s.from
        property alias to: s.to
        property alias stepSize: s.stepSize
        property int decimals: 2
        property string suffix: ""
        QQC2.Slider {
            id: s
            Layout.preferredWidth: Kirigami.Units.gridUnit * 14
            snapMode: QQC2.Slider.SnapAlways
        }
        QQC2.Label {
            Layout.minimumWidth: Kirigami.Units.gridUnit * 3
            text: s.value.toFixed(parent.decimals) + parent.suffix
        }
    }

    Kirigami.FormLayout {
        QQC2.CheckBox { id: showRings;      Kirigami.FormData.label: i18n("Show:"); text: i18n("Rings") }
        QQC2.CheckBox { id: showRingLabels; text: i18n("Tick labels (00–59)") }
        Item { Kirigami.FormData.isSection: true }

        SliderRow {
            id: ringDiameter
            Kirigami.FormData.label: i18n("Ring diameter:")
            from: 0.25; to: 0.55; stepSize: 0.01; decimals: 2
        }
        SliderRow {
            id: ringGap
            Kirigami.FormData.label: i18n("Ring spacing:")
            from: 16; to: 140; stepSize: 1; decimals: 0; suffix: " px"
        }
        SliderRow {
            id: ringArc
            Kirigami.FormData.label: i18n("Ring arc:")
            from: 0; to: 360; stepSize: 5; decimals: 0; suffix: "°"
        }
        QQC2.Label {
            text: i18n("0 uses the default arc for the chosen position.")
            font: Kirigami.Theme.smallFont
            opacity: 0.7
        }
        SliderRow {
            id: ringTransparency
            Kirigami.FormData.label: i18n("Ring opacity:")
            from: 0; to: 1; stepSize: 0.01; decimals: 2
        }
        SliderRow {
            id: ringRotation
            Kirigami.FormData.label: i18n("Rotation offset:")
            from: -180; to: 180; stepSize: 1; decimals: 0; suffix: "°"
        }
        SliderRow {
            id: ringLabelScale
            Kirigami.FormData.label: i18n("Tick label size:")
            from: 0.5; to: 2.5; stepSize: 0.05; decimals: 2
        }
        Item { Kirigami.FormData.isSection: true }

        QQC2.TextField { id: minuteRingColor; Kirigami.FormData.label: i18n("Minute ring color:"); placeholderText: i18n("theme default") }
        QQC2.TextField { id: secondRingColor; Kirigami.FormData.label: i18n("Second ring color:"); placeholderText: i18n("theme default") }
        QQC2.TextField { id: ringLabelColor;  Kirigami.FormData.label: i18n("Tick label color:");  placeholderText: i18n("theme default") }
        QQC2.Label {
            text: i18n("Colors are #rrggbb, or blank to follow the theme.")
            font: Kirigami.Theme.smallFont
            opacity: 0.7
        }
    }
}
