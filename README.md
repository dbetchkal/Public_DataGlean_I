# Public_DataGlean_I
## A tool to glean useful numeric results that are 'locked up' in a plot

From a static plot:
 - we define the Y, then X range bounds with the mouse, then...
 - we give the bounds numeric values with the keyboard, then...
 - we glean one or multiple (x,y) series with the mouse, 
 - writing each series to [a JSON file](https://github.com/dbetchkal/Public_DataGlean_I/blob/main/Public_DataGlean_I/data/dataThief_output_L90%20vs%20S_Series1.json).

## Quick Start

Download this repository. <br>
Save an image file to the `Processing` 'data' folder. <br>
Change the `path` variable, and press *Run*. <br>
Follow the directions in the console.

## Tutorial
Consider the image from [*Betchkal et al. 2022*, Figure 10](https://irma.nps.gov/DataStore/DownloadFile/671164), which shows species richness, $S$, versus the tenth-percentile sound level of an environment, $L_{90}$: <br><br>
<img src=https://github.com/dbetchkal/Public_DataGlean_I/blob/main/Public_DataGlean_I/data/L90%20vs%20S.png height=400></img>

The image is included with the repository. Say we're replicating this experiment and we'd like to recover the co-ordinates of points from this plot without access to the original data. The process requires mapping the *image co-ordinates* back into the *measurement co-ordinates*. `Public_DataGlean_I` allows us to perform this task. 

### Step One: enumerate the bounds on each figure axis

The first step involves clicking each **linear-scale, orthogonal** axis bound in sequence: {`Y_max`, `Y_min`, `X_min`, `X_max`}, for which `Public_DataGlean_I` will print the pixel coordinates to the console. The user may choose any reference point on the original image as long as the set bounds the data to be gleaned. The green linear guides indicate the user's `mouseX` and `mouseY` positions, shown in the image below before clicking `X_max` ($L_{90}$ = 30.0). After each bound is clicked, the user sequentially enters the corresponding numeric value from the figure for each reference point using the keyboard. Pressing the up-arrow ⬆️ allows a given numeric value of the axis bound to be re-entered. Pressing the down-arrow ⬇️ key advances to the next axis bound. <br><br>
<img src=https://github.com/dbetchkal/Public_DataGlean_I/blob/main/static/Public_DataGlean_I%20tutorial%20step%20one.png height=400></img>

### Step Two: glean the series of points

The second step simply involves clicking a series of points to write their estimated figure co-cordinates to a file. The user begins data entry for a series by pressing the 'S' key. As in step one, the green linear guides follow the user's `mouseX` and `mouseY` positions. The image below shows the console output immediately after clicking the red point labeled 'TKAN' co-ordinates of roughly (17.0, 17.3). To begin a new series, press 'S' again. To close the file/program, press 'C'. <br><br>
<img src=https://github.com/dbetchkal/Public_DataGlean_I/blob/main/static/Public_DataGlean_I%20tutorial%20step%20two.png height=400></img>

## Python parsing support
Basic `Python` parsing support *.geojson* $\rightarrow$ `pandas.DataFrame` is provided as `Public_DataGlean_I.read_Dataglean_json()`. Bi-directional transformations from logarithmic to linear axes may be performed using they keyword parameters of the function. For example:
>`data, bounds = read_Dataglean_json(dg_path, x_to_log=False, y_to_log=False, x_from_log=False, y_from_log=False)` <br>
>`plt.plot(data["x"], data["y"]) # convenient plotting` <br>
>`bounds # returns [0, 20, 20, 110] corresponding to xmin,ymin,xmax,ymax`

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States,
> and copyright and related rights in the work worldwide are waived through the
> [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
