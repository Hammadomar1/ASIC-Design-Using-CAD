package Phase1_Package;

//  Constants 
    timeunit 1ns;
    timeprecision 1ps;
    
    parameter time CLK_50_PERIOD = 20;
    parameter time CLK_50_HALF_PERIOD = CLK_50_PERIOD / 2;
    parameter time CLK_100_PERIOD = 10;
    parameter time CLK_100_HALF_PERIOD = CLK_100_PERIOD / 2;
    parameter string START_SIMULATION_MSG = "================Simulation started================";
    parameter string END_SIMULATION_MSG = "================Simulation finished==============";
    
    //randomizer
    parameter logic [95:0] INPUT_RANDOMIZER_VECTOR_CONST = 96'hACBCD2114DAE1577C6DBF4C9;
    parameter logic [95:0] OUTPUT_RANDOMIZER_VECTOR_CONST = 96'h558AC4A53A1724E163AC2BF9;
    
    //FEC Encoder
    parameter logic [95:0] INPUT_FEC_VECTOR_CONST = 96'h558AC4A53A1724E163AC2BF9;
    
    //interleaver
    parameter logic [191:0] INPUT_INTERLEAVER_VECTOR_CONST = 192'h2833E48D392026D5B6DC5E4AF47ADD29494B6C89151348CA;
    
    //modulator
    parameter logic [15:0] ZeroPointSeven = 16'b0101101001111111;
    parameter logic [15:0] NegativeZeroPointSeven = 16'b1010010110000001;
    parameter logic [191:0] INPUT_MODULATION_VECTOR_CONST = 192'h4B047DFA42F2A5D5F61C021A5851E9A309A24FD58086BD1E;
    parameter logic [191:0] INPUT_MODULATION_VECTOR_CONST2 = 192'h4B047DFA42F2A5D5F61C021A5851E9A309A24FD58087BD1E;

   //tasks
    
task automatic enter_96_inputs(
    input int start,
    input int STOP,
    input logic [95:0] data_in,
    output logic test_data
);
    for (int i = STOP; i >= start; i--) begin
        while (!ready_out || !interleaver_ready) @(posedge clk_50mhz); // Wait until both FEC and interleaver are ready
        test_data = data_in[i];
        @(posedge clk_50mhz);
    end
endtask


    // Fill 192-bit input vector
    task automatic fill_192_inputs_procedure(
        input int start,
        input int endd,
        input logic [191:0] input_vector,
        output logic test_data_bit
    );
        for (int i = endd; i >= start; i--) begin
            test_data_bit = input_vector[i];
            #(CLK_100_PERIOD);
        end
    endtask

    // Fill 192-bit output vector
    task automatic fill_192_outputs_procedure(
        input int start,
        input int endd,
        output logic [191:0] output_vector,
        input logic test_data_bit
    );
        for (int i = endd; i >= start; i--) begin
            output_vector[i] = test_data_bit;
            #(CLK_100_PERIOD);
        end
    endtask

endpackage