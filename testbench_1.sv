`timescale 1ns/1ps
module testbench_1();
    reg clk=0, rst;
    
    always begin
        clk = ~clk;
        #50;
    end
pipeline_myself dut (.clk(clk), .rst(rst));
    initial begin
        rst <= 1'b0;
        #200;
        rst <= 1'b1;
        #1000;
		$finish;  
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end

endmodule
