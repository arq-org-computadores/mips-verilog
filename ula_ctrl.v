module ula_ctrl(
        input wire [5:0] funct,
        input wire [2:0] ALUOp,
        output Jr,
        Shamt,
        output reg [3:0] OP);

    reg [3:0] OPc;

    always @(*) begin
        case(funct)
            /* instrução add ou jr */
            6'b100000: OPc = 4'b0000; /* operação alu: add */
            
            /* instrução sub */
            6'b100010: OPc = 4'b0001; /* operação alu: sub */
            
            /* instrução and */
            6'b100100: OPc = 4'b0011; /* operação alu: and */
            
            /* instrução nor */
            6'b100111: OPc = 4'b0100; /* operação alu: nor */
            
            /* instrução or */
            6'b100101: OPc = 4'b0101; /* operação alu: or */
           
            /* instrução xor */
            6'b100110: OPc = 4'b0110; /* operação alu: xor */
            
            /* instrução sll ou sllv*/
            6'b000000, 6'b000100: OPc = 4'b0111; /* operação alu: shift left */
            
            /* instrução srl ou srlv*/
            6'b000010, 6'b000110: OPc = 4'b1001; /* operação alu: unsigned shift right */
            
            /* instrução sra ou srav */
            6'b000011, 6'b000111: OPc = 4'b1000; /* operação alu: signed shift right*/

            /* instrução slt */
            6'b101010: OPc = 4'b0010; /* operação alu: slt */

            /* instrução sltu */
            6'b101011: OPc = 4'b1010; /* operação alu: sltu */
            
            default: OPc = 4'b0000;
        endcase
    end

    always @(*) begin
        case(ALUOp)
            3'b000: OP = 4'b0000; /* add */
            3'b001: OP = 4'b0001; /* sub */
            3'b010: OP = 4'b1000; /* and */
            3'b011: OP = 4'b1001; /* or */
            3'b100: OP = 4'b1010; /* xor */
            3'b101: OP = 4'b0010; /* slt */
            3'b110: OP = OPc; /* obtém do funct */
            3'b111: OP = 4'b1010; /* sltu */
            default: OP = 4'b0000; /* padrão para add */
        endcase
    end

    assign Jr = (ALUOp == 3'b110) ? ((funct == 6'b001000) ? 1'b1 : 1'b0) : 1'b0;
    assign Shamt = (ALUOp == 3'b110) ? ((funct == 6'b000000 || funct == 6'b000010 || funct == 6'b000011) ? 1'b1 : 1'b0) : 1'b0;

endmodule
