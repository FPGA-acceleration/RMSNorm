`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2025 08:30:50 PM
// Design Name: 
// Module Name: sum_top
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

//输出 低16bit位是rms值，高128位是对齐后的数据，当第一次rms值输出时，高128bit为第一批的8个bf16，在RMSnorm中做除法

module rms_sum_top(
    input aclk,
    input arstn,

    input [127:0] S_AXIS_TDATA,
    input S_AXIS_TVALID,
    output S_AXIS_TREADY,

    output [143:0] M_AXIS_TDATA,
    output M_AXIS_TVALID,
    output M_AXIS_TLAST,
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
    
  parallel_mean_square u_pms(
    .aclk(aclk),
    .arstn(arstn),

    .S_AXIS_TDATA(S_AXIS_TDATA),
    .S_AXIS_TVALID(S_AXIS_TVALID0),
    .S_AXIS_TREADY(S_AXIS_TREADY0),

    .M_AXIS_TDATA(mean_data),
    .M_AXIS_TVALID(mean_valid),
    .M_AXIS_TREADY(mean_ready)
 
  );
  
wire [143:0] acc_data;
wire acc_valid;
wire acc_last;
wire acc_ready;
    
  accumulator u_accumulator (
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
    
wire [127:0]data_aligned;
wire align_valid;
wire align_ready;
 
//整个rms_sum_top需要143个周期来对齐数据，acc需要125个，pms需要18个
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
assign acc_ready = M_AXIS_TREADY;  
assign M_AXIS_TVALID = acc_valid & align_valid ;
assign M_AXIS_TLAST  = acc_last;
assign M_AXIS_TDATA =  {data_aligned, acc_data[15:0]};
  

endmodule

