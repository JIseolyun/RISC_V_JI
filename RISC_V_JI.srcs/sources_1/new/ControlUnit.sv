`timescale 1ns / 1ps
// ControlUnit.sv

`include "defines.sv"
module ControlUnit (
    input  logic [31:0] instrCode,
    output logic        regFileWe,
    output logic [ 3:0] aluControl,
    output logic        aluSrcMuxSel,
    output logic        dataWe
);
    wire [6:0] opcode = instrCode[6:0];
    wire [3:0] operators = {
        instrCode[30], instrCode[14:12]
    };  // {funct7[5], funct3}
    //regFileWe 읽기 동작할때는 0
    logic [2:0] signals;
    assign {regFileWe, aluSrcMuxSel, dataWe, RAMSrcMuxSel} = signals;
    always_comb begin
        signals = 4'b0;
        case (opcode)
        // {regFileWe, aluSrcMuxSel, dataWe} = signals;
            `OP_TYPE_R: signals = 4'b1_0_0_0;
            `OP_TYPE_S: signals = 4'b0_1_1_0;
            `OP_TYPE_L: signals = 4'b1_1_0_1;
        endcase
    end

    always_comb begin
        aluControl = 4'bx;
        case (opcode)
            `OP_TYPE_R: aluControl = operators;  // {funct7[5], funct3}
            `OP_TYPE_S: aluControl = `ADD;
        endcase
    end
endmodule
