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
nxySize = 4
Nxy = []
for x in range(nxySize-1):
	Nxy.append(x)
Nxy = str(Nxy)	

ra0 = 30
ri0 = 30

wT = "0.2546mm"
ra = "30mm"
ri = "30mm"
N  = "3"
numSeg = "200"
O = 1
########################################################################
#### END:  define parameters within python script
########################################################################


############################################################################
# define parameters within hfss stuff
## Initialize Variables 
############################################################################
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
				"NAME:NewProps",
				[
					"NAME:wT",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, wT
				],
				[
					"NAME:pitch",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "wT*2.0001"
				],
				[
					"NAME:ra",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, ra
				],
				[
					"NAME:ri",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, ri
				],
				[
					"NAME:N",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, N
				],
				[
					"NAME:Nxy",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, nxySize
				],
				[
					"NAME:numSeg",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, 
				],
				[
					"NAME:h",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "wT*0.35"
				],
				[
					"NAME:zEnd",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "h*N*2*pi"
				]
			]
		]
	])
########################################################################
#### END:  define parameters within hfss
########################################################################
