pragma Singleton
import QtQuick

// Stand-in for Omarchy's qs.Commons Color singleton.
// Writable so main.qml can push the live Plasma colour scheme in.
QtObject {
    property color foreground: "#e6e6e6"
    property color background: "#101014"
    property color muted:      "#8a8a99"
    property color accent:     "#7aa2f7"
}
