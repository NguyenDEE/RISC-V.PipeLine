module memmory_cycle (
input clk,rst,
input logic RegWriteM,MemWriteM,
input logic [1:0] ResultSrcM,
input logic [31:0] ALUResultM,WriteDataM,
input logic [4:0] RdM,
input logic [31:0] PCPlus4M,
output logic RegWriteW,
output logic [1:0] ResultSrcW,
output logic [31:0] ALUResultW,ReadDataW,
output logic [4:0] RdW,
output logic [31:0] PCPlus4W
);
//wrie 
logic [31:0] ReadDataM;
//register
logic [31:0] Reg_ReadDataM;
logic Reg_RegWriteM;
logic [1:0] Reg_ResultSrcM;
logic [31:0] Reg_ALUResultM;
logic [4:0] Reg_RdM;
logic [31:0] Reg_PCPlus4M;

Data_Memory  MemM
(					.clk(clk),
					.rst(rst),
					.WE(MemWriteM),
					.WD(WriteDataM),
					.A(ALUResultM),
					.RD(ReadDataM));
always_ff @(posedge clk or negedge rst) begin
	if (rst == 1'b0) begin
			Reg_ReadDataM <= 32'h00000000;
			Reg_RegWriteM <= 1'b0;
			Reg_ResultSrcM <= 2'b00;
			Reg_ALUResultM <= 32'h00000000;
			Reg_RdM <= 5'h00;
			Reg_PCPlus4M <= 32'h00000000;
			end
	else begin
			Reg_ReadDataM <= ReadDataM;
			Reg_RegWriteM <= RegWriteM;
			Reg_ResultSrcM <= ResultSrcM;
			Reg_ALUResultM <= ALUResultM;
			Reg_RdM <= RdM;
			Reg_PCPlus4M <= PCPlus4M;
			end
end
assign ReadDataW = Reg_ReadDataM;
assign RegWriteW = Reg_RegWriteM;
assign ResultSrcW = Reg_ResultSrcM;
assign ALUResultW = Reg_ALUResultM;
assign RdW = Reg_RdM;
assign PCPlus4W= Reg_PCPlus4M;
endmodule
