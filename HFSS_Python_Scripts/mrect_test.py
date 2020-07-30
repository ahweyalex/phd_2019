		for ns in range(0,int(N)+1):
			# first iteration 
			# half (bottom)
			if ns==0:
			# front side 
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				#yi = "wT*2 + wT*"+str(nxy)
				#yf = "ra/2 + wT*"+str(nxy)
				yi = "wT*2"
				yf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)				
				zi = str(zRect[z])+"+wT*1.15*"+str(ns)
				zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
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
					zi = str(zRect[z])+"+wT*1.15*"+str(ns-1)
					zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
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
					zi = str(zRect[z])+"+wT*1.15*"+str(ns-1)
					zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
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
				zi = str(zRect[z])+"+wT*1.15*"+str(ns-1)
				zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
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
				zi = str(zRect[z])+"+wT*1.15*"+str(ns)
				zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
				fn = "rs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
			# back side 
				xi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*1.15*"+str(ns)
				zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
				fn = "bs"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
				xi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
			# left side 
				xf = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRect[z])+"+wT*1.15*"+str(ns)
				zf = str(zRect[z+1])+"+wT*1.15*"+str(ns)
				fn = "ls"+str(ns)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1