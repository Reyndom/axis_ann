module register #(
    parameter WIDTH = 16  // Parameterisasi lebar bit
) (
    input wire clk,        // Clock input
    input wire rst_n,      // Active-low reset
    input wire en,         // Enable signal
    input wire clr,        // Clear signal
    input wire signed [WIDTH-1:0] d, // Signed input data
    output reg signed [WIDTH-1:0] q  // Signed output register
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n || clr) begin
            q <= {WIDTH{1'b0}};  // Reset atau clear: q = 16'b0
        end else if (en) begin
            q <= d;  // Jika enable aktif: q = d
        end
    end

endmodule
