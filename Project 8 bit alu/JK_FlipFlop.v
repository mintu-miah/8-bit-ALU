module JK_FlipFlop (
    input J, K, clk, reset,
    output reg Q, Qn
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 0;
            Qn <= 1;
        end else begin
            case ({J, K})
                2'b00: ; // No change
                2'b01: Q <= 0;
                2'b10: Q <= 1;
                2'b11: Q <= ~Q;
            endcase
            Qn <= ~Q;
        end
    end
endmodule
