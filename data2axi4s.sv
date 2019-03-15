`timescale 1ns / 1ps

module data2axi4s #(
	PACKET_BYTE = 1024 * 1024 * 4,
	DATA_WIDTH = 64
)(
	input logic clk,
	input logic rst_n,
	input logic [DATA_WIDTH - 1 : 0] in_data,

	output logic [DATA_WIDTH - 1 : 0] tdata,
	output logic tlast,
	input logic tready,
	output logic tvalid
);

	localparam PACKET_LEN = PACKET_BYTE / (DATA_WIDTH / 8);

	reg [$clog2(PACKET_LEN) : 0] packet_cnt = 0;

	always_ff @(posedge clk) begin
		if (~rst_n || packet_cnt == PACKET_LEN - 1) begin
			packet_cnt <= 0;
		end else begin
			packet_cnt <= packet_cnt + 1;
		end
	end


	// aix4 stream signals
	always_ff @(posedge clk) begin
		tdata <= in_data;
	end

	always_ff @(posedge clk) begin
		if (packet_cnt == PACKET_LEN - 1) begin
			tlast <= 1'b1;
		end else begin
			tlast <= 1'b0;
		end
	end

	always_ff @(posedge clk) begin
		if (~rst_n) begin
			tvalid <= 1'b0;
		end else begin
			tvalid <= 1'b1;
		end
	end

endmodule //data2axi4s