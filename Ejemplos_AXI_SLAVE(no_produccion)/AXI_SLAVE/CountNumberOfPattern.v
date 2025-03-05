`timescale 1 ns / 1 ps

module CountNumberOfPattern #(
    parameter DATA_WIDTH = 32, 
    parameter PATTERN_WIDTH = 3,
    parameter DATA_OUT_WIDTH = $clog2(DATA_WIDTH)
)(
    input  wire [DATA_WIDTH-1:0]       In,
    input  wire [PATTERN_WIDTH-1:0]    Pattern,
    output reg  [DATA_OUT_WIDTH-1:0]   CountOut
); 

integer i_count; 

always @(In) begin 
    CountOut = 0; 
    for (i_count = (DATA_WIDTH-1); i_count >= (PATTERN_WIDTH-1); i_count = i_count - 1) begin
        if (Pattern == In[i_count -: PATTERN_WIDTH])
            CountOut = CountOut + 1; 
    end
end 

endmodule


