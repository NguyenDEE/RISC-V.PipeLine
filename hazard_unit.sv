module hazard_unit (
input rst,
input logic [4:0] Rs1E,Rs2E,RdM,RdW,
input logic RegWriteM,RegWriteW,
output logic [1:0] ForwardAE, ForwardBE
);
assign ForwardAE = (rst==1'b0) ? 2'b00:
						((RdM==Rs1E)&(RegWriteM==1'b1)&(RdM!=5'h00))? 2'b10:
						((RdW==Rs1E)&(RegWriteW==1'b1)&(RdW!=5'h00))? 2'b01: 2'b00;
assign ForwardBE = (rst==1'b0) ? 2'b00:
						((RdM==Rs2E)&(RegWriteM==1'b1)&(RdM!=5'h00))? 2'b10:
						((RdW==Rs2E)&(RegWriteW==1'b1)&(RdW!=5'h00))? 2'b01: 2'b00;
endmodule
