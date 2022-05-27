`timescale 1ns / 1ps

module FSM_Door(
		input clk,
		input clear,
		input b0,
		input b1,
		input b2,
		input b3,
        output clock,
		output reg LED_right,
		output reg LED_wrong,
		output reg Buzzer
    );
    
    wire [11:0] sw;
    reg [3:1] bn=0;
    
    always @(b0 or b1 or b2 or b3)
        begin
        if(b0 == 1)
            begin
                bn = 3'b001;
            end
        else if(b1 == 1)
            begin
                bn = 3'b010;
            end
        else if(b2 == 1)
            begin
                bn = 3'b011;
            end
        else if(b3 == 1)
            begin
                bn = 3'b100;
            end
//        else begin
//        next_state <= s0;
         
//        end
        end
        
                
    
    assign sw = 12'b001010011100;

    reg [1:0] counter=0;
    reg [3:0] present_state, next_state;
    reg [27:0] count=0;
    parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, s4 = 4'b0100, e1 = 4'b0101, e2 = 4'b0110, e3 = 4'b0111, e4 = 4'b1000;
    
    always@(posedge clk)
        count = count + 1;
// CLK_DIV
    assign clock = count[27];
    
    always @(posedge clock or posedge clear)

    begin
    	if (clear == 1)

    	begin
    		present_state <= s0;
    		Buzzer <= 0;
    		counter <= 0;
    	end

    	else

    	begin
    		present_state <= next_state;
    	end

    end
        
    always @ (present_state)

    begin

    	case (present_state)
    		s0 : if ( bn == sw[11:9] && bn!=0 )
    				next_state <= s1;
    			 else
    			 	next_state <= e1;
    		s1 : if ( bn == sw[8:6] && bn!=0)
    				next_state <= s2;
    			 else
    			 	next_state <= e2;
    		s2 : if ( bn == sw[5:3] && bn!=0)
    				next_state <= s3;
    			 else
    			 	next_state <= e3;
    		s3 : if ( bn == sw[2:0] && bn!=0)
    				next_state <= s4;
    			 else
    			 	next_state <= e4;
    		s4 : if ( bn == sw[11:9] && bn!=0 )
    				next_state <= s1;
    			 else
    			 	next_state <= e1;

    		e1 : next_state <= e2;
    		e2 : next_state <= e3;
    		e3 : next_state <= e4;
    		e4 : if ( bn == sw[11:9] )
    				next_state <= s1;
    			 else
    			 	next_state <= e1;
    		
    		default : next_state <= s0;
    	endcase
    end
    
    always @ (present_state)

    begin
    	if (present_state == s4)
    	begin
    		  LED_right <= 1;
    		  LED_wrong <= 0;  
    	end

    	else if (present_state == e4)
    	begin
    		  LED_right <= 0;
    		  LED_wrong <= 1; 
//    		  counter <= counter + 1; 
    	end

        else
        begin
    		  LED_right <= 0;
    		  LED_wrong <= 0;        
    	end

    end


//    always @ (LED_wrong)
//    begin
//    if(LED_wrong==1)begin
//    counter <= counter + 1;
//    end
//    end
    
//    always @ (counter)
//    begin
//        if(counter ==3)
//            begin
//                Buzzer <= 1;
//            end
//    end
    always @ (counter)

    begin
    	if (counter >= 2'b11)
    	begin
    		  Buzzer <= 1;
//    		  counter <= 0;
//    		  LED_wrong <= 0;  
    	end
        else
        begin
    		  Buzzer <= 0;        
    	end

    end

	
endmodule