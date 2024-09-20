module decoder_cycle 
(input logic clk,rst,
input logic [31:0] InstrD,PCD, PCPlus4D,
input logic  [31:0] ResultW,
input logic [4:0] RdW,
input logic RegWriteW,
output logic RegWriteE,ALUSrcE,MemWriteE,BranchE,JumpE,
output logic [1:0] ResultSrcE,
output logic [2:0]ALUControlE,
output logic [31:0] RD1E,RD2E,
output logic [31:0] PCE,
output logic [4:0] Rs1E,Rs2E,RdE,
output logic [31:0] ImmExtE,PCPlus4E
);
//wrie
logic [31:0] RD1D,RD2D,ImmExtD;
logic RegWriteD,ALUSrcD,MemWriteD,BranchD,JumpD;
logic [1:0]ImmSrcD,ResultSrcD;
logic [2:0]ALUControlD;
//register 
logic Reg_RegWriteD,Reg_ALUSrcD,Reg_MemWriteD,Reg_BranchD,Reg_JumpD;
logic [1:0] Reg_ResultSrcD;
logic [2:0] Reg_ALUControlD;
logic [31:0] Reg_RD1D,Reg_RD2D;
logic [31:0] Reg_PCD;
logic [4:0] Reg_Rs1D,Reg_Rs2D,Reg_RdD;
logic [31:0] Reg_ImmExtD,Reg_PCPlus4D;
// Control_Unit
Control_Unit_Top Pipe_control(.Op(InstrD[6:0]),
										.RegWrite(RegWriteD),
										.ImmSrc(ImmSrcD),
										.ALUSrc(ALUSrcD),
										.MemWrite(MemWriteD),
										.ResultSrc(ResultSrcD),
										.Branch(BranchD),
										.Jump(JumpD),
										.funct3(InstrD[14:12]),
										.funct7(InstrD[31:25]),
										.ALUControl(ALUControlD));

//Register_File
Register_File Pipe_RegFile	 (	.clk(clk),
										.rst(rst),
										.WE3(RegWriteW),
										.WD3(ResultW),
										.A1(InstrD[19:15]),
										.A2(InstrD[24:20]),
										.A3(RdW),
										.RD1(RD1D),
										.RD2(RD2D) );
//Extend				
Sign_Extend Pipe_Extend 	 (	.In(InstrD[31:0]),
										.ImmSrc(ImmSrcD),
										.Imm_Ext(ImmExtD));
//sysnom
always_ff @(posedge clk or negedge rst) begin
	if (rst==1'b0) begin
			Reg_RegWriteD <= 1'b0;
			Reg_ALUSrcD <= 1'b0;
			Reg_MemWriteD <= 1'b0;
			Reg_BranchD <= 1'b0;
			Reg_JumpD <= 1'b0;
			Reg_ResultSrcD <= 2'b00;
			Reg_ALUControlD <= 3'b000;
			Reg_RD1D <= 32'h00000000;
			Reg_RD2D <= 32'h00000000;
			Reg_PCD  <= 32'h00000000;
			Reg_Rs1D <= 5'b00000;
			Reg_Rs2D <= 5'b00000;
			Reg_RdD  <= 5'b00000;
			Reg_ImmExtD <= 32'h00000000;
			Reg_PCPlus4D <= 32'h00000000;
			end
else begin				
			Reg_RegWriteD <= RegWriteD;
			Reg_ALUSrcD <= ALUSrcD;
			Reg_MemWriteD <= MemWriteD;
			Reg_BranchD <= BranchD;
			Reg_JumpD <= JumpD;
			Reg_ResultSrcD <= ResultSrcD;
			Reg_ALUControlD <= ALUControlD;
			Reg_RD1D <= RD1D;
			Reg_RD2D <= RD2D;
			Reg_PCD  <= PCD;
			Reg_Rs1D <= InstrD[19:15];
			Reg_Rs2D <= InstrD[24:20];
			Reg_RdD  <= InstrD[11:7];
			Reg_ImmExtD <= ImmExtD;
			Reg_PCPlus4D <= PCPlus4D;
end
end
assign 			RegWriteE = Reg_RegWriteD;
assign			ALUSrcE = Reg_ALUSrcD; 
assign			MemWriteE = Reg_MemWriteD;
assign			BranchE = Reg_BranchD;
assign			JumpE = Reg_JumpD; 
assign			ResultSrcE = Reg_ResultSrcD; 
assign			ALUControlE = Reg_ALUControlD; 
assign			RD1E = Reg_RD1D;
assign			RD2E = Reg_RD2D; 
assign			PCE = Reg_PCD;  
assign			Rs1E = Reg_Rs1D; 
assign			Rs2E = Reg_Rs2D; 
assign			RdE = Reg_RdD;  
assign			ImmExtE = Reg_ImmExtD; 
assign			PCPlus4E = Reg_PCPlus4D; 
endmodule
										
