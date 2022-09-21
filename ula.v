module alu(
        input		[3:0]	OP,
        input		[31:0]	ln1, ln2,
        output reg	[31:0]	result,
        output				Zero_flag);

    assign Zero_flag = (0 == result);

    always @(*) begin
        case (OP)
            4'b0000: result <= ln1 + ln2;				/* add */
            4'b1000: result <= ln1 & ln2;				/* and */
            4'b1011: result <= ~(ln1 | ln2);				/* nor */
            4'b1001: result <= ln1 | ln2;				/* or */
            4'b0001: result <= ln1 - ln2;					/* sub */
            4'b1010: result <= ln1 ^ ln2;				/* xor */
            4'b0100: result <= ln1<<1;           /*logical shift left*/
            4'b1100: result <= ln1>>1;				 /*logical shift right*/
            4'b1110: result <= (ln1>ln2)? 32'd1: 32'd0 ;			 /* comparison*/
            4'b1111: result <= (ln1==ln2)? 32'd1: 32'd0 ;  		 /* equal comparison*/

            default: result <= 0;
        endcase
    end

endmodule
