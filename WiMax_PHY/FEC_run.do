quit -sim
vlib work
vmap altera_mf "C:/intelFPGA_lite/23.1std/questa_fse/intel/verilog/altera_mf"

vlog -sv "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/Package_wimax.sv"
vlog -sv "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/FEC_DPR.v"
vlog -sv "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/fec_encoder_wimax_phy.sv"
vlog -sv "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/fec_encoder_wimax_phy_tb.sv"
#vlog -work work "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/FEC_DPR.v"
#vlog -work work "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/fec_encoder_wimax_phy.sv"
#vlog -work work "C:/Users/iT/Desktop/ASIC/WiMaxPHYQPSK/fec_encoder_wimax_phy_tb.sv"

vsim -voptargs=+acc -L altera_mf work.fec_encoder_wimax_phy_tb
do wave.do
run -all




