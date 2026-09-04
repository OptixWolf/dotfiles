import QtQuick 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
// for run systemmonitor
import org.kde.plasma.private.timer 0.1 as Exec

Item {
    id: root
    readonly property bool inPanel: [PlasmaCore.Types.TopEdge, PlasmaCore.Types.RightEdge, PlasmaCore.Types.BottomEdge, PlasmaCore.Types.LeftEdge].includes(
        Plasmoid.location)
    readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground
    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: null

    function action_openSystemMonitor() {
        Exec.Timer.runCommand("plasma-systemmonitor")
    }
    Component.onCompleted: {
        Plasmoid.setAction("openSystemMonitor",
                           i18ndc("plasma_applet_org.kde.plasma.systemmonitor",
                                  "@action", "Open System Monitor…"),
                           "utilities-system-monitor")
    }
}
