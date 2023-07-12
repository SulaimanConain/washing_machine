module WashingMachine_tb;
  // Input signals
  reg start;       // Start signal
  
  // Instantiate the module under test
  WashingMachine dut (
    .start(start)
    // Connect other module ports here if necessary
  );
  
  // Clock signal generation
  reg clk;
  always #5 clk = ~clk;  // Generate a clock signal with 10ns period
  
  // Initialize signals
  initial
  begin
    clk = 0;
    start = 0;
    #10;  // Wait for 10ns
    start = 1;  // Trigger the start signal
    #200;  // Wait for 2us
    start = 0;  // Stop the washing machine
    #100;  // Wait for 1us
    $finish;  // End simulation
  end
  
  // Clock the dut
  always @(posedge clk)
  begin
    #1;  // Delay for 1ns
  end
endmodule
