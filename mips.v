module Mux_4x1_NBits #(
        parameter Bits = 2
    )
    (
        input [1:0] sel,
        input [(Bits - 1):0] in_0,
        input [(Bits - 1):0] in_1,
        input [(Bits - 1):0] in_2,
        input [(Bits - 1):0] in_3,
        output reg [(Bits - 1):0] out
    );
    always @ (*) begin
        case (sel)
            2'h0: out = in_0;
            2'h1: out = in_1;
            2'h2: out = in_2;
            2'h3: out = in_3;
            default:
                out = 'h0;
        endcase
    end
endmodule

module Mux_2x1_NBits #(
        parameter Bits = 2
    )
    (
        input [0:0] sel,
        input [(Bits - 1):0] in_0,
        input [(Bits - 1):0] in_1,
        output reg [(Bits - 1):0] out
    );
    always @ (*) begin
        case (sel)
            1'h0: out = in_0;
            1'h1: out = in_1;
            default:
                out = 'h0;
        endcase
    end
endmodule

module adder32_0(
        input [31:0] a,
        b,
        output [31:0] out);

    assign out = a + b;
endmodule

module DIG_BitExtender #(
        parameter inputBits = 2,
        parameter outputBits = 4
    )
    (
        input [(inputBits-1):0] in,
        output [(outputBits - 1):0] out
    );
    assign out = {{(outputBits - inputBits){in[inputBits - 1]}}, in};
endmodule


module shifter32(
        input [31:0] a,
        shamt,
        output [31:0] out);

    assign out = a << shamt;
endmodule

module adder32_1(
        input [31:0] a,
        b,
        output [31:0] out);

    assign out = a + b;
endmodule

