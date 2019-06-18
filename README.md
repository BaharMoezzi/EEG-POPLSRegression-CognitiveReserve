# Introduction
Parallel and orthogonalized partial least squares (PO-PLS) multiblock regression was used in order to investigate associations between a comprehensive cognitive reserve proxy and functional connectivity of the prefrontal cortex across the whole scalp, covarying for the level of current cognitive functioning.

This repository provides the code for our investigation of the associations between EEG functional brain connectivity and a cognitive reserve proxy in healthy older adults ([bioRxiv manuscript](http://https://www.biorxiv.org/content/10.1101/625608v1.abstract)).

# Code
For PO-PLS analysis we used the Nofima multiblock regression by PO-PLS MATLAB toolbox (Naes et al. 2013). A threshold of 0.3 was used for regression coefficients to include in the PO-PLS model. We computed percentage explained variance in LEQ uniquely by the functional connectivity. In each PO-PLS model, we identified clusters of electrodes with at least three adjacent electrodes in space with regression coefficients above threshold. 

# Dependencies
Programming Language: MATLAB 9.3
 
To be able to run this code, the following MATLAB toolboxes need to be added to the path:
* POSOPLS (Naes et al. 2013)
* EEGLAB (Delorme et a. 2004)

# How to run?
Enetr the your data information, run, answer with number 1 to all prompted questions (to utilize the first component for all PO-PLS models). the outcome will be the topographic plots of regression coefficients from the parallel and orthogonalized partial least squares multiblock regression model covarying for ACE-R. The seed electrodes are shown with filled black circles, and electrodes identified as being in a cluster are marked with magenta stars.            

# References
Næs, T., Tomic, O., Afseth, N.K., Segtnan, V.H., Måge, I. 2013. Multi-block regression based on combinations of orthogonalisation, PLS-regression and canonical correlation analysis. Chemometrics and Intelligent Laboratory Systems, Vol 124, pp 32-42.

Delorme, Arnaud, and Scott  Makeig. 2004. 'EEGLAB: an open source toolbox for analysis of single-trial EEG dynamics including independent component analysis', Journal of neuroscience methods, 134: 9-21.
