//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Mon Oct 27 22:15:17 2025
//Host        : Hua running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target RMSnorm.bd
//Design      : RMSnorm
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "RMSnorm,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=RMSnorm,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=1,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "RMSnorm.hwdef" *) 
module RMSnorm
   (M_AXIS_0_tdata,
    M_AXIS_0_tready,
    M_AXIS_0_tvalid,
    S_AXIS_0_tdata,
    S_AXIS_0_tready,
    S_AXIS_0_tvalid,
    aclk,
    arstn);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TDATA" *) (* X_INTERFACE_MODE = "Master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS_0, CLK_DOMAIN RMSnorm_aclk, FREQ_HZ 200000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [127:0]M_AXIS_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TREADY" *) input M_AXIS_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS_0 TVALID" *) output M_AXIS_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TDATA" *) (* X_INTERFACE_MODE = "Slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS_0, CLK_DOMAIN RMSnorm_aclk, FREQ_HZ 200000000, HAS_TKEEP 0, HAS_TLAST 0, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 16, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [127:0]S_AXIS_0_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TREADY" *) output S_AXIS_0_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TVALID" *) input S_AXIS_0_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.ACLK, ASSOCIATED_BUSIF S_AXIS_0:M_AXIS_0, CLK_DOMAIN RMSnorm_aclk, FREQ_HZ 200000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.ARSTN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.ARSTN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input arstn;

  wire [127:0]M_AXIS_0_tdata;
  wire M_AXIS_0_tready;
  wire M_AXIS_0_tvalid;
  wire [127:0]S_AXIS_0_tdata;
  wire S_AXIS_0_tready;
  wire S_AXIS_0_tvalid;
  wire aclk;
  wire arstn;
  wire [143:0]rms_sum_top_0_M_AXIS_TDATA;
  wire rms_sum_top_0_M_AXIS_TREADY;
  wire rms_sum_top_0_M_AXIS_TVALID;

  RMSnorm_rms_norm_top_0_0 rms_norm_top_0
       (.M_AXIS_TDATA(M_AXIS_0_tdata),
        .M_AXIS_TREADY(M_AXIS_0_tready),
        .M_AXIS_TVALID(M_AXIS_0_tvalid),
        .S_AXIS_TDATA(rms_sum_top_0_M_AXIS_TDATA),
        .S_AXIS_TREADY(rms_sum_top_0_M_AXIS_TREADY),
        .S_AXIS_TVALID(rms_sum_top_0_M_AXIS_TVALID),
        .aclk(aclk),
        .arstn(arstn));
  RMSnorm_rms_sum_top_0_0 rms_sum_top_0
       (.M_AXIS_TDATA(rms_sum_top_0_M_AXIS_TDATA),
        .M_AXIS_TREADY(rms_sum_top_0_M_AXIS_TREADY),
        .M_AXIS_TVALID(rms_sum_top_0_M_AXIS_TVALID),
        .S_AXIS_TDATA(S_AXIS_0_tdata),
        .S_AXIS_TREADY(S_AXIS_0_tready),
        .S_AXIS_TVALID(S_AXIS_0_tvalid),
        .aclk(aclk),
        .arstn(arstn));
endmodule
