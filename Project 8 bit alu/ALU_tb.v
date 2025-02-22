`timescale 1ns / 1ps

module ALU_tb;
    // Testbench signals
    reg [7:0] A, B;
    reg [3:0] ALU_Sel;
    reg J, K, clk, reset;
    wire [15:0] ALU_Out;
    wire Zero;
    wire [6:0] seg;
    wire Q, Qn;

    // Instantiate the ALU module
    Sequential_ALU uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .J(J),
        .K(K),
        .clk(clk),
        .reset(reset),
        .ALU_Out(ALU_Out),
        .Zero(Zero),
        .seg(seg),
        .Q(Q),
        .Qn(Qn)
    );

    // Generate a clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with a period of 10 units
    end

    // Test scenarios
    initial begin

    $dumpfile("dump.vcd");  // Specifies the name of the VCD file
    $dumpvars(0, ALU_tb);    // Dumps variables from the testbench module
end
    initial begin
        // Initialize inputs
        A = 8'b00000010; // Example value for A
        B = 8'b00000001; // Example value for B
        ALU_Sel = 4'b0000; // Initialize ALU_Sel
        J = 0;
        K = 1;
        reset = 1; // Start with reset active
        
        #10 reset = 0; // Release reset after 10 time units
        
        // Test addition
        ALU_Sel = 4'b0000; // Addition operation
        #10; // Wait 10 time units

        // Test subtraction
        ALU_Sel = 4'b0001; // Subtraction operation
        #10;

        // Test multiplication
        ALU_Sel = 4'b0010; // Multiplication operation
        #10;

        // Test division
        ALU_Sel = 4'b0011; // Division operation
        #10;

        // Test AND operation
        ALU_Sel = 4'b0100;
        #10;

        // Test OR operation
        ALU_Sel = 4'b0101;
        #10;

        // Test XOR operation
        ALU_Sel = 4'b0110;
        #10;

        // Test NOT operation
        ALU_Sel = 4'b0111;
        #10;

        // Test Greater Than
        ALU_Sel = 4'b1010;
        #10;

        // Test Equal To
        ALU_Sel = 4'b1100;
        #10;

        // Toggle JK flip-flop inputs to test flip-flop behavior
        J = 1;
        K = 0;
        #10;
        J = 1;
        K = 1;
        #10;

        // End the simulation
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time=%0t | A=%0d B=%0d ALU_Sel=%b | ALU_Out=%0d Zero=%b seg=%b | Q=%b Qn=%b",
                 $time, A, B, ALU_Sel, ALU_Out, Zero, seg, Q, Qn);
    end

endmodule