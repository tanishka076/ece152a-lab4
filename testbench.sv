`timescale 1ns/1ps

module taillights_tb;

    logic clk;
    logic rst_n;
    logic clk_dimmer_i;

    logic left_i;
    logic right_i;
    logic hazard_i;
    logic brake_i;
    logic runlights_i;

    logic [5:0] lights_o;

    ucsbece152a_taillights dut (
        .clk(clk),
        .rst_n(rst_n),
        .clk_dimmer_i(clk_dimmer_i),
        .left_i(left_i),
        .right_i(right_i),
        .hazard_i(hazard_i),
        .brake_i(brake_i),
        .runlights_i(runlights_i),
        .lights_o(lights_o)
    );

    always #5 clk = ~clk;
    always #1 clk_dimmer_i = ~clk_dimmer_i;

    initial begin
        clk = 0;
        clk_dimmer_i = 0;

        rst_n = 0;
        left_i = 0;
        right_i = 0;
        hazard_i = 0;
        brake_i = 0;
        runlights_i = 0;

        #20;
        rst_n = 1;

        // No inputs: all lights off
        #40;

        // Left turn signal
        left_i = 1;
        right_i = 0;
        hazard_i = 0;
        brake_i = 0;
        runlights_i = 0;
        #80;

        // Turn left signal off
        left_i = 0;
        #40;

        // Right turn signal
        right_i = 1;
        #80;

        // Turn right signal off
        right_i = 0;
        #40;

        // Hazard lights
        hazard_i = 1;
        #80;

        // Turn hazards off
        hazard_i = 0;
        #40;

        // Both left and right on should behave like hazard
        left_i = 1;
        right_i = 1;
        #80;

        left_i = 0;
        right_i = 0;
        #40;

        // Brake only: all lights on
        brake_i = 1;
        #60;

        // Brake + left turn
        left_i = 1;
        brake_i = 1;
        #80;

        left_i = 0;
        brake_i = 0;
        #40;

        // Brake + right turn
        right_i = 1;
        brake_i = 1;
        #80;

        right_i = 0;
        brake_i = 0;
        #40;

        // Brake + hazard: brake should override hazard
        brake_i = 1;
        hazard_i = 1;
        #60;

        brake_i = 0;
        hazard_i = 0;
        #40;

        // Running lights only
        runlights_i = 1;
        #80;

        // Running lights + left turn
        left_i = 1;
        #80;

        left_i = 0;
        runlights_i = 0;
        #40;

        // Reset test
        left_i = 1;
        brake_i = 1;
        hazard_i = 1;
        runlights_i = 1;
        #30;

        rst_n = 0;
        #30;

        rst_n = 1;
        left_i = 0;
        right_i = 0;
        hazard_i = 0;
        brake_i = 0;
        runlights_i = 0;

        #40;

        $stop;
    end

endmodule
