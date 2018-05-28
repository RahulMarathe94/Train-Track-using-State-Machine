//Test Bench for Train Track Problem using Finite State Machines
//
//
// created by Rahul Marathe
// 4t October 2017 
//
//
//
// 
//
module TestBench;                                       //Module TestBench
reg reset,Clock,S1,S2,S3,S4,S5;				//Inputs are set as reg variables
wire SW1,SW2,SW3,DA0,DA1,DB0,DB1;			//Outputs are set as wires	

parameter TRUE           =1'b1;
parameter FALSE          =1'b0;
parameter CLOCK_CYCLE    =20;
parameter CLOCK_WIDTH    = CLOCK_CYCLE/2;
parameter IDLE_CLOCKS    =2;

TrainTrack TT(Clock,reset,S1,S2,S3,S4,S5,SW1,SW2,SW3,DA1,DA0,DB1,DB0);  //Instantiate a Module of TrainTrack which implements the Finite State Machine
//
///
//
initial 
begin
$display("                   Time  Clock  reset      S1 S2 S3 S4 S5     SW1 SW2 SW3   DA0DA1   DB0DB1\n");
$monitor($time,  "      %b       %b        %b  %b  %b  %b  %b       %b   %b   %b     %b  %b     %b  %b ",Clock,reset,S1,S2,S3,S4,S5,SW1,SW2,SW3,DA1,DA0,DB1,DB0);
end

//Create a Clock
initial 
begin
Clock=FALSE; 
forever #CLOCK_WIDTH Clock = ~Clock;
end
 
//Generate reset  

initial
begin
reset= TRUE;
repeat (IDLE_CLOCKS)@(negedge Clock);
reset = FALSE; 
end

//
// Generate stimulus
//
 
initial 
begin
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b00000;   
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b10000;   
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b01000;
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b01010;
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b10000;
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b10100;
@(negedge Clock); {S1,S2,S3,S4,S5} = 5'b01000;





@(negedge Clock);
$stop;
end


endmodule

