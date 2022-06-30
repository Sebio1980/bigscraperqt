import QtQuick 2.8
import QtQuick.Window 2.15

import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
//import QtQuick.Dialogs
import QtQuick.Dialogs 1.3

import "../CommonUI"

Item {
	id: scrapeOne
	anchors.fill: parent

	property var chosenFile: ""
	property var chosenSystem: ""

	PageTitle {
		id: scrapeOneTitle
		text: "Scrape 1 Game"
	}

	ButtonLabelRow {
		id: gameFileSelect
		width: pageWidth
		height: 48

		anchors.right: parent.right
		anchors.rightMargin: pageWidthOffset / 2
		anchors.top: scrapeOneTitle.bottom
		anchors.topMargin: 24

		label: "Select Game File"
		btnIcon: (chosenFile == "") ? "folder-symbolic" : ""
		btnLabel: fileBasename(chosenFile)

		function pushAction() {
			scrapeOneFileSelect.open()
		}
	}

	DDLabelRow {
		id: systemSelect
		width: pageWidth
		height: 48

		anchors.right: parent.right
		anchors.rightMargin: pageWidthOffset / 2
		anchors.top: gameFileSelect.bottom
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
			if (chosenFile != "" && chosenSystem != "") {
				working = true;
				runtask(1, chosenFile + ";;;" + chosenSystem);
			}
		}
	}


	/*
	FileDialog {
		id: scrapeOneFileSelect
		title: "Choose Game File"
		currentFolder: homeFolder

		modality: Qt.ApplicationModal

		acceptLabel: "Select"

		onAccepted: {
			chosenFile = selectedFile
			console.log("[UI]: Selected File (" + selectedFile + ")")
			scrapeOneFileSelect.close()
		}
	}
	*/


	FileDialog {
		id: scrapeOneFileSelect
		title: "Choose Game File"
		folder: shortcuts.home

		modality: Qt.ApplicationModal

		onAccepted: {
			chosenFile = fileUrl
			console.log("[UI]: Selected File (" + fileUrl + ")")
			scrapeOneFileSelect.close()
		}
	}


}