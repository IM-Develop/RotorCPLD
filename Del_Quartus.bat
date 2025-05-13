cd output_files\

del POFForRPD.pof

set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set SUBFILENAME=%CUR_DD%%CUR_MM%%CUR_YYYY%
copy pofforrpd_cfm0_auto.rpd AGG_CPLD_V3_%SUBFILENAME%.rpd
move AGG_CPLD.pof AGG_CPLD_V3_%SUBFILENAME%.pof

del *.done
del *.html
del *.jdi
del *.map
del *.pin
del *.rpt
del *.smsg
del *.sopcinfo
del *.summary
del *.txt
del *.sld
del POFForRPD_auto.rpd
del pofforrpd_ufm_auto.rpd
del pofforrpd_cfm0_auto.rpd
rem del *.pof
cd ..
del *.done
del *.html
del *.jdi
del *.map
del *.pin
del *.rpt
del *.smsg
del *.sopcinfo
del *.summary
del *.txt
rem del *.pof
del *.csv
del *.qws
del greybox_tmp\*.*
rem del db\*.*
del .qsys_edit\*.*
del incremental_db\*.*
del incremental_db\compiled_partitions\*.*
del hps_isw_handoff\*.*
del hps_isw_handoff\TestHPFQsys_hps_0\*.*
rmdir hps_isw_handoff\TestHPFQsys_hps_0
rmdir hps_isw_handoff
rmdir greybox_tmp
rmdir /s db
rmdir .qsys_edit
rmdir incremental_db\compiled_partitions
rmdir incremental_db
copy  simulation\modelsim\*.vht *.*
del simulation\modelsim\*.*
rmdir /s/q simulation\modelsim\rtl_work
rmdir /s/q simulation\modelsim\gate_work
copy *.vht simulation\modelsim\*.*
del *.vht