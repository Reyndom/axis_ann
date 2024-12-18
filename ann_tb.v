`timescale 1ns / 1ps

module ann_tb();
    localparam T = 10;
    
    reg clk;
    reg rst_n;
    reg en;
    reg clr;

    wire ready;
    reg start;
    wire done;

    reg wb_ena;
    reg [2:0] wb_addra;
    reg [127:0] wb_dina;
    reg [15:0] wb_wea;

    reg k_ena;
    reg [1:0] k_addra;
    reg [127:0] k_dina;
    reg [15:0] k_wea;

    reg a_enb;
    reg [1:0] a_addrb;
    wire [63:0] a_doutb;
 
    ann dut
    (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .ready(ready),
        .start(start),
        .done(done),
        .wb_ena(wb_ena),
        .wb_addra(wb_addra),
        .wb_dina(wb_dina),
        .wb_wea(wb_wea),
        .k_ena(k_ena),
        .k_addra(k_addra),
        .k_dina(k_dina),
        .k_wea(k_wea),
        .a_enb(a_enb),
        .a_addrb(a_addrb),
        .a_doutb(a_doutb)
    );

    always
    begin
        clk = 0;
        #(T/2);
        clk = 1;
        #(T/2);
    end
    
    initial
    begin
        en = 1;
        clr = 0;
        start = 0;
        wb_ena = 1;
        wb_addra = 0;
        wb_dina = 0;
        wb_wea = 0;
        k_ena = 1;
        k_addra = 0;
        k_dina = 0;
        k_wea = 0;
        a_enb = 0;
        a_addrb = 0;
        
        rst_n = 0;
        #(T*5);
        rst_n = 1;
        #(T*5);
        
        // *** Testvector 1 ***
        // Write weight and bias
        wb_wea = 16'hffff;
        wb_addra = 0;
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111101011001100_1111101011001100_0000011011001100_0000010100110011_1111101100110011;
        #T;     
        wb_addra = 1;
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110000000000_0000010000000000_0000000011001100_0000001000000000_0000000100110011;
        #T;
        wb_addra = 2;  
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110000000000_0000011000000000_0000001100110011_0000000001100110_0000001001100110;
        #T;
        wb_addra = 3;  
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110001100110_0000010100110011_1111101001100110_1111101100110011_0000010100110011;
        #T;
        wb_addra = 4;  
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110000000000_0000000110011001_0000001000000000_0000000100110011_0000010100110011;
        #T;
        wb_addra = 5;  
        wb_dina = 128'b0000000000000000_0000000000000000_1111101000000000_0000000001100110_1111001000000000_0000001100110011_1111111011001100_0001010011001100;
        #T;
        wb_addra = 6;  
        wb_dina = 128'b0000000000000000_0000000000000000_1111101001100110_0000001110011001_0001000000000000_0000001011001100_0000000001100110_1110110011001100;
        #T;
        wb_wea = 16'h0000;
        wb_addra = 0;  
        wb_dina = 0;
        #T;
        
        // Write input
        k_wea = 16'hffff;
        k_addra = 0;
        k_dina = 128'b0000000000000000_0000000000000000_0000110000000000_0001100000000000_0000110000000000_0001100000000000_0001110000000000_0000100000000000;
        #T;
        k_addra = 1;
        k_dina = 128'b0000000000000000_0000000000000000_0000100000000000_0010010000000000_0010100000000000_0010000000000000_0000100000000000_0010100000000000;
        #T;
        k_addra = 2;
        k_dina = 128'b0000000000000000_0000000000000000_0001100000000000_0001010000000000_0000110000000000_0000010000000000_0000110000000000_0001010000000000;
        #T;
        k_addra = 3;
        k_dina = 128'b0000000000000000_0000000000000000_0010100000000000_0001100000000000_0000010000000000_0001100000000000_0000110000000000_0000110000000000;
        #T;
        k_wea = 16'h0000;
        k_addra = 0;  
        k_dina = 0;
        #T;
        
        // Start module
        start = 1;
        #T;
        start = 0;
        #T;
        
        #(T*100);
        
        // *** Testvector 2 ***
        // Write weight and bias
        wb_wea = 16'hffff;
        wb_addra = 0;
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111101011001100_1111101011001100_0000011011001100_0000010100110011_1111101100110011;
        #T;     
        wb_addra = 1;
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110000000000_0000010000000000_0000000011001100_0000001000000000_0000000100110011;
        #T;
        wb_addra = 2;  
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110000000000_0000011000000000_0000001100110011_0000000001100110_0000001001100110;
        #T;
        wb_addra = 3;  
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110001100110_0000010100110011_1111101001100110_1111101100110011_0000010100110011;
        #T;
        wb_addra = 4;  
        wb_dina = 128'b0000000000000000_0000000000000000_0000000000000000_1111110000000000_0000000110011001_0000001000000000_0000000100110011_0000010100110011;
        #T;
        wb_addra = 5;  
        wb_dina = 128'b0000000000000000_0000000000000000_1111101000000000_0000000001100110_1111001000000000_0000001100110011_1111111011001100_0001010011001100;
        #T;
        wb_addra = 6;  
        wb_dina = 128'b0000000000000000_0000000000000000_1111101001100110_0000001110011001_0001000000000000_0000001011001100_0000000001100110_1110110011001100;
        #T;
        wb_wea = 16'h0000;
        wb_addra = 0;  
        wb_dina = 0;
        #T;
        
        // Write input
        k_wea = 16'hffff;
        k_addra = 0;
        k_dina = 128'b0000000000000000_0000000000000000_0000110000000000_0001100000000000_0000110000000000_0001100000000000_0001110000000000_0000100000000000;
        #T;
        k_addra = 1;
        k_dina = 128'b0000000000000000_0000000000000000_0000100000000000_0010010000000000_0010100000000000_0010000000000000_0000100000000000_0010100000000000;
        #T;
        k_addra = 2;
        k_dina = 128'b0000000000000000_0000000000000000_0001100000000000_0001010000000000_0000110000000000_0000010000000000_0000110000000000_0001010000000000;
        #T;
        k_addra = 3;
        k_dina = 128'b0000000000000000_0000000000000000_0010100000000000_0001100000000000_0000010000000000_0001100000000000_0000110000000000_0000110000000000;
        #T;
        k_wea = 16'h0000;
        k_addra = 0;  
        k_dina = 0;
        #T;
        
        // Start module
        start = 1;
        #T;
        start = 0;
        #T;
        
        #(T*100);
    end
    
endmodule