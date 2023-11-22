         seed =  -1
      seqfile =  tmp.phy
     treefile =  tmp.tree
      outfile =  mcmctree.out
        ndata =  1
      usedata =  2    * 0: no data; 1:seq like; 2:use in.BV; 3: out.BV
        clock =  2    * 1: global clock; 2: independent rates; 3: correlated rates
      RootAge =  <1.6  * safe constraint on root age, used if no fossil for root.
        model =  0    * 0:JC69, 1:K80, 2:F81, 3:F84, 4:HKY85
        alpha =  0.760336    * alpha for gamma rates at sites
        ncatG =  4    * No. categories in discrete gamma
    cleandata =  0    * remove sites with ambiguity data (1:yes, 0:no)?
      BDparas =  1 1 0    * birth, death, sampling
  kappa_gamma =  6 2      * gamma prior for kappa
  alpha_gamma =  1 1      * gamma prior for alpha
  rgene_gamma =  2 2   * gamma prior for overall rates for genes
 sigma2_gamma =  1 10    * gamma prior for sigma^2     (for clock=2 or 3)
     finetune =  1: .1 .1 .1 .1 .1 .1  * times, rates, mixing, paras, RateParas
        print =  1
       burnin =  100000
     sampfreq =  2
      nsample =  1000000

