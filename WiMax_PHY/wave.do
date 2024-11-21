onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fec_encoder_wimax_phy_tb/reset_N
add wave -noupdate -expand -group {Clocks (Fast and Slow)} /fec_encoder_wimax_phy_tb/clk_50mhz
add wave -noupdate -expand -group {Clocks (Fast and Slow)} /fec_encoder_wimax_phy_tb/clk_100mhz
add wave -noupdate -color {Orange Red} -height 25 /fec_encoder_wimax_phy_tb/data_out
add wave -noupdate -expand -group {States (Input and Output)} /fec_encoder_wimax_phy_tb/dut/output_state
add wave -noupdate -expand -group {States (Input and Output)} /fec_encoder_wimax_phy_tb/dut/input_state
add wave -noupdate /fec_encoder_wimax_phy_tb/data_in
add wave -noupdate -expand -group {Gold Data} /fec_encoder_wimax_phy_tb/input_vector
add wave -noupdate -expand -group {Gold Data} /fec_encoder_wimax_phy_tb/expected_output_vector
add wave -noupdate /fec_encoder_wimax_phy_tb/output_vector
add wave -noupdate /fec_encoder_wimax_phy_tb/i
add wave -noupdate /fec_encoder_wimax_phy_tb/output_bit_count
add wave -noupdate -expand -group {Handshaking Signals} /fec_encoder_wimax_phy_tb/randomizer_output_valid
add wave -noupdate -expand -group {Handshaking Signals} /fec_encoder_wimax_phy_tb/ready_out
add wave -noupdate -expand -group {Handshaking Signals} /fec_encoder_wimax_phy_tb/interleaver_ready
add wave -noupdate -expand -group {Handshaking Signals} /fec_encoder_wimax_phy_tb/valid_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6166922 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
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
WaveRestoreZoom {1492557 ps} {22031434 ps}
