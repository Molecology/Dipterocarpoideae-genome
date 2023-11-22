###The analysis parameters are in the configuration files, mcmctree_estimate.ctl and mcmctree.ctl. 
###The topology of the trees is analyzed by RAxML (Code 1).
###'tmp_2.tree' contains 2 calibration points from Ng et al.(15), 'tmp_3.tree' contains the 3 calibration points Bansal et al. (17), and 'tmp_5.tree' contains all 5 calibration points. 
mcmctree mcmctree_estimate.ctl
cp out.BV in.BV
mcmctree mcmctree.ctl
