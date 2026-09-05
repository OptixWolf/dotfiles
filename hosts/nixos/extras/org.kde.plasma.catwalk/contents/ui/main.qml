import QtQuick
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid

PlasmoidItem {
    id: root

    readonly property bool inPanel:
    Plasmoid.location === PlasmaCore.Types.TopEdge ||
    Plasmoid.location === PlasmaCore.Types.RightEdge ||
    Plasmoid.location === PlasmaCore.Types.BottomEdge ||
    Plasmoid.location === PlasmaCore.Types.LeftEdge

    readonly property bool isVertical:
    Plasmoid.formFactor === PlasmaCore.Types.Vertical

    compactRepresentation: CompactRepresentation {}
    preferredRepresentation: compactRepresentation
    fullRepresentation: null

    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18ndc(
                "plasma_applet_org.kde.plasma.systemmonitor",
                "@action",
                "Open System Monitor…"
            )
            icon.name: "utilities-system-monitor"
            onTriggered: Qt.openUrlExternally(
                "applications:org.kde.plasma-systemmonitor.desktop"
            )
        }
    ]
}
