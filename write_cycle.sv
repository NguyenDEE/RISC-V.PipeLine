module write_cycle
(
input clk,rst,
input logic [1:0] ResultSrcW,
input logic [31:0] ALUResultW,ReadDataW,
input logic [31:0] PCPlus4W,
output logic [31:0] ResultW
);
 Mux_3_by_1 Mux_Write (			.a(ALUResultW),
										.b(ReadDataW),
										.c(PCPlus4W),
										.s(ResultSrcW),
										.d(ResultW)
										);
endmodule


