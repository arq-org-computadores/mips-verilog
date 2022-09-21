module alu(
        input		[3:0]	OP,
        input		[31:0]	In1, In2,
        output reg	[31:0]	result,
        output				Zero_flag);

    assign Zero_flag = (result == 0);

    always @(*) begin
        case (OP)
            4'b0000: result <= In1 + In2;				/* add */
            4'b1000: result <= In1 & In2;				/* and */
            4'b1011: result <= ~(In1 | In2);				/* nor */
            4'b1001: result <= In1 | In2;				/* or */
            4'b0001: result <= In1 - In2;					/* sub */
            4'b1010: result <= In1 ^ In2;				/* xor */
            4'b0100: result <= In1 << (In2);           /*logical shift left*/
            4'b1100: result <= In1 >> (In2);				 /*logical shift right*/
            4'b1110: result <= (In1 > In2)? 32'd1: 32'd0 ;			 /* comparison*/
            4'b1111: result <= (In1 == In2)? 32'd1: 32'd0 ;  		 /* equal comparison*/

            default: result <= 0;
        endcase
    end

endmodule
