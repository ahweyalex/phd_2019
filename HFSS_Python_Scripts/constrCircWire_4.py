# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 16:22:54  Mar 30, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Project1")
oDesign = oProject.SetActiveDesign("Maxwell3DDesign1")
############################################################################
# define parameters within python script
############################################################################
nxySize = 3
Nxy = []
# starts at 0, step size is 2
for x in range(0,(nxySize)*2,2):
	Nxy.append(str(x))
	
wT = "0.2546mm"
ra = "30mm"
ri = "30mm"
N  = "3"
numSeg = "200"
O = 1
u = "mm"
########################################################################
#### END:  define parameters within python script
########################################################################

############################################################################
# create lines for multi-coil
############################################################################
oEditor = oDesign.SetActiveEditor("3D Modeler")

if O == 1: # checks start orientation 
	############################################################################
	# start: CW
	############################################################################
	# circle
		# construct circ lines
		for n in range(nxySize): # number of turns along xy-plane
			if n%2==0: # checks to switch orientation along xy-plane
				## Create Line
				if n==0:
					# cw circ
					oEditor.CreateEquationCurve(
						[
							"NAME:EquationBasedCurveParameters",
							"XtFunction:="		, "(ra) * sin(_t)",
							"YtFunction:="		, "(ri) * cos(_t)",
							"ZtFunction:="		, "h*(_t)",
							"tStart:="		, "0",
							"tEnd:="		, "N*2*pi",
							"NumOfPointsOnCurve:="	, "numSeg",
							"Version:="		, 1,
							[
								"NAME:PolylineXSection",
								"XSectionType:="	, "None",
								"XSectionOrient:="	, "Auto",
								"XSectionWidth:="	, "0",
								"XSectionTopWidth:="	, "0",
								"XSectionHeight:="	, "0",
								"XSectionNumSegments:="	, "0",
								"XSectionBendType:="	, "Corner"
							]
						], 
						[
							"NAME:Attributes",
							"Name:="		, "EquationCurve"+Nxy[n],
							"Flags:="		, "",
							"Color:="		, "(143 175 143)",
							"Transparency:="	, 0,
							"PartCoordinateSystem:=", "Global",
							"UDMId:="		, "",
							"MaterialValue:="	, "\"copper\"",
							"SurfaceMaterialValue:=", "\"\"",
							"SolveInside:="		, True,
							"IsMaterialEditable:="	, True,
							"UseMaterialAppearance:=", False,
							"IsLightweight:="	, False
						])
					# connect circ lines
					oEditor.CreatePolyline(
						[
							"NAME:PolylineParameters",
							"IsPolylineCovered:="	, True,
							"IsPolylineClosed:="	, False,
							[
								"NAME:PolylinePoints",
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri",
									"Z:="			, "zEnd"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n+1]+".2",
									"Z:="			, "zEnd"
								]
							],
							[
								"NAME:PolylineSegments",
								[
									"NAME:PLSegment",
									"SegmentType:="		, "Line",
									"StartIndex:="		, 0,
									"NoOfPoints:="		, 2
								]
							],
							[
								"NAME:PolylineXSection",
								"XSectionType:="	, "None",
								"XSectionOrient:="	, "Auto",
								"XSectionWidth:="	, "0mm",
								"XSectionTopWidth:="	, "0mm",
								"XSectionHeight:="	, "0mm",
								"XSectionNumSegments:="	, "0",
								"XSectionBendType:="	, "Corner"
							]
						], 
						[
							"NAME:Attributes",
							"Name:="		, "Polyline"+str(n),
							"Flags:="		, "",
							"Color:="		, "(143 175 143)",
							"Transparency:="	, 0,
							"PartCoordinateSystem:=", "Global",
							"UDMId:="		, "",
							"MaterialValue:="	, "\"vacuum\"",
							"SurfaceMaterialValue:=", "\"\"",
							"SolveInside:="		, True,
							"IsMaterialEditable:="	, True,
							"UseMaterialAppearance:=", False,
							"IsLightweight:="	, False
						])					
				elif n==len(Nxy):
					# create last circ
					oEditor.CreateEquationCurve(
						[
							"NAME:EquationBasedCurveParameters",
							"XtFunction:="		, "(ra + wT*"+Nxy[n]+".2) * sin(_t)",
							"YtFunction:="		, "(ri + wT*"+Nxy[n]+".2) * cos(_t)",
							"ZtFunction:="		, "h*(_t)",
							"tStart:="		, "0",
							"tEnd:="		, "N*2*pi",
							"NumOfPointsOnCurve:="	, "numSeg",
							"Version:="		, 1,
							[
								"NAME:PolylineXSection",
								"XSectionType:="	, "None",
								"XSectionOrient:="	, "Auto",
								"XSectionWidth:="	, "0",
								"XSectionTopWidth:="	, "0",
								"XSectionHeight:="	, "0",
								"XSectionNumSegments:="	, "0",
								"XSectionBendType:="	, "Corner"
							]
						], 
						[
							"NAME:Attributes",
							"Name:="		, "EquationCurve"+str(n),
							"Flags:="		, "",
							"Color:="		, "(143 175 143)",
							"Transparency:="	, 0,
							"PartCoordinateSystem:=", "Global",
							"UDMId:="		, "",
							"MaterialValue:="	, "\"copper\"",
							"SurfaceMaterialValue:=", "\"\"",
							"SolveInside:="		, True,
							"IsMaterialEditable:="	, True,
							"UseMaterialAppearance:=", False,
							"IsLightweight:="	, False
						])
					# connect last circ with prev
					oEditor.CreatePolyline(
						[
							"NAME:PolylineParameters",
							"IsPolylineCovered:="	, True,
							"IsPolylineClosed:="	, False,
							[
								"NAME:PolylinePoints",
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n-1]+".2",
									"Z:="			, "0"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n]+".2",
									"Z:="			, "0"
								]
							],
							[
								"NAME:PolylineSegments",
								[
									"NAME:PLSegment",
									"SegmentType:="		, "Line",
									"StartIndex:="		, 0,
									"NoOfPoints:="		, 2
								]
							],
							[
								"NAME:PolylineXSection",
								"XSectionType:="	, "None",
								"XSectionOrient:="	, "Auto",
								"XSectionWidth:="	, "0mm",
								"XSectionTopWidth:="	, "0mm",
								"XSectionHeight:="	, "0mm",
								"XSectionNumSegments:="	, "0",
								"XSectionBendType:="	, "Corner"
							]
						], 
						[
							"NAME:Attributes",
							"Name:="		, "Polyline"+str(n),
							"Flags:="		, "",
							"Color:="		, "(143 175 143)",
							"Transparency:="	, 0,
							"PartCoordinateSystem:=", "Global",
							"UDMId:="		, "",
							"MaterialValue:="	, "\"vacuum\"",
							"SurfaceMaterialValue:=", "\"\"",
							"SolveInside:="		, True,
							"IsMaterialEditable:="	, True,
							"UseMaterialAppearance:=", False,
							"IsLightweight:="	, False
						])						
				else:
					oEditor.CreateEquationCurve(
						[
							"NAME:EquationBasedCurveParameters",
							"XtFunction:="		, "(ra + wT*"+Nxy[n]+".2) * sin(_t)",
							"YtFunction:="		, "(ri + wT*"+Nxy[n]+".2) * cos(_t)",
							"ZtFunction:="		, "h*(_t)",
							"tStart:="		, "0",
							"tEnd:="		, "N*2*pi",
							"NumOfPointsOnCurve:="	, "numSeg",
							"Version:="		, 1,
							[
								"NAME:PolylineXSection",
								"XSectionType:="	, "None",
								"XSectionOrient:="	, "Auto",
								"XSectionWidth:="	, "0",
								"XSectionTopWidth:="	, "0",
								"XSectionHeight:="	, "0",
								"XSectionNumSegments:="	, "0",
								"XSectionBendType:="	, "Corner"
							]
						], 
						[
							"NAME:Attributes",
							"Name:="		, "EquationCurve"+str(n),
							"Flags:="		, "",
							"Color:="		, "(143 175 143)",
							"Transparency:="	, 0,
							"PartCoordinateSystem:=", "Global",
							"UDMId:="		, "",
							"MaterialValue:="	, "\"copper\"",
							"SurfaceMaterialValue:=", "\"\"",
							"SolveInside:="		, True,
							"IsMaterialEditable:="	, True,
							"UseMaterialAppearance:=", False,
							"IsLightweight:="	, False
						])
			
			# flip orientation
			else: # ccw circ
				# check if its the last one 
				a=1
else:
	a=1