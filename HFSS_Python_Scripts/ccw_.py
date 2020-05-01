	for n in range(nxySize):
		# first case
		if n==0:
			# create first circ 
			oEditor.CreateEquationCurve(
				[
					"NAME:EquationBasedCurveParameters",
					"XtFunction:="		, "(ra) * cos(_t)",
					"YtFunction:="		, "(ri) * sin(_t)",
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
							"Y:="			, "ri + wT*"+Nxy[n+1]+".0",
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
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+") * sin(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+") * cos(_t)",
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
									"Y:="			, "ri + wT*"+Nxy[n]+".0",
									"Z:="			, "0"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n+1]+".0",
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
						"XtFunction:="		, "(ra + wT*"+Nxy[n]+") * cos(_t)",
						"YtFunction:="		, "(ri + wT*"+Nxy[n]+") * sin(_t)",
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
									"Y:="			, "ri + wT*"+Nxy[n]+".0",
									"Z:="			, "zEnd"
								],
								[
									"NAME:PLPoint",
									"X:="			, "0mm",
									"Y:="			, "ri + wT*"+Nxy[n+1]+".0",
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
