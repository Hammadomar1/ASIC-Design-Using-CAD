onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /prbs_tb/data_in
add wave -noupdate /prbs_tb/clk
add wave -noupdate /prbs_tb/reset
add wave -noupdate /prbs_tb/load
add wave -noupdate /prbs_tb/en
add wave -noupdate /prbs_tb/seed
add wave -noupdate /prbs_tb/data_out
add wave -noupdate /prbs_tb/input_sequence
add wave -noupdate /prbs_tb/output_sequence
add wave -noupdate /prbs_tb/expected_out
add wave -noupdate /prbs_tb/dut/r_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
