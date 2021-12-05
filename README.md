# Beveridgean Unemployment Gap: Code and Data

This repository contains the code and data accompanying the paper "Beveridgean Unemployment Gap", written by [Pascal Michaillat](https://pascalmichaillat.org) and [Emmanuel Saez](https://eml.berkeley.edu/~saez/), and published in the [Journal of Public Economics Plus](https://doi.org/10.1016/j.pubecp.2021.100009) in December 2021.

## Paper webpage

The paper and its online appendix are available at https://pascalmichaillat.org/9/.

## Data

The data used to produce the results in the paper are located in the `data` folder. The data used as input by the code are stored in an Excel file: `data.xlsx`. The data from the 1997 National Employer Survey (NES) are located in the `nes` subfolder:

+ `nes.csv` - Public-use CSV file for the 1997 NES; the recruiting cost in the United States is computed from the answer to question 29
+ `questionaire.pdf` - Questionaire for the 1997 NES
+ `description.pdf` - Description of the NES data by Peter Cappelli (NES principal investigator)

## Code

The results in the paper are obtained using MATLAB. The MATLAB code used to produce the results is located in the `code` folder. There are two types of programs:

1. MATLAB scripts producing the figures in the paper and online appendix
2. MATLAB helper scripts and functions called at different places by the figure-producing scripts

### Figure-producing scripts

The figures in the paper and online appendix are produced by the following scripts:

+ `figure1A.m` - Produce figure 1A
+ `figure1B.m` - Produce figure 1B
+ `figure1CF.m` - Produce figures 1C, 1D, 1E, 1F
+ `figure5.m` - Produce figures 5A, 5B, 5C, 5D, 5E, 5F
+ `figure6.m` - Produce figure 6
+ `figure7A.m` - Produce figure 7A
+ `figure7B.m` - Produce figure 7B
+ `figure7C.m` - Produce figure 7C
+ `figure7D.m` - Produce figure 7D
+ `figure8A.m` - Produce figure 8A
+ `figure8B.m` - Produce figure 8B
+ `figure8C.m` - Produce figure 8C
+ `figure9A.m` - Produce figure 9A
+ `figure9B.m` - Produce figure 9B
+ `figure9C.m` - Produce figure 9C
+ `figure10.m` - Produce figure 10
+ `figureA1.m` - Produce figure A1
+ `figureA2.m` - Produce figure A2
+ `figureA3.m` - Produce figure A3
+ `figureA4.m` - Produce figure A4
+ `figureA5.m` - Produce figure A5
+ `figureA6.m` - Produce figure A6
+ `figureA7.m` - Produce figure A7
+ `figureA8.m` - Produce panels A and B or figure A8 
+ `figureA9.m` - Produce figure A9

The scripts produce each figure in a MATLAB window, save a copy of each figure in PDF, and save a copy of the data plotted in each figure in an Excel file.

### Helper scripts and functions

The figure-producing scripts call the following helper scripts:

+ `formatFigure.m` - Format figures
+ `formatPlot.m` - Provide formatting settings for plots

The figure-producing scripts also call the following functions:

+ `computeBeveridgeanUnemployment.m` - Compute Beveridgean unemployment rate in DMP model
+ `computeBeveridgeInverse.m` - Compute inverse-optimum Beveridge elasticity from sufficient-statistic formula 
+ `computeEfficiencyEndogenous.m` - Compute efficient allocation in DMP model using sufficient-statistic formula with endogeous Beveridge elasticity
+ `computeEfficiencyHosios.m` - Compute efficient allocation in DMP model using Hosios condition
+ `computeEfficientTightness.m` - Compute efficient labor-market tightness from sufficient-statistic formula
+ `computeEfficientUnemployment.m` - Compute efficient unemployment rate from sufficient-statistic formula 
+ `computeMatchingEfficacy.m` - Compute matching efficacy in DMP model
+ `computeMatchingElasticity.m` - Compute matching elasticity in DMP model
+ `computeNonworkInverse.m` - Compute inverse-optimum social value of nonwork from sufficient-statistic formula
+ `computeRecruitingInverse.m` - Compute inverse-optimum recruiting cost from sufficient-statistic formula
+ `computeSeparationEfficacy.m` - Compute separation-efficacy ratio in DMP model
+ `computeUnemploymentGap.m` - Compute unemployment gap from sufficient-statistic formula 
+ `getBeveridgeElasticity.m` - Return Beveridge elasticity in the United States, 1951–2019
+ `getBreakDate.m` - Return dates of structural breaks in US Beveridge curve between 1951 and 2019
+ `getLaborProductivity.m` - Return quarterly labor productivity in the United States, 1951–2019
+ `getNairu.m` - Return NAIRU in the United States, 1960Q1–2018Q3
+ `getNaturalUnemployment.m` - Return natural rate of unemployment in the United States, 1951–2019
+ `getRecessionDate.m` - Return dates of recessions in the United States between 1951 and 2019
+ `getTimeline.m` - Return quarterly timeline for 1951Q1–2019Q4
+ `getTrendUnemployment.m` - Return trend of unemployment rate in the United States, 1960Q1–2018Q3
+ `getUnemploymentRate.m` - Return quarterly unemployment rate in the United States, 1951–2019
+ `getVacancyRate.m` - Return quarterly vacancy rate in the United States, 1951–2019
+ `measureJobFinding.m` - Measure job-finding rate in the United States, 1951–2019
+ `measureJobSeparation.m` - Measure job-separation rate in the United States, 1951–2019
+ `monthlyToQuarterly.m` - Aggregate monthly data to quarterly frequency

A last helper script is `baiPerron.m`. This MATLAB script estimates the US Beveridge curve with the Bai-Perron algorithm. It calls on MATLAB functions stored in the folder `baiperron`. The folder was created by Yohei Yamamoto, based on Gauss code by Pierre Perron. It was downloaded from http://blogs.bu.edu/perron/files/2020/05/m-break-matlab.zip.

## Figures

The figures produced by the code are stored in the `figures` folder, both as PDF files and as Excel files.

### PDF files

The figures produced by the code are saved as PDF files and stored in the `pdf` subfolder. The PDF files correspond to the following figures in the paper and online appendix:

+ `figure1A.pdf` - Figure 1A
+ `figure1B.pdf` - Figure 1B
+ `figure1C.pdf` - Figure 1C
+ `figure1D.pdf` - Figure 1D
+ `figure1E.pdf` - Figure 1E
+ `figure1F.pdf` - Figure 1F
+ `figure5A.pdf` - Figure 5A
+ `figure5B.pdf` - Figure 5B
+ `figure5C.pdf` - Figure 5C
+ `figure5D.pdf` - Figure 5D
+ `figure5E.pdf` - Figure 5E
+ `figure5F.pdf` - Figure 5F
+ `figure6.pdf` - Figure 6
+ `figure7A.pdf` - Figure 7A
+ `figure7B.pdf` - Figure 7B
+ `figure7C.pdf` - Figure 7C
+ `figure7D.pdf` - Figure 7D
+ `figure8A.pdf` - Figure 8A
+ `figure8B.pdf` - Figure 8B
+ `figure8C.pdf` - Figure 8C
+ `figure9A.pdf` - Figure 9A
+ `figure9B.pdf` - Figure 9B
+ `figure9C.pdf` - Figure 9C
+ `figure10.pdf` - Figure 10
+ `figureA1.pdf` - Figure A1
+ `figureA2.pdf` - Figure A2
+ `figureA3.pdf` - Figure A3
+ `figureA4.pdf` - Figure A4
+ `figureA5.pdf` - Figure A5
+ `figureA6.pdf` - Figure A6
+ `figureA7.pdf` - Figure A7
+ `figureA8A.pdf` - Panel A of figure A8
+ `figureA8B.pdf` - Panel B of figure A8
+ `figureA9.pdf` - Figure A9

### Excel files

The data underlying all the figures produced by the code are saved as Excel files and  stored in the `xlsx` subfolder. The Excel files contain data pertaining to the following figures in the paper and online appendix:

+ `figure1A.xlsx` - Figure 1A
+ `figure1B.xlsx` - Figure 1B
+ `figure1CF.xlsx` - Figures 1C, 1D, 1E, 1F
+ `figure5.xlsx` - Figures 5A, 5B, 5C, 5D, 5E, 5F
+ `figure6.xlsx` - Figure 6
+ `figure7A.xlsx` - Figure 7A
+ `figure7B.xlsx` - Figure 7B
+ `figure7C.xlsx` - Figure 7C
+ `figure7D.xlsx` - Figure 7D
+ `figure8A.xlsx` - Figure 8A
+ `figure8B.xlsx` - Figure 8B
+ `figure8C.xlsx` - Figure 8C
+ `figure9A.xlsx` - Figure 9A
+ `figure9B.xlsx` - Figure 9B
+ `figure9C.xlsx` - Figure 9C
+ `figure10.xlsx` - Figure 10
+ `figureA1.xlsx` - Figure A1
+ `figureA2.xlsx` - Figure A2
+ `figureA3.xlsx` - Figure A3
+ `figureA4.xlsx` - Figure A4
+ `figureA5.xlsx` - Figure A5
+ `figureA6.xlsx` - Figure A6
+ `figureA7.xlsx` - Figure A7
+ `figureA8.xlsx` - Panels A and B of figure A8
+ `figureA9.xlsx` - Figure A9

The `xlsx` subfolder also contains the output of the Bai-Perron algorithm produced by the `baiperron.m` script. The output is saved as a text file: `baiperron.txt`.

## Software

The results were obtained using MATLAB R2021a on macOS BigSur.

## License

This repository is licensed under the [MIT License](LICENSE.md).

## Related code

+ [Python version of this code](https://github.com/smxzehvb/unemployment-gap/tree/main/python) - Written by Sarah Charlton. The paper's results are presented in Jupyter Notebooks.