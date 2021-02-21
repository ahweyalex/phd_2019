# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 21:40:39  Feb 16, 2021
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Ellipse_Loop_Temp")
oDesign = oProject.SetActiveDesign("HFSSDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")

############################################################################
#                       FUNCTION NAME: createSingleCoil
############################################################################
def create_CCW_Coil(NXY,N,O,nxy,sep_xy,sep_z,fnList):
    # ellipse line
    oEditor.CreateEquationCurve(
        [
            "NAME:EquationBasedCurveParameters",
            "XtFunction:="		, "(ra + wT*("+str(nxy)+"*2.2+1)) * sin(_t)",
            "YtFunction:="		, "(ri + wT*("+str(nxy)+"*2.2+1)) * cos(_t)",
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
            "Name:="		, "EquationCurve" + str(nxy),
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
    # create connection line
    if(nxy<(NXY-1)):
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
                    "Y:="			, "(ri + wT*("+str(nxy)+"*2.2+1))",
                    "Z:="			, "zEnd"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(ri + wT*("+str(nxy+1)+"*2.2+1))",
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
            "Name:="		, "CCW_Polyline_"+str(nxy),
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
    elif(nxy<NXY):
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
                    "Y:="			, "(ri + wT*("+str(nxy)+"*2.2+1))",
                    "Z:="			, "zEnd"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(1.5*ri + wT*("+str(nxy+1)+"*2.2+1))",
                    "Z:="			, "zEnd"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(1.5*ri + wT*("+str(nxy+1)+"*2.2+1))",
                    "Z:="			, "-4*wT"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(ri + wT*("+str(0)+"*2.2+1))",
                    "Z:="			, "-4*wT"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(ri + wT*("+str(0)+"*2.2+1))",
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
                ],
                [
                    "NAME:PLSegment",
                    "SegmentType:="		, "Line",
                    "StartIndex:="		, 1,
                    "NoOfPoints:="		, 2
                ],
                [
                    "NAME:PLSegment",
                    "SegmentType:="		, "Line",
                    "StartIndex:="		, 2,
                    "NoOfPoints:="		, 2
                ],
                [
                    "NAME:PLSegment",
                    "SegmentType:="		, "Line",
                    "StartIndex:="		, 3,
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
            "Name:="		, "FEED_"+str(nxy),
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
        
def create_CW_Coil(NXY,N,O,nxy,sep_xy,sep_z,fnList):
    # ellipse line
    oEditor.CreateEquationCurve(
        [
            "NAME:EquationBasedCurveParameters",
            "XtFunction:="		, "(ri + wT*("+str(nxy)+"*2.2+1)) * cos(_t)",
            "YtFunction:="		, "(ra + wT*("+str(nxy)+"*2.2+1)) * sin(_t)",
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
            "Name:="		, "EquationCurve"+ str(nxy),
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
            "Selections:="		, "EquationCurve"+ str(nxy),
            "NewPartsModelFlag:="	, "Model"
        ], 
        [
            "NAME:RotateParameters",
            "RotateAxis:="		, "Z",
            "RotateAngle:="		, "90deg"
        ])
    if(nxy<(NXY-1)):
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
                    "Y:="			, "(ri + wT*("+str(nxy)+"*2.2+1))",
                    "Z:="			, "0"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(ri + wT*("+str(nxy+1)+"*2.2+1))",
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
            "Name:="		, "CW_Polyline_"+str(nxy),
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
    elif(nxy<NXY):
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
                    "Y:="			, "(ri + wT*("+str(nxy)+"*2.2+1))",
                    "Z:="			, "0"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(1.5*ri + wT*("+str(nxy+1)+"*2.2+1))",
                    "Z:="			, "0"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(1.5*ri + wT*("+str(nxy+1)+"*2.2+1))",
                    "Z:="			, "-4*wT"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(ri + wT*("+str(0)+"*2.2+1))",
                    "Z:="			, "-4*wT"
                ],
                [
                    "NAME:PLPoint",
                    "X:="			, "0mm",
                    "Y:="			, "(ri + wT*("+str(0)+"*2.2+1))",
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
                ],
                [
                    "NAME:PLSegment",
                    "SegmentType:="		, "Line",
                    "StartIndex:="		, 1,
                    "NoOfPoints:="		, 2
                ],
                [
                    "NAME:PLSegment",
                    "SegmentType:="		, "Line",
                    "StartIndex:="		, 2,
                    "NoOfPoints:="		, 2
                ],
                [
                    "NAME:PLSegment",
                    "SegmentType:="		, "Line",
                    "StartIndex:="		, 3,
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
            "Name:="		, "FEED_"+str(nxy),
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


############################################################################
#               FUNCTION NAME: CREATE CIRCLE AND CYLINDER
############################################################################
def create_circ_cylind():
    
    # circle to sweep along wires to thicken the wire 
    oEditor.CreateCircle(
        [
            "NAME:CircleParameters",
            "IsCovered:="		, True,
            "XCenter:="		, "0mm",
            "YCenter:="		, "(ri*1.5 + wT*(0*2.2+1))",
            "ZCenter:="		, "-4*wT",
            "Radius:="		, "wT",
            "WhichAxis:="		, "Y",
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
    
    # remove cylinder to create gap for lump port
    oEditor.CreateCylinder(
        [
            "NAME:CylinderParameters",
            "XCenter:="		, "0mm",
            "YCenter:="		, "(ri*1.5 + wT*(0*2.2+1))",
            "ZCenter:="		, "-4*wT",
            "Radius:="		, "wT",
            "Height:="		, "-wT/2",
            "WhichAxis:="		, "Y",
            "NumSides:="		, "0"
        ], 
        [
            "NAME:Attributes",
            "Name:="		, "remove_cy",
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

    # lump port
    oEditor.CreateRectangle(
        [
            "NAME:RectangleParameters",
            "IsCovered:="		, True,
            "XStart:="		, "-wT/2",
            "YStart:="		, "(ri*1.5 + wT*(0*2.2+1))-wT/2",
            "ZStart:="		, "-4*wT",
            "Width:="		, "wT",
            "Height:="		, "wT/2",
            "WhichAxis:="		, "Z"
        ], 
        [
            "NAME:Attributes",
            "Name:="		, "lp",
            "Flags:="		, "",
            "Color:="		, "(255 0 0)",
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

    # airbox
    oEditor.CreateBox(
        [
            "NAME:BoxParameters",
            "XPosition:="		, "-airBoxDim",
            "YPosition:="		, "-airBoxDim",
            "ZPosition:="		, "-airBoxDim",
            "XSize:="		, "2*airBoxDim",
            "YSize:="		, "2*airBoxDim",
            "ZSize:="		, "2*airBoxDim"
        ], 
        [
            "NAME:Attributes",
            "Name:="		, "airBox",
            "Flags:="		, "",
            "Color:="		, "(143 175 143)",
            "Transparency:="	, 1,
            "PartCoordinateSystem:=", "Global",
            "UDMId:="		, "",
            "MaterialValue:="	, "\"vacuum\"",
            "SurfaceMaterialValue:=", "\"\"",
            "SolveInside:="		, True,
            "IsMaterialEditable:="	, True,
            "UseMaterialAppearance:=", False,
            "IsLightweight:="	, False
        ])
    
#==========================================================================#
#==========================================================================#
#==========================================================================#

############################################################################
#                       FUNCTION NAME: MAIN
############################################################################
O   = 'CW' # O=1
NXY = 3
Nxy = []
for idx in range(0,NXY):
    Nxy.append(idx)
    
N   = 1
wT0 = 0.2546
wT  = str(wT0) + "mm"
h 	= (wT0*1e-3)*0.35
ra  = "30mm"
ri  = "30mm"
#sep_xy = 2.2 
#sep_z  = 1.52
sep_xy = "sep_xy" 
sep_z  = "sep_z"
fnList = []	

for nxy in range(0,NXY):
    if(O=='CW'):
        create_CCW_Coil(NXY,N,O,nxy,sep_xy,sep_z,fnList)
        O = 'CCW' # switch orientation
    elif(O=='CCW'):
        create_CW_Coil(NXY,N,O,nxy,sep_xy,sep_z,fnList)
        O = 'CW' # switch orientation
    
create_circ_cylind()
############################################################################
#                            END: MAIN
############################################################################