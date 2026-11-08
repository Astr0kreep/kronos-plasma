pragma Singleton
import QtQuick

// Stand-in for Omarchy's qs.Commons Style singleton.
// `bar` is Omarchy's shell bar; on Plasma the panel never overlaps the
// desktop containment, so the clearances are zero.
QtObject {
    readonly property QtObject font: QtObject {
        property string family: "Liberation Sans"
    }
    readonly property QtObject bar: QtObject {
        property int sizeVertical: 0
        property int sizeHorizontal: 0
    }
}
