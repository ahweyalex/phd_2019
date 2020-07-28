# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 10:11:23  Jul 23, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Rect_Nxy3_N3")
oDesign = oProject.SetActiveDesign("Maxwell3DDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, "cw_FeedLineLeft,cw_fs0"
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
