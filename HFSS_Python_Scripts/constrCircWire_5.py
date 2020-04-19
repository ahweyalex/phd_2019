# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 16:22:54  Mar 30, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Project1")
oDesign = oProject.SetActiveDesign("Maxwell3DDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
############################################################################
# define parameters within python script
############################################################################
nxySize = 3
Nxy = []
# starts at 0, step size is 2
for x in range(0,(nxySize)*2,2):
	Nxy.append(str(x))
	
wT = "0.2546mm"
ra = "0.5mm"
ri = "0.5mm"
N  = "3"
numSeg = "200"
O = 1
u = "mm"
########################################################################
#### END:  define parameters within python script
#######################################################################
if O==1:
	# start cw
	for n in range(nxySize):
		# first case
		if n==0:
			# create first circ 
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
			# create connecting line between first and second circ
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
		# all other cases
		#n==len(Nxy):
		else: 
			# flip circ
			# odd
			if n%2==1:
				# create circ line
				oEditor.CreateEquationCurve(
					[
						"NAME:EquationBasedCurveParameters",
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+".2) * cos(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+".2) * sin(_t)",
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
				# rotate
				oEditor.Rotate(
					[
						"NAME:Selections",
						"Selections:="		, "EquationCurve"+str(n),
						"NewPartsModelFlag:="	, "Model"
					], 
					[
						"NAME:RotateParameters",
						"RotateAxis:="		, "Z",
						"RotateAngle:="		, "90deg"
					])
				# create connecting line
				if n!=(nxySize-1):
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
									"Y:="			, "ri + wT*"+Nxy[n]+".2",
									"Z:="			, "0"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n+1]+".2",
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

			# no flip
			# even			
			else:
				# create circ line
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
				# create connecting line
				if n!=(nxySize-1):
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
									"Y:="			, "ri + wT*"+Nxy[n]+".2",
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

# start ccw	
else:
	a=1
	
########################################################################
#### END: Combine lines and sweep circle to create 3D object
#######################################################################
# oEditor.CreateCircle(
	# [
		# "NAME:CircleParameters",
		# "IsCovered:="		, True,
		# "XCenter:="		, "0mm",
		# "YCenter:="		, ri,
		# "ZCenter:="		, "0mm",
		# "Radius:="		, wT,
		# "WhichAxis:="		, "X",
		# "NumSegments:="		, "0"
	# ], 
	# [
		# "NAME:Attributes",
		# "Name:="		, "Circle0",
		# "Flags:="		, "",
		# "Color:="		, "(143 175 143)",
		# "Transparency:="	, 0,
		# "PartCoordinateSystem:=", "Global",
		# "UDMId:="		, "",
		# "MaterialValue:="	, "\"vacuum\"",
		# "SurfaceMaterialValue:=", "\"\"",
		# "SolveInside:="		, True,
		# "IsMaterialEditable:="	, True,
		# "UseMaterialAppearance:=", False,
		# "IsLightweight:="	, False
	# ])

cStr = "EquationCurve"
pStr = "Polyline"
q    = '"'
c    = ","
eqC  = ""
poL  = ""
for n in range(nxySize):
	if n==nxySize:
		eqC = eqC + cStr +str(n)
	elif n==(nxySize-1):
		eqC = eqC + cStr + str(n) + c
		poL = poL + pStr + str(n)
	else:
		eqC = eqC + cStr + str(n) + c
		poL = pStr + str(n) + c

selNames = q+ eqC + poL +q
oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, selNames
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
	
# oEditor.SweepAlongPath(
	# [
		# "NAME:Selections",
		# "Selections:="		, "EquationCurve0,Circle0",
		# "NewPartsModelFlag:="	, "Model"
	# ], 
	# [
		# "NAME:PathSweepParameters",
		# "DraftAngle:="		, "0deg",
		# "DraftType:="		, "Round",
		# "CheckFaceFaceIntersection:=", False,
		# "TwistAngle:="		, "0deg"
	# ])