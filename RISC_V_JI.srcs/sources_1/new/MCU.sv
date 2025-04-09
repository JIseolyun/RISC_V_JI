`timescale 1ns / 1ps
// MCU.sv
module MCU (
    input logic clk,
    input logic reset
);
    logic [31:0] instrCode;
    logic [31:0] instrMemAdder;
    logic        dataWe;
    logic [31:0] dataAddr;
    logic [31:0] dataWData;

    RV32I_Core U_Core (.*);

    rom U_ROM (
        .addr(instrMemAdder),
        .data(instrCode)
    );

    ram U_RAM (
        .clk  (clk),
        .we   (dataWe),
        .addr (dataAddr),
        .wData(dataWData),
        .rData()
    );
endmodule
