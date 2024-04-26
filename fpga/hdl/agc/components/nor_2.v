`timescale 1ns/1ps
`default_nettype none

module nor_2(y, a, b, rst, clk);
    parameter delay = 9;
    parameter iv = 1'b0;
    input wire a, b, rst, clk;

    output reg y = iv;
    reg next_val = iv;
    reg prev_val = iv;
    wire result;
    
    assign result = ~(a|b);

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            prev_val = iv;
            y = iv;
        end else begin
            prev_val = y;
            y = next_val;
        end
    end

    always @(negedge clk or posedge rst)
    begin
        if (rst) begin
            next_val = iv;
        end else begin
            next_val = ((result == prev_val) && (y == iv)) ? iv : result;
        end
    end
endmodule
`default_nettype wire
