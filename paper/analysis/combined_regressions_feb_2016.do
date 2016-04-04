/*
Debt regressions
*/

/* 1. Clean the slate. */
clear
set more off

// Set working directory, change as needed/
cd "/git_repositories/FRTIndex/paper/"

use "analysis/frt0215.dta"


/* ECM Models */

/* Non-Interactive Models */

* Spreads

xtreg dnewspread lnewspread lfrt dfrt lpubdebtgdp dpubdebtgdp linfl dinfl lcgdpgrowth dcgdpgrowth lpcgdp2005l dpcgdp2005l loecdgrowth doecdgrowth lus3mrate dus3mrate lvix dvix if country != "United States", cluster(imf_code) i(imf_code) fe vsquish noomit

regsave using "tables/FRT_1.dta", detail(all) replace table(nonInteractSpread, ///
        order(regvars r2) format(%5.2f) paren(stderr) asterisk())

* Coefficient of variation
xtreg dltratecov lltratecov lfrt dfrt lpubdebtgdp dpubdebtgdp linfl dinfl lcgdpgrowth dcgdpgrowth lpcgdp2005l dpcgdp2005l loecdgrowth doecdgrowth lus3mrate dus3mrate lvix dvix, cluster(imf_code) i(imf_code) fe vsquish noomit

regsave using "tables/FRT_3.dta", detail(all) replace table(nonInteractCov, ///
        order(regvars r2) format(%5.2f) paren(stderr) asterisk())


/* Interactive Models */

* Spreads
xtreg dnewspread lnewspread lfrt dfrt lpubdebtgdp dpubdebtgdp lfrtxlpub dfrtxdpub linfl dinfl lcgdpgrowth dcgdpgrowth lpcgdp2005l dpcgdp2005l loecdgrowth doecdgrowth lus3mrate dus3mrate lvix dvix if country != "United States", cluster(imf_code) i(imf_code) fe vsquish noomit

regsave using "tables/FRT_2.dta", detail(all) replace table(frt1, ///
        order(regvars r2) format(%5.2f) paren(stderr) asterisk())

* Coefficient of variation
xtreg dltratecov lltratecov lfrt dfrt lpubdebtgdp dpubdebtgdp lfrtxlpub dfrtxdpub linfl dinfl lcgdpgrowth dcgdpgrowth lpcgdp2005l dpcgdp2005l loecdgrowth doecdgrowth lus3mrate dus3mrate lvix dvix, cluster(imf_code) i(imf_code) fe vsquish noomit

regsave using "tables/FRT_4.dta", detail(all) replace table(frt2, ///
        order(regvars r2) format(%5.2f) paren(stderr) asterisk())

