`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2025 11:19:41 AM
// Design Name: 
// Module Name: rms_sum_topv2
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



//v2更新： 1. 将除768操作放在求和的后面以节省资源，同时保证数值较小的数的精度
//        2. 对 @AnRunsen 的accumulator进行了简化，除去多余的fifo延时链

module rms_sum_topv2(
    input aclk,
    input arstn,

    input [127:0] S_AXIS_TDATA,
    input S_AXIS_TVALID,
    output S_AXIS_TREADY,

    output [143:0] M_AXIS_TDATA,
    output M_AXIS_TVALID,
    input M_AXIS_TREADY
    );

wire S_AXIS_TREADY0;
wire S_AXIS_TREADY1;
assign S_AXIS_TREADY = S_AXIS_TREADY0 & S_AXIS_TREADY1;

wire S_AXIS_TVALID0;
wire S_AXIS_TVALID1;
assign S_AXIS_TVALID0 = S_AXIS_TVALID;
assign S_AXIS_TVALID1 = S_AXIS_TVALID;

wire mean_ready;
wire mean_valid;
wire [127:0] mean_data;       
    
  parallel_squarev2 u_ps(
    .aclk(aclk),
    .arstn(arstn),

    .S_AXIS_TDATA(S_AXIS_TDATA),
    .S_AXIS_TVALID(S_AXIS_TVALID0),
    .S_AXIS_TREADY(S_AXIS_TREADY0),

    .M_AXIS_TDATA(mean_data),
    .M_AXIS_TVALID(mean_valid),
    .M_AXIS_TREADY(mean_ready)
 
  );
  
wire [15:0] acc_data;
wire acc_valid;
wire acc_last;
wire acc_ready;
    
  squaresum_acc u_accumulatorv2 (
    .aclk           (aclk),
    .arstn          (arstn),

    .S_AXIS_TDATA   (mean_data),
    .S_AXIS_TVALID  (mean_valid),
    .S_AXIS_TREADY  (mean_ready),

    .M_AXIS_TDATA   (acc_data),
    .M_AXIS_TVALID  (acc_valid),
    .M_AXIS_TLAST   (acc_last),
    .M_AXIS_TREADY  (acc_ready)
);  
  
  
wire [15:0] sum_data;
wire sum_valid;
wire sum_ready;

  sum_keep keep(
    .aclk(aclk),
    .arstn(arstn),

    .S_AXIS_TDATA(acc_data),
    .S_AXIS_TVALID(acc_valid),
    .S_AXIS_TLAST(acc_last),
    .S_AXIS_TREADY(acc_ready),

    .M_AXIS_TDATA(sum_data),
    .M_AXIS_TVALID(sum_valid),
    .M_AXIS_TREADY(sum_ready)
  );
  
  
  
wire var_ready;
wire var_valid;
wire [15:0] var_data;  
  
  bf_mul variance (
          .aclk(aclk),
          .aresetn(arstn),
          .s_axis_a_tvalid(sum_valid),
          .s_axis_a_tready(sum_ready),
          .s_axis_a_tdata(sum_data),
          
          
          .s_axis_b_tvalid(1'b1),
          .s_axis_b_tready(),
          .s_axis_b_tdata(16'h3aab),
          
          
          .m_axis_result_tvalid(var_valid),
          .m_axis_result_tready(var_ready),
          .m_axis_result_tdata(var_data)
      );  
  
  
  
    
wire [127:0]data_aligned;
wire align_valid;
wire align_ready;
 
 
 
 
//整个rms_sum_top需要155个周期来对齐数据
  sum_align u_align (
    .aclk(aclk),
    .arstn(arstn),

    .S_AXIS_TDATA(S_AXIS_TDATA),
    .S_AXIS_TVALID(S_AXIS_TVALID1),
    .S_AXIS_TREADY(S_AXIS_TREADY1),

    .M_AXIS_TDATA(data_aligned),
    .M_AXIS_TVALID(align_valid),
    .M_AXIS_TREADY(align_ready)
  );

assign align_ready = M_AXIS_TREADY;
assign var_ready = M_AXIS_TREADY;  
assign M_AXIS_TVALID = var_valid & align_valid;
assign M_AXIS_TDATA =  {data_aligned, var_data};
  

endmodule
