/*
FRT/Debt regressions, including Z-Scores
October 2016
*/

/* 1. Clean the slate. */
clear
set more off

// Set working directory, change as needed/
cd "/git_repositories/FRTIndex/paper/"

use "analysis/frt10_16_v1.dta"

* Create interactions
gen l_frt2015xl_pub_gen = l_frt_2015 * l_pubdebtgdp_gen
gen d_frt_2015xd_pubdebtgdp_gen = d_frt_2015 * d_pubdebtgdp_gen

gen l_frt2015xd_pubdebtgdp_gen = l_frt_2015 * d_pubdebtgdp_gen
gen d_frt_2015xl_pub_gen = d_frt_2015 * l_pubdebtgdp_gen

* Subset sample to OECD/non-Japan (other countries lack FRED bond yield data)
keep if country != "Russian Federation" & country != "South Africa" & country != "Japan"

gen imf_program = 0
replace imf_program = 1 if country == "Iceland" & year == 2008
replace imf_program = 1 if country == "Greece" & year == 2010
replace imf_program = 1 if country == "Ireland" & year == 2010
replace imf_program = 1 if country == "Portugal" & year == 2011
replace imf_program = 1 if country == "Korea, Republic of" & year == 1997
replace imf_program = 1 if country == "Mexico" & year == 1995

sort imf_code year
by imf_code: gen imf_program_lag = imf_program[_n-1]

/* ECM Models */

/************** Spreads ********************/
* Spreads non-interactive
xtreg d_bond_spread_fred l_bond_spread_fred l_frt_2015 d_frt_2015 ///
 	l_pubdebtgdp_gen d_pubdebtgdp_gen ///
	l_infl d_infl l_cgdpgrowth d_cgdpgrowth l_pcgdp2005l d_pcgdp2005l ///
	l_oecdgrowth d_oecdgrowth l_us3mrate d_us3mrate l_vix d_vix ///
	l_uds d_uds imf_program_lag ///
	l_zscore d_zscore ///
	if country!="United States", cluster(imf_code) i(imf_code) fe vsquish noomit
	
	
* Spreads interactive	
xtreg d_bond_spread_fred l_bond_spread_fred ///
	l_frt_2015 d_frt_2015 ///
	l_pubdebtgdp_gen d_pubdebtgdp_gen ///
	l_frt2015xl_pub_gen d_frt_2015xd_pubdebtgdp_gen ///
	l_frt2015xd_pubdebtgdp_gen d_frt_2015xl_pub_gen ///
	l_infl d_infl ///
	l_cgdpgrowth d_cgdpgrowth l_pcgdp2005l d_pcgdp2005l ///
	l_oecdgrowth d_oecdgrowth ///
	l_us3mrate d_us3mrate l_vix d_vix ///
	l_uds d_uds imf_program_lag ///
	l_zscore d_zscore ///
	l_zscore d_zscore ///
	if country!="United States", ///
	cluster(imf_code) i(imf_code) fe vsquish noomit
	
/************ Volatility ******************/
* Volatility non-interactive
xtreg d_lt_ratecov_fred l_lt_ratecov_fred l_frt_2015 d_frt_2015 ///
	l_pubdebtgdp_gen d_pubdebtgdp_gen ///
	l_infl d_infl l_cgdpgrowth d_cgdpgrowth l_pcgdp2005l ///
	d_pcgdp2005l l_oecdgrowth d_oecdgrowth l_us3mrate d_us3mrate l_vix d_vix ///
	l_uds d_uds imf_program_lag ///
	l_zscore d_zscore, ///
	cluster(imf_code) i(imf_code) fe vsquish noomit
	
	
xtreg d_lt_ratecov_fred l_lt_ratecov_fred l_frt_2015 d_frt_2015 ///
	l_pubdebtgdp_gen d_pubdebtgdp_gen ///
	l_frt2015xl_pub_gen d_frt_2015xd_pubdebtgdp_gen ///
	l_frt2015xd_pubdebtgdp_gen d_frt_2015xl_pub_gen ///
	l_infl d_infl l_cgdpgrowth d_cgdpgrowth l_pcgdp2005l d_pcgdp2005l ///
	l_oecdgrowth d_oecdgrowth l_us3mrate d_us3mrate ///
	l_vix d_vix ///
	l_uds d_uds imf_program_lag ///
	l_zscore d_zscore, ///
	cluster(imf_code) i(imf_code) fe vsquish noomit
