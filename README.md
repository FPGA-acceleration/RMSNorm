## RMSnorm_v2 UPDATE
Version2
  1. 交换了“除维度”步骤和“求和”步骤，省去7个bf_mul,同时降低了小数值计算的精度损失;对大数值的数值稳定性有待考量。
  2. 除去了accumulator中对rms计算无用的fifo 
