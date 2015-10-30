# filmcolorvectors

We want to explore how movies genres are related to colors in a film. The inspiration for this idea came from a youtube video that mentioned: “You can glance at a movie and instantly tell what genre it is, warm red tones for romances, desaturated colors for post-apocalyptic films”. What we want to try to do is to get a weighted average color of all the movie pixels in a movie and see that if we can train a classifier on movies to predict the genre of a movie.   We will aim to extract evenly spaced frames from the movies, and then run a weighted average on the pixels in those frames and then represent each movie as a vector of these averaged colors. This would look similar to the color bars seen here: thecolorsofmotion.com/films. We will run some supervised learning methods such as softmax regression, support vector machines and gaussian discriminant analysis to see if we can relate the color vector to certain genres. We will train our classifier on color data (feature vector) of movies and get their genre tags (class labels) from IMDB.com. We can also explore the correlation of color to other attributes of the movie such as style of directors and subtitle sentiment.   Since current methods of clustering movies are based on data tags such as genre, director and year of production, we also want to investigate using unsupervised learning methods to cluster movies based on the vectors of color data. For example, we hope to discover and explore how color is a common motif among movies with similar attributes such as the mood of the film, or animated films, or classics, country of the film. We will use techniques such as principal component analysis and the k-means algorithm to discover clusters.

https://trac.ffmpeg.org/wiki/Create%20a%20thumbnail%20image%20every%20X%20seconds%20of%20the%20video

http://www.wisegeek.com/how-can-i-find-the-average-color-in-a-photograph.htm

http://stackoverflow.com/questions/10957412/fastest-way-to-extract-frames-using-ffmpeg



