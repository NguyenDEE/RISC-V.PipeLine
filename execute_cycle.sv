module execute_cycle (
input clk,rst,
input logic RegWriteE,ALUSrcE,MemWriteE,BranchE,JumpE,
input logic [1:0] ResultSrcE,
input logic [2:0]ALUControlE,
input logic [31:0] RD1E,RD2E,
input logic [31:0] PCE,
input logic [4:0] RdE,
input logic [1:0] ForwardAE,ForwardBE,
input logic [31:0] ResultW,
input logic [31:0] ImmExtE,PCPlus4E,
output logic PCSrcE,RegWriteM,MemWriteM,
output logic [1:0] ResultSrcM,
output logic [31:0] ALUResultM,WriteDataM,
output logic [4:0] RdM,
output logic [31:0] PCPlus4M,PCTargetE);
//wire
logic [31:0] SrcAE,SrcBE,WriteDataE;
logic [31:0] ALUResultE;
logic Zero;
//register
logic Reg_RegWriteE,Reg_MemWriteE;
logic [1:0]  Reg_ResultSrcE;
logic [31:0] Reg_ALUResultE;
logic [31:0] Reg_WriteDataE;
logic [4:0]  Reg_RdE;
logic [31:0] Reg_PCPlus4E;
//
Mux_3_by_1 Mux_SrcA(
							.a(RD1E),
							.b(ResultW),
							.c(ALUResultM),
							.s(ForwardAE),
							.d(SrcAE)
							);
//
Mux_3_by_1 Mux_Data(
							.a(RD2E),
							.b(ResultW),
							.c(ALUResultM),
							.s(ForwardBE),
							.d(WriteDataE)
							);
//
Mux 			Mux_SrcB	(
							.a(WriteDataE),
							.b(ImmExtE),
							.s(ALUSrcE),
							.c(SrcBE));
//
 ALU  Pipeline_Alu
 (		.A(SrcAE),
		.B(SrcBE),
		.ALUControl(ALUControlE),
		.Carry(),
		.OverFlow(),
		.Zero(Zero),
		.Negative(),
		.Result(ALUResultE)
);	
PC_Adder Pipeline_PCA  
							(	.a(PCE),
								.b(ImmExtE),
								.c(PCTargetE));
always_ff @ (posedge clk or negedge rst) begin
if (rst==1'b0) begin
Reg_RegWriteE <= 1'b0;
Reg_MemWriteE <= 1'b0;
Reg_ResultSrcE	<= 2'b00;
Reg_ALUResultE <= 32'h00000000;
Reg_WriteDataE <= 32'h00000000;
Reg_RdE <=	5'b00000;
Reg_PCPlus4E <= 32'h00000000;
end
else begin
Reg_RegWriteE <= RegWriteE ;
Reg_MemWriteE <= MemWriteE;
Reg_ResultSrcE <= ResultSrcE;
Reg_ALUResultE <= ALUResultE;
Reg_WriteDataE <= WriteDataE; 
Reg_RdE <= RdE ;
Reg_PCPlus4E <= PCPlus4E;
end
end
assign RegWriteM = Reg_RegWriteE;
assign MemWriteM = Reg_MemWriteE;
assign ResultSrcM = Reg_ResultSrcE;
assign ALUResultM =Reg_ALUResultE;
assign WriteDataM = Reg_WriteDataE;
assign RdM = Reg_RdE;
assign PCPlus4M = Reg_PCPlus4E;
assign PCSrcE = (Zero&BranchE)| JumpE ;
endmodule

							

