//Train Track Problem using Finite State Machines
//
//
// created by Rahul Marathe
// 4t October 2017
//
// 
//
//
module TrainTrack(Clock,reset,S1,S2,S3,S4,S5,SW1,SW2,SW3,DA1,DA0,DB1,DB0);
input Clock,S1,S2,S3,S4,S5,reset;
output SW1,SW2,SW3,DA1,DA0,DB1,DB0;
reg SW1,SW2,SW3,SW4,DA1,DA0,DB1,DB0;
 
parameter ON= 1'b1;
parameter OFF=1'b0;

parameter  
BothStartMoving       =  5'b00001,
AMoves1BMoves2        =  5'b00010, 		//AMoves1BMoves2 indicates A is moving on track 1 and B on Shared 2 
AMoves2BMoves3        =  5'b00100, 		//AMoves2BMoves3 indicates A is moving on Shared track 2 and B on Track3  
AMoves2BStops3        =  5'b01000,              //AMoves2BStops3 indicates A is moving on Shared track 2 and B is stopped on Sensor S2 on Track 3 
AStops1BMoves2        =  5'b10000;		//AMoves2BStops3 indicates B is moving on Shared track 2 and A is stopped on Sensor S1 on Track 1 


reg [4:0] State,NextState;

// STATE UPDATION ON EVERY CLOCK EDGE
 
always @(posedge Clock)
begin
if(reset)
State<=BothStartMoving;
else 
State<=NextState;
end

  
//Moore

always@(State)
begin
case(State)

//Both trains start moving on Tracks(1) and (3) respectively;
BothStartMoving            :   begin
	      			SW1=1;
	      			SW2=1;
	      			SW3=0;
	      			DA1=0;
	      			DA0=1;
	      			DB1=0;
	      			DB0=1;
	      		end

//A approaches first and B also keeps moving on(3)
AMoves2BMoves3  	:       begin
	      			SW1=0;
	      			SW2=0;
	      			SW3=0;
	      			DA1=0;
	      			DA0=1;
	      			DB1=0;
	      			DB0=1;
	      		end

//B approaches first at common track and A also keeps moving on(1)
AMoves1BMoves2 :   begin
	      			SW1=1;
	      			SW2=1;
	      			SW3=0;
	      			DA1=0;
	      			DA0=1;
	      			DB1=0;
	      			DB0=1;
	      		end

//A stops at sensor 1 and B keeps moving on Shared Track(2)
AStops1BMoves2		 :   begin
	      			SW1=1;
	      			SW2=1;
	      			SW3=0;
	      			DA1=0;
	      			DA0=0;
	      			DB1=0;
	      			DB0=1;
	      		end


//B stops at sensor 2 and A keeps moving on Shared Track(2)
AMoves2BStops3 :   begin
	      			SW1=0;
	      			SW2=0;
	      			SW3=0;
	      			DA1=0;
	      			DA0=1;
	      			DB1=0;
	      			DB0=0;
	      		end
endcase
end  



//Next State Generator
always@(State or S1 or S2 or S3 or S4 or S5)
begin
case(State)

	BothStartMoving 	: begin 
				if(S1&& !S2 && !S3 && !S4 ) 
				NextState= AMoves2BMoves3;
			 	else if	(!S1 && S2 && !S3 &&!S4)
			 	NextState=AMoves1BMoves2;
				else		
				NextState=BothStartMoving;		
				end

	AMoves2BMoves3 :	begin
		        	if(S2)
				NextState=AMoves2BStops3;
				else if(S4)
				NextState=AMoves2BMoves3;
				end


	AMoves2BStops3 :	 begin
		        	if(S2&&S4)
				NextState=AMoves1BMoves2;
				else
				NextState=AMoves2BStops3;
	 			end

	AMoves1BMoves2 : begin
		                if(S1)
				NextState= AStops1BMoves2;
				else if(S3)
				NextState=AMoves1BMoves2;
				end
				

	AStops1BMoves2 : begin
		        	if(S1&&S3)
				NextState=AMoves2BMoves3;
				else
				NextState=AStops1BMoves2;
				end	

endcase 
end


endmodule
 

	

	
			
			
		