module MIPS (
        input CLK,
        input RST,
        output [31:0] PC,
        output [31:0] ALUResult,
        output [31:0] MemData
    );
    wire [31:0] PC_temp;
    wire [31:0] NextPC;
    wire [5:0] opcode;
    wire [2:0] ALUOp;
    wire [1:0] RegDst;
    wire [1:0] ALUSrc;
    wire MemToReg;
    wire MemWrite;
    wire MemRead;
    wire RegWrite;
    wire Jal;
    wire Jump;
    wire BranchNe;
    wire Branch;
    wire [31:0] instr;
    wire [25:0] j_address;
    wire [15:0] immediate;
    wire [4:0] s0;
    wire [4:0] s1;
    wire [5:0] funct;
    wire [4:0] shamt;
    wire [4:0] rd;
    wire [4:0] RegWAddr;
    wire [31:0] RegWD;
    wire [31:0] RegData1;
    wire [31:0] s2;
    wire [31:0] ALUResult_temp;
    wire [31:0] MemData_temp;
    wire PCSrc;
    wire [31:0] PCPlus4;
    wire [31:0] PCBranch;
    wire [31:0] NPC0;
    wire [31:0] PCJump;
    wire [31:0] NPC1;
    wire JumpRegister;
    wire [31:0] ALUMem;
    wire [3:0] Op;
    wire [31:0] In1;
    wire [31:0] In2;
    wire zero;
    wire UseShamt;
    wire [27:0] s_j_addr;
    wire [59:0] s3;
    wire [31:0] sign_imm;
    wire [31:0] zero_imm;
    wire [31:0] branch_offset;
    wire [31:0] upper_imm;
    wire [31:0] sign_shamt;

    // regfile
    regfile regfile_i0 (
                .Clock( CLK ),
                .Reset( RST ),
                .RegWrite( RegWrite ),
                .ReadAddr1( s1 ),
                .ReadAddr2( s0 ),
                .WriteAddr( RegWAddr ),
                .WriteData( RegWD ),
                .ReadData1( RegData1 ),
                .ReadData2( s2 )
            );

    // d_mem
    d_mem d_mem_i1 (
              .MemWrite( MemWrite ),
              .MemRead( MemRead ),
              .Address( ALUResult_temp ),
              .WriteData( s2 ),
              .ReadData( MemData_temp )
          );

    Mux_4x1_NBits #(
                      .Bits(32)
                  )
                  Mux_4x1_NBits_i2 (
                      .sel( ALUSrc ),
                      .in_0( s2 ),
                      .in_1( sign_imm ),
                      .in_2( zero_imm ),
                      .in_3( upper_imm ),
                      .out( In2 )
                  );


    Mux_2x1_NBits #(
                      .Bits(32)
                  )
                  Mux_2x1_NBits_i3 (
                      .sel( UseShamt ),
                      .in_0( RegData1 ),
                      .in_1( sign_shamt ),
                      .out( In1 )
                  );


    // ula
    ula ula_i4 (
            .OP( Op ),
            .In1( In1 ),
            .In2( In2 ),
            .result( ALUResult_temp ),
            .Zero_flag( zero )
        );


    Mux_2x1_NBits #(
                      .Bits(32)
                  )
                  Mux_2x1_NBits_i5 (
                      .sel( MemToReg ),
                      .in_0( ALUResult_temp ),
                      .in_1( MemData_temp ),
                      .out( ALUMem )
                  );


    Mux_2x1_NBits #(
                      .Bits(32)
                  )
                  Mux_2x1_NBits_i6 (
                      .sel( JumpRegister ),
                      .in_0( NPC1 ),
                      .in_1( ALUMem ),
                      .out( NextPC )
                  );

    assign PCSrc = ((~ zero & BranchNe) | (zero & Branch));

    Mux_2x1_NBits #(
                      .Bits(32)
                  )
                  Mux_2x1_NBits_i7 (
                      .sel( Jal ),
                      .in_0( ALUMem ),
                      .in_1( PCPlus4 ),
                      .out( RegWD )
                  );

    // PC
    PC PC_i8 (
           .Clock( CLK ),
           .NextPC( NextPC ),
           .PC( PC_temp )
       );

    // i_mem
    i_mem i_mem_i9 (
              .address( PC_temp ),
              .i_out( instr )
          );

    // adder32_0
    adder32_0 adder32_0_i10 (
                  .a( PC_temp ),
                  .b( 32'b1 ),
                  .out( PCPlus4 )
              );

    assign j_address = instr[25:0];
    assign opcode = instr[31:26];

    // ctrl
    ctrl ctrl_i11 (
             .opcode( opcode ),
             .ALUOp( ALUOp ),
             .RegDst( RegDst ),
             .ALUSrc( ALUSrc ),
             .MemToReg( MemToReg ),
             .MemWrite( MemWrite ),
             .MemRead( MemRead ),
             .RegWrite( RegWrite ),
             .Jal( Jal ),
             .Jump( Jump ),
             .BranchNe( BranchNe ),
             .Branch( Branch )
         );

    assign s_j_addr[25:0] = j_address;
    assign s_j_addr[27:26] = 2'b0;
    assign immediate = j_address[15:0];
    assign s0 = j_address[20:16];
    assign s1 = j_address[25:21];
    assign s3[27:0] = s_j_addr;
    assign s3[59:28] = PCPlus4;

    DIG_BitExtender #(
                        .inputBits(16),
                        .outputBits(32)
                    )
                    DIG_BitExtender_i12 (
                        .in( immediate ),
                        .out( sign_imm )
                    );

    assign zero_imm[15:0] = immediate;
    assign zero_imm[31:16] = 16'b0;
    assign upper_imm[15:0] = immediate;
    assign upper_imm[31:16] = 16'b0;
    assign funct = immediate[5:0];
    assign shamt = immediate[10:6];
    assign rd = immediate[15:11];

    // ula_ctrl
    ula_ctrl ula_ctrl_i13 (
                 .funct( funct ),
                 .ALUOp( ALUOp ),
                 .Jr( JumpRegister ),
                 .Shamt( UseShamt ),
                 .OP( Op )
             );

    Mux_4x1_NBits #(
                      .Bits(5)
                  )
                  Mux_4x1_NBits_i14 (
                      .sel( RegDst ),
                      .in_0( s0 ),
                      .in_1( rd ),
                      .in_2( 5'b1 ),
                      .in_3( 5'b0 ),
                      .out( RegWAddr )
                  );

    DIG_BitExtender #(
                        .inputBits(5),
                        .outputBits(32)
                    )
                    DIG_BitExtender_i15 (
                        .in( shamt ),
                        .out( sign_shamt )
                    );

    // shifter32
    shifter32 shifter32_i16 (
                  .a( sign_imm ),
                  .shamt( 32'b10 ),
                  .out( branch_offset )
              );

    assign PCJump = s3[31:0];

    // adder32_1
    adder32_1 adder32_1_i17 (
                  .a( PCPlus4 ),
                  .b( branch_offset ),
                  .out( PCBranch )
              );

    Mux_2x1_NBits #(
                      .Bits(32)
                  )
                  Mux_2x1_NBits_i18 (
                      .sel( PCSrc ),
                      .in_0( PCPlus4 ),
                      .in_1( PCBranch ),
                      .out( NPC0 )
                  );

    Mux_2x1_NBits #(
                      .Bits(32)
                  )
                  Mux_2x1_NBits_i19 (
                      .sel( Jump ),
                      .in_0( NPC0 ),
                      .in_1( PCJump ),
                      .out( NPC1 )
                  );

    assign PC = PC_temp;
    assign ALUResult = ALUResult_temp;
    assign MemData = MemData_temp;
endmodule
