module lightfsm(input  logic clk,
                input  logic reset,
                input  logic left, right,
                output logic la, lb, lc, ra, rb, rc);

  typedef enum logic [2:0] {S0,S1,S2,S3,S4,S5,S6} statetype;
  statetype state, nextstate;

  always_ff @ (posedge clk)
  begin
    if(reset)
      state <= S0;
    else
      state <= nextstate;
  end

  always_comb begin
    case(state)
      S0: if(left)        nextstate = S1;
          else if (right) nextstate = S4;
          else            nextstate = S0;
      S1: nextstate = S2;
      S2: nextstate = S3;
      S3: nextstate = S0;
      S4: nextstate = S5;
      S5: nextstate = S6;
      S6: nextstate = S0;
    endcase  
  end

  always_comb begin
    // Initialize all outputs to 0 by default
    la = 1'b0; lb = 1'b0; lc = 1'b0;
    ra = 1'b0; rb = 1'b0; rc = 1'b0;

    case (state)
        // Left turn sequence
        S1: la = 1'b1;                  // Only `la` on
        S2: begin la = 1'b1; lb = 1'b1; end // `la` and `lb` on
        S3: begin la = 1'b1; lb = 1'b1; lc = 1'b1; end // All three on

        // Right turn sequence
        S4: ra = 1'b1;                  // Only `ra` on
        S5: begin ra = 1'b1; rb = 1'b1; end // `ra` and `rb` on
        S6: begin ra = 1'b1; rb = 1'b1; rc = 1'b1; end // All three on

        default: begin
            la = 1'b0; lb = 1'b0; lc = 1'b0;
            ra = 1'b0; rb = 1'b0; rc = 1'b0;
        end
    endcase
  end
  
