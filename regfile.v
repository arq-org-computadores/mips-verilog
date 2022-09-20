// Esse módulo implementa um regfile

module regfile (
        input Clock,
        input Reset,
        input RegWrite,
        input [4:0] ReadAddr1,
        input [4:0] ReadAddr2,
        input [4:0] WriteAddr,
        input [31:0] WriteData,
        output [31:0] ReadData1,
        output [31:0] ReadData2);

    // 32 Registradores de 32 bits
    reg [31:0] Registers [31:0];

    // Inteiro auxiliar para fazer o loop
    //  nos registradores
    integer i;

    always @(posedge Clock or posedge Reset) begin
        if(Reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                Registers[i] <= 32'b0;
            end
        end
        else begin
            if(RegWrite && WriteAddr != 32'b0) begin
                Registers[WriteAddr] <= WriteData;
            end
        end
    end

    assign ReadData1 = (ReadAddr1 == 0) ? 32'b0 : Registers[ReadAddr1];
    assign ReadData2 = (ReadAddr2 == 0) ? 32'b0 : Registers[ReadAddr2];
endmodule
