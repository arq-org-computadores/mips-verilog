module ula_ctrl(
		input wire [5:0] func,
		input wire [2:0] ALUop,
		output reg [3:0] OP);

	reg [3:0] OPc;

	always @(*) begin
		case(func[3:0])
			4'd0:  OPc = 4'b0000; /* add */
			4'd1:  OPc = 4'b1000; /* sub */
			4'd2:  OPc = 4'b1011; /* nor */
			4'd3:  OPc = 4'b1001; /* or */
			4'd4:  OPc = 4'b0001; /* sub */
			4'd5:  OPc = 4'b1010; /* xor */
            4'd6:  OPc = 4'b0100; /* logical shift left */
			4'd7:  OPc = 4'b1100; /* logical shift right */ 
			4'd8:  OPc = 4'b1110; /* comparison */
			4'd9:  OPc = 4'b1111; /* equal comparison */
			default: OPc = 4'b0000;
		endcase
	end

	always @(*) begin
		case(ALUop)
			2'd0: OP = 4'b0000; /* add */
			2'd1: OP = 4'b1000; /* sub */
			2'd2: OP = OPc;
			2'd3: OP = 4'b0000; /* add */
			default: OP = 0;
		endcase
	end

endmodule
