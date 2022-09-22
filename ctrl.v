// Módulo de controle que suporta todas as instruções solicitadas.
/* Referências:
- https://www.d.umn.edu/~gshute/mips/control-signal-summary.html
- https://courses.cs.washington.edu/courses/cse378/09wi/lectures/lec08.pdf
*/

module ctrl(
        input [5:0] opcode,
        output reg [2:0] ALUOp,
        output reg [1:0] RegDst,
        ALUSrc,
        output reg MemToReg,
        MemWrite,
        MemRead,
        RegWrite,
        Jal,
        Jump,
        BranchNe,
        Branch);

    always @(*)
    begin
        case(opcode)
            // sll, srl, sra, sllv, srlv, srav, jr, add,
            // sub, and, or, xor, nor, slt, sltu
            6'd0: begin
                ALUOp <= 3'b110;
                MemToReg <= 1'b0;
                RegDst <= 2'b01;
                ALUSrc <= 2'b00;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd4: begin // beq
                ALUOp <= 3'b001;
                MemToReg <= 1'bX;
                RegDst <= 2'bXX;
                ALUSrc <= 2'b00;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b0;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b1;
            end
            6'd5: begin // bne
                ALUOp <= 3'b001;
                MemToReg <= 1'bX;
                RegDst <= 2'bXX;
                ALUSrc <= 2'b00;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b0;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b1;
                Branch <= 1'b0;
            end
            6'd8: begin // addi
                ALUOp <= 3'b000;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b01;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd10: begin // slti
                ALUOp <= 3'b101;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b01;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd11: begin // sltiu
                ALUOp <= 3'b101;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b01;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd12: begin // andi
                ALUOp <= 3'b010;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b10;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd13: begin // ori
                ALUOp <= 3'b011;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b10;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd14: begin // xori
                ALUOp <= 3'b100;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b10;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd15: begin // lui
                ALUOp <= 3'b000;
                MemToReg <= 1'b0;
                RegDst <= 2'b00;
                ALUSrc <= 2'b11;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd35: begin // lw
                ALUOp <= 3'b000;
                MemToReg <= 1'b1;
                RegDst <= 2'b00;
                ALUSrc <= 2'b01;
                MemWrite <= 1'b0;
                MemRead <= 1'b1;
                RegWrite <= 1'b1;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd43: begin // sw
                ALUOp <= 3'b000;
                MemToReg <= 1'bX;
                RegDst <= 2'bXX;
                ALUSrc <= 2'b01;
                MemWrite <= 1'b1;
                MemRead <= 1'b0;
                RegWrite <= 1'b0;
                Jal <= 1'b0;
                Jump <= 1'b0;
                BranchNe <= 1'b0;
                Branch <= 1'b0;
            end
            6'd2: begin // j
                ALUOp <= 3'bXXX;
                MemToReg <= 1'bX;
                RegDst <= 2'bXX;
                ALUSrc <= 2'bXX;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b0;
                Jal <= 1'b0;
                Jump <= 1'b1;
                BranchNe <= 1'bX;
                Branch <= 1'bX;
            end
            6'd3: begin // jal
                ALUOp <= 3'bXXX;
                MemToReg <= 1'bX;
                RegDst <= 2'b10;
                ALUSrc <= 2'bXX;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                RegWrite <= 1'b1;
                Jal <= 1'b1;
                Jump <= 1'b1;
                BranchNe <= 1'bX;
                Branch <= 1'bX;
            end
        endcase
    end
endmodule
