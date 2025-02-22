module Sequential_ALU (
    input [7:0] A, B,
    input [3:0] ALU_Sel,
    input J, K, clk, reset, // Inputs for JK flip-flop
    output reg [15:0] ALU_Out,
    output reg Zero,
    output reg [6:0] seg, // 7-segment display output
    output Q, Qn // Outputs from JK flip-flop
);

// Instantiate the JK flip-flop
JK_FlipFlop jk_ff (
    .J(J),
    .K(K),
    .clk(clk),
    .reset(reset),
    .Q(Q),
    .Qn(Qn)
);

always @(*) begin
    case (ALU_Sel)
        4'b0000: ALU_Out = A + B; // Addition
        4'b0001: ALU_Out = A - B; // Subtraction
        4'b0010: ALU_Out = A * B; // Multiplication
        4'b0011: ALU_Out = A / B; // Division
        4'b0100: ALU_Out = A & B; // AND
        4'b0101: ALU_Out = A | B; // OR
        4'b0110: ALU_Out = A ^ B; // XOR
        4'b0111: ALU_Out = ~A;    // NOT
        4'b1000: ALU_Out = A << 1; // Left Shift
        4'b1001: ALU_Out = A >> 1; // Right Shift
        4'b1010: ALU_Out = (A > B) ? 16'b1 : 16'b0; // Greater Than
        4'b1011: ALU_Out = (A < B) ? 16'b1 : 16'b0; // Less Than
        4'b1100: ALU_Out = (A == B) ? 16'b1 : 16'b0; // Equal To
        default: ALU_Out = 16'b0; // Default case
    endcase

    // Zero flag
    if (ALU_Out == 16'b0)
        Zero = 1;
    else
        Zero = 0;

    // 7-segment display logic (example for displaying ALU_Out[3:0])
    case (ALU_Out[3:0])
        4'b0000: seg = 7'b1000000; // 0
        4'b0001: seg = 7'b1111001; // 1
        4'b0010: seg = 7'b0100100; // 2
        4'b0011: seg = 7'b0110000; // 3
        4'b0100: seg = 7'b0011001; // 4
        4'b0101: seg = 7'b0010010; // 5
        4'b0110: seg = 7'b0000010; // 6
        4'b0111: seg = 7'b1111000; // 7
        4'b1000: seg = 7'b0000000; // 8
        4'b1001: seg = 7'b0010000; // 9
        4'b1010: seg = 7'b0001000; // A
        4'b1011: seg = 7'b0000011; // b
        4'b1100: seg = 7'b1000110; // C
        4'b1101: seg = 7'b0100001; // d
        4'b1110: seg = 7'b0000110; // E
        4'b1111: seg = 7'b0001110; // F
        default: seg = 7'b1111111; // Blank
    endcase
end

endmodule