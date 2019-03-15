`timescale 1ns / 1ps

module tb_data2axi4s;

	localparam STEP = 10;

	logic clk;
	logic rst_n;
	logic [63 : 0] in_data;

	logic [63 : 0] tdata;
	logic tlast;
	logic tready;
	logic tvalid;


	data2axi4s #(.PACKET_BYTE(64))
		data2axi4s(
		.clk(clk), .rst_n(rst_n), .in_data(in_data),
		.tdata(tdata), .tlast(tlast), .tready(tready), .tvalid(tvalid)
	);


	always begin
		clk = 1; #(STEP);
		clk = 0; #(STEP);
	end

	always_ff @(posedge clk) begin
		if(~rst_n) begin
			in_data <= 0;
		end else begin
			in_data <= in_data + 1;
		end
	end

	initial begin
		rst_n = 0;
		tready = 1;
		#(STEP * 10);
		rst_n = 1;

		#(STEP * 1000);

		$finish;
	end

endmodule