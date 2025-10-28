`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 03:48:06 PM
// Design Name: 
// Module Name: parallel_square
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



//并行输入 8个bf16数据 做平方后提前除以768防止上溢出

module parallel_mean_square(
    input aclk,
    input arstn,

    input [127:0] S_AXIS_TDATA,
    input S_AXIS_TVALID,
    output S_AXIS_TREADY,

    output [127:0] M_AXIS_TDATA,
    output M_AXIS_TVALID,
    //output M_AXIS_TLAST,
    input M_AXIS_TREADY
    );
  
  
wire a_ready [7:0];  
wire b_ready [7:0];
wire square_valid [7:0];
wire square_ready [7:0];
wire [15:0] square_out [7:0];
wire [15:0] bf16_in [7:0];

assign S_AXIS_TREADY = a_ready[7] & a_ready[6] & a_ready[5] & a_ready[4] & a_ready[3] & a_ready[2] & a_ready[1] & a_ready[0] & b_ready[7] & b_ready[6] & b_ready[5] & b_ready[4] & b_ready[3] & b_ready[2] & b_ready[1] & b_ready[0]; 

assign { bf16_in[7], bf16_in[6], bf16_in[5], bf16_in[4],
         bf16_in[3], bf16_in[2], bf16_in[1], bf16_in[0] } = S_AXIS_TDATA; 
  
genvar i;
    generate
        for (i=0; i<8; i=i+1) begin : square
            bf_mul square (
                .aclk(aclk),
                .aresetn(arstn),
                .s_axis_a_tvalid(S_AXIS_TVALID),
                .s_axis_a_tready(a_ready[i]),
                .s_axis_a_tdata(bf16_in[i]),
                .s_axis_b_tvalid(S_AXIS_TVALID),
                .s_axis_b_tready(b_ready[i]),
                .s_axis_b_tdata(bf16_in[i]),
                .m_axis_result_tvalid(square_valid[i]),
                .m_axis_result_tready(square_ready[i]),
                .m_axis_result_tdata(square_out[i])
            );
        end
endgenerate
    
wire mean_valid[7:0];
wire mean_ready[7:0];
wire [15:0] mean_out[7:0];   
    
genvar j;
    generate
        for (j=0; j<8; j=j+1) begin : pre_mean
            bf_mul pre_mean (
                .aclk(aclk),
                .aresetn(arstn),
                .s_axis_a_tvalid(square_valid[j]),
                .s_axis_a_tready(square_ready[j]),
                .s_axis_a_tdata(square_out[j]),
                
                
                .s_axis_b_tvalid(1'b1),
                .s_axis_b_tready(),
                .s_axis_b_tdata(16'h3aab),
                
                
                .m_axis_result_tvalid(mean_valid[j]),
                .m_axis_result_tready(mean_ready[j]),
                .m_axis_result_tdata(mean_out[j])
            );
        end
endgenerate
    
assign M_AXIS_TDATA ={ mean_out[7], mean_out[6], mean_out[5], mean_out[4],
                       mean_out[3], mean_out[2], mean_out[1], mean_out[0] };
    
assign M_AXIS_TVALID = mean_valid[7] & mean_valid[6] & mean_valid[5] & mean_valid[4]  //
                     & mean_valid[3] & mean_valid[2] & mean_valid[1] &mean_valid[0];     
    
assign {mean_ready[7], mean_ready[6], mean_ready[5], mean_ready[4],
        mean_ready[3], mean_ready[2], mean_ready[1], mean_ready[0]} = {8{M_AXIS_TREADY}};    
    
endmodule
