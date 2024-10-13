module prbs_tb();
    
    bit data_in;
    bit clk;
    bit reset;
    bit load;
    bit en;
    bit data_out;

    bit [1:96] output_sequence;
    bit [1:96] input_sequence = 96'hACBCD2114DAE1577C6DBF4C9;
    bit [1:15] seed = 15'b011011100010101;
    bit [1:96] expected_out = 96'h558AC4A53A1724E163AC2BF9;
    integer i = 1;


    prbs dut(
            .data_in(data_in), .clk(clk), .reset(reset),
            .load(load), .en(en), .seed(seed), .data_out(data_out)
            );
            
    initial forever #10 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        reset = 1;
        #20;
        reset = 0; // Reset sequence
        en = 0;
        load = 0;
        #20; 
         // time for load to happen
        load = 1;
        en = 1;
        
        repeat (96) begin @(posedge clk) begin
            data_in = input_sequence[i];
            #1;
            output_sequence[i] = data_out;
            i ++;
            #1;
            load = 0;
        end
        end /*while(input_sequence !== 96'b0);*/
        // for (i=96; i>0; i--)
        //     output_sequence [i] <= data_out; 

        if(output_sequence == expected_out) begin
            $display("Output: %h\t\tExpected: %h\tTEST PASSED", output_sequence, expected_out);
        end else begin
             $display("Output: %h\t\tExpected: %h\tTEST FAILED", output_sequence, expected_out);
        end

        $stop();

    end

 

        // output check
        // expected_out[0:95] = 96'h558AC4A53A1724E163AC2BF9;


endmodule