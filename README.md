# Beveridgean Unemployment Gap: Code and Data

This repository contains the code and data accompanying the paper "Beveridgean Unemployment Gap", written by [Pascal Michaillat](https://pascalmichaillat.org) and [Emmanuel Saez](https://eml.berkeley.edu/~saez/), and published in the [Journal of Public Economics Plus](https://doi.org/10.1016/j.pubecp.2021.100009) in November 2021.

## Paper webpage

The paper and its online appendix are available at https://pascalmichaillat.org/9/.

## Data

The data used as input to produce the results in the article are stored in the Excel file `data.xlsx`, which is placed in the folder `code`. 

## Code

The code used to produce the results in the article is placed in the folder `code`. The code can be divided into two types of programs:

1. Matlab scripts producing the figures in the article and online appendix
2. Matlab helper scripts and functions called at different places by the figure-producing scripts

### Figure-producing scripts

To produce the figures in the article and online appendix, run the following Matlab scripts:

* `figure1A.m` - produce figure 1A
* `figure1B.m` - produce figure 1B
* `figure1CF.m` - produce figures 1C, 1D, 1E, 1F
* `figure5.m` - produce figures 5A, 5B, 5C, 5D, 5E, 5F
* `figure6.m` - produce figure 6
* `figure7A.m` - produce figure 7A
* `figure7B.m` - produce figure 7B
* `figure7C.m` - produce figure 7C
* `figure7D.m` - produce figure 7D
* `figure8A.m` - produce figure 8A
* `figure8B.m` - produce figure 8B
* `figure8C.m` - produce figure 8C
* `figure9A.m` - produce figure 9A
* `figure9B.m` - produce figure 9B
* `figure9C.m` - produce figure 9C
* `figure10.m` - produce figure 10
* `figureA1.m` - produce figure A1
* `figureA2.m` - produce figure A2
* `figureA3.m` - produce figure A3
* `figureA4.m` - produce figure A4
* `figureA5.m` - produce figure A5
* `figureA6.m` - produce figure A6
* `figureA7.m` - produce figure A7
* `figureA8.m` - produce panels A and B or figure A8 
* `figureA9.m` - produce figure A9

The scripts produce each figure in a Matlab window, save a copy of each figure in PDF format, and save a copy of the data plotted in each figure in an Excel file.

### Helper scripts and functions

At different places, the figure-producing scripts call the following Matlab scripts:

* `formatFigure.m` -  format figures
* `formatPlot.m` - provide formatting settings for plots

The figure-producing scripts also call the following Matlab functions:

* `computeBeveridgeanUnemployment.m` - compute Beveridgean unemployment rate in DMP model
* `computeBeveridgeInverse.m` - compute inverse-optimum Beveridge elasticity from sufficient-statistic formula 
* `computeEfficiencyEndogenous.m` - compute efficient allocation in DMP model using sufficient-statistic formula with endogeous Beveridge elasticity
* `computeEfficiencyHosios.m` - compute efficient allocation in DMP model using Hosios condition
* `computeEfficientTightness.m` - compute efficient labor-market tightness from sufficient-statistic formula
* `computeEfficientUnemployment.m` - compute efficient unemployment rate from sufficient-statistic formula 
* `computeMatchingEfficacy.m` - compute matching efficacy in DMP model
* `computeMatchingElasticity.m` - compute matching elasticity in DMP model
* `computeNonworkInverse.m` - compute inverse-optimum social value of nonwork from sufficient-statistic formula
* `computeRecruitingInverse.m` - compute inverse-optimum recruiting cost from sufficient-statistic formula
* `computeSeparationEfficacy.m` - compute separation-efficacy ratio in DMP model
* `computeUnemploymentGap.m` - compute unemployment gap from sufficient-statistic formula 
* `getBeveridgeElasticity.m` - return Beveridge elasticity in the United States, 1951–2019
* `getBreakDate.m` - return dates of structural breaks in US Beveridge curve between 1951 and 2019
* `getLaborProductivity.m` - return quarterly labor productivity in the United States, 1951–2019
* `getNairu.m` - return NAIRU in the United States, 1960Q1–2018Q3
* `getNaturalUnemployment.m` - return natural rate of unemployment in the United States, 1951–2019
* `getRecessionDate.m` - return dates of recessions in the United States between 1951 and 2019
* `getTimeline.m` - return quarterly timeline for 1951Q1–2019Q4
* `getTrendUnemployment.m` - return trend of unemployment rate in the United States, 1960Q1–2018Q3
* `getUnemploymentRate.m` - return quarterly unemployment rate in the United States, 1951–2019
* `getVacancyRate.m` - return quarterly vacancy rate in the United States, 1951–2019
* `measureJobFinding.m` - measure job-finding rate in the United States, 1951–2019
* `measureJobSeparation.m` - measure job-separation rate in the United States, 1951–2019
* `monthlyToQuarterly.m` - aggregate monthly data to quarterly frequency

A last helper script is `baiPerron.m`. This Matlab script estimates the US Beveridge curve with the Bai-Perron algorithm. It calls on Matlab functions stored in the folder `baiperron`. The folder was created by Yohei Yamamoto, based on Gauss code by Pierre Perron. It was downloaded from http://blogs.bu.edu/perron/files/2020/05/m-break-matlab.zip.

## Figures

The figures produced by the code are stored in the folder `figures`, both as PDF files and as Excel files.

### PDF files

The figures produced by the code are saved as PDF files and stored in the subfolder `pdf`. The PDF files correspond to the following figures in the article and online appendix:

* `figure1A.pdf` - figure 1A
* `figure1B.pdf` - figure 1B
* `figure1C.pdf` - figure 1C
* `figure1D.pdf` - figure 1D
* `figure1E.pdf` - figure 1E
* `figure1F.pdf` - figure 1F
* `figure5A.pdf` - figure 5A
* `figure5B.pdf` - figure 5B
* `figure5C.pdf` - figure 5C
* `figure5D.pdf` - figure 5D
* `figure5E.pdf` - figure 5E
* `figure5F.pdf` - figure 5F
* `figure6.pdf` - figure 6
* `figure7A.pdf` - figure 7A
* `figure7B.pdf` - figure 7B
* `figure7C.pdf` - figure 7C
* `figure7D.pdf` - figure 7D
* `figure8A.pdf` - figure 8A
* `figure8B.pdf` - figure 8B
* `figure8C.pdf` - figure 8C
* `figure9A.pdf` - figure 9A
* `figure9B.pdf` - figure 9B
* `figure9C.pdf` - figure 9C
* `figure10.pdf` - figure 10
* `figureA1.pdf` - figure A1
* `figureA2.pdf` - figure A2
* `figureA3.pdf` - figure A3
* `figureA4.pdf` - figure A4
* `figureA5.pdf` - figure A5
* `figureA6.pdf` - figure A6
* `figureA7.pdf` - figure A7
* `figureA8A.pdf` - panel A of figure A8
* `figureA8B.pdf` - panel B of figure A8
* `figureA9.pdf` - figure A9

### Excel files

The data underlying all the figures produced by the code are saved as Excel files and  stored in the subfolder `xlsx`. The Excel files contain data pertaining to the following figures in the article and online appendix:

* `figure1A.xlsx` - figure 1A
* `figure1B.xlsx` - figure 1B
* `figure1CF.xlsx` - figures 1C, 1D, 1E, 1F
* `figure5.xlsx` - figures 5A, 5B, 5C, 5D, 5E, 5F
* `figure6.xlsx` - figure 6
* `figure7A.xlsx` - figure 7A
* `figure7B.xlsx` - figure 7B
* `figure7C.xlsx` - figure 7C
* `figure7D.xlsx` - figure 7D
* `figure8A.xlsx` - figure 8A
* `figure8B.xlsx` - figure 8B
* `figure8C.xlsx` - figure 8C
* `figure9A.xlsx` - figure 9A
* `figure9B.xlsx` - figure 9B
* `figure9C.xlsx` - figure 9C
* `figure10.xlsx` - figure 10
* `figureA1.xlsx` - figure A1
* `figureA2.xlsx` - figure A2
* `figureA3.xlsx` - figure A3
* `figureA4.xlsx` - figure A4
* `figureA5.xlsx` - figure A5
* `figureA6.xlsx` - figure A6
* `figureA7.xlsx` - figure A7
* `figureA8.xlsx` - panels A and B of figure A8
* `figureA9.xlsx` - figure A9

The subfolder `xlsx` also contains the output of the Bai-Perron algorithm produced by the script `baiperron.m`. The output is saved as a text file: `baiperron.txt`.

## Software

The results were obtained on a Mac running macOS BigSur 11.6 with Matlab R2021a and Microsoft Excel 16.54.

## License

The content of this repository is licensed under the terms of the MIT License.

## Related code

The [Macroeconomic Model Database](https://www.macromodelbase.com) has developed [MATLAB and Dynare code](https://github.com/IMFS-MMB/mmb-rep/tree/master/NK_MI14) to reproduce Figure 2 and Figure 3.
