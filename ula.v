module ula(
        input		[3:0]	OP,
        input		[31:0]	In1, In2,
        output reg	[31:0]	result,
        output				Zero_flag);

    assign Zero_flag = (result == 0);

    always @(*) begin
        case (OP)
            4'b0000: result <= In1 + In2; /* add */
            4'b0001: result <= In1 - In2; /* sub */
            4'b0010: result <=  ($signed(In1) < $signed(In2)) ? 32'd1 : 32'd0; /* slt */
            4'b0011: result <= In1 & In2; /* and */
            4'b0100: result <= ~(In1 | In2); /* nor */
            4'b0101: result <= In1 | In2; /* or */
            4'b0110: result <= In1 ^ In2; /* xor */
            4'b0111: result <= In1 << (In2); /* shift left */
            4'b1000: result <= In1 >>> (In2); /* signed shift right*/
            4'b1001: result <= In1 >> (In2); /* unsigned shift right*/
            4'b1010: result <= (In1 < In2) ? 32'd1 : 32'd0 ; /* sltu */	

            default: result <= 0;
        endcase
    end

endmodule
