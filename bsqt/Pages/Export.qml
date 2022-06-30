import QtQuick 2.8
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
//import QtQuick.Dialogs
import QtQuick.Dialogs 1.3

import "../CommonUI"

Item {
	id: exportPage
	anchors.fill: parent

	property var chosenFolder: ""
	property var chosenSystem: ""
	property var chosenExport: "pegasus"

	PageTitle {
		id: exportTitle
		text: "Export Data"
	}

	ButtonLabelRow {
		id: gameFolderSelect
		width: pageWidth
		height: 48

		anchors.right: parent.right
		anchors.rightMargin: pageWidthOffset / 2
		anchors.top: exportTitle.bottom
		anchors.topMargin: 24

		label: "Select Output Folder"
		btnIcon: (chosenFolder == "") ? "folder-symbolic" : ""
		btnLabel: folderPath(chosenFolder)

		function pushAction() {
			exportFolderSelect.open()
		}
	}

	/*
	ButtonLabelChoice {
		id: exportSelect
		width: pageWidth
		height: 48

		anchors.right: parent.right
		anchors.rightMargin: pageWidthOffset / 2
		anchors.top: gameFolderSelect.bottom
		anchors.topMargin: 24

		label: "Select Export Type"
		choiceA: "Pegasus Frontend"
		choiceB: "EmulationStation"

		function pushActionA() {
			chosenExport = "pegasus"
			console.log("[UI]: Set Export (" + chosenExport + ")")
		}
		function pushActionB() {
			chosenExport = "es"
			console.log("[UI]: Set Export (" + chosenExport + ")")
		}
	}
	*/

	DDLabelRow {
		id: systemSelect
		width: pageWidth
		height: 48

		anchors.right: parent.right
		anchors.rightMargin: pageWidthOffset / 2
		anchors.top: gameFolderSelect.bottom
		anchors.topMargin: 24

		label: "Select System"
		btnIcon: (chosenSystem == "") ? "input-gamepad-symbolic" : ""
		btnLabel: chosenSystem
		dropDownModel: systemData

		function pushAction(md) {
			chosenSystem = md
			console.log("[UI]: Selected System (" + md + ")")
		}
	}



	BsqtButton {
		id: beginOneStep

		anchors.bottom: parent.bottom
		anchors.bottomMargin: 48

		anchors.left: parent.left
		anchors.leftMargin: sidebarWidth + pageWidthOffset / 2

		width: pageWidth * 0.25
		height: 72

		label: "Begin"
		btnhighlight: true

		onClicked: {
			if (chosenFolder != "" && chosenSystem != "" && chosenExport != "") {
				working = true;
				runtask(3, chosenFolder + ";;;" + chosenSystem + ";;;" + chosenExport);
			}
		}
	}


	/*
	FolderDialog {
		id: exportFolderSelect
		title: "Choose Export Path"
		currentFolder: homeFolder

		modality: Qt.ApplicationModal

		acceptLabel: "Select"

		onAccepted: {
			chosenFolder = selectedFolder
			console.log("[UI]: Selected Folder (" + selectedFolder + ")")
		}
	}
	*/


	FileDialog {
		id: exportFolderSelect
		title: "Choose Export Path"
		folder: shortcuts.home
		selectFolder: !inFlatpak

		modality: Qt.ApplicationModal

		onAccepted: {
			exportFolderSelect.close()
			chosenFolder = inFlatpak ? dirFromFileUrl(fileUrl) : folder
			console.log("[UI]: Selected Folder (" + chosenFolder + ")")
		}
	}

}