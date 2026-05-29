module ucsbece152a_taillights (
    input  logic clk,
    input  logic rst_n,
    input  logic clk_dimmer_i,
    input  logic left_i,
    input  logic right_i,
    input  logic hazard_i,
    input  logic brake_i,
    input  logic runlights_i,
    output logic [5:0] lights_o
);

logic [5:0] fsm_pattern;
logic [5:0] lights_runlightsoff;
logic [5:0] lights_runlightson;

ucsbece152a_fsm fsm (
    .clk(clk),
    .rst_n(rst_n),
    .left_i(left_i),
    .right_i(right_i),
    .hazard_i(hazard_i),
    .state_o(),
    .pattern_o(fsm_pattern)
);

always_comb begin
    lights_runlightsoff = fsm_pattern;

    if (brake_i) begin
        if (left_i && !right_i && !hazard_i) begin
            lights_runlightsoff = fsm_pattern | 6'b000_111;
        end
        else if (right_i && !left_i && !hazard_i) begin
            lights_runlightsoff = fsm_pattern | 6'b111_000;
        end
        else begin
            lights_runlightsoff = 6'b111_111;
        end
    end

    lights_runlightson = lights_runlightsoff | ({6{clk_dimmer_i}} & ~lights_runlightsoff);

    if (!rst_n) begin
        lights_o = 6'b000_000;
    end
    else if (runlights_i) begin
        lights_o = lights_runlightson;
    end
    else begin
        lights_o = lights_runlightsoff;
    end
end

endmodule
