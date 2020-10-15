# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 16:22:54  Mar 30, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Ellipse_Loop_Temp")
oDesign = oProject.SetActiveDesign("Maxwell3DDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
############################################################################
# define parameters within python script
############################################################################
# current code needs nxySize to be equal or greater than 3
nxySize = 1
Nxy = []
# starts at 0, step size is 2
for x in range(0,(nxySize)*2,2):
	if(x==0):
		Nxy.append(str(x))
	else:
		Nxy.append(str(x+1))
# input parameters for HFSS Script	
wT = "0.2546mm"
ra = "5mm"
ri = "5mm"
N  = "1"
numSeg = "200"
O = 0
u = "mm"
nn = 0

###########################################################################
#### END:  define parameters within python script
###########################################################################
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

############################################################################
# define create lines
############################################################################

# create circle lines
if O==1:
	#######################################################################
	# start cw
	for n in range(nxySize):
		nn=nn+1
		# first case
		if n==0:
			# create first circ 
			oEditor.CreateEquationCurve(
				[
					"NAME:EquationBasedCurveParameters",
					"XtFunction:="		, "(ra+wT) * sin(_t)",
					"YtFunction:="		, "(ri+wT) * cos(_t)",
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
							"Y:="			, "(ri+wT)",
							"Z:="			, "zEnd"
						],
						[
							"NAME:PLPoint",
							"X:="			, "0mm",
							"Y:="			, "(ri + wT*"+Nxy[n+1]+"."+str(nn+1)+")",
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
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+"."+str(nn)+") * cos(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+"."+str(nn)+") * sin(_t)",
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
									"Y:="			, "(ri + wT*"+Nxy[n]+"."+str(nn)+")",
									"Z:="			, "0"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "(ri + wT*"+Nxy[n+1]+"."+str(nn+1)+")",
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
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+"."+str(nn)+") * sin(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+"."+str(nn)+") * cos(_t)",
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
									"Y:="			, "(ri + wT*"+Nxy[n]+"."+str(nn)+")",
									"Z:="			, "zEnd"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "(ri + wT*"+Nxy[n+1]+"."+str(nn+1)+")",
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

else:
	#######################################################################
	# start ccw	
	for n in range(nxySize):
		nn=nn+1
		# first case
		if n==0:
			# create first circ 
			oEditor.CreateEquationCurve(
				[
					"NAME:EquationBasedCurveParameters",
					"XtFunction:="		, "(ra+wT) * cos(_t)",
					"YtFunction:="		, "(ri+wT) * sin(_t)",
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
							"Y:="			, "(ri+wT)",
							"Z:="			, "zEnd"
						],
						[
							"NAME:PLPoint",
							"X:="			, "0mm",
							"Y:="			, "ri + wT*"+Nxy[n+1]+"."+str(nn+1)+"",
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
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+"."+str(nn)+") * sin(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+"."+str(nn)+") * cos(_t)",
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
									"Y:="			, "ri + wT*"+Nxy[n]+"."+str(nn)+"",
									"Z:="			, "0"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n+1]+"."+str(nn+1)+"",
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
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+"."+str(nn)+") * cos(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+"."+str(nn)+") * sin(_t)",
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
									"Y:="			, "ri + wT*"+Nxy[n]+"."+str(nn)+"",
									"Z:="			, "zEnd"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n+1]+"."+str(nn+1)+"",
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



