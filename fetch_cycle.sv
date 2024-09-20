module fetch_cycle (
input logic clk,rst,
input logic PCSrcE,
input logic [31:0] PCTargetE,
output logic [31:0] InstrD,PCD, PCPlus4D);
logic [31:0] PCF, PC_F,PCPlus4F,InstrF;
logic [31:0] Reg_InstrF,Reg_PCF,Reg_PCPlus4F;
Mux muxpcf (.a(PCPlus4F),
				.b(PCTargetE),
				.s(PCSrcE),
				.c(PC_F));
PC_Module PC_NF  (.clk(clk),
						.rst(rst),
						.PC(PCF),
						.PC_Next(PC_F));
PC_Adder Adder_PCF
(						.a(PCF),
						.b(32'h00000004),
						.c(PCPlus4F)
);

Instruction_Memory pipe_insmem (	.rst(rst),
											.A(PCF),
											.RD(InstrF));
always_ff @ (posedge clk or negedge rst)
begin
if (rst==1'b0) begin
	Reg_InstrF <= 32'h00000000;
	Reg_PCF <= 32'h00000000;
	Reg_PCPlus4F <= 32'h00000000;
end
else begin
	Reg_InstrF <= InstrF;
	Reg_PCF <= PCF;
	Reg_PCPlus4F <= PCPlus4F;
end
end
assign InstrD = (rst == 1'b0) ? 32'h00000000 : Reg_InstrF;
assign PCD = (rst == 1'b0) ? 32'h00000000 : Reg_PCF;
assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : Reg_PCPlus4F;
endmodule
