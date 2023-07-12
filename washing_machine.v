module WashingMachine;
  // Input signals
  reg start;       // Start signal
  // Output signals
  reg water;       // Water control signal
  reg detergent;   // Detergent control signal
  reg door;        // Door control signal
  
  // Internal registers
  reg [5:0] timer; // Timer counter (6 bits for 0 to 105 minutes)
  
  // Washing machine states
  localparam IDLE = 2'b00;          // Idle state
  localparam WASHING_DETERGENT = 2'b01;  // Washing with detergent state
  localparam WASHING_WATER = 2'b10;      // Washing with water state
  localparam DRYING = 2'b11;             // Drying state
  
  // Current state
  reg [1:0] state;
  
  always @(posedge start)
  begin
    case (state)
      IDLE:
        begin
          water <= 0;         // Water off
          detergent <= 0;     // Detergent off
          door <= 0;          // Door closed
          timer <= 0;         // Reset timer
          state <= WASHING_DETERGENT;  // Transition to washing with detergent state
        end
      
      WASHING_DETERGENT:
        begin
          water <= 1;         // Water on
          detergent <= 1;     // Detergent on
          door <= 0;          // Door closed
          timer <= timer + 1; // Increment timer
          if (timer >= 30)    // Check if 30 minutes have elapsed
            state <= WASHING_WATER;  // Transition to washing with water state
        end
      
      WASHING_WATER:
        begin
          water <= 1;         // Water on
          detergent <= 0;     // Detergent off
          door <= 0;          // Door closed
          timer <= timer + 1; // Increment timer
          if (timer >= 60)    // Check if 60 minutes have elapsed
            state <= DRYING;  // Transition to drying state
        end
      
      DRYING:
        begin
          water <= 0;         // Water off
          detergent <= 0;     // Detergent off
          door <= 0;          // Door closed
          timer <= timer + 1; // Increment timer
          if (timer >= 105)   // Check if 105 minutes have elapsed
            door <= 1;        // Open the door
        end
    endcase
  end
endmodule
