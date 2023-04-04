#V3.30.18.00;_safe;_compile_date:_Sep 30 2021;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis

#C file created using the SS_writectl function in the R package r4ss
#C file write time: 2020-03-30 14:33:05
#_data_and_control_files: data.ss_new // control_modified.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
1 #_Nblock_Patterns
 9 #_blocks_per_pattern 
# begin and end years of blocks
 1979 1981 1982 1984 1985 1987 1988 1991 1992 1996 1997 2005 2006 2010 2011 2015 2016 2019
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 0 0 0 0 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1 #_Age(post-settlement)_for_L1;linear growth below this
999 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
0 #_First_Mature_Age
2 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.001 2 0.248 -2.92 0.22 3 -1 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -50 100 17.1 17.1 10 0 -3 0 0 0 0 0 1 2 # L_at_Amin_Fem_GP_1
 1 500 36.01 36.01 10 0 -2 0 0 0 0 0 1 2 # L_at_Amax_Fem_GP_1
 0.001 2 0.28 0.28 0.05 0 -3 0 0 0 0 0 1 2 # VonBert_K_Fem_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 3 0.001342 0.001342 99 0 -99 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 2 4 3.0111 3.0111 99 0 -99 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 0.0001 1000 22.51 22.51 99 0 -99 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -2 4 -0.28 -0.28 99 0 -99 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 0 3 0.001342 0.001342 0.8 0 -3 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 0 4 3.0111 3.0111 0.8 0 -3 0 0 0 0 0 0 0 # Eggs_exp_len_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 0.001 2 0.248 -2.92 0.22 3 -1 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 -50 100 18.29 18.29 10 0 -3 0 0 0 0 0 1 2 # L_at_Amin_Mal_GP_1
 1 500 35.19 35.19 10 0 -2 0 0 0 0 0 1 2 # L_at_Amax_Mal_GP_1
 0.001 2 0.26 0.26 0.05 0 -3 0 0 0 0 0 1 2 # VonBert_K_Mal_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 0.001 5 0.1 0.1 0.5 0 -4 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 0 3 0.001342 0.001342 99 0 -99 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 2 4 3.0111 3.0111 99 0 -99 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution  
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 0.01 0.99 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 0 100 14.41 14.41 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_1979
 0 100 14.86 14.86 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_1982
 0 100 16.55 16.55 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_1985
 0 100 16.63 16.63 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_1988
 0 100 17.04 17.04 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_1992
 0 100 13.84 13.84 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_1997
 0 100 15.53 15.53 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_2006
 0 100 18.54 18.54 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_2011
 0 100 17.25 17.25 10 0 -3 # L_at_Amin_Fem_GP_1_BLK1repl_2016
 1 1000 37.03 37.03 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_1979
 1 1000 37.45 37.45 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_1982
 1 1000 38.85 38.85 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_1985
 1 1000 39.72 39.72 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_1988
 1 1000 39.07 39.07 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_1992
 1 1000 39.55 39.55 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_1997
 1 1000 40.4 40.4 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_2006
 1 1000 42.1 42.1 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_2011
 1 1000 41.16 41.16 10 0 -2 # L_at_Amax_Fem_GP_1_BLK1repl_2016
 0.001 2 0.34 0.34 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_1979
 0.001 2 0.31 0.31 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_1982
 0.001 2 0.31 0.31 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_1985
 0.001 2 0.25 0.25 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_1988
 0.001 2 0.32 0.32 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_1992
 0.001 2 0.41 0.41 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_1997
 0.001 2 0.33 0.33 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_2006
 0.001 2 0.27 0.27 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_2011
 0.001 2 0.3 0.3 0.05 0 -3 # VonBert_K_Fem_GP_1_BLK1repl_2016
 0 100 14.76 14.76 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_1979
 0 100 14.73 14.73 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_1982
 0 100 16.71 16.71 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_1985
 0 100 17.25 17.25 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_1988
 0 100 16.31 16.31 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_1992
 0 100 14.58 14.58 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_1997
 0 100 17.69 17.69 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_2006
 0 100 18.45 18.45 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_2011
 0 100 17.17 17.17 10 0 -3 # L_at_Amin_Mal_GP_1_BLK1repl_2016
 1 1000 35.55 35.55 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_1979
 1 1000 36.07 36.07 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_1982
 1 1000 37.56 37.56 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_1985
 1 1000 38.7 38.7 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_1988
 1 1000 37.36 37.36 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_1992
 1 1000 38.27 38.27 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_1997
 1 1000 39.19 39.19 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_2006
 1 1000 41.66 41.66 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_2011
 1 1000 40.38 40.38 10 0 -2 # L_at_Amax_Mal_GP_1_BLK1repl_2016
 0.001 2 0.36 0.36 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_1979
 0.001 2 0.32 0.32 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_1982
 0.001 2 0.29 0.29 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_1985
 0.001 2 0.25 0.25 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_1988
 0.001 2 0.37 0.37 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_1992
 0.001 2 0.41 0.41 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_1997
 0.001 2 0.33 0.33 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_2006
 0.001 2 0.25 0.25 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_2011
 0.001 2 0.29 0.29 0.05 0 -3 # VonBert_K_Mal_GP_1_BLK1repl_2016
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
        0.0001            20       6.85593             7            99             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
 0.2 1 0.9 0.73 0.24 3 -1 0 0 0 0 0 0 0 # SR_BH_steep
             0             2          0.75           0.4            99             0         -6          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0            99             0        -99          0          0          0          0          0          0          0 # SR_regime
             0             2             0             1            99             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1959 # first year of main recr_devs; early devs can preceed this era
