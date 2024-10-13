quit -sim
vlib work

vlog -sv "../rtl/prbs.sv"
vlog -sv prbs_tb.sv
vsim -voptargs=+acc work.prbs_tb
do prbs_wave.do
run -all