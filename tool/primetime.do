set power_enable_analysis true
set power_analysis_mode time_based
set power_report_leakage_breakdowns true
set power_clock_network_include_register_clock_pin_power true
set search_path "./"

set target_library "fast.db"
set link_library "* fast.db"
set sythetic_library "dw_foundation.sldb"

read_file -format verilog [list CHIP.v]
current_design [get_designs CHIP]
read_sdf -load_delay net CHIP.sdf
read_vcd -time {0 1370} -strip_path testbench/CHIP_tb ./CHIP.vcd

check_power
set_power_analysis_options -waveform_interval 1
update_power

set_power_analysis_options -waveform_interval 1 -waveform_format out -waveform_output vcd
report_power -verbose -hierarchy > my_design.power
report_power >> my_design.power
exit