module Main_Decoder(
    input [6:0]Op,
    output RegWrite,ALUSrc,MemWrite,Branch,Jump,
    output [1:0]ImmSrc,ALUOp,ResultSrc);
	 logic [10:0] controls;
	 //
	 assign  {RegWrite, ImmSrc, ALUSrc, 
			Branch, MemWrite, ResultSrc,
			Jump, ALUOp} = controls;
			//
always_comb begin
case(Op)
// regwrite_immsrc_alusrc_branch_memwrite_memtoreg_jump_aluop
7'b0110011: controls <= 11'b1_xx_0_0_0_00_0_10; // R-type data processing
7'b0010011: controls <= 11'b1_00_1_0_0_00_0_10; // I-type data processing
7'b0000011: controls <= 11'b1_00_1_0_0_01_0_00; // LW
7'b0100011: controls <= 11'b0_01_1_0_1_00_0_00; // SW
7'b1100011: controls <= 11'b0_10_0_1_0_00_0_01; // BEQ
7'b1101111: controls <= 11'b1_11_0_0_0_10_1_00; // JAL
default: controls <= 11'b00000000000; //777
endcase
end
endmodule
