import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property string cfg_position
    property string cfg_centerLayout
    property string cfg_accentMode
    property string cfg_renderer
    property alias cfg_use24h: use24h.checked
    property alias cfg_showSeconds: showSeconds.checked
    property alias cfg_showDate: showDate.checked
    property alias cfg_showHour: showHour.checked
    property alias cfg_lowPower: lowPower.checked
    property alias cfg_followPlasmaColors: followColors.checked
    property alias cfg_margin: margin.value

    Kirigami.FormLayout {
        QQC2.ComboBox {
            Kirigami.FormData.label: i18n("Position:")
            model: ["top-left","top-center","top-right","middle-left","middle-center",
                    "middle-right","bottom-left","bottom-center","bottom-right"]
            currentIndex: Math.max(0, model.indexOf(cfg_position))
            onActivated: cfg_position = model[currentIndex]
        }
        QQC2.ComboBox {
            Kirigami.FormData.label: i18n("Layout style:")
            model: ["orbit","digital"]
            currentIndex: Math.max(0, model.indexOf(cfg_centerLayout))
            onActivated: cfg_centerLayout = model[currentIndex]
        }
        QQC2.ComboBox {
            Kirigami.FormData.label: i18n("Ring colors:")
            model: ["contrast","accent","theme","mono"]
            currentIndex: Math.max(0, model.indexOf(cfg_accentMode))
            onActivated: cfg_accentMode = model[currentIndex]
        }
        QQC2.CheckBox {
            id: followColors
            Kirigami.FormData.label: i18n("Colors:")
            text: i18n("Follow Plasma color scheme")
        }
        Item { Kirigami.FormData.isSection: true }

        QQC2.CheckBox { id: showHour;     Kirigami.FormData.label: i18n("Show:"); text: i18n("Hour numeral") }
        QQC2.CheckBox { id: showDate;     text: i18n("Date block") }
        QQC2.CheckBox { id: showSeconds;  text: i18n("Seconds ring") }
        QQC2.CheckBox { id: use24h;       text: i18n("24-hour clock") }
        Item { Kirigami.FormData.isSection: true }

        QQC2.SpinBox {
            id: margin
            Kirigami.FormData.label: i18n("Edge margin:")
            from: 0; to: 400
        }
        QQC2.CheckBox {
            id: lowPower
            Kirigami.FormData.label: i18n("Performance:")
            text: i18n("Low power (tick twice a second)")
        }
        QQC2.ComboBox {
            Kirigami.FormData.label: i18n("Ring renderer:")
            model: ["shader","canvas"]
            currentIndex: Math.max(0, model.indexOf(cfg_renderer))
            onActivated: cfg_renderer = model[currentIndex]
        }
        QQC2.Label {
            text: i18n("“shader” rotates a cached ring texture on the GPU.\n“canvas” repaints every tick — slower, but a safe fallback.")
            font: Kirigami.Theme.smallFont
            opacity: 0.7
        }
    }
}
