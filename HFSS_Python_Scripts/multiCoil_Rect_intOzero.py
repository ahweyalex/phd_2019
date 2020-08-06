# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
# 15:45:00  Jul 16, 2020
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Rect_Test")
oDesign  = oProject.SetActiveDesign("Maxwell3DDesign1")
oEditor  = oDesign.SetActiveEditor("3D Modeler")

				
############################################################################
#                        Custom Functions
############################################################################

#--------------------------------------------------------------------------#
#                     FUNCTION NAME: createVars
# DESCRIPTION: creates variables within HFSS, make sure to comment this out 
# after variables have been created when re-running this script on the same
# project to avoid errors.
#                         [INPUT PARAMETERS]
# Nxy
# description: Number of coils/number of turns along the xy-plane
# type: integer 
# units: N/A
#
# N
# description: Number of turns along the z-direction
# type: integer
# units: N/A
#
# h
# description: total height of the coiled
# type: float/string
# units: [m]
#
# ra
# description: radius in the x-direction
# type: float/string
# units: [m]
#
# ri
# description: radius in the x-direction
# type: float/string
# units: [m]
#
# wT
# description: thickness of wire (gauge)
# type: float/string
# units: [m]
#

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
					"NAME:sep_z",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, 0.25
				],
				[
					"NAME:sep_xy",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, 2.1
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
#                       END: createVars
#--------------------------------------------------------------------------#


#--------------------------------------------------------------------------#
#                     FUNCTION NAME: create_PolyLine
# DESCRIPTION: creates lines for HFSS 
#                         [INPUT PARAMETERS]
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
#                       END: create_PolyLine
#--------------------------------------------------------------------------#


#--------------------------------------------------------------------------#
#                     FUNCTION NAME: create_singleCoil
# DESCRIPTION: creates a single rectangular coil with orientation clock-wise
# or counter clock-wise
#                         [INPUT PARAMETERS]
# N
# description: Number of turns in the z-direction
# type: string/float
#
# O
# description: orientation of the coil. value of 1 yields ccw orientation. 
# value of 0 yields cw orientation  
# type: integer
# values: 1 or 0
#
# nxy
# description: value between 0 and Nxy. determines placement in xy-plane of the 
# rect-coil lines
# type: integer
# values: 0 to Nxy
#
# sep_xy
# description: seperation along the xy-plane between each coils
# type: float/string
# units: N/A
#
# sep_z
# description: seperation along the z-plane within the coils
# type: float/string
# units: N/A
#
# ZN
# description: total number of points along the z-direction 
# for each point of the rectangule coil
# type: integer
# units: N/A
#
def create_singleCoil(N,O,nxy,sep_xy,sep_z,ZN,zRect,fnList):
	nz  = 0	
	z   = 0
	sn  = 0 
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
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
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
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
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
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-wT*2"
				zi = str(zRect[z])  +"+wT*"+str(sep_z)+"*"+str(ns-0.5)
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
			# front (full)
			elif(ns is not int(N)):
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns-1)
				zf = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1		
			# right, back, left
			if(ns is not int(N) and ns<int(N)):
			# left side 
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
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
				zi = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "bs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
				xi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
			# right side 
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z+1])+"+wT*"+str(sep_z)+"*"+str(ns)
				zf = str(zRect[z])+"+wT*"+str(sep_z)+"*"+str(ns)
				fn = "rs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1


