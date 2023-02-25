/*   Public_DataGlean_I

      Davyd_Betchkal@nps.gov

     A public reboot around the concept of "DataThief",
     B. Tummers, DataThief III. 2006 <https://datathief.org/>
       for freeing useful numeric results 
       that are 'locked up' in a plot
     
     From a static plot:
       - we define the Y, then X range bounds with the mouse, then...
       - we give the bounds numeric values with the keyboard, then...
       - we glean multiple (x,y) series with the mouse, 
       - writing each series to a JSON file.
     
     
     To begin,
     Indicate `path` to file below. ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

*/

JSONObject json;
JSONArray x_values;
JSONArray y_values;

PImage fig;
String path = "LD831-LOWN_with378A04_dynamicRange.png";
int path_len = path.length();
int counter = 0;
int enter_count = 0;
int series_count = 0;
String series_name; 
String col_X_name;
String col_Y_name;

// the first point, in IMAGE CO-ORDINATES
float Y_max_final;
int X_min_err_A; // we'll use the second coordinate to average later

// the second point
int Y_min;
int X_min_err_B;

// the third point
int X_min;
int Y_min_err_A;

// the fourth point
float X_max_final;
int Y_min_err_B;

// Note that this above schematic results in a surprising fact
// greater knowledge of the origin than of the unrelated 'wings'

float X_min_final;
float Y_min_final;

// now the indicated values

float Y_max_I; // numeric inputs for bound values
float Y_min_I;
float X_min_I;
float X_max_I;
float[] xs = new float[1];
float x_trans; // translated output co-ordinates
float[] ys = new float[1];
float y_trans;

boolean save;
boolean stage_two = false;
String value;

void setup(){
  
  background(0);
  size(1000, 1000);
  
  fig = loadImage(path);
  imageMode(CENTER);
  image(fig, 500, 500); 
  
  println("First step: click the UPPER Y range bound.");

}

void draw(){
  if(stage_two == true){
    for (int i = 0; i < xs.length; i = i+1) {
      stroke(67, 224, 20);
      strokeWeight(3);
      point(xs[i], ys[i]);
    }
  }
}

/*
Important note!

  For digitally-produced plots (or very precise hand-drawn)
  this tool will produce correct results. We assume this.
  ------> PROCEED
  
  For hand-drawn or or poorly-scanned images,
  these results cannot account for affine transformations in the plane.
  ------> DO NOT PROCEED!
*/

void mousePressed(){
  
  if(counter == 0){
    println("\n\tUpper Y range at image position:");
    println("\t", mouseX, mouseY, "px");
    Y_max_final = mouseY;
    X_min_err_A = mouseX;
    println("\n\nSecond step: click the LOWER Y range bound.");
  }
  else if(counter == 1){
    println("\n\tLower Y range at:");
    println("\t", mouseX, mouseY, "px"); 
    Y_min = mouseY;
    X_min_err_B = mouseX;
    println("\n\nThird step: click the LOWER X range bound.");
  } 
  else if(counter == 2){
    println("\n\tLower X range at:");
    println("\t", mouseX, mouseY, "px");    
    X_min = mouseX;
    Y_min_err_A = mouseY;
    println("\n\nFourth step: click the UPPER X range bound.");
  }
  else if(counter == 3){
    println("\n\tUpper X range at:");
    println("\t", mouseX, mouseY, "px");  
    X_max_final = mouseX;
    Y_min_err_B = mouseY;
    
    // we're done!
    stage_two = true;
    
    X_min_final = (X_min_err_A + X_min + X_min_err_B)/3;
    Y_min_final = (Y_min_err_A + Y_min + Y_min_err_B)/3;
    
    println("\nto summarize:");
    println("\tX_min", X_min_final, "Y_min", Y_min_final);
    println("\tX_max", X_max_final, "Y_max", Y_max_final);
    
    println("\n\nNow we'll enter indicated bound values. Press DOWN to begin.");
  }
  else if (counter >3) {
    
    // we'll draw to screen to keep people aware
    // of what they've drawn so far...
    xs = append(xs, float(mouseX));
    ys = append(ys, float(mouseY));
    
    x_trans = map(mouseX, X_min_final, X_max_final, X_min_I, X_max_I);
    y_trans = map(mouseY, Y_min_final, Y_max_final, Y_min_I, Y_max_I);
    
    // quality control
    if (x_trans < 0.0){
      x_trans = 0.0;
    }
    
    println("\t", x_trans, y_trans);
    x_values = x_values.append(x_trans); // add current mouse value to the array
    y_values = y_values.append(y_trans);
  }
    
  counter = counter + 1;

}

void keyPressed(){
  
  // Close!
  if (key == 'c'){
    exit();
  }
  
  // only proceed to the second step if bounds have been chosen
  if (stage_two == true){
    
      // 'Enter' 
    if (key == ENTER) {
      println("\tYou entered:");
      
      // save values
      switch(str(enter_count)){
        case "0":
          Y_max_I = float(value.substring(1));
          println("\t", Y_max_I, "        press DOWN to continue."); 
          break;
        case "1":
          Y_min_I = float(value.substring(1));
          println("\t", Y_min_I, "        press DOWN to continue."); 
          break;
        case "2":
          X_min_I = float(value.substring(1));
          println("\t", X_min_I, "        press DOWN to continue."); 
          break;
        case "3":
          X_max_I = float(value.substring(1));
          println("\t", X_max_I, "\n");
          println("\n\nPress 'S' to start your first Series.");
      }
      
      enter_count = enter_count + 1;
      save = false;
    }

    // 'Turn on' 
    if (keyCode == DOWN) {
      
      value = ""; // reset
      save = true; // turn on saving
      
      // prompt user for value
      switch(str(enter_count)){
        case "0":
          println("\n\tPlease enter Y_MAX value as indicated, then ENTER.");
          break;
        case "1":
          println("\n\tPlease enter Y_MIN value as indicated, then ENTER.");
          break;
        case "2":
          println("\n\tPlease enter X_MIN value as indicated, then ENTER.");
          break;
        case "3":
          println("\n\tPlease enter X_MAX value as indicated, then ENTER.");          
      }
    }
    
    if (save == true){
      value = value + key;
    }
  }
  
  // Series break indicator
  if (key == 's'){
    // to be pressed before starting a series...
    

    if(series_count > 0){
      // save out the JSON file
      println("\n\nSaving JSON file for", series_name, "!");
      json.setJSONArray("x", x_values);
      json.setJSONArray("y", y_values);
      saveJSONObject(json, "data/dataGlean_output_" + path.substring(0, path_len - 4) + "_" + series_name + ".json");
    }
    
    // intitialize a new output file for each series 
    json = new JSONObject(); 
    x_values = new JSONArray();
    y_values = new JSONArray();
    
    series_count = series_count + 1; // ...thus, "Series1" is the first
    series_name = "Series" + str(series_count);
    println("\n\nNow digitizing", series_name);
    println("\t click each point to continue. 'S' to start a new series. 'C' to close file.");
  }
}
