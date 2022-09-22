module i_mem(
        input		[31:0]	address ,
        output reg		[31:0]	i_out
    );

    reg [31:0] instructions [255:0];

    initial begin
        $readmemb("instruction.list", instructions);
    end

    always @ (address) begin
        i_out = instructions[address >> 2]; /* Valores são múltiplos de 4 */
    end

endmodule
