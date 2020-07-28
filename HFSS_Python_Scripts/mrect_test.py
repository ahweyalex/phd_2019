def create_singleCoil(N,O,nxy):
	nxy = 0
	nz  = 0	
	z   = 0
	sn  = 0 
	# Coiled Rectangle	
	ZN0 = ZN-1 # one less than the total 
	# ------ SINGLE COIL CASE (Nxy=0) ------ # 
	# ccw
	if(O==0):
	# ------ Counter-Clock-Wise ------ # 
		for ns in range(0,int(N)+1):
			# first iteration
			# half (bottom)
			if ns==0:
			# front side 
				xi = "ri/2 + wT*"str(nxy)
				xf = "ri/2 + wT*"str(nxy)
				yi = "wT*2 + wT*"str(nxy)
				yf = "ra/2 + wT*"str(nxy)
				zi = str(zRect[z])
				zf = str(zRect[z+1])
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
					xi = "ri/2 + wT*"str(nxy)
					xf = "ri/2 + wT*"str(nxy)
					yi = "-ra/2 - wT*"str(nxy)
					yf = "-wT*2 - wT*"str(nxy)
					zi = str(zRect[z])
					zf = str(zRect[z+1])
					fn = "fs"+str(ns)+"_"+str(nxy)	# filname
					create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					fnList.append(fn)
					z = z + 1
				# odd (right side)
				else:
					xi = "ri/2 + wT*"str(nxy)
					xf = "ri/2 + wT*"str(nxy)
					yi = "ra/2 + wT*"str(nxy)
					yf = "wT*2 + wT*"str(nxy)
					zi = str(zRect[z])
					zf = str(zRect[z+1])
					fn = "fs"+str(ns)+"_"+str(nxy)	# filname
					create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					fnList.append(fn)
					z = z + 1				
					
			# inside coil
			elif(ns is not int(N)):
			# front side	
				xi = "ri/2 + wT*"str(nxy)
				xf = "ri/2 + wT*"str(nxy)
				yi = "-ra/2 - wT*"str(nxy)
				yf = "ra/2 + wT*"str(nxy)
				zi = str(zRect[z])
				zf = str(zRect[z+1])
				fn = "fs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1	
			if (ns is not int(N)):	
			# right side 
				xi = "ra/2 + wT*"str(nxy)
				xf = "-ra/2 - wT*"str(nxy)
				yi = "ri/2  + wT*"str(nxy)
				yf = "ri/2  + wT*"str(nxy)
				zi = str(zRect[z])
				zf = str(zRect[z+1])
				fn = "rs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
			# back side 
				xi = "-ri/2 - wT*"str(nxy)
				xf = "-ri/2 - wT*"str(nxy)
				yi = "ra/2  + wT*"str(nxy)
				yf = "-ra/2 - wT*"str(nxy)
				zi = str(zRect[z])
				zf = str(zRect[z+1])
				fn = "bs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
			# left side 
				xi = "-ra/2 - wT*"str(nxy)
				xf = "ra/2  + wT*"str(nxy)
				yi = "-ri/2 - wT*"str(nxy)
				yf = "-ri/2 - wT*"str(nxy)
				zi = str(zRect[z])
				zf = str(zRect[z+1])
				fn = "ls"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1

	# ------ Clock-Wise ------ # 
	else:
	