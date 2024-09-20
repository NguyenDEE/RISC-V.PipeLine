module pipeline_myself (
input clk,
input rst);
// wire
logic PCSrcE,RegWriteW,RegWriteE,ALUSrcE,MemWriteE;
logic BranchE,JumpE;
logic [31:0] InstrD,PCD, PCPlus4D,PCTargetE,ResultW,RD1E,RD2E,PCE,ImmExtE,PCPlus4E;
logic [4:0] RdW,Rs1E,Rs2E,RdE;
logic [1:0] ResultSrcE;
logic [2:0] ALUControlE;
logic [1:0] ForwardAE,ForwardBE;
//
logic RegWriteM,MemWriteM;
logic [1:0] ResultSrcM;
logic [31:0] ALUResultM,WriteDataM,PCPlus4M;
logic [4:0] RdM;
//
logic [1:0] ResultSrcW;
logic [31:0] ALUResultW,ReadDataW,PCPlus4W;
//

fetch_cycle pipe_fetch (
									.clk(clk),
									.rst(rst),
									.PCSrcE(PCSrcE),
									.PCTargetE(PCTargetE),
									.InstrD(InstrD),
									.PCD(PCD),
									.PCPlus4D(PCPlus4D)
);
//
decoder_cycle pipe_decoder
( 
									.clk(clk),
									.rst(rst),
									.InstrD(InstrD),
									.PCD(PCD), 
									.PCPlus4D(PCPlus4D),
									.ResultW(ResultW),
									.RdW (RdW),
									.RegWriteW(RegWriteW),
									.RegWriteE (RegWriteE),
									.ALUSrcE(ALUSrcE),
									.MemWriteE(MemWriteE),
									.BranchE(BranchE),
									.JumpE(JumpE),
									.ResultSrcE(ResultSrcE),
									.ALUControlE(ALUControlE),
									.RD1E(RD1E),
									.RD2E(RD2E),
									.PCE(PCE),
									.Rs1E(Rs1E),
									.Rs2E(Rs2E),
									.RdE(RdE),
									.ImmExtE(ImmExtE),
									.PCPlus4E(PCPlus4E)
);
//
execute_cycle pipe_excute(
									.clk(clk),
									.rst(rst),
									.RegWriteE(RegWriteE),
									.ALUSrcE (ALUSrcE),
									.MemWriteE (MemWriteE),
									.BranchE (BranchE),
									.JumpE (JumpE),
									.ResultSrcE(ResultSrcE),
									.ALUControlE (ALUControlE),
									.RD1E(RD1E),
									.RD2E(RD2E),
									.PCE(PCE),
									.RdE(RdE),
									.ForwardAE(ForwardAE) ,
									.ForwardBE (ForwardBE),
									.ResultW (ResultW),
									.ImmExtE (ImmExtE),
									.PCPlus4E (PCPlus4E),
									.PCSrcE(PCSrcE),
									.RegWriteM(RegWriteM),
									.MemWriteM(MemWriteM),
									.ResultSrcM(ResultSrcM),
									.ALUResultM (ALUResultM),
									.WriteDataM(WriteDataM),
									.RdM (RdM),
									.PCPlus4M (PCPlus4M),
									.PCTargetE(PCTargetE)
);
//
memmory_cycle pipe_memmory
(
									.clk(clk),
									.rst(rst),
									.RegWriteM(RegWriteM),
									.MemWriteM(MemWriteM),
									.ResultSrcM(ResultSrcM),
									.ALUResultM (ALUResultM),
									.WriteDataM (WriteDataM),
									.RdM (RdM),
									.PCPlus4M (PCPlus4M),
									.RegWriteW (RegWriteW),
									.ResultSrcW (ResultSrcW),
									.ALUResultW (ALUResultW),
									.ReadDataW (ReadDataW),
									.RdW (RdW),
									.PCPlus4W(PCPlus4W)
);
//
write_cycle pipe_write
(									.clk(clk),
									.rst(rst),
									.ResultSrcW (ResultSrcW),
									.ALUResultW (ALUResultW),
									.ReadDataW (ReadDataW),
									.PCPlus4W (PCPlus4W),
									.ResultW(ResultW)
);
//
hazard_unit pipe_hazard
(
									.rst(rst),
									.Rs1E(Rs1E),
									.Rs2E(Rs2E),
									.RdM(RdM),
									.RdW(RdW),
									.RegWriteM(RegWriteM),
									.RegWriteW(RegWriteW),
									.ForwardAE(ForwardAE), 
									.ForwardBE(ForwardBE)
);
endmodule

