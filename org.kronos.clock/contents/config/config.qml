import QtQuick
import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: i18n("General")
        icon: "preferences-system-time"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: i18n("Rings")
        icon: "draw-ellipse"
        source: "configRings.qml"
    }
    ConfigCategory {
        name: i18n("Components")
        icon: "preferences-desktop-font"
        source: "configComponents.qml"
    }
}
