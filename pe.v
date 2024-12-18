module pe #(parameter WIDTH = 16, FRAC_BIT = 10) (
    input  signed [WIDTH-1:0] a_in,  // Input a_in (signed 16-bit)
    input  signed [WIDTH-1:0] y_in,  // Input y_in (signed 16-bit)
    input  signed [WIDTH-1:0] b,     // Input b (signed 16-bit)
    output signed [WIDTH-1:0] a_out, // Output a_out (signed 16-bit)
    output signed [WIDTH-1:0] y_out  // Output y_out (signed 16-bit)
);

    // Internal signal for multiplication result
    reg signed [2*WIDTH-1:0] y_out_i; 

    // Assign outputs
    assign a_out = a_in;               // a_out langsung mengambil a_in
    assign y_out = y_out_i[WIDTH+FRAC_BIT-1:FRAC_BIT] + y_in;  // Fixed-point scaling

    // Always block for sequential logic (optional if needed)
    always @(*) begin
        // Perkalian signed dari a_in dan b
        y_out_i = a_in * b;
    end

endmodule
