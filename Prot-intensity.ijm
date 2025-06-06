showMessage("Click on *OK* to choose input folder");
dir1 = getDirectory("Choose input folder"); // Choose the folder with base images
print(dir1);

// Choisir le dossier où enregistrer le fichier CSV
showMessage("Click on *OK* to choose output folder for CSV");
outputDir = getDirectory("Choose output folder for CSV");  // Choose the folder for the CSV

print(outputDir);
// Define the file path for the CSV in the chosen folder
filePath = outputDir + "resultats.csv";  // CSV file name

// Open or create the CSV file
// Vérifier si le fichier CSV existe déjà
csvContent = "";
if (File.exists(filePath)) {
    // Lire le contenu existant pour l'ajouter ensuite
    csvContent = File.openAsString(filePath);
} else {
    // Si le fichier n'existe pas, ajouter l'en-tête des colonnes
    csvContent = "Imagename";
}


list1 = getFileList(dir1);

// Process the images
for (i=0; i<list1.length; i++) {
    if (endsWith(list1[i], ".tif")) {
        open(dir1 + list1[i]);
imageName = getTitle();

if (imageName.contains("SVCC")){
close();
continue;
}

 getDimensions(width, height, channels, slices, frames);
        // Resize the image
        run("Canvas Size...", "width=" + width*6 +" height=" + width*6 +" position=Center zero");
        // Scale the image
        run("Scale...", "x=6 y=6 z=1.0 interpolation=Bilinear average" );
        run("Set Scale...", "known=" + 1/6 +" pixel=1");
        
        run("Clear Results");

        savetitle = replace(imageName, ".tif", "");
        
        if (list1[i]==list1[0]) {
        	nSlices
for (j = 1; j <= nSlices; j++) {
if (File.exists(filePath)) {
    // Lire le contenu existant pour l'ajouter ensuite
    csvContent = File.openAsString(filePath);
} else {
    // Si le fichier n'existe pas, ajouter l'en-tête des colonnes
csvContent += ", IntegratedIntensity-C" + j + ", RawIntensity-C" + j;
}
}
csvContent += "\n";
}

nSlices

        setTool("line");
        run("Line Width...", "line=1");

        // Wait for user to draw a line (the user will manually draw along the axon)
        waitForUser("Draw a line along the centriole (from proximal to distal).\nDon't draw any line if you want to pass to the next image");
        type = selectionType();

        if (type == -1) {
            print("No line drawn");
            close;
            continue;  // Skip this image if no line is drawn
        }

        // Get line coordinates and calculate rotation angle
        getLine(x1, y1, x2, y2, lineWidth);
        angle = -90 - 180 * atan2((y2 - y1), (x2 - x1)) / PI; // Rotation angle needed
        setResult("rot.angle", nResults, angle);

        // Rotate image to align with the axon
        run("Rotate...", "angle=" + angle + " grid=1 interpolation=Bilinear enlarge stack");
      
      if (nSlices >= 2) {
      run("Next Slice [>]");
      run("Previous Slice [<]");
}

        makeRectangle(0, 0, 90, 120);
        run("ROI Manager...");
        waitForUser("Place a rectangle on your zone of interest and add it to ROI manager");

        type = selectionType();

        run("Set Measurements...", "integrated redirect=None decimal=3");


//Get total ROIs number
    nROIs = roiManager("count");
    // Browse each ROI
    
    if (nROIs == 0){
close();
selectWindow("ROI Manager");
run("Close");
continue
}
    
    for (roi=0; roi<nROIs; roi++) {
roiManager("select", roi);
csvContent += savetitle + "_ROI" + roi+1;
selectImage(imageName); 

for (j = 1; j <= nSlices; j++) {
setSlice(j);

        // Measure intensities in the selected region
        run("Measure");

        // Measure for channel 1 (C1)
        IntegratedIntensity = getResult("IntDen", 0); // Integrated intensity for channel 1
        RawIntensity = getResult("RawIntDen", 0);   // Mean intensity for channel 1

        // Organize results and add them to the CSV content
csvContent += "," + IntegratedIntensity + "," + RawIntensity;

run("Clear Results");
   }
csvContent += "\n";
   }
//Close image
close();
selectWindow("ROI Manager");
run("Close");
}
}

// Save the results in the CSV file (append to the end of the file)
File.saveString(csvContent, filePath);

run("Clear Results");
run("Close All");
