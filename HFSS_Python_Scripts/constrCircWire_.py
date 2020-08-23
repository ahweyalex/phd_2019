# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 16:22:54  Mar 30, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Ellipse_Loop_Temp")
oDesign = oProject.SetActiveDesign("Maxwell3DDesign1")
# oDesign.ChangeProperty(
	# [
		# "NAME:AllTabs",
		# [
			# "NAME:LocalVariableTab",
			# [
				# "NAME:PropServers", 
				# "LocalVariables"
			# ],
			# [
				# "NAME:NewProps",
				# [
					# "NAME:wT",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "0.2546mm"
				# ],
				# [
					# "NAME:pitch",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "wT*2.0001"
				# ],
				# [
					# "NAME:ra",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "30mm"
				# ],
				# [
					# "NAME:ri",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "30mm"
				# ],
				# [
					# "NAME:N",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "3"
				# ],
				# [
					# "NAME:Nxy",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "3"
				# ],
				# [
					# "NAME:numSeg",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "200"
				# ],
				# [
					# "NAME:h",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "wT*0.35"
				# ],
				# [
					# "NAME:zEnd",
					# "PropType:="		, "VariableProp",
					# "UserDef:="		, True,
					# "Value:="		, "h*N*2*pi"
				# ]
			# ]
		# ]
	# ])


oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateEquationCurve(
	[
		"NAME:EquationBasedCurveParameters",
		"XtFunction:="		, "(ra+wT*0) * sin(_t)",
		"YtFunction:="		, "(ri+wT*0) * cos(_t)",
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
		"Name:="		, "EquationCurve1",
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
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:ri",
					"Value:="		, "5mm"
				],
				[
					"NAME:ra",
					"Value:="		, "5mm"
				]
			]
		]
	])
oEditor.Copy(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve1"
	])
oEditor.Paste()
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve2:CreateEquationCurve:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:X(_t)",
					"Value:="		, "(ra+wT*2.2) * sin(_t)"
				],
				[
					"NAME:Y(_t)",
					"Value:="		, "(ri+wT*2.2) * cos(_t)"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve2:CreateEquationCurve:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:X(_t)",
					"Value:="		, "(ra+wT*2.2) * cos(_t)"
				],
				[
					"NAME:Y(_t)",
					"Value:="		, "(ri+wT*2.2) * sin(_t)"
				]
			]
		]
	])
oEditor.Rotate(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve2",
		"NewPartsModelFlag:="	, "Model"
	], 
	[
		"NAME:RotateParameters",
		"RotateAxis:="		, "Z",
		"RotateAngle:="		, "90deg"
	])
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
				"Y:="			, "5mm",
				"Z:="			, "1.67968392816832mm"
			],
			[
				"NAME:PLPoint",
				"X:="			, "0mm",
				"Y:="			, "5.56012mm",
				"Z:="			, "1.67968392816832mm"
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
		"Name:="		, "Polyline1",
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
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:ra",
					"Value:="		, "3mm"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve2:Rotate:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Angle",
					"Value:="		, "0deg"
				]
			]
		]
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:ra",
					"Value:="		, "5mm"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve2:Rotate:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Angle",
					"Value:="		, "90deg"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DPolylineTab",
			[
				"NAME:PropServers", 
				"Polyline1:CreatePolyline:2:Segment0"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Point1",
					"X:="			, "0mm",
					"Y:="			, "ri",
					"Z:="			, "1.6796839281683mm"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DPolylineTab",
			[
				"NAME:PropServers", 
				"Polyline1:CreatePolyline:2:Segment0"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Point1",
					"X:="			, "0mm",
					"Y:="			, "ri",
					"Z:="			, "h*N*2*pi"
				],
				[
					"NAME:Point2",
					"X:="			, "0mm",
					"Y:="			, "5.56012mm",
					"Z:="			, "h*N*2*pi"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DPolylineTab",
			[
				"NAME:PropServers", 
				"Polyline1:CreatePolyline:2:Segment0"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Point2",
					"X:="			, "0mm",
					"Y:="			, "ri+wT*2.2",
					"Z:="			, "h*N*2*pi"
				],
				[
					"NAME:Point2",
					"X:="			, "0mm",
					"Y:="			, "(ri+wT*2.2)",
					"Z:="			, "(h*N*2*pi)"
				]
			]
		]
	])
