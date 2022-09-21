module ula_ctrl(
        input wire [5:0] funct,
        input wire [2:0] ALUOp,
        output Jr,
        output reg [3:0] OP);

    reg [3:0] OPc;

    always @(*) begin
        case(funct)
            6'b100000, 6'b100001: OPc = 4'b0000; /* add */
            6'b100010, 6'b100011: OPc = 4'b0001; /* sub */
            6'b100100: OPc = 4'b1000; /* and */
            6'b100111: OPc = 4'b1011; /* nor */
            6'b100101: OPc = 4'b1001; /* or */
            6'b100010, 6'b100011: OPc = 4'b0001; /* sub */
            6'b100110: OPc = 4'b1010; /* xor */
            6'b000000, 6'b000100: OPc = 4'b0100; /* logical shift left */
            6'b000010, 6'b000111, 6'b000110: OPc = 4'b1100; /* logical shift right */
            6'b101010, 6'b101011: OPc = 4'b1110; /* comparison */
            default: OPc = 4'b0000; /* defaults to add */
        endcase
    end

    always @(*) begin
        case(ALUOp)
            3'b000: OP = 4'b0000; /* add */
            3'b001: OP = 4'b0001; /* sub */
            3'b010: OP = 4'b1000; /* and */
            3'b011: OP = 4'b1001; // or
            3'b100: OP = 4'b1010; // xor
            3'b101: OP = 4'b1110; // slt
            3'b110: OP = OPc; // check funct
            3'b111: OP = 4'b0000; /* N/A, defaults to add */
            default: OP = 4'b0000; /* defaults to add */
        endcase
    end

    assign Jr = (ALUOp == 3'b110) ? ((funct == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;

endmodule
