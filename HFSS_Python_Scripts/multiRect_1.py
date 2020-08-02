# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 15:45:00  Jul 16, 2020
# ----------------------------------------------

# this does not work to import python libs..
#import sys
#sys.path.append("C:\Users\Adam\Documents\GitHub\phd_2019\Python\Lib\numpy-master")
#sys.path.append("C:\Users\Adam\Documents\GitHub\phd_2019\Python\Lib\numpy-master\numpy-master\numpy")
#sys.path.append("C:\Users\Adam\Documents\GitHub\phd_2019\Python\Lib\numpy-master\numpy-master\numpy\matlib.py")
#import numpy as np

import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Rect_Test")
oDesign  = oProject.SetActiveDesign("Maxwell3DDesign1")
oEditor  = oDesign.SetActiveEditor("3D Modeler")
				
############################################################################
#                        Custom Functions
############################################################################
# description: creates lines for HFSS 
# input parameters:
# xi
# description: intitial x postion [m] for a single line segment
#
# yi
# description: intitial y postion [m] for a single line segment
# type: string
#
# zi
# description: intitial z postion [m] for a single line segment
# type: string
#
# xf
# description: final x postion [m] for a single line segment
# type: string
#
# yf
# description: final y postion [m] for a single line segment
# type: string
#
# zf
# description: final z postion [m] for a single line segment
# type: string
#
# lineName
# description: name of the line
# type: String
#
# output paramters:
# description: its a void command, creates a line object in HFSS	
#
def create_PolyLine(xi,yi,xf,yf,zi,zf,lineName):
	n = 1
	oEditor.CreatePolyline(
	[
		"NAME:PolylineParameters",
		"IsPolylineCovered:="	, True,
		"IsPolylineClosed:="	, False,
		[
			"NAME:PolylinePoints",
			[
				"NAME:PLPoint",
				"X:="			, xi,
				"Y:="			, yi,
				"Z:="			, zi
			],
			[
				"NAME:PLPoint",
				"X:="			, xf,
				"Y:="			, yf,
				"Z:="			, zf
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
		"Name:="		, "cw_"+lineName+"",
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

# description: creates rect coil for HFSS 
# input parameters:
#
# N
# description: Number of turns along the z-direction
# type: <scalar> [integer]
#
# output paramters:
# description: its a void command, creates a line object in HFSS	
#
#def create_MultiCoil_Rect(Nxy,N):
# initialize variables
	nxy = 0 # counter for number of turns along xy-plane
	nz  = 0 # counter for number of turns along z-direction
	sn  = 0 # counter for number of lines, will be used to 
	#give each line an unique name to later combine
	z   = 0 # counter for the zRect (array containg z-steps)



def create_singleCoil(N,O,nxy):
	nz  = 0	
	z   = 0
	sn  = 0 
	sep_xy = 2.2 
	sep_z  = 1.52
	# Coiled Rectangle	
	ZN0 = ZN-1 # one less than the total 
	if(O==0):
	# -------------------------------- #
	# ------ Counter-Clock-Wise ------ # 
	# -------------------------------- #
		for ns in range(0,int(N)+1):
			# first iteration 
			# half (bottom)
			if(ns==0):
			# front side 
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				#yi = "wT*2 + wT*"+str(nxy)
				#yf = "ra/2 + wT*"+str(nxy)
				yi = "wT*2"
				yf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)				
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns-0.5)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
			# final iteration
			# half (top)
			elif ns==int(N):
			# front side 
				# even (left side)
				if(ns%2==0):
					xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					# yi = "-ra/2 - wT*"+str(nxy)
					# yf = "-wT*2 - wT*"+str(nxy)
					yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
					yf = "-wT*2"
					zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns-1)
					zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns-0.5)
					fn = "fs"+str(ns)+"_"+str(nxy)	# filname
					create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					fnList.append(fn)
					z = z + 1
				# odd (right side)
				else:
					xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					#yi = "ra/2 + wT*"+str(nxy)
					#yf = "wT*2 + wT*"+str(nxy)
					yi = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					yf = "wT*2"
					zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns-1)
					zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns-0.5)
					fn = "fs"+str(ns)+"_"+str(nxy)	# filname
					create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					fnList.append(fn)
					z = z + 1				
					
			# inside coil
			elif(ns is not int(N)):
			# front side	
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns-1)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1	
			if (ns is not int(N) and ns<int(N)):	
			# right side 
				xi = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ri/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ri/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "rs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
			# back side 
				xi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "bs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
				xi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
			# left side 
				xf = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "ls"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
	
	# ------------------------ # 
	# ------ Clock-Wise ------ # 
	# ------------------------ #
	elif(O==1):
		zn = int(N)-1
		#for ns in range(1,int(N)+2):
		for ns in range(0,int(N)+1):
			# first iteration
			# front (half) (done)
			if(ns==0):
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				# yi = "-ra/2 - wT*"+str(nxy)
				# yf = "-wT*2 - wT*"+str(nxy)
				yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-wT*2"
				zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)			
				z = z + 1	
			# final iteration
			# front (half) (working)
			elif(ns==int(N)):
				# ends on ?? (even)
				#if(ns%2==0):
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "wT*2"
				yf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)				
				zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z  = z + 1				
				# ends on ???? (odd)
				# elif(ns%2==1):
					# xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					# xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					# #yi = "ra/2 + wT*"+str(nxy)
					# #yf = "wT*2 + wT*"+str(nxy)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
					# yi = "ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
					# yf = "wT*2"					
					# zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(zn+2)
					# zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(zn+1)
					# fn = "fs"+str(ns)+"_"+str(nxy)	# filname
					# create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					# fnList.append(fn)
					# z = z + 1			
			
			# inside coil
			# front (full)
			elif(ns is not int(N)):
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf =  "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z+1])  +"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns-1)
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1	
			# right, back, left
			if(ns is not int(N) and ns<int(N)):
			# right side (done)
				xi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)				
				xf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "ls"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)	
				z = z + 1					
			# back side
				xi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "bs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)		
				z = z + 1					
			# left side
				xi = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ri/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ri/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "rs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
