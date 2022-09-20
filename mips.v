/* Multiplexador de 4 entradas de 32 bits
    com seleção de 2 bits e produzindo
    saída de 32 bits. */

module mux_4_to_1(input [31:0] a,
                      b,
                      c,
                      d,
                      input [1:0] sel,
                      output [31:0] out);

    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);

endmodule


module MIPS(
        input CLK,
        input RST,
        output reg [31:0] PCOut,
        output reg [31:0] ALUResult);

    wire [31:0] PC;
    wire [31:0] instr;

    // PC = nextPC
    PC pc_module(CLK, ,.PC());

    assign PCOut = PC;

endmodule
