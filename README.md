# Public_DataGlean_I
## A tool to glean useful numeric results that are 'locked up' in a plot

From a static plot:
 - we define the Y, then X range bounds with the mouse, then...
 - we give the bounds numeric values with the keyboard, then...
 - we glean one or multiple (x,y) series with the mouse, 
 - writing each series to [a JSON file](https://github.com/dbetchkal/Public_DataGlean_I/blob/main/Public_DataGlean_I/data/dataThief_output_L90%20vs%20S_Series1.json).

To use, download this repository. Save an image file (if necessary, scaling so that dimensions are less than 1000x1000 px.)
Change the `path` variable, and press *Run*. Follow the directions in the console.

## Tutorial
Consider the example image from [*Betchkal et al. 2022*, Figure 10](https://irma.nps.gov/DataStore/DownloadFile/671164), which shows species richness, $S$, versus the tenth-percentile sound level of an environment, $L_{90}$: <br><br>
<img src=https://github.com/dbetchkal/Public_DataGlean_I/blob/main/Public_DataGlean_I/data/L90%20vs%20S.png width=700></img>

Say we're replicating this experiment and we'd like to recover the co-ordinates of the reddish points from this plot without the original data. The process requires mapping the *image co-ordinates* back into the *measurement co-ordinates*. `Public_DataGlean_I` allows us to perform this task. 

### Step One: enumerate the bounds on each figure axis

### Step Two: indicate the series of points desired

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States,
> and copyright and related rights in the work worldwide are waived through the
> [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
