# MIPS Verilog

Implementação de um sub-conjunto das instruções do MIPS 32 em Verilog.

![MIPS](imgs/MIPS.png)

## Principais Módulos

### MIPS Top-level

O Módulo MIPS contém a organização de todos os outros módulos (além da definição de módulos auxiliares) abstraindo o funcionamento do processador MIPS monociclo proposto.

| | |
| --- | --- |
| **CLK** (entrada) | Representa o clock |
| **RST** (entrada) | Indica se os registradores devem ser limpos (assíncrono) |
| **PC** (saída, 32-bits) | Indica o valor do PC atual |
| **ALUResult** (saída, 32-bits) | Indica o valor produzido na saída da ALU |
| **MemData** (saída, 32-bits) | Indica o valor de saída da memória de dados |

### Program Counter (PC)

O módulo PC é extremamente simples e é responsável pelas atualizações do PC ao longo da execução do processador.

```verilog
module PC(input Clock, 
          input [31:0] NextPC, 
          output reg [31:0] PC);

always @(posedge Clock) begin
  PC <= NextPC;
end

endmodule
```

### Register File (regfile)

O módulo regfile é responsável por armazenar os 32 registradores disponíveis aos processadores MIPS. Inicialmente, todos os registradores possuem valor $0$ e qualquer registrador pode ser acessado.

```verilog
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

// ....
// ....

endmodule
```

### Instruction Memory (i_mem) e Data Memory (d_mem)

Ambos os módulos são implementadas como RAM's assíncronas simples que servem para o armazenamento de instruções e dados, respectivamente.

Em especial, a memória de instruções deve ser pré-carregada através de um arquivo com as instruções MIPS (em binário, 1 por linho). O nome padrão do arquivo é *instruction.list*, mas que pode ser alterado ao depender do cenário.

```verilog
module i_mem(
        input [31:0] address ,
        output reg [31:0] i_out
    );

    reg [31:0] instructions [255:0];

    initial begin
        $readmemb("instruction.list", instructions);
    end

    always @ (address) begin
        i_out = instructions[address >> 2]; /* Valores são múltiplos de 4 */
    end

endmodule

```

A memória de dados é bem similar, optamos por manter um pequeno espaço de memória e utilizar $256$ células endereçáveis que armazenam $32$ bits.

```verilog
module d_mem(
      input MemWrite,
      input MemRead,
      input [31:0] Address,
      input [31:0] WriteData,
      output [31:0] ReadData);

    // Memória RAM
    reg [31:0] RAM [255:0];
  
    // ....
    // ....

    // Leitura dos dados
    assign ReadData = (MemRead == 0) ? 32'b0 : RAM[Address];

endmodule
```

### Unidade de Controle (ctrl)

### Controle da ULA (ula_ctrl)

### Unidade Lógica e Aritmética (ULA/ALU)

---
*Requisitos e mais informações sobre o projeto podem ser encontradas na pasta de [documentação](docs) desse repositório.*

Algumas referências utilizadas para a produção desse projeto podem ser encontradas em:

- [HARDWARE MODELLING OF A 32-BIT, SINGLE CYCLE RISC PROCESSOR USING VHDL](https://www.researchgate.net/publication/301694967_HARDWARE_MODELLING_OF_A_32-BIT_SINGLE_CYCLE_RISC_PROCESSOR_USING_VHDL)
- [Verilog Code for 16-bit RISC Processor](https://www.fpga4student.com/2017/04/verilog-code-for-16-bit-risc-processor.html)
- https://github.com/jmahler/mips-cpu
- https://github.com/mohamed-minawi/MIPS-Processor-Verilog
- https://github.com/ahegazy/mips-cpu