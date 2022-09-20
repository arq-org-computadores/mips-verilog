module PC(input Clock, input [31:0] NextPC, output reg [31:0] PC);

always @(posedge Clock) begin
  PC <= NextPC;
end

endmodule