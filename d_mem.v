/* Esse módulo implementa uma memória de dados
  Vamos utilizar o layout do MIPS presente descrito em: 
    http://www.it.uu.se/education/course/homepage/os/vt18/module-0/mips-and-mars/mips-memory-layout/
*/

module d_mem(
      input MemWrite,
      input MemRead,
      input [31:0] Address,
      input [31:0] WriteData,
      output [31:0] ReadData);

    // Memória RAM
    reg [31:0] RAM [255:0];

    // Inteiro auxiliar para fazer o loop 
    //  nas células de memória
    integer i;
    

    initial begin
      for (i = 0; i < 256; i = i + 1) begin
        RAM[i] <= 32'b0;
      end
    end

    // Escrita na memória
    always @(*) begin
      if (MemWrite) begin
        RAM[Address] <= WriteData;
      end
    end 

    // Leitura dos dados
    assign ReadData = (MemRead == 0) ? 32'b0 : RAM[Address];

endmodule