oEditor.Copy(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve2"
	])
oEditor.Paste()
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve3:Rotate:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Angle",
					"Value:="		, "0deg"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve3:CreateEquationCurve:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:X(_t)",
					"Value:="		, "(ra+wT*4.2) * cos(_t)"
				],
				[
					"NAME:Y(_t)",
					"Value:="		, "(ri+wT*4.2) * sin(_t)"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve3:CreateEquationCurve:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:X(_t)",
					"Value:="		, "(ra+wT*4.2) * sin(_t)"
				],
				[
					"NAME:Y(_t)",
					"Value:="		, "(ri+wT*4.2) * cos(_t)"
				]
			]
		]
	])
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
				"Y:="			, "5.56012mm",
				"Z:="			, "0mm"
			],
			[
				"NAME:PLPoint",
				"X:="			, "0mm",
				"Y:="			, "6.06932mm",
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
		"Name:="		, "Polyline2",
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
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DPolylineTab",
			[
				"NAME:PropServers", 
				"Polyline2:CreatePolyline:2:Segment0"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Point2",
					"X:="			, "0mm",
					"Y:="			, "(ri+wT*4.2)",
					"Z:="			, "0mm"
				],
				[
					"NAME:Point1",
					"X:="			, "0mm",
					"Y:="			, "(ri+wT*2.2)",
					"Z:="			, "0mm"
				]
			]
		]
	])
oEditor.CreateCircle(
	[
		"NAME:CircleParameters",
		"IsCovered:="		, True,
		"XCenter:="		, "0mm",
		"YCenter:="		, "5mm",
		"ZCenter:="		, "0mm",
		"Radius:="		, "0.11180339887499mm",
		"WhichAxis:="		, "X",
		"NumSegments:="		, "0"
	], 
	[
		"NAME:Attributes",
		"Name:="		, "Circle1",
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
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"Circle1:CreateCircle:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Radius",
					"Value:="		, "wT"
				],
				[
					"NAME:Center Position",
					"X:="			, "0mm",
					"Y:="			, "ri",
					"Z:="			, "0mm"
				]
			]
		]
	])
oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve1,EquationCurve2,EquationCurve3,Polyline1,Polyline2"
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
oEditor.SweepAlongPath(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve1,Circle1",
		"NewPartsModelFlag:="	, "Model"
	], 
	[
		"NAME:PathSweepParameters",
		"DraftAngle:="		, "0deg",
		"DraftType:="		, "Round",
		"CheckFaceFaceIntersection:=", False,
		"TwistAngle:="		, "0deg"
	])
oDesign.Undo()
oDesign.Redo()
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve3:CreateEquationCurve:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Y(_t)",
					"Value:="		, "(ri+wT*4.3) * cos(_t)"
				],
				[
					"NAME:X(_t)",
					"Value:="		, "(ra+wT*4.3) * sin(_t)"
				]
			]
		]
	])
oDesign.Undo()
oDesign.Undo()
oDesign.Undo()
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"EquationCurve3:CreateEquationCurve:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Y(_t)",
					"Value:="		, "(ri+wT*4.3) * cos(_t)"
				],
				[
					"NAME:X(_t)",
					"Value:="		, "(ra+wT*4.3) * sin(_t)"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DPolylineTab",
			[
				"NAME:PropServers", 
				"Polyline2:CreatePolyline:2:Segment0"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Point2",
					"X:="			, "0mm",
					"Y:="			, "(ri+wT*4.3)",
					"Z:="			, "0mm"
				]
			]
		]
	])
oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, "EquationCurve1,EquationCurve2,EquationCurve3,Polyline1,Polyline2"
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
oEditor.SweepAlongPath(
	[
		"NAME:Selections",
		"Selections:="		, "Circle1,EquationCurve1",
		"NewPartsModelFlag:="	, "Model"
	], 
	[
		"NAME:PathSweepParameters",
		"DraftAngle:="		, "0deg",
		"DraftType:="		, "Round",
		"CheckFaceFaceIntersection:=", False,
		"TwistAngle:="		, "0deg"
	])
