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
def create_CCW_Coil(N,O,nxy,sep_xy,sep_z,fnList):
    oEditor.CreateEquationCurve(
        [
            "NAME:EquationBasedCurveParameters",
            "XtFunction:="		, "(ra + wT) * sin(_t)",
            "YtFunction:="		, "(ri + wT) * cos(_t)",
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
        
def create_CW_Coil(N,O,nxy,sep_xy,sep_z,fnList):
    oEditor.CreateEquationCurve(
        [
            "NAME:EquationBasedCurveParameters",
            "XtFunction:="		, "(ri + wT) * cos(_t)",
            "YtFunction:="		, "(ra + wT) * sin(_t)",
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
#==========================================================================#
#==========================================================================#
#==========================================================================#

############################################################################
#                       FUNCTION NAME: MAIN
############################################################################
O   = 'CW' # O=1
NXY = 2
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
        create_CCW_Coil(N,O,nxy,sep_xy,sep_z,fnList)
        O = 'CCW' # switch orientation
    elif(O=='CCW'):
        create_CW_Coil(N,O,nxy,sep_xy,sep_z,fnList)
        O = 'CW' # switch orientation


############################################################################
#                            END: MAIN
############################################################################