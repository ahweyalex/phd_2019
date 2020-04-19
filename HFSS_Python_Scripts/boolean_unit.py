# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 1:40:00  Apr 19, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Project1")
oDesign = oProject.SetActiveDesign("Maxwell3DDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve0,EquationCurve1,EquationCurve2,Polyline0,Polyline1"
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
oEditor.SweepAlongPath(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve0,Circle1",
		"NewPartsModelFlag:="	, "Model"
	], 
	[
		"NAME:PathSweepParameters",
		"DraftAngle:="		, "0deg",
		"DraftType:="		, "Round",
		"CheckFaceFaceIntersection:=", False,
		"TwistAngle:="		, "0deg"
	])
