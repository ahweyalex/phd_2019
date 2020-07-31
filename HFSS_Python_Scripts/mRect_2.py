			
			# final iteration
			# front (half)
			elif(ns==int(N)):
				# ends on ?? (even)
				if(ns%2==0):
					xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					# yi = "-ra/2 - wT*"+str(nxy)
					# yf = "-wT*2 - wT*"+str(nxy)
					yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
					yf = "-wT*2"
					zi = str(zRev[z])+"+wT*1.15*"+str(zn+1)
					zf = str(zRev[z+1])+"+wT*1.15*"+str(zn)
					fn = "fs"+str(zn)+"_"+str(nxy)	# filname
					create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					fnList.append(fn)
					z = z + 1				
				# ends on ???? (odd)
				elif(ns%2==1):
					xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					#yi = "ra/2 + wT*"+str(nxy)
					#yf = "wT*2 + wT*"+str(nxy)
					yi = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
					yf = "wT*2"
					zi = str(zRev[z])+"+wT*1.15*"+str(zn+1)
					zf = str(zRev[z+1])+"+wT*1.15*"+str(zn)
					fn = "fs"+str(zn)+"_"+str(nxy)	# filname
					create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
					fnList.append(fn)
					z = z + 1			
			# inside coil
			# front (full)
			elif(ns is not int(N)):
				xi = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "ri/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRev[z])+"+wT*1.15*"+str(zn+1)
				zf = str(zRev[z+1])+"+wT*1.15*"+str(zn)
				fn = "fs"+str(zn)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1				
			# left, back, right
			if(ns is not int(N) and ns<int(N)):
			# left side
				xi = "-ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)				
				xf = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRev[z])+"+wT*1.15*"+str(zn)
				zf = str(zRev[z+1])+"+wT*1.15*"+str(zn)
				fn = "ls"+str(zn)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1
			# back side
				xi = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ri/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ra/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRev[z])+"+wT*1.15*"+str(zn)
				zf = str(zRev[z+1])+"+wT*1.15*"+str(zn)
				fn = "bs"+str(zn)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1			
			# right side
				xi = "ra/2 +"+str(sep_xy)+"*wT*"+str(nxy)
				xf = "-ra/2 -"+str(sep_xy)+"*wT*"+str(nxy)
				yi = "ri/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				yf = "ri/2  +"+str(sep_xy)+"*wT*"+str(nxy)
				zi = str(zRev[z])+"+wT*1.15*"+str(zn)
				zf = str(zRev[z+1])+"+wT*1.15*"+str(zn)
				fn = "rs"+str(zn)+"_"+str(nxy)	# filname
				create_PolyLine(xi,yi,xf,yf,zi,zf,fn)
				fnList.append(fn)
				z = z + 1	