2018 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
0 # (0/1) to read 13 advanced options
#_Cond 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
#_Cond -4 #_recdev_early_phase
#_Cond 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
#_Cond 1 #_lambda for Fcast_recr_like occurring before endyr+1
#_Cond 959 #_last_yr_nobias_adj_in_MPD; begin of ramp
#_Cond 1937 #_first_yr_fullbias_adj_in_MPD; begin of plateau
#_Cond 2018 #_last_yr_fullbias_adj_in_MPD
#_Cond 2020 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS sets bias_adj to 0.0 for fcast yrs)
#_Cond 1 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
#_Cond 0 #_period of cycles in recruitment (N parms read below)
#_Cond -5 #min rec_dev
#_Cond 5 #max rec_dev
#_Cond 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1959R 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 1968R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019F 2020F
#  0.0547455 0.0616002 0.0701273 0.0807098 0.0937839 0.109956 0.129744 0.154041 0.18359 0.21832 0.258483 0.304411 0.35943 0.435166 1.84947 0.379486 0.152184 0.35997 0.175527 0.705785 1.26327 0.941572 0.682274 0.162607 -0.0768924 0.33615 0.237129 -0.0794651 -0.432103 -0.513434 -0.599048 -0.574354 -0.608194 -0.729102 -0.114931 -0.445554 -0.473154 -0.46765 0.532392 0.0534646 -0.138288 0.268203 -0.0417369 0.205227 -0.275558 -0.164492 0.114069 -0.896985 0.397778 0.299475 0.49711 -0.314526 -0.874066 -0.625585 -0.812263 -1.62666 -0.23345 -0.111215 -0.857692 -0.0408534 0 0
#
#Fishing Mortality info 
0.03 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
4  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 2
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 0 1000 1e-20 1 999 0 -1 # InitF_seas_1_flt_1Bottom_Trawls
 0 1000 1e-20 1 999 0 -1 # InitF_seas_1_flt_2Bottom_gillnet
