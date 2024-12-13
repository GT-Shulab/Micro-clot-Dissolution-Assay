# Micro-clot-Dissolution-Assay
There are 3 matlab files:

(1) Fibrin_Analysis.m - This code takes a folder of fibrin degradation videos and calculates the pixel intensity of each frame and saves it as a matrix
(2) logistic_curve_fitting.m - This code uses the matrix generated from Fibrin_Analysis.m to curve fit a 4 parameter logistic equation.  The parameters (i.e. a, b, c, d) are useful metrics for comparing fibrinolysis rates
(3) FourPL2.m - This is the 4-parameter logistic curve function.

Steps to using MATLAB code:

- Export all videos from the Incucyte as a video file (.mp4)
- Place Fibrin_Analysis.m in the same folder as the videos and run
- This should generate an output file
- Run "logistic_curve_fitting.m" - you will need to update the code to use the output file that you just generated
- Make sure FourPL2.m is in the same folder
- Save the coefficient parameters to your preferred stats program (e.g. GraphPad)
