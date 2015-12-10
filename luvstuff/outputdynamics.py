#this script reads from movie_categories and outputs dynamics into movie_dynamics respectively.
#

from skimage import data
from skimage.color import rgb2luv
from numpy import linalg as LA
import numpy as np
import glob, os
import matplotlib.pyplot as plt
import scipy.stats as stats
import pylab as pl
import six
# from matplotlib import colors
# import seaborn as sns

os.chdir("../movie_categories/")
categories = ['action','animation','horror','romance']
colors_array = ['blue','yellow','green','red']
# colors_array = list(six.iteritems(colors.cnames))
color_index = 0
for c in categories:
	print c
	category_sum = 0
	category_count = 0
	
	x_values = []
	for file_name in glob.glob("../movie_categories/" + c + "/*.txt"):
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

		avg_change = temp_sum / count
		x_values.append(avg_change)
		category_count += 1
		category_sum += avg_change

		#### writing output to file here
		avg_change = str(avg_change)
		concat_name = file_name.rsplit('/',1)[-1]
		output = open('../movie_dynamics/'+ c + "/" + concat_name  , 'w')
		output.write(avg_change)
		output.close()

	x_values = sorted(x_values)
	# fit = stats.norm.pdf(x_values, np.mean(x_values), np.std(x_values))
	# print colors_array[color_index]
	# print color_index, "befr"
	
	# print color_index, "aft"
	# print c, category_sum/ category_count
	# plt.plot(x_values,fit,'-o',c=colors_array[color_index],label = c)
	color_index += 1
	# plt.scatter(x_values, np.zeros_like(x_values) + 0 , alpha=0.5)
	# plt.hist(x_values,normed=True) 
# plt.xlabel('Averaged Rate of Change of Color')
# plt.ylabel('P(X) ')
# plt.title('Normal Distributions of Average Rate of Change of Color')
# plt.legend()
# plt.show()