#                       END: create_singleCoil
#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
#                     FUNCTION NAME: multiRectCoil
# DESCRIPTION:
#                         [INPUT PARAMETERS]
# O
# description: orientation of the coil. value of 1 yields ccw orientation. 
# type: integer
# values: 0 or 1
#
# Nxy
# description:
# type: integer
#
# N
# description: Number of turns in the z-direction
# type: string/float
#
# wT0
# description: thickness of wire (gauge)
# type: float/string
# units: [m]
#
# h
# description: total height of the coiled
# type: float/string
# units: [m]
#
# ra
# description: radius in the x-direction
# type: float/string
# units: [m]
#
# ri
# description: radius in the y-direction
# type: float/string
# units: [m]
#
# sep_xy
# description: seperation along the xy-plane between each coils
# type: float/string
# units: N/A
#
# sep_z
# description: seperation along the z-plane within the coils
# type: float/string
# units: N/A
#
def multiRectCoil(O,Nxy,N,wT0,h,ra,ri,sep_xy,sep_z,fnList):
	wT  = str(wT0) + "mm"
	h 	= (wT0*1e-3)*0.35
	# set up the z-values
	zEnd   = h*int(N)*2*3.14 # last value along z-direction
	ZN     = int(N)*4 + 2	 # total number of points along the z-direction
	# for each point of the rectangule coil
	zRect  = []				 # initialize empty list to later fill with 
	# points along z-direction
	fnList = []				 # initialize empty list to later fill with 
	# strings of each line segments
	zSTEP  = zEnd/ZN	 	 	
	zn     = 0	# counter for z-axis
	ns     = 0
	z      = 0
	# create zRect
	for ns in range(0,ZN+1):
		zStr = "(zEnd *("+str(ns)+"/("+str(ZN)+")))"
		#zRect.append(zEnd * (ns/(ZN-1)))
		zRect.append(zStr)
		ns = ns+1	
		
	# create multi-coil
	for nxy in range(0,Nxy):
		create_singleCoil(N,O,nxy,sep_xy,sep_z,ZN,zRect,fnList)
		# inbetween connections
		# even --> O=0 (top)
		if(nxy%2==0 and nxy is not Nxy-1):
			xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
			xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy+1)
			yi = "-wT*2"
			yf = "wT*2"
			zi = "(zEnd *(9/(10)))+wT*"+str(sep_z)+"*1.5"
			zf = "(zEnd *(9/(10)))+wT*"+str(sep_z)+"*1.5"
			fn = "fc_"+str(nxy)	# filname
			create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
			fnList.append(fn)
		# odd --> O=1 (bottom)
		elif(nxy%2==1 and nxy is not Nxy-1):
			xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
			xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy+1)
			yi = "-wT*2"
			yf = "wT*2"
			zi = "wT*"+str(sep_z)+"*-0.5"
			zf = "wT*"+str(sep_z)+"*-0.5"
			fn = "fc_"+str(nxy)	# filname
			create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
			fnList.append(fn)	
		# feed lines
		if(nxy==0):
			# goes down
			xi = "ri/2"
			xf = "ri/2"
			yi = "wT*2"
			yf = "wT*2"
			zi = "wT*"+str(sep_z)+"*-0.5"
			zf = "wT*"+str(sep_z)+"*-0.5-3*wT"
			fn = "fc_a_"+str(nxy)	# filname
			create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
			fnList.append(fn)
			# feed line 
			xi = "ri/2"
			xf = "ri"
			yi = "wT*2"
			yf = "wT*2"
			zi = "wT*"+str(sep_z)+"*-0.5-3*wT"
			zf = "wT*"+str(sep_z)+"*-0.5-3*wT"
			fn = "fc_b_"+str(nxy)	# filname
			create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
			fnList.append(fn)	
		# (top) (even)
		if(nxy==Nxy-1 and Nxy%2==0):
			xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
			xf = "ri"
			yi = "-wT*2"
			yf = "-wT*2"
			zi = "wT*"+str(sep_z)+"*-0.5"
			zf = "wT*"+str(sep_z)+"*-0.5"
			fn = "feed_top"+str(ns)+"_"+str(nxy)	# filname
			create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
			fnList.append(fn)
		# (bottom) (odd)
		if(nxy==Nxy-1 and Nxy%2==1):	
			xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
			xf = "ri"
			yi = "-wT*2"
			yf = "-wT*2"
			zi = "(zEnd *(9/(10)))+wT*"+str(sep_z)+"*1.5"
			zf = "(zEnd *(9/(10)))+wT*"+str(sep_z)+"*1.5"
			fn = "feed_bottom"+str(ns)+"_"+str(nxy)	# filname
			create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
			fnList.append(fn)
		# change orienation	
		if(O==1):
			O=0
		elif(O==0):
			O=1	
#                       END: multiRectCoil
#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
#                     FUNCTION NAME: unite_PolyLine
# DESCRIPTION: unites all polylines in HFSS into one structure(object)
# <not working?>
#                         [INPUT PARAMETERS]
# fnList
# description: list that contains the line names as strings
# type: list <Strings>	
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
#                       END: unite_PolyLine
#--------------------------------------------------------------------------#

#--------------------------------------------------------------------------#
#                     FUNCTION NAME: unite_PolyLine
# DESCRIPTION: creates 3D wire structure with a radius of wT
#                         [INPUT PARAMETERS]
# <needs unite_PolyLine to work for this to work>
# fnList
# description: list that contains the line names as strings, only using the first entry
# type: list <Strings>
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
#                       END: unite_PolyLine
#--------------------------------------------------------------------------#


############################################################################
#                     FUNCTION NAME: MAIN
############################################################################
O   = 0 
Nxy = 2
N   = 2
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
#createVars(Nxy,N,h,ra,ri,wT)
multiRectCoil(O,Nxy,N,wT0,h,ra,ri,sep_xy,sep_z,fnList)

############################################################################
#                       END: MAIN
############################################################################