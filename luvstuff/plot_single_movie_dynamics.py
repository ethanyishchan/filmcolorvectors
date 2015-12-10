from skimage import data
from skimage.color import rgb2luv
from numpy import linalg as LA
import numpy as np
import glob, os
import matplotlib.pyplot as plt
import scipy.stats as stats
import pylab as pl
import six
from matplotlib import colors
import seaborn as sns
import scipy.io
import seaborn as sns
import pandas as pd
from scipy import stats, integrate
import matplotlib.pyplot as plt
sns.set(color_codes=True)


os.chdir("../movie_categories/")
# categories = ['action','animation','everything_else','horror','romance']
categories = ['animation']
colors_array = ['blue','yellow','black','green','red']
# colors_array = list(six.iteritems(colors.cnames))
color_index = 0
dynamic_vec = []
color_vec = []
for c in categories:
	
	category_sum = 0
	category_count = 0
	
	x_values = []
	for file_name in glob.glob("../movie_categories/" + c + "/*.txt"):
		concat_name = file_name.rsplit('/',1)[-1]
		if concat_name != 'FindingNemo.txt':
			continue
		f = open(file_name)

		prev = [0.,0.,0.]
		count = 0
		temp_sum = 0 
		array = f.read().split('\n')[:-1]
		# color_vec = array

		for line in array:
			count += 1
			r,g,b = line.split()
			r,g,b = float(r), float(g), float(b)
			color_vec.append([r,g,b])
			rgb_vec = [[[r,g,b]],[[r,g,b]]]
			luv_vec = rgb2luv(rgb_vec)
			luv_vec = luv_vec[0][0]
			diff = LA.norm(luv_vec-prev)
			dynamic_vec.append(diff)
			temp_sum += diff
			prev = luv_vec

		avg_change = temp_sum / count
		x_values.append(avg_change)
		category_count += 1
		category_sum += avg_change

		#### writing output to file here
		# avg_change = str(avg_change)
		# concat_name = file_name.rsplit('/',1)[-1]
		# output = open('../movie_dynamics/'+ c + "/" + concat_name  , 'w')
		# output.write(avg_change)
		# output.close()

	# x_values = sorted(x_values)
	# fit = stats.norm.pdf(x_values, np.mean(x_values), np.std(x_values))
	# print colors_array[color_index]
	# print color_index, "befr"
	
	# print color_index, "aft"
	# print c, category_sum/ category_count
	# plt.plot(x_values,fit,'-o',c=colors_array[color_index],label = c)
	# color_index += 1
	# plt.scatter(x_values, np.zeros_like(x_values) + 0 , alpha=0.5)
	# plt.hist(x_values,normed=True) 
nemo = dynamic_vec
nemo_x = [i for i in range(len(nemo))]

for i in range(len(color_vec)):
	for j in range(len(color_vec[i])):
		color_vec[i][j] = color_vec[i][j] * 2.5
		if color_vec[i][j] > 255:
			color_vec[i][j] = 254

rgb_array = ['#%02x%02x%02x' % tuple(c) for c in color_vec]

sns.barplot(y = nemo ,x =nemo_x , palette = sns.color_palette(rgb_array))
sns.barplot(y = nemo ,x =nemo_x , palette = sns.color_palette(rgb_array))

# print dynamic_vec
# plt.legend()
plt.xlabel('Frame t')
plt.ylabel('Color difference')
plt.title('Color Difference over Time')
plt.show()