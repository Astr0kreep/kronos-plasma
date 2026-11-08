import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_scale: layoutScale.value
    property alias cfg_hourScale: hourScale.value
    property alias cfg_dateScale: dateScale.value
    property alias cfg_subtimeScale: subtimeScale.value
    property alias cfg_minuteCapsuleScale: minCapScale.value
    property alias cfg_secondCapsuleScale: secCapScale.value

    property alias cfg_clockFont: clockFont.text
    property alias cfg_labelFont: labelFont.text
    property alias cfg_hourFont: hourFont.text
    property alias cfg_dateFont: dateFont.text
    property alias cfg_minuteCapsuleFont: minCapFont.text
    property alias cfg_secondCapsuleFont: secCapFont.text

    property alias cfg_hourColor: hourColor.text
    property alias cfg_dateColor: dateColor.text
    property alias cfg_minuteCapsuleColor: minCapColor.text
    property alias cfg_secondCapsuleColor: secCapColor.text

    property alias cfg_showMinuteCapsule: showMinCap.checked
    property alias cfg_showSecondCapsule: showSecCap.checked

    property alias cfg_hourOffsetX: hourOffX.value
    property alias cfg_hourOffsetY: hourOffY.value
    property alias cfg_dateOffsetX: dateOffX.value
    property alias cfg_dateOffsetY: dateOffY.value
    property alias cfg_minuteCapsuleAngleOffset: minCapAngle.value
    property alias cfg_minuteCapsuleRadiusOffset: minCapRadius.value
    property alias cfg_secondCapsuleAngleOffset: secCapAngle.value
    property alias cfg_secondCapsuleRadiusOffset: secCapRadius.value

    component SliderRow: RowLayout {
        property alias value: s.value
        property alias from: s.from
        property alias to: s.to
        property alias stepSize: s.stepSize
        property int decimals: 2
        property string suffix: ""
        QQC2.Slider {
            id: s
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
            snapMode: QQC2.Slider.SnapAlways
        }
        QQC2.Label {
            Layout.minimumWidth: Kirigami.Units.gridUnit * 3
            text: s.value.toFixed(parent.decimals) + parent.suffix
        }
    }

    Kirigami.FormLayout {
        Kirigami.Separator { Kirigami.FormData.label: i18n("Sizes"); Kirigami.FormData.isSection: true }
        SliderRow { id: layoutScale;  Kirigami.FormData.label: i18n("Layout:");         from: 0.5; to: 2.5; stepSize: 0.05 }
        SliderRow { id: hourScale;    Kirigami.FormData.label: i18n("Hour numeral:");   from: 0.5; to: 2.5; stepSize: 0.05 }
        SliderRow { id: dateScale;    Kirigami.FormData.label: i18n("Date block:");     from: 0.5; to: 2.5; stepSize: 0.05 }
        SliderRow { id: minCapScale;  Kirigami.FormData.label: i18n("Minute capsule:"); from: 0.5; to: 2.5; stepSize: 0.05 }
        SliderRow { id: secCapScale;  Kirigami.FormData.label: i18n("Second capsule:"); from: 0.5; to: 2.5; stepSize: 0.05 }
        SliderRow { id: subtimeScale; Kirigami.FormData.label: i18n("Subtime (legacy):"); from: 0.5; to: 2.5; stepSize: 0.05 }

        Kirigami.Separator { Kirigami.FormData.label: i18n("Fonts"); Kirigami.FormData.isSection: true }
        QQC2.TextField { id: clockFont;  Kirigami.FormData.label: i18n("Clock font:") }
        QQC2.TextField { id: labelFont;  Kirigami.FormData.label: i18n("Ring label font:") }
        QQC2.TextField { id: hourFont;   Kirigami.FormData.label: i18n("Hour font:");   placeholderText: i18n("use clock font") }
        QQC2.TextField { id: dateFont;   Kirigami.FormData.label: i18n("Date font:");   placeholderText: i18n("use clock font") }
        QQC2.TextField { id: minCapFont; Kirigami.FormData.label: i18n("Minute capsule font:"); placeholderText: i18n("use clock font") }
        QQC2.TextField { id: secCapFont; Kirigami.FormData.label: i18n("Second capsule font:"); placeholderText: i18n("use clock font") }
        QQC2.Label {
            text: i18n("A font field may list fallbacks, comma separated.")
            font: Kirigami.Theme.smallFont
            opacity: 0.7
        }

        Kirigami.Separator { Kirigami.FormData.label: i18n("Colors"); Kirigami.FormData.isSection: true }
        QQC2.TextField { id: hourColor;   Kirigami.FormData.label: i18n("Hour:");           placeholderText: i18n("theme default") }
        QQC2.TextField { id: dateColor;   Kirigami.FormData.label: i18n("Date:");           placeholderText: i18n("theme default") }
        QQC2.TextField { id: minCapColor; Kirigami.FormData.label: i18n("Minute capsule:"); placeholderText: i18n("theme default") }
        QQC2.TextField { id: secCapColor; Kirigami.FormData.label: i18n("Second capsule:"); placeholderText: i18n("theme default") }

        Kirigami.Separator { Kirigami.FormData.label: i18n("Capsules"); Kirigami.FormData.isSection: true }
        QQC2.CheckBox { id: showMinCap; Kirigami.FormData.label: i18n("Show:"); text: i18n("Minute capsule") }
        QQC2.CheckBox { id: showSecCap; text: i18n("Second capsule") }
        SliderRow { id: minCapAngle;  Kirigami.FormData.label: i18n("Minute angle:");  from: -90; to: 90; stepSize: 1; decimals: 0; suffix: "°" }
        SliderRow { id: minCapRadius; Kirigami.FormData.label: i18n("Minute radius:"); from: -80; to: 80; stepSize: 1; decimals: 0; suffix: " px" }
        SliderRow { id: secCapAngle;  Kirigami.FormData.label: i18n("Second angle:");  from: -90; to: 90; stepSize: 1; decimals: 0; suffix: "°" }
        SliderRow { id: secCapRadius; Kirigami.FormData.label: i18n("Second radius:"); from: -80; to: 80; stepSize: 1; decimals: 0; suffix: " px" }

        Kirigami.Separator { Kirigami.FormData.label: i18n("Nudges"); Kirigami.FormData.isSection: true }
        SliderRow { id: hourOffX; Kirigami.FormData.label: i18n("Hour X:"); from: -200; to: 200; stepSize: 1; decimals: 0; suffix: " px" }
        SliderRow { id: hourOffY; Kirigami.FormData.label: i18n("Hour Y:"); from: -200; to: 200; stepSize: 1; decimals: 0; suffix: " px" }
        SliderRow { id: dateOffX; Kirigami.FormData.label: i18n("Date X:"); from: -200; to: 200; stepSize: 1; decimals: 0; suffix: " px" }
        SliderRow { id: dateOffY; Kirigami.FormData.label: i18n("Date Y:"); from: -200; to: 200; stepSize: 1; decimals: 0; suffix: " px" }
    }
}
