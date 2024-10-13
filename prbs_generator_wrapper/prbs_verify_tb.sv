module prbs_verify_tb();
    bit clk;
    bit reset;
    bit load;
    bit en;

    bit pass;

    prbs_verify dut(.clk(clk), .reset(reset), .load(load), .en(en), .pass(pass));
    
    initial forever #10 clk = ~clk;


    initial begin
        clk = 0;
        reset = 0;
        // #20;
        @(posedge clk)
        reset = 1;
        en = 0;
        load = 0;   // Reset sequence done
        // #20;
        @(posedge clk)
        reset = 0;
        // #10;
        @(posedge clk)
        load = 1;
        // #20;
        @(posedge clk)
        load = 0;   // Seed loaded
        @(posedge clk)
        en = 1;     // Generator Started
        repeat(96) begin
            // Self Checking logic
            if(pass === 1'b1) begin
                $display("Test Passed!");
            end else begin
                $display("Test Failed!");
            end
        
            #20;
        end

        $stop();

    end
endmodule