$(function() {
    var diagram = $("#diagram").dxDiagram({
        contextMenu: {
            enabled: true,
              commands: ["bringToFront", "sendToBack", "lock", "unlock",{name: "connectorLineType", text: "connectorLineType"},"connectorLineStart","connectorLineEnd"]
        },
        contextToolbox: {
            enabled: true,
            category: "flowchart",
            shapeIconsPerRow: 5,
            width: 200
        },
        propertiesPanel: {
            visibility: 'visible'
         
        },
        historyToolbar: {
            visible: false
        },
        viewToolbar: {
            visible: true
        },
        mainToolbar: {
            visible: true,
            commands: [
                { name: "undo" },
                { name: "redo" },
                { name: "separator" },
                { name: "fontName" },
                { name: "fontSize" },
                { name: "separator" },
                { name: "bold" },
                { name: "italic" },
                { name: "underline" },
                { name: "separator" },
                { name: "fontColor" },
                { name: "lineColor" },
                { name: "fillColor" },
                { name: "separator" },
                { name: "clear", icon: "clearsquare", text: "Clear Diagram" }
            ]
        },
        toolbox: {
            visibility: 'visible',
            groups: [
                "general", { category: "flowchart", title: "Flowchart", expanded: true }
            ],
            showSearch: false,
            shapeIconsPerRow: 4,
            width: 220
        },
        onCustomCommand: function(e) {
            if(e.name === "clear") {
                var result = DevExpress.ui.dialog.confirm("Are you sure you want to clear the diagram? This action cannot be undone.", "Warning");
                result.done(
                    function(dialogResult) {
                        if(dialogResult) {
                            e.component.import("");
                        }
                    }
                );
            }
        }
    }).dxDiagram("instance");

    $.ajax({
        url: "https://js.devexpress.com/Demos/WidgetsGallery/JSDemos/data/diagram-flow.json",
        dataType: "text",
        success: function(data) {
            diagram.import(data);
        }
    });
});