#
# F rates by fleet x season
# Yr:  1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Bottom_Trawls 0 0.00565361 0.00499323 0.0120454 0.0071499 0.0127069 0.0124602 0.00884233 0.0237832 0.0222129 0.0292564 0.0397747 0.074341 0.0996818 0.285958 0.232034 0.202296 0.23553 0.285493 0.29632 0.19465 0.240018 0.229386 0.138039 0.183755 0.3166 0.255944 0.329175 0.335791 0.25882 0.247233 0.213558 0.332446 0.38138 0.459612 0.413447 0.62487 0.284247 0.209156 0.0994459 0.118928 0.142743 0.373812 0.438874 0.330342 0.338722 0.303604 0.324445 0.500588 0.371599 0.488308 0.600828 0.793387 0.454394 0.484306 0.408824 0.332311 0.665178 0.917522 0.661545 0.662991 5.27539e-06
# Bottom_gillnet 0 0.000496061 0.000437977 0.00102257 0.000608913 0.0010867 0.00106864 0.000772517 0.0020791 0.001978 0.0026303 0.00363941 0.0069115 0.00949026 0.028031 0.0285375 0.0282955 0.0521012 0.0281793 0.0330985 0.0186048 0.0129925 0.0203039 0.00903866 0.0204028 0.0284487 0.0257397 0.0198001 0.0414445 0.0164062 0.0130916 0.0176972 0.0401402 0.0342076 0.133686 0.101813 0.147093 0.121888 0.0337017 0.0215651 0.0555114 0.0880479 0.135228 0.169118 0.170135 0.221806 0.230113 0.377024 0.438763 0.524493 0.563543 0.364787 0.22947 0.0495587 0.122673 0.16493 0.125182 0.391248 0.293037 0.400333 0.399909 3.18206e-06
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         0         0         1  #  Bottom_Trawls
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -15            15      -9.49581             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Bottom_Trawls(1)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_2;  parm=6; modification of pattern 24 with improved sex-specific offset
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (average over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (average over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 0 0 0 # 1 Bottom_Trawls
 1 0 0 0 # 2 Bottom_gillnet
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (average over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (average over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 10 0 0 0 # 1 Bottom_Trawls
 10 0 0 0 # 2 Bottom_gillnet
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Bottom_Trawls LenSelex
           7.5          48.5        26.435            28            99             0         -1          0          0          0          0          0          0          0  #  Size_DblN_peak_Bottom_Trawls(1)
           -15            15      -3.03132            15            99             0         -1          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Bottom_Trawls(1)
            -4            12       3.30008       3.95003            99             0         -1          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Bottom_Trawls(1)
           -10             6       4.09878           -15            99             0         -1          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Bottom_Trawls(1)
          -999            15           -15           -10            99             0         -2          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Bottom_Trawls(1)
            -5            20      -4.66383            15            99             0         -1          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Bottom_Trawls(1)
# 2   Bottom_gillnet LenSelex
          16.5          45.5       27.9159            34            99             0         -2          0          0          0          0          0          0          0  #  Size_inflection_Bottom_gillnet(2)
           0.1           100         4.047            15            99             0         -3          0          0          0          0          0          0          0  #  Size_95%width_Bottom_gillnet(2)
# 1   Bottom_Trawls AgeSelex
# 2   Bottom_gillnet AgeSelex
#_No_Dirichlet parameters
#_no timevary selex parameters
#
0   #  use 2D_AR1 selectivity(0/1)
#_no 2D_AR1 selex offset used
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1     2     1     1     2     0     0     0     0     0     0     0
#      1     3    10     1     2     0     0     0     0     0     0     0
#      1     4    19     1     2     0     0     0     0     0     0     0
#      1    14    28     1     2     0     0     0     0     0     0     0
#      1    15    37     1     2     0     0     0     0     0     0     0
#      1    16    46     1     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
 -9999   1    0  # terminator
#
15 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 4 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 8 1 1 1 1
 8 2 1 1 1
 9 1 1 0 1
 9 2 1 0 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_1
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_CPUE/survey:_2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_1
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_lencomp:_2
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_init_equ_catch1
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #_init_equ_catch2
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_recruitments
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

