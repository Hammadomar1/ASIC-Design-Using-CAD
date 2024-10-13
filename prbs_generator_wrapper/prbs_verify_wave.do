onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /prbs_verify_tb/clk
add wave -noupdate /prbs_verify_tb/reset
add wave -noupdate /prbs_verify_tb/load
add wave -noupdate /prbs_verify_tb/en
add wave -noupdate /prbs_verify_tb/pass
add wave -noupdate /prbs_verify_tb/dut/in_data_rom
add wave -noupdate /prbs_verify_tb/dut/data_in_serial
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1296 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 112
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
WaveRestoreZoom {1179 ns} {2054 ns}
