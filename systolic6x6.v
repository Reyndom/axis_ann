module systolic6x6 
    #(
        parameter WIDTH = 16,
        parameter FRAC_BIT = 10
    )
    (
        input wire                     clk,
        input wire                     rst_n,
        input wire                     en,
        input wire                     clr,
        input wire signed [WIDTH-1:0]  a0, a1, a2, a3, a4, a5,
        input wire                     in_valid,
        input wire signed [WIDTH-1:0]  b00, b01, b02, b03, b04, b05,
        input wire signed [WIDTH-1:0]  b10, b11, b12, b13, b14, b15,
        input wire signed [WIDTH-1:0]  b20, b21, b22, b23, b24, b25,
        input wire signed [WIDTH-1:0]  b30, b31, b32, b33, b34, b35,
        input wire signed [WIDTH-1:0]  b40, b41, b42, b43, b44, b45,
        input wire signed [WIDTH-1:0]  b50, b51, b52, b53, b54, b55,
        output wire signed [WIDTH-1:0] y0, y1, y2, y3, y4, y5,
        output wire                    out_valid  
    );

    // Interconnecting wires between PEs and registers
    wire signed [WIDTH-1:0] a00_out;
    wire signed [WIDTH-1:0] a10_out, a11_out;
    wire signed [WIDTH-1:0] a20_out, a21_out, a22_out;
    wire signed [WIDTH-1:0] a30_out, a31_out, a32_out, a33_out;
    wire signed [WIDTH-1:0] a40_out, a41_out, a42_out, a43_out, a44_out;
    wire signed [WIDTH-1:0] a50_out, a51_out, a52_out, a53_out, a54_out, a55_out;
    
    wire signed [WIDTH-1:0] y00_out, y01_out, y02_out, y03_out, y04_out, y05_out;
    wire signed [WIDTH-1:0] y10_out, y11_out, y12_out, y13_out, y14_out;
    wire signed [WIDTH-1:0] y20_out, y21_out, y22_out, y23_out;
    wire signed [WIDTH-1:0] y30_out, y31_out, y32_out;
    wire signed [WIDTH-1:0] y40_out, y41_out;
    wire signed [WIDTH-1:0] y50_out;
    
    wire signed [WIDTH-1:0] y0_tmp, y1_tmp, y2_tmp, y3_tmp, y4_tmp, y5_tmp;
    
    wire signed [WIDTH-1:0] b00_a0_out, b01_a0_out, b02_a0_out, b03_a0_out, b04_a0_out,
                            b10_a1_out, b11_a1_out, b12_a1_out, b13_a1_out, b14_a1_out,
                            b20_a2_out, b21_a2_out, b22_a2_out, b23_a2_out, b24_a2_out,
                            b30_a3_out, b31_a3_out, b32_a3_out, b33_a3_out, b34_a3_out,
                            b40_a4_out, b41_a4_out, b42_a4_out, b43_a4_out, b44_a4_out,
                            b50_a5_out, b51_a5_out, b52_a5_out, b53_a5_out, b54_a5_out;
                            
    wire signed [WIDTH-1:0] b00_y0_out, b01_y1_out, b02_y2_out, b03_y3_out, b04_y4_out, b05_y5_out,
                            b10_y0_out, b11_y1_out, b12_y2_out, b13_y3_out, b14_y4_out, b15_y5_out,
                            b20_y0_out, b21_y1_out, b22_y2_out, b23_y3_out, b24_y4_out, b25_y5_out,
                            b30_y0_out, b31_y1_out, b32_y2_out, b33_y3_out, b34_y4_out, b35_y5_out,
                            b40_y0_out, b41_y1_out, b42_y2_out, b43_y3_out, b44_y4_out, b45_y5_out;
                            
    wire signed [WIDTH-1:0] b00_a, b01_a, b02_a, b03_a, b04_a, b05_a,
                            b10_a, b11_a, b12_a, b13_a, b14_a, b15_a,
                            b20_a, b21_a, b22_a, b23_a, b24_a, b25_a,
                            b30_a, b31_a, b32_a, b33_a, b34_a, b35_a,
                            b40_a, b41_a, b42_a, b43_a, b44_a, b45_a,
                            b50_a, b51_a, b52_a, b53_a, b54_a, b55_a;
                            
    wire signed [WIDTH-1:0] b00_y, b01_y, b02_y, b03_y, b04_y, b05_y,
                            b10_y, b11_y, b12_y, b13_y, b14_y, b15_y,
                            b20_y, b21_y, b22_y, b23_y, b24_y, b25_y,
                            b30_y, b31_y, b32_y, b33_y, b34_y, b35_y,
                            b40_y, b41_y, b42_y, b43_y, b44_y, b45_y,
                            b50_y, b51_y, b52_y, b53_y, b54_y, b55_y;
                            
    // *** Valid registers ***
    wire in_valid_reg0, in_valid_reg1, in_valid_reg2, in_valid_reg3, in_valid_reg4, in_valid_reg5, in_valid_reg6, in_valid_reg7, in_valid_reg8, in_valid_reg9, in_valid_reg10, in_valid_reg11, in_valid_reg12;

    // Register a
    // Register a0
    register #(.WIDTH(WIDTH)) a00 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a0), .q(a00_out));
    //Register a1
    register #(.WIDTH(WIDTH)) a10 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a1), .q(a10_out));
    register #(.WIDTH(WIDTH)) a11 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a10_out), .q(a11_out));
    //Register a2
    register #(.WIDTH(WIDTH)) a20 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a2), .q(a20_out));
    register #(.WIDTH(WIDTH)) a21 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a20_out), .q(a21_out));
    register #(.WIDTH(WIDTH)) a22 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a21_out), .q(a22_out));
    // Register a3
    register #(.WIDTH(WIDTH)) a30 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a3), .q(a30_out));
    register #(.WIDTH(WIDTH)) a31 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a30_out), .q(a31_out));
    register #(.WIDTH(WIDTH)) a32 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a31_out), .q(a32_out));
    register #(.WIDTH(WIDTH)) a33 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a32_out), .q(a33_out));
    // Register a4
    register #(.WIDTH(WIDTH)) a40 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a4), .q(a40_out));
    register #(.WIDTH(WIDTH)) a41 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a40_out), .q(a41_out));
    register #(.WIDTH(WIDTH)) a42 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a41_out), .q(a42_out));
    register #(.WIDTH(WIDTH)) a43 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a42_out), .q(a43_out));
    register #(.WIDTH(WIDTH)) a44 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a43_out), .q(a44_out));
    // Register a5
    register #(.WIDTH(WIDTH)) a50 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a5), .q(a50_out));
    register #(.WIDTH(WIDTH)) a51 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a50_out), .q(a51_out));
    register #(.WIDTH(WIDTH)) a52 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a51_out), .q(a52_out));
    register #(.WIDTH(WIDTH)) a53 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a52_out), .q(a53_out));
    register #(.WIDTH(WIDTH)) a54 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a53_out), .q(a54_out));
    register #(.WIDTH(WIDTH)) a55 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(a54_out), .q(a55_out));
    
        // PE Module
    // PE 00 - 05
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_00 (.a_in(a00_out), .y_in(0), .b(b00), .a_out(b00_a), .y_out(b00_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_01 (.a_in(b00_a0_out), .y_in(0), .b(b01), .a_out(b01_a), .y_out(b01_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_02 (.a_in(b01_a0_out), .y_in(0), .b(b02), .a_out(b02_a), .y_out(b02_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_03 (.a_in(b02_a0_out), .y_in(0), .b(b03), .a_out(b03_a), .y_out(b03_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_04 (.a_in(b03_a0_out), .y_in(0), .b(b04), .a_out(b04_a), .y_out(b04_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_05 (.a_in(b04_a0_out), .y_in(0), .b(b05), .a_out(b05_a), .y_out(b05_y));
    // PE 10 - 15
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_10 (.a_in(a11_out), .y_in(b00_y0_out), .b(b10), .a_out(b10_a), .y_out(b10_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_11 (.a_in(b10_a1_out), .y_in(b01_y1_out), .b(b11), .a_out(b11_a), .y_out(b11_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_12 (.a_in(b11_a1_out), .y_in(b02_y2_out), .b(b12), .a_out(b12_a), .y_out(b12_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_13 (.a_in(b12_a1_out), .y_in(b03_y3_out), .b(b13), .a_out(b13_a), .y_out(b13_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_14 (.a_in(b13_a1_out), .y_in(b04_y4_out), .b(b14), .a_out(b14_a), .y_out(b14_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_15 (.a_in(b14_a1_out), .y_in(b05_y5_out), .b(b15), .a_out(b15_a), .y_out(b15_y));
    // PE 20 - 25
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_20 (.a_in(a22_out), .y_in(b10_y0_out), .b(b20), .a_out(b20_a), .y_out(b20_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_21 (.a_in(b20_a2_out), .y_in(b11_y1_out), .b(b21), .a_out(b21_a), .y_out(b21_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_22 (.a_in(b21_a2_out), .y_in(b12_y2_out), .b(b22), .a_out(b22_a), .y_out(b22_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_23 (.a_in(b22_a2_out), .y_in(b13_y3_out), .b(b23), .a_out(b23_a), .y_out(b23_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_24 (.a_in(b23_a2_out), .y_in(b14_y4_out), .b(b24), .a_out(b24_a), .y_out(b24_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_25 (.a_in(b24_a2_out), .y_in(b15_y5_out), .b(b25), .a_out(b25_a), .y_out(b25_y));
    // PE 30 - 35
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_30 (.a_in(a33_out), .y_in(b20_y0_out), .b(b30), .a_out(b30_a), .y_out(b30_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_31 (.a_in(b30_a3_out), .y_in(b21_y1_out), .b(b31), .a_out(b31_a), .y_out(b31_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_32 (.a_in(b31_a3_out), .y_in(b22_y2_out), .b(b32), .a_out(b32_a), .y_out(b32_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_33 (.a_in(b32_a3_out), .y_in(b23_y3_out), .b(b33), .a_out(b33_a), .y_out(b33_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_34 (.a_in(b33_a3_out), .y_in(b24_y4_out), .b(b34), .a_out(b34_a), .y_out(b34_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_35 (.a_in(b34_a3_out), .y_in(b25_y5_out), .b(b35), .a_out(b35_a), .y_out(b35_y));
    // PE 40 - 45
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_40 (.a_in(a44_out), .y_in(b30_y0_out), .b(b40), .a_out(b40_a), .y_out(b40_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_41 (.a_in(b40_a4_out), .y_in(b31_y1_out), .b(b41), .a_out(b41_a), .y_out(b41_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_42 (.a_in(b41_a4_out), .y_in(b32_y2_out), .b(b42), .a_out(b42_a), .y_out(b42_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_43 (.a_in(b42_a4_out), .y_in(b33_y3_out), .b(b43), .a_out(b43_a), .y_out(b43_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_44 (.a_in(b43_a4_out), .y_in(b34_y4_out), .b(b44), .a_out(b44_a), .y_out(b44_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_45 (.a_in(b44_a4_out), .y_in(b35_y5_out), .b(b45), .a_out(b45_a), .y_out(b45_y));
    // PE 50 - 55
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_50 (.a_in(a55_out), .y_in(b40_y0_out), .b(b50), .a_out(b50_a), .y_out(b50_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_51 (.a_in(b50_a5_out), .y_in(b41_y1_out), .b(b51), .a_out(b51_a), .y_out(b51_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_52 (.a_in(b51_a5_out), .y_in(b42_y2_out), .b(b52), .a_out(b52_a), .y_out(b52_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_53 (.a_in(b52_a5_out), .y_in(b43_y3_out), .b(b53), .a_out(b53_a), .y_out(b53_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_54 (.a_in(b53_a5_out), .y_in(b44_y4_out), .b(b54), .a_out(b54_a), .y_out(b54_y));
    pe #(.WIDTH(WIDTH), .FRAC_BIT(FRAC_BIT)) PE_55 (.a_in(b54_a5_out), .y_in(b45_y5_out), .b(b55), .a_out(b55_a), .y_out(b55_y));

    // Register b_a
    // b00 - 04 a0
    register #(.WIDTH(WIDTH)) b00_a0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b00_a), .q(b00_a0_out));
    register #(.WIDTH(WIDTH)) b01_a0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b01_a), .q(b01_a0_out));
    register #(.WIDTH(WIDTH)) b02_a0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b02_a), .q(b02_a0_out));
    register #(.WIDTH(WIDTH)) b03_a0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b03_a), .q(b03_a0_out));
    register #(.WIDTH(WIDTH)) b04_a0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b04_a), .q(b04_a0_out));
    // b10 - 14 a1
    register #(.WIDTH(WIDTH)) b10_a1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b10_a), .q(b10_a1_out));
    register #(.WIDTH(WIDTH)) b11_a1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b11_a), .q(b11_a1_out));
    register #(.WIDTH(WIDTH)) b12_a1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b12_a), .q(b12_a1_out));
    register #(.WIDTH(WIDTH)) b13_a1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b13_a), .q(b13_a1_out));
    register #(.WIDTH(WIDTH)) b14_a1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b14_a), .q(b14_a1_out));
    // b20 - 24 a2
    register #(.WIDTH(WIDTH)) b20_a2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b20_a), .q(b20_a2_out));
    register #(.WIDTH(WIDTH)) b21_a2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b21_a), .q(b21_a2_out));
    register #(.WIDTH(WIDTH)) b22_a2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b22_a), .q(b22_a2_out));
    register #(.WIDTH(WIDTH)) b23_a2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b23_a), .q(b23_a2_out));
    register #(.WIDTH(WIDTH)) b24_a2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b24_a), .q(b24_a2_out));
    // b30 - 34 a3
    register #(.WIDTH(WIDTH)) b30_a3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b30_a), .q(b30_a3_out));
    register #(.WIDTH(WIDTH)) b31_a3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b31_a), .q(b31_a3_out));
    register #(.WIDTH(WIDTH)) b32_a3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b32_a), .q(b32_a3_out));
    register #(.WIDTH(WIDTH)) b33_a3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b33_a), .q(b33_a3_out));
    register #(.WIDTH(WIDTH)) b34_a3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b34_a), .q(b34_a3_out));
    // b40 - 44 a4
    register #(.WIDTH(WIDTH)) b40_a4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b40_a), .q(b40_a4_out));
    register #(.WIDTH(WIDTH)) b41_a4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b41_a), .q(b41_a4_out));
    register #(.WIDTH(WIDTH)) b42_a4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b42_a), .q(b42_a4_out));
    register #(.WIDTH(WIDTH)) b43_a4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b43_a), .q(b43_a4_out));
    register #(.WIDTH(WIDTH)) b44_a4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b44_a), .q(b44_a4_out));
    // b50 - 54 a5
    register #(.WIDTH(WIDTH)) b50_a5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b50_a), .q(b50_a5_out));
    register #(.WIDTH(WIDTH)) b51_a5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b51_a), .q(b51_a5_out));
    register #(.WIDTH(WIDTH)) b52_a5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b52_a), .q(b52_a5_out));
    register #(.WIDTH(WIDTH)) b53_a5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b53_a), .q(b53_a5_out));
    register #(.WIDTH(WIDTH)) b54_a5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b54_a), .q(b54_a5_out));
    
    // Register b_y
    // b00 - 40 y0
    register #(.WIDTH(WIDTH)) b00_y0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b00_y), .q(b00_y0_out));
    register #(.WIDTH(WIDTH)) b10_y0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b10_y), .q(b10_y0_out));
    register #(.WIDTH(WIDTH)) b20_y0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b20_y), .q(b20_y0_out));
    register #(.WIDTH(WIDTH)) b30_y0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b30_y), .q(b30_y0_out));
    register #(.WIDTH(WIDTH)) b40_y0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b40_y), .q(b40_y0_out));
    register #(.WIDTH(WIDTH)) b50_y0 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b50_y), .q(y0_tmp));
    // b01 - 41 y1
    register #(.WIDTH(WIDTH)) b01_y1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b01_y), .q(b01_y1_out));
    register #(.WIDTH(WIDTH)) b11_y1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b11_y), .q(b11_y1_out));
    register #(.WIDTH(WIDTH)) b21_y1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b21_y), .q(b21_y1_out));
    register #(.WIDTH(WIDTH)) b31_y1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b31_y), .q(b31_y1_out));
    register #(.WIDTH(WIDTH)) b41_y1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b41_y), .q(b41_y1_out));
    register #(.WIDTH(WIDTH)) b51_y1 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b51_y), .q(y1_tmp));
    // b02 - 42 y2
    register #(.WIDTH(WIDTH)) b02_y2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b02_y), .q(b02_y2_out));
    register #(.WIDTH(WIDTH)) b12_y2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b12_y), .q(b12_y2_out));
    register #(.WIDTH(WIDTH)) b22_y2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b22_y), .q(b22_y2_out));
    register #(.WIDTH(WIDTH)) b32_y2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b32_y), .q(b32_y2_out));
    register #(.WIDTH(WIDTH)) b42_y2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b42_y), .q(b42_y2_out));
    register #(.WIDTH(WIDTH)) b52_y2 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b52_y), .q(y2_tmp));
    // b03 - 43 y3
    register #(.WIDTH(WIDTH)) b03_y3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b03_y), .q(b03_y3_out));
    register #(.WIDTH(WIDTH)) b13_y3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b13_y), .q(b13_y3_out));
    register #(.WIDTH(WIDTH)) b23_y3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b23_y), .q(b23_y3_out));
    register #(.WIDTH(WIDTH)) b33_y3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b33_y), .q(b33_y3_out));
    register #(.WIDTH(WIDTH)) b43_y3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b43_y), .q(b43_y3_out));
    register #(.WIDTH(WIDTH)) b53_y3 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b53_y), .q(y3_tmp));
    // b04 - 44 y4
    register #(.WIDTH(WIDTH)) b04_y4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b04_y), .q(b04_y4_out));
    register #(.WIDTH(WIDTH)) b14_y4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b14_y), .q(b14_y4_out));
    register #(.WIDTH(WIDTH)) b24_y4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b24_y), .q(b24_y4_out));
    register #(.WIDTH(WIDTH)) b34_y4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b34_y), .q(b34_y4_out));
    register #(.WIDTH(WIDTH)) b44_y4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b44_y), .q(b44_y4_out));
    register #(.WIDTH(WIDTH)) b54_y4 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b54_y), .q(y4_tmp));
    // b05 - 45 y5
    register #(.WIDTH(WIDTH)) b05_y5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b05_y), .q(b05_y5_out));
    register #(.WIDTH(WIDTH)) b15_y5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b15_y), .q(b15_y5_out));
    register #(.WIDTH(WIDTH)) b25_y5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b25_y), .q(b25_y5_out));
    register #(.WIDTH(WIDTH)) b35_y5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b35_y), .q(b35_y5_out));
    register #(.WIDTH(WIDTH)) b45_y5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b45_y), .q(b45_y5_out));
    register #(.WIDTH(WIDTH)) b55_y5 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(b55_y), .q(y5_tmp));

    // Register y
    // Register y0
    register #(.WIDTH(WIDTH)) y00 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y0_tmp), .q(y00_out));
    register #(.WIDTH(WIDTH)) y01 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y00_out), .q(y01_out));
    register #(.WIDTH(WIDTH)) y02 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y01_out), .q(y02_out));
    register #(.WIDTH(WIDTH)) y03 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y02_out), .q(y03_out));
    register #(.WIDTH(WIDTH)) y04 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y03_out), .q(y04_out));
    register #(.WIDTH(WIDTH)) y05 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y04_out), .q(y0));
    // Register y1
    register #(.WIDTH(WIDTH)) y10 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y1_tmp), .q(y10_out));
    register #(.WIDTH(WIDTH)) y11 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y10_out), .q(y11_out));
    register #(.WIDTH(WIDTH)) y12 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y11_out), .q(y12_out));
    register #(.WIDTH(WIDTH)) y13 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y12_out), .q(y13_out));
    register #(.WIDTH(WIDTH)) y14 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y13_out), .q(y1));
    // Register y2
    register #(.WIDTH(WIDTH)) y20 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y2_tmp), .q(y20_out));
    register #(.WIDTH(WIDTH)) y21 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y20_out), .q(y21_out));
    register #(.WIDTH(WIDTH)) y22 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y21_out), .q(y22_out));
    register #(.WIDTH(WIDTH)) y23 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y22_out), .q(y2));
    // Register y3
    register #(.WIDTH(WIDTH)) y30 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y3_tmp), .q(y30_out));
    register #(.WIDTH(WIDTH)) y31 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y30_out), .q(y31_out));
    register #(.WIDTH(WIDTH)) y32 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y31_out), .q(y3));
    // Register y4
    register #(.WIDTH(WIDTH)) y40 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y4_tmp), .q(y40_out));
    register #(.WIDTH(WIDTH)) y41 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y40_out), .q(y4));
    // Register y5
    register #(.WIDTH(WIDTH)) y50 (.clk(clk), .rst_n(rst_n), .en(en), .clr(clr), .d(y5_tmp), .q(y5));

    // *** Valid registers ***
    register #(1) reg_valid_0(clk, rst_n, en, clr, in_valid,      in_valid_reg0); 
    register #(1) reg_valid_1(clk, rst_n, en, clr, in_valid_reg0, in_valid_reg1);
    register #(1) reg_valid_2(clk, rst_n, en, clr, in_valid_reg1, in_valid_reg2);
    register #(1) reg_valid_3(clk, rst_n, en, clr, in_valid_reg2, in_valid_reg3);
    register #(1) reg_valid_4(clk, rst_n, en, clr, in_valid_reg3, in_valid_reg4);
    register #(1) reg_valid_5(clk, rst_n, en, clr, in_valid_reg4, in_valid_reg5);
    register #(1) reg_valid_6(clk, rst_n, en, clr, in_valid_reg5, in_valid_reg6);
    register #(1) reg_valid_7(clk, rst_n, en, clr, in_valid_reg6, in_valid_reg7);
    register #(1) reg_valid_8(clk, rst_n, en, clr, in_valid_reg7, in_valid_reg8);
    register #(1) reg_valid_9(clk, rst_n, en, clr, in_valid_reg8, in_valid_reg9);
    register #(1) reg_valid_10(clk, rst_n, en, clr, in_valid_reg9, in_valid_reg10);
    register #(1) reg_valid_11(clk, rst_n, en, clr, in_valid_reg10, in_valid_reg11);
    register #(1) reg_valid_12(clk, rst_n, en, clr, in_valid_reg11, in_valid_reg12);
    
    // *** Outputs ***
    assign out_valid = in_valid_reg12;

endmodule