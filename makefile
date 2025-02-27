
.PHONY : all batch combine check_combine copy_for_download download_final download_txt

all :

batch :
	sbatch "code/batch/server1.sbatch"
	# sbatch "code/batch/server2.sbatch"

combine :
	sbatch "code/batch/combine_runs.sbatch"

check_combine :
	cat "output/combine.err"

dldir = output/download/
copy_for_download :
	-rm -rf "$(dldir)"
	-mkdir -p "$(dldir)"
	-cp output/*.csv "$(dldir)"
	-cp output/*.xlsx "$(dldir)"
	-cp output/*.out "$(dldir)"
	-cp output/*.err "$(dldir)"
	-cp output/output_table.mat "$(dldir)"
	-cp output/*.eps "$(dldir)"


spath1 := "abram@midway2.rcc.uchicago.edu:/home/abram/Continuous_Time_HA/output/download/*"
cdate := $(shell date +"%m-%d-%Y-%T")
download_final :
	-mkdir -p output/server-$(cdate)
	-scp $(spath1) output/server-$(cdate)

spath2 := "abram@midway2.rcc.uchicago.edu:/home/abram/Continuous_Time_HA/output/*.out"
cdate := $(shell date +"%m-%d-%Y-%T")
download_txt :
	-mkdir -p output/server-txt-$(cdate)
	-scp $(spath2) output/server-txt-$(cdate)

spath3 := "abram@midway2.rcc.uchicago.edu:/home/abram/Continuous_Time_HA/output/*"
cdate := $(shell date +"%m-%d-%Y-%T")
download_all_out :
	-mkdir -p output/server-all-$(cdate)
	-scp $(spath3) output/server-all-$(cdate)

readme :
	-pandoc readme.md -o readme.pdf
	-xdg-open readme.pdf

clean :
	-rm -rf output/*
	-rm -rf temp/*