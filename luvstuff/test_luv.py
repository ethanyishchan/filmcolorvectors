from skimage import data
from skimage.color import rgb2luv
from numpy import linalg as LA
import glob, os

os.chdir("../movie_categories/")
categories = ['action','animation','everything_else','horror','romance']
for c in categories:
	print c
	for file_name in glob.glob("../movie_categories/" + c + "/*.txt"):
		print(file_name.rsplit('/',1)[-1])
		f = open(file_name)
		prev = [0.,0.,0.]
		count = 0
		temp_sum = 0 
		array = f.read().split('\n')[:-1]
		for line in array:
			count += 1
			r,g,b = line.split()
			r,g,b = float(r), float(g), float(b)
			rgb_vec = [[[r,g,b]],[[r,g,b]]]
			luv_vec = rgb2luv(rgb_vec)
			luv_vec = luv_vec[0][0]
			diff = LA.norm(luv_vec-prev)
			temp_sum += diff
			prev = luv_vec
		print "fuck: ", count, temp_sum
		avg_change = temp_sum / count
		print "bye", avg_change
		avg_change = str(avg_change)

		concat_name = file_name.rsplit('/',1)[-1]
		print concat_name, avg_change
		output = open('../movie_dynamics/'+ c + "/" + concat_name  , 'w')
		print output
		output.write(avg_change)
		output.close()
