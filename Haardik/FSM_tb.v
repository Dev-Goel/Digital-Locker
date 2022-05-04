`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2022 00:10:43
// Design Name: 
// Module Name: FSM_tb
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


module FSM_tb;

reg clock;
reg clear;
reg [2:1] bn;
reg [7:0] sw;
wire [1:0] counter;
wire LED_right;
wire LED_wrong;

wire [3:0] state;
wire Buzzer;

initial clock = 1;

//assign state = 0;
FSM_Door fsm(clock, clear, bn, LED_right, LED_wrong,  Buzzer);

always #10 clock=~clock;
initial
    begin

    
    #20 bn = 0;
    #20 bn = 3;
    #20 bn = 0;
    #20 bn = 3;
    #20;
//    #20 clear=1;
//    #5 clear=0;
   
    
    #20 bn = 0;
    #20 bn = 1;
    #20 bn = 0;
    #20 bn = 1;
    
    clear=1;clear=0;
    
//    #20 bn = 0;
//    #20 bn = 3;
//    #20 bn = 0;
//    #20 bn = 3;
    
//    #20 bn = 0;
//    #20 bn = 0;
//    #20 bn = 3;
//    #20 bn = 3;    
    end
    
initial #400 $finish;
endmodule 
