

// 
// Module: tb
// 
// Notes:
// - Top level simulation testbench.
//

//`timescale 1ns/1ns
//`define WAVES_FILE "./work/waves-rx.vcd"

module tb();
    
reg        clk          ; // Top level system clock input.
reg rst;
reg neg_clk; 
reg neg_rst ; 
reg        resetn       ;
reg        uart_rxd     ; // UART Recieve pin.

reg        uart_rx_en   ; // Recieve enable
//wire [8:0] res;
wire       uart_rx_break; // Did we get a BREAK message?
wire       uart_rx_valid; // Valid data recieved and available.
wire [7:0] uart_rx_data ; // The recieved data.
wire [31:0] inst ; 
wire [31:0] inst_mem ; 

reg rst_pin ; 
wire write_done ; 


// Bit rate of the UART line we are testing.
localparam BIT_RATE = 9600;
localparam BIT_P    = (1000000000/BIT_RATE);


// Period and frequency of the system clock.
localparam CLK_HZ   = 50000000;
localparam CLK_P    = 1000000000/ CLK_HZ;

reg slow_clk = 0;


// Make the clock tick.
always begin #(CLK_P/2) clk  = ~clk; end   
always begin #(CLK_P/2) neg_clk  = ~neg_clk; end     
always begin #(CLK_P*2) slow_clk <= !slow_clk;end



task write_instruction;
    input [31:0] instruction;
    begin
            @(posedge clk);
            send_byte(instruction[7:0]);
            check_byte(instruction[7:0]);
            @(posedge clk);
            send_byte(instruction[15:8]);
            check_byte(instruction[15:8]);
            
            @(posedge clk);
            send_byte(instruction[23:16]);
            check_byte(instruction[23:16]);
            
            @(posedge clk);
            send_byte(instruction[31:24]);
            check_byte(instruction[31:24]);
    end
    endtask

task send_byte;
    input [7:0] to_send;
    integer i;
    begin


        #BIT_P;  uart_rxd = 1'b0;
        for(i=0; i < 8; i = i+1) begin
            #BIT_P;  uart_rxd = to_send[i];
        end
        #BIT_P;  uart_rxd = 1'b1;
        #1000;
    end
endtask


// Checks that the output of the UART is the value we expect.
integer passes = 0;
integer fails  = 0;
task check_byte;
    input [7:0] expected_value;
    begin
        if(uart_rx_data == expected_value) begin
            passes = passes + 1;
            $display("%d/%d/%d [PASS] Expected %b and got %b", 
                     passes,fails,passes+fails,
                     expected_value, uart_rx_data);
        end else begin
            fails  = fails  + 1;
            $display("%d/%d/%d [FAIL] Expected %b and got %b", 
                     passes,fails,passes+fails,
                     expected_value, uart_rx_data);
        end
    end
endtask


initial 
begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0,tb);
end 

reg [0:23] Sensors; 
wire Motor1A,Motor1B,Motor2A,Motor2B; 
wire [2:0] pc ; 


