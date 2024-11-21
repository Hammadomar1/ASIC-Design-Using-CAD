onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /prbs_tb/CLK_PERIOD
add wave -noupdate /prbs_tb/data_in
add wave -noupdate /prbs_tb/clk
add wave -noupdate /prbs_tb/resetN
add wave -noupdate /prbs_tb/load
add wave -noupdate /prbs_tb/en
add wave -noupdate /prbs_tb/seed
add wave -noupdate /prbs_tb/ready_fec
add wave -noupdate /prbs_tb/valid_in
add wave -noupdate /prbs_tb/data_out
add wave -noupdate /prbs_tb/valid_out
add wave -noupdate /prbs_tb/ready_randomizer
add wave -noupdate /prbs_tb/data_in_sequence
add wave -noupdate /prbs_tb/data_out_expected
add wave -noupdate /prbs_tb/data_out_sequence
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {339241082 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {334611006 ps} {347668030 ps}