# create circle to sweep along mutli-coil lines
oEditor.CreateCircle(
	[
		"NAME:CircleParameters",
		"IsCovered:="		, True,
		"XCenter:="		, "0mm",
		"YCenter:="		, "(ri+wT)",
		"ZCenter:="		, "zEnd",
		"Radius:="		, "wT",
		"WhichAxis:="		, "X",
		"NumSegments:="		, "0"
	], 
	[
		"NAME:Attributes",
		"Name:="		, "Circle0",
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
# create string arrays, will tell hfss what to unite 
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
		# poL = poL + pStr + str(n)
	elif n==(nxySize-2):
		eqC = eqC + cStr + str(n) + c
		poL = poL + pStr + str(n)
	else:
		eqC = eqC + cStr + str(n) + c
		poL = poL + pStr + str(n) + c
selNames = eqC + poL
# unite lines into one
oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, selNames
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
# sweep circle along united path to create wire	
oEditor.SweepAlongPath(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve0,Circle0",
		"NewPartsModelFlag:="	, "Model"
	], 
	[
		"NAME:PathSweepParameters",
		"DraftAngle:="		, "0deg",
		"DraftType:="		, "Round",
		"CheckFaceFaceIntersection:=", False,
		"TwistAngle:="		, "0deg"
	])

# create feed lines
# check start orientation of wire
if O==1:
	#######################################################################
	# start cw
	#######################################################################
	# check if total turns along xy-plane
	# even:
	if nxySize%2==0:
		# create poly lines	
		# backLine
		# line goes out to the side
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
						"Z:="			, "0"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "ri",
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
				"Name:="		, "BackLine0",
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
		# line goes down in z
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "ri",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "ri",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine1",
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
		# line goes out in y
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "ri",
						"Z:="			, "-(ra*0.5)"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						#"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Y:="			, "(ri * Nxy)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine2",
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
		
		# frontLine
		# line goes out to the side
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
						"Y:="			, "(ri + wT+ wT*2*"+str(nxySize-1)+")",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri + wT+ wT*2*"+str(nxySize-1)+")",
						"Z:="			, "0mm"
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
				"Name:="		, "FrontLine0",
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
		# line goes out in y 
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			,"(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri * Nxy)",
						"Z:="			, "0mm"
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
				"Name:="		, "FrontLine1",
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
	# odd:
	else:
		# create poly lines	
		# backLine
		# line goes out to the side
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
						"Y:="			, "(ri+wT)",
						"Z:="			, "0"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri+wT)",
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
				"Name:="		, "BackLine0",
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
		# line goes down in z
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine1",
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
		# line goes out in y
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "-(ra*0.5)"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						#"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Y:="			, "(ri * Nxy)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine2",
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
		
		# frontLine
		# line goes out to the side
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
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "zEnd"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
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
				"Name:="		, "FrontLine0",
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
		# line goes out in y 
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			,"(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "zEnd"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri * Nxy)",
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
				"Name:="		, "FrontLine1",
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
	#######################################################################
	# start ccw
	#######################################################################
	# check if total turns along xy-plane
	# even:	
	if nxySize%2==0:
		# create poly lines 
		# backLine
		# line goes out to the side
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
						"Z:="			, "0"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
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
				"Name:="		, "BackLine0",
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
		# line goes down in z
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine1",
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
		# line goes out in y
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "-(ra*0.5)"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						#"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Y:="			, "(ri * Nxy)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine2",
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

		# frontLine
		# line goes out to the side
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
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "0mm"
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
				"Name:="		, "FrontLine0",
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
		# line goes out in y 
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			,"-(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri * Nxy)",
						"Z:="			, "0mm"
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
				"Name:="		, "FrontLine1",
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
			
	# odd:
	else:
		# create poly lines 
		# backLine
		# line goes out to the side
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
						"Y:="			, "(ri+wT)",
						"Z:="			, "0"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
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
				"Name:="		, "BackLine0",
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
		# line goes down in z
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "0mm"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine1",
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
		# line goes out in y
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						"Y:="			, "(ri+wT)",
						"Z:="			, "-(ra*0.5)"
					],
					[
						"NAME:PLPoint",
						"X:="			, "(ra*0.2)",
						#"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Y:="			, "(ri * Nxy)",
						"Z:="			, "-(ra*0.5)"
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
				"Name:="		, "BackLine2",
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

		# frontLine
		# line goes out to the side
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
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "zEnd"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
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
				"Name:="		, "FrontLine0",
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
		# line goes out in y 
		oEditor.CreatePolyline(
			[
				"NAME:PolylineParameters",
				"IsPolylineCovered:="	, True,
				"IsPolylineClosed:="	, False,
				[
					"NAME:PolylinePoints",
					[
						"NAME:PLPoint",
						"X:="			,"-(ra*0.2)",
						"Y:="			, "(ri + wT*2*"+str(nxySize-1)+")",
						"Z:="			, "zEnd"
					],
					[
						"NAME:PLPoint",
						"X:="			, "-(ra*0.2)",
						"Y:="			, "(ri * Nxy)",
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
				"Name:="		, "FrontLine1",
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
	