reg [7:0] to_send;
initial begin
    rst=1;
    rst_pin=1; 
    neg_rst = 1; 
    resetn  = 1'b0;
    clk     = 1'b0;
    neg_clk = 1; 
    neg_rst = ~clk ;
    uart_rxd = 1'b1;
    neg_clk = 1'b1; 
    Sensors =24'h0B0401;
    #4000
    resetn = 1'b1;
    rst=0;
    neg_rst = 0; 
    rst_pin = 0 ; 
   Sensors =24'h01040C;
    #4000

    uart_rx_en = 1'b1;
    /*@(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00712423); 
    @(posedge slow_clk);write_instruction(32'h01010393); 
    @(posedge slow_clk);write_instruction(32'h8201a683); 
    @(posedge slow_clk);write_instruction(32'h00b6a693); 
    @(posedge slow_clk);write_instruction(32'h0016c693); 
    @(posedge slow_clk);write_instruction(32'h0ff6f693); 
    @(posedge slow_clk);write_instruction(32'h00068613); 
    @(posedge slow_clk);write_instruction(32'h80c1a423); 
    @(posedge slow_clk);write_instruction(32'h8241a683); 
    @(posedge slow_clk);write_instruction(32'h00b6a693); 
    @(posedge slow_clk);write_instruction(32'h0016c693); 
    @(posedge slow_clk);write_instruction(32'h0ff6f693); 
    @(posedge slow_clk);write_instruction(32'h00068613); 
    @(posedge slow_clk);write_instruction(32'h000116b7); 
    @(posedge slow_clk);write_instruction(32'h40c6aa23); 
    @(posedge slow_clk);write_instruction(32'h8281a683); 
    @(posedge slow_clk);write_instruction(32'h00b6a693); 
    @(posedge slow_clk);write_instruction(32'h0016c693); 
    @(posedge slow_clk);write_instruction(32'h0ff6f693); 
    @(posedge slow_clk);write_instruction(32'h00068613); 
    @(posedge slow_clk);write_instruction(32'h000116b7); 
    @(posedge slow_clk);write_instruction(32'h40c6a823); 
    @(posedge slow_clk);write_instruction(32'h8081a603); 
    @(posedge slow_clk);write_instruction(32'h00100693); 
    @(posedge slow_clk);write_instruction(32'h00d61663); 
    @(posedge slow_clk);write_instruction(32'h218000ef); 
    @(posedge slow_clk);write_instruction(32'hfa1ff06f); 
    @(posedge slow_clk);write_instruction(32'h000116b7); 
    @(posedge slow_clk);write_instruction(32'h4146a603); 
    @(posedge slow_clk);write_instruction(32'h00100693); 
    @(posedge slow_clk);write_instruction(32'h00d61663); 
    @(posedge slow_clk);write_instruction(32'h0b0000ef); 
    @(posedge slow_clk);write_instruction(32'hf89ff06f); 
    @(posedge slow_clk);write_instruction(32'h000116b7); 
    @(posedge slow_clk);write_instruction(32'h4106a603); 
    @(posedge slow_clk);write_instruction(32'h00100693); 
    @(posedge slow_clk);write_instruction(32'h00d61663); 
    @(posedge slow_clk);write_instruction(32'h178000ef); 
    @(posedge slow_clk);write_instruction(32'hf71ff06f); 
    @(posedge slow_clk);write_instruction(32'h100000ef); 
    @(posedge slow_clk);write_instruction(32'hf69ff06f); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02712623); 
    @(posedge slow_clk);write_instruction(32'h03010393); 
    @(posedge slow_clk);write_instruction(32'hfc83ae23); 
    @(posedge slow_clk);write_instruction(32'hfc93ac23); 
    @(posedge slow_clk);write_instruction(32'hfca3aa23); 
    @(posedge slow_clk);write_instruction(32'h100006b7); 
    @(posedge slow_clk);write_instruction(32'hfff68693); 
    @(posedge slow_clk);write_instruction(32'hfed3a623); 
    @(posedge slow_clk);write_instruction(32'hfec3a683); 
    @(posedge slow_clk);write_instruction(32'h00068713); 
    @(posedge slow_clk);write_instruction(32'h00e87233); 
    @(posedge slow_clk);write_instruction(32'h0ff00793); 
    @(posedge slow_clk);write_instruction(32'h00f275b3); 
    @(posedge slow_clk);write_instruction(32'h00825293); 
    @(posedge slow_clk);write_instruction(32'h00f2f633); 
    @(posedge slow_clk);write_instruction(32'h01025313); 
    @(posedge slow_clk);write_instruction(32'h00f376b3); 
    @(posedge slow_clk);write_instruction(32'hfeb3a423); 
    @(posedge slow_clk);write_instruction(32'hfec3a223); 
    @(posedge slow_clk);write_instruction(32'hfed3a023); 
    @(posedge slow_clk);write_instruction(32'hfdc3a683); 
    @(posedge slow_clk);write_instruction(32'hfe83a603); 
    @(posedge slow_clk);write_instruction(32'h00c6a023); 
    @(posedge slow_clk);write_instruction(32'hfd83a683); 
    @(posedge slow_clk);write_instruction(32'hfe43a603); 
    @(posedge slow_clk);write_instruction(32'h00c6a023); 
    @(posedge slow_clk);write_instruction(32'hfd43a683); 
    @(posedge slow_clk);write_instruction(32'hfe03a603); 
    @(posedge slow_clk);write_instruction(32'h00c6a023); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12383); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00712423); 
    @(posedge slow_clk);write_instruction(32'h01010393); 
    @(posedge slow_clk);write_instruction(32'h10000237); 
    @(posedge slow_clk);write_instruction(32'hfff20213); 
    @(posedge slow_clk);write_instruction(32'h00487833); 
    @(posedge slow_clk);write_instruction(32'h050002b7); 
    @(posedge slow_clk);write_instruction(32'h00586833); 
    @(posedge slow_clk);write_instruction(32'h01000737); 
    @(posedge slow_clk);write_instruction(32'h00e874b3); 
    @(posedge slow_clk);write_instruction(32'h02000737); 
    @(posedge slow_clk);write_instruction(32'h00e87533); 
    @(posedge slow_clk);write_instruction(32'h04000737); 
    @(posedge slow_clk);write_instruction(32'h00e875b3); 
    @(posedge slow_clk);write_instruction(32'h08000737); 
    @(posedge slow_clk);write_instruction(32'h00e87633); 
    @(posedge slow_clk);write_instruction(32'h8091a623); 
    @(posedge slow_clk);write_instruction(32'h80a1a823); 
    @(posedge slow_clk);write_instruction(32'h80b1aa23); 
    @(posedge slow_clk);write_instruction(32'h80c1ac23); 
    @(posedge slow_clk);write_instruction(32'h2bc00413); 
    @(posedge slow_clk);write_instruction(32'h1d0000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812383); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00712423); 
    @(posedge slow_clk);write_instruction(32'h01010393); 
    @(posedge slow_clk);write_instruction(32'h10000237); 
    @(posedge slow_clk);write_instruction(32'hfff20213); 
    @(posedge slow_clk);write_instruction(32'h00487833); 
    @(posedge slow_clk);write_instruction(32'h0a0002b7); 
    @(posedge slow_clk);write_instruction(32'h00586833); 
    @(posedge slow_clk);write_instruction(32'h01000737); 
    @(posedge slow_clk);write_instruction(32'h00e874b3); 
    @(posedge slow_clk);write_instruction(32'h02000737); 
    @(posedge slow_clk);write_instruction(32'h00e87533); 
    @(posedge slow_clk);write_instruction(32'h04000737); 
    @(posedge slow_clk);write_instruction(32'h00e875b3); 
    @(posedge slow_clk);write_instruction(32'h08000737); 
    @(posedge slow_clk);write_instruction(32'h00e87633); 
    @(posedge slow_clk);write_instruction(32'h8091a623); 
    @(posedge slow_clk);write_instruction(32'h80a1a823); 
    @(posedge slow_clk);write_instruction(32'h80b1aa23); 
    @(posedge slow_clk);write_instruction(32'h80c1ac23); 
    @(posedge slow_clk);write_instruction(32'h57800413); 
    @(posedge slow_clk);write_instruction(32'h160000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812383); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00712423); 
    @(posedge slow_clk);write_instruction(32'h01010393); 
    @(posedge slow_clk);write_instruction(32'h10000237); 
    @(posedge slow_clk);write_instruction(32'hfff20213); 
    @(posedge slow_clk);write_instruction(32'h00487833); 
    @(posedge slow_clk);write_instruction(32'h060002b7); 
    @(posedge slow_clk);write_instruction(32'h00586833); 
    @(posedge slow_clk);write_instruction(32'h01000737); 
    @(posedge slow_clk);write_instruction(32'h00e874b3); 
    @(posedge slow_clk);write_instruction(32'h02000737); 
    @(posedge slow_clk);write_instruction(32'h00e87533); 
    @(posedge slow_clk);write_instruction(32'h04000737); 
    @(posedge slow_clk);write_instruction(32'h00e875b3); 
    @(posedge slow_clk);write_instruction(32'h08000737); 
    @(posedge slow_clk);write_instruction(32'h00e87633); 
    @(posedge slow_clk);write_instruction(32'h8091a623); 
    @(posedge slow_clk);write_instruction(32'h80a1a823); 
    @(posedge slow_clk);write_instruction(32'h80b1aa23); 
    @(posedge slow_clk);write_instruction(32'h80c1ac23); 
    @(posedge slow_clk);write_instruction(32'h2bc00413); 
    @(posedge slow_clk);write_instruction(32'h0f0000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812383); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00712423); 
    @(posedge slow_clk);write_instruction(32'h01010393); 
    @(posedge slow_clk);write_instruction(32'h10000237); 
    @(posedge slow_clk);write_instruction(32'hfff20213); 
    @(posedge slow_clk);write_instruction(32'h00487833); 
    @(posedge slow_clk);write_instruction(32'h090002b7); 
    @(posedge slow_clk);write_instruction(32'h00586833); 
    @(posedge slow_clk);write_instruction(32'h01000737); 
    @(posedge slow_clk);write_instruction(32'h00e874b3); 
    @(posedge slow_clk);write_instruction(32'h02000737); 
    @(posedge slow_clk);write_instruction(32'h00e87533); 
    @(posedge slow_clk);write_instruction(32'h04000737); 
    @(posedge slow_clk);write_instruction(32'h00e875b3); 
    @(posedge slow_clk);write_instruction(32'h08000737); 
    @(posedge slow_clk);write_instruction(32'h00e87633); 
    @(posedge slow_clk);write_instruction(32'h8091a623); 
    @(posedge slow_clk);write_instruction(32'h80a1a823); 
    @(posedge slow_clk);write_instruction(32'h80b1aa23); 
    @(posedge slow_clk);write_instruction(32'h80c1ac23); 
    @(posedge slow_clk);write_instruction(32'h57800413); 
    @(posedge slow_clk);write_instruction(32'h080000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812383); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hff010113); 
    @(posedge slow_clk);write_instruction(32'h00112623); 
    @(posedge slow_clk);write_instruction(32'h00712423); 
    @(posedge slow_clk);write_instruction(32'h01010393); 
    @(posedge slow_clk);write_instruction(32'h10000237); 
    @(posedge slow_clk);write_instruction(32'hfff20213); 
    @(posedge slow_clk);write_instruction(32'h00487833); 
    @(posedge slow_clk);write_instruction(32'h01000737); 
    @(posedge slow_clk);write_instruction(32'h00e874b3); 
    @(posedge slow_clk);write_instruction(32'h02000737); 
    @(posedge slow_clk);write_instruction(32'h00e87533); 
    @(posedge slow_clk);write_instruction(32'h04000737); 
    @(posedge slow_clk);write_instruction(32'h00e875b3); 
    @(posedge slow_clk);write_instruction(32'h08000737); 
    @(posedge slow_clk);write_instruction(32'h00e87633); 
    @(posedge slow_clk);write_instruction(32'h8091a623); 
    @(posedge slow_clk);write_instruction(32'h80a1a823); 
    @(posedge slow_clk);write_instruction(32'h80b1aa23); 
    @(posedge slow_clk);write_instruction(32'h80c1ac23); 
    @(posedge slow_clk);write_instruction(32'h57800413); 
    @(posedge slow_clk);write_instruction(32'h018000ef); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00c12083); 
    @(posedge slow_clk);write_instruction(32'h00812383); 
    @(posedge slow_clk);write_instruction(32'h01010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02712623); 
    @(posedge slow_clk);write_instruction(32'h03010393); 
    @(posedge slow_clk);write_instruction(32'hfc83ae23); 
    @(posedge slow_clk);write_instruction(32'hfe03a623); 
    @(posedge slow_clk);write_instruction(32'h0100006f); 
    @(posedge slow_clk);write_instruction(32'hfec3a683); 
    @(posedge slow_clk);write_instruction(32'h00168693); 
    @(posedge slow_clk);write_instruction(32'hfed3a623); 
    @(posedge slow_clk);write_instruction(32'hfec3a603); 
    @(posedge slow_clk);write_instruction(32'hfdc3a683); 
    @(posedge slow_clk);write_instruction(32'hfed646e3); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12383); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hffffffff); 
    @(posedge slow_clk);write_instruction(32'hffffffff); */

     $display("Test Results:");
     $display("    PASSES: %d", passes);
     $display("    FAILS : %d", fails);
    #100000
    $display("Finish simulation at time %d", $time);
    $finish;
end

 wrapper dut (
.clk        (clk          ), // Top level system clock input.
.resetn       (resetn       ), // Asynchronous active low reset.
.uart_rxd     (uart_rxd     ), // UART Recieve pin.
.uart_rx_en   (uart_rx_en   ), // Recieve enable
.uart_rx_break(uart_rx_break), // Did we get a BREAK message?
.uart_rx_valid(uart_rx_valid), // Valid data recieved and available.
.uart_rx_data (uart_rx_data ), 
.Motor1A(Motor1A),
.Motor1B(Motor1B),
.Motor2A(Motor2A),
.Motor2B(Motor2B), 
.write_done(write_done)
); 



endmodule
