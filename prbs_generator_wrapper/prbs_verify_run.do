quit -sim
vlib work

vlog -sv "../rtl/*.sv"
vlog -sv prbs_verify_tb.sv
vsim -voptargs=+acc work.prbs_verify_tb
do prbs_verify_wave.do
run -all