# description: creates lines for HFSS 
# input parameters:
# fnList
# description: list that contains the line names as strings
# type: list <Strings>
#
# output paramters:
# description: unites all polylines in HFSS into one structure(object)	
#
def unite_PolyLine(fnList):
	FN = len(fnList)
	q  = ""
	c  = ","
	cw = "cw_"
	for fn  in range(0,FN):
		if fn == 0:
			fList = q + cw+fnList[fn]
		elif fn == FN:
			fList = fList +c+ cw+fnList[fn] +q
		else:
			fList = fList +c+ cw+fnList[fn]
			
	oEditor.Unite(
	[
		"NAME:Selections",
		"Selections:="		, fList
	], 
	[
		"NAME:UniteParameters",
		"KeepOriginals:="	, False
	])
	
# description: sweeps 2D circle along the path of coiled rect 
# input parameters:
# fnList
# description: list that contains the line names as strings, only using the first entry
# type: list <Strings>
#
# output paramters:
# description: creates 3D wire structure with a radius of wT
#
def ThickenWire(fnList):
	q  = ""
	c  = ","
	cw = "cw_"	
	sweepStr = q+cw+fnList[0]+c+q+"circ0"+q
	# create circle
	oEditor.CreateCircle(
	[
		"NAME:CircleParameters",
		"IsCovered:="		, True,
		"XCenter:="		, "ri",
		"YCenter:="		, "wT*2",
		"ZCenter:="		, "0mm",
		"Radius:="		, "wT",
		"WhichAxis:="		, "X",
		"NumSegments:="		, "0"
	], 
	[
		"NAME:Attributes",
		"Name:="		, "circ0",
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
	# sweep circle along path
	oEditor.SweepAlongPath(
	[
		"NAME:Selections",
		"Selections:="		, sweepStr,
		"NewPartsModelFlag:="	, "Model"
	], 
	[
		"NAME:PathSweepParameters",
		"DraftAngle:="		, "0deg",
		"DraftType:="		, "Round",
		"CheckFaceFaceIntersection:=", False,
		"TwistAngle:="		, "0deg"
	])



def createVars(Nxy,N,h,ra,ri,wT):
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
					"NAME:Nxy",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, str(Nxy)
				],				
				[
					"NAME:N",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, str(N)
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
					"NAME:wT",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, str(wT)
				],
				[
					"NAME:h",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, str(h)
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

#--------------------------------------------------------------------------
#---------------------------END OF Custom Functions------------------------
#--------------------------------------------------------------------------


############################################################################	
############################################################################
#                              MAIN FUNCTION
############################################################################
############################################################################

############################################################################
# define parameters within python script
############################################################################
# current code needs nxySize to be equal or greater than 3

wT0 = 0.2546
wT  = str(wT0) + "mm"
h 	= (wT0*1e-3)*0.35
ra  = "30mm"
ri  = "30mm"
N   = 2
Nxy = 2
#createVars(N,Nxy,h,ra,ri,wT)

# set up the z-values
zEnd   = h*int(N)*2*3.14 
ZN     = int(N)*4 + 2
zRect  = []
zRev   = []
fnList = [] 
zSTEP  = zEnd/ZN
zn     = 0	# counter for z-axis
ns     = 0
z      = 0
#O     = 1	# works --> Nxy is even

nxyO   = 1
nxy=0
# create zRect
for ns in range(0,ZN+1):
	zStr = "(zEnd *("+str(ns)+"/("+str(ZN)+")))"
	#zRect.append(zEnd * (ns/(ZN-1)))
	zRect.append(zStr)
	ns = ns+1
# create zRev
for ns in range(len(zRect)-1,-1,-1):
	zRev.append(zRect[ns])
zRev = zRev[1:len(zRev)]

############################################################################
# construct coiled rect wire
############################################################################
nxy = 2 
#O=0 # doesnt break
O  = 1 # breaks
create_singleCoil(N,O,nxy)


#create_MultiCoil_Rect(Nxy,N)
#unite_PolyLine(fnList)
#ThickenWire(fnList)