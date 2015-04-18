// (C) 1992-2014 Altera Corporation. All rights reserved.                         
// Your use of Altera Corporation's design tools, logic functions and other       
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Altera MegaCore Function License Agreement, or other applicable     
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Altera and sold by   
// Altera or its authorized distributors.  Please refer to the applicable         
// agreement for further details.                                                 
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module graying_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input [31:0] 		input_iterations,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		output 		lvb_bb0_cmp5,
		output [3:0] 		lvb_bb0_memcoalesce_img_test_out_or_byte_en_2,
		input [31:0] 		workgroup_size
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb0_cmp5_inputs_ready;
 reg local_bb0_cmp5_wii_reg_NO_SHIFT_REG;
 reg local_bb0_cmp5_valid_out_0_NO_SHIFT_REG;
wire local_bb0_cmp5_stall_in_0;
 reg local_bb0_cmp5_valid_out_1_NO_SHIFT_REG;
wire local_bb0_cmp5_stall_in_1;
wire local_bb0_cmp5_output_regs_ready;
 reg local_bb0_cmp5_NO_SHIFT_REG;
wire local_bb0_cmp5_causedstall;

assign local_bb0_cmp5_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_cmp5_output_regs_ready = (~(local_bb0_cmp5_wii_reg_NO_SHIFT_REG) & ((~(local_bb0_cmp5_valid_out_0_NO_SHIFT_REG) | ~(local_bb0_cmp5_stall_in_0)) & (~(local_bb0_cmp5_valid_out_1_NO_SHIFT_REG) | ~(local_bb0_cmp5_stall_in_1))));
assign merge_node_stall_in_0 = (~(local_bb0_cmp5_wii_reg_NO_SHIFT_REG) & (~(local_bb0_cmp5_output_regs_ready) | ~(local_bb0_cmp5_inputs_ready)));
assign local_bb0_cmp5_causedstall = (local_bb0_cmp5_inputs_ready && (~(local_bb0_cmp5_output_regs_ready) && !(~(local_bb0_cmp5_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp5_NO_SHIFT_REG <= 'x;
		local_bb0_cmp5_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb0_cmp5_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp5_NO_SHIFT_REG <= 'x;
			local_bb0_cmp5_valid_out_0_NO_SHIFT_REG <= 1'b0;
			local_bb0_cmp5_valid_out_1_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp5_output_regs_ready)
			begin
				local_bb0_cmp5_NO_SHIFT_REG <= (input_iterations == 32'h0);
				local_bb0_cmp5_valid_out_0_NO_SHIFT_REG <= local_bb0_cmp5_inputs_ready;
				local_bb0_cmp5_valid_out_1_NO_SHIFT_REG <= local_bb0_cmp5_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_cmp5_stall_in_0))
				begin
					local_bb0_cmp5_valid_out_0_NO_SHIFT_REG <= local_bb0_cmp5_wii_reg_NO_SHIFT_REG;
				end
				if (~(local_bb0_cmp5_stall_in_1))
				begin
					local_bb0_cmp5_valid_out_1_NO_SHIFT_REG <= local_bb0_cmp5_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_cmp5_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_cmp5_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_cmp5_inputs_ready)
			begin
				local_bb0_cmp5_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_var__inputs_ready;
 reg local_bb0_var__wii_reg_NO_SHIFT_REG;
 reg local_bb0_var__valid_out_0_NO_SHIFT_REG;
wire local_bb0_var__stall_in_0;
 reg local_bb0_var__valid_out_1_NO_SHIFT_REG;
wire local_bb0_var__stall_in_1;
 reg local_bb0_var__valid_out_2_NO_SHIFT_REG;
wire local_bb0_var__stall_in_2;
wire local_bb0_var__output_regs_ready;
 reg [3:0] local_bb0_var__NO_SHIFT_REG;
wire local_bb0_var__causedstall;

assign local_bb0_var__inputs_ready = local_bb0_cmp5_valid_out_0_NO_SHIFT_REG;
assign local_bb0_var__output_regs_ready = (~(local_bb0_var__wii_reg_NO_SHIFT_REG) & ((~(local_bb0_var__valid_out_0_NO_SHIFT_REG) | ~(local_bb0_var__stall_in_0)) & (~(local_bb0_var__valid_out_1_NO_SHIFT_REG) | ~(local_bb0_var__stall_in_1)) & (~(local_bb0_var__valid_out_2_NO_SHIFT_REG) | ~(local_bb0_var__stall_in_2))));
assign local_bb0_cmp5_stall_in_0 = (~(local_bb0_var__wii_reg_NO_SHIFT_REG) & (~(local_bb0_var__output_regs_ready) | ~(local_bb0_var__inputs_ready)));
assign local_bb0_var__causedstall = (local_bb0_var__inputs_ready && (~(local_bb0_var__output_regs_ready) && !(~(local_bb0_var__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_var__NO_SHIFT_REG <= 'x;
		local_bb0_var__valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb0_var__valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb0_var__valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_var__NO_SHIFT_REG <= 'x;
			local_bb0_var__valid_out_0_NO_SHIFT_REG <= 1'b0;
			local_bb0_var__valid_out_1_NO_SHIFT_REG <= 1'b0;
			local_bb0_var__valid_out_2_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_var__output_regs_ready)
			begin
				local_bb0_var__NO_SHIFT_REG <= local_bb0_cmp5_NO_SHIFT_REG;
				local_bb0_var__valid_out_0_NO_SHIFT_REG <= local_bb0_var__inputs_ready;
				local_bb0_var__valid_out_1_NO_SHIFT_REG <= local_bb0_var__inputs_ready;
				local_bb0_var__valid_out_2_NO_SHIFT_REG <= local_bb0_var__inputs_ready;
			end
			else
			begin
				if (~(local_bb0_var__stall_in_0))
				begin
					local_bb0_var__valid_out_0_NO_SHIFT_REG <= local_bb0_var__wii_reg_NO_SHIFT_REG;
				end
				if (~(local_bb0_var__stall_in_1))
				begin
					local_bb0_var__valid_out_1_NO_SHIFT_REG <= local_bb0_var__wii_reg_NO_SHIFT_REG;
				end
				if (~(local_bb0_var__stall_in_2))
				begin
					local_bb0_var__valid_out_2_NO_SHIFT_REG <= local_bb0_var__wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_var__wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_var__wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_var__inputs_ready)
			begin
				local_bb0_var__wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb0_memcoalesce_img_test_out_cast_byte_en_1_stall_local;
wire [3:0] local_bb0_memcoalesce_img_test_out_cast_byte_en_1;

assign local_bb0_memcoalesce_img_test_out_cast_byte_en_1 = (local_bb0_var__NO_SHIFT_REG << 4'h1);

// This section implements an unregistered operation.
// 
wire local_bb0_memcoalesce_img_test_out_cast_byte_en_2_stall_local;
wire [3:0] local_bb0_memcoalesce_img_test_out_cast_byte_en_2;

assign local_bb0_memcoalesce_img_test_out_cast_byte_en_2 = (local_bb0_var__NO_SHIFT_REG << 4'h2);

// This section implements an unregistered operation.
// 
wire local_bb0_var__u0_stall_local;
wire [3:0] local_bb0_var__u0;

assign local_bb0_var__u0 = (local_bb0_memcoalesce_img_test_out_cast_byte_en_1 | local_bb0_var__NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb0_var__u1_valid_out;
wire local_bb0_var__u1_stall_in;
wire local_bb0_var__u1_inputs_ready;
wire local_bb0_var__u1_stall_local;
wire [3:0] local_bb0_var__u1;

assign local_bb0_var__u1_inputs_ready = (local_bb0_var__valid_out_0_NO_SHIFT_REG & local_bb0_var__valid_out_1_NO_SHIFT_REG & local_bb0_var__valid_out_2_NO_SHIFT_REG);
assign local_bb0_var__u1 = (local_bb0_memcoalesce_img_test_out_cast_byte_en_2 | local_bb0_var__u0);
assign local_bb0_var__u1_valid_out = local_bb0_var__u1_inputs_ready;
assign local_bb0_var__u1_stall_local = local_bb0_var__u1_stall_in;
assign local_bb0_var__stall_in_0 = (local_bb0_var__u1_stall_local | ~(local_bb0_var__u1_inputs_ready));
assign local_bb0_var__stall_in_1 = (local_bb0_var__u1_stall_local | ~(local_bb0_var__u1_inputs_ready));
assign local_bb0_var__stall_in_2 = (local_bb0_var__u1_stall_local | ~(local_bb0_var__u1_inputs_ready));

// This section implements a registered operation.
// 
wire local_bb0_memcoalesce_img_test_out_or_byte_en_2_inputs_ready;
 reg local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG;
 reg local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG;
wire local_bb0_memcoalesce_img_test_out_or_byte_en_2_stall_in;
wire local_bb0_memcoalesce_img_test_out_or_byte_en_2_output_regs_ready;
 reg [3:0] local_bb0_memcoalesce_img_test_out_or_byte_en_2_NO_SHIFT_REG;
wire local_bb0_memcoalesce_img_test_out_or_byte_en_2_causedstall;

assign local_bb0_memcoalesce_img_test_out_or_byte_en_2_inputs_ready = local_bb0_var__u1_valid_out;
assign local_bb0_memcoalesce_img_test_out_or_byte_en_2_output_regs_ready = (~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG) | ~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_stall_in))));
assign local_bb0_var__u1_stall_in = (~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG) & (~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_output_regs_ready) | ~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_inputs_ready)));
assign local_bb0_memcoalesce_img_test_out_or_byte_en_2_causedstall = (local_bb0_memcoalesce_img_test_out_or_byte_en_2_inputs_ready && (~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_output_regs_ready) && !(~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_memcoalesce_img_test_out_or_byte_en_2_NO_SHIFT_REG <= 'x;
		local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_memcoalesce_img_test_out_or_byte_en_2_NO_SHIFT_REG <= 'x;
			local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_memcoalesce_img_test_out_or_byte_en_2_output_regs_ready)
			begin
				local_bb0_memcoalesce_img_test_out_or_byte_en_2_NO_SHIFT_REG <= (local_bb0_var__u1 ^ 4'h7);
				local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG <= local_bb0_memcoalesce_img_test_out_or_byte_en_2_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_memcoalesce_img_test_out_or_byte_en_2_stall_in))
				begin
					local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG <= local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_memcoalesce_img_test_out_or_byte_en_2_inputs_ready)
			begin
				local_bb0_memcoalesce_img_test_out_or_byte_en_2_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg lvb_bb0_cmp5_reg_NO_SHIFT_REG;
 reg [3:0] lvb_bb0_memcoalesce_img_test_out_or_byte_en_2_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb0_memcoalesce_img_test_out_or_byte_en_2_valid_out_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG & local_bb0_cmp5_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb0_memcoalesce_img_test_out_or_byte_en_2_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign merge_node_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_cmp5_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb0_cmp5 = lvb_bb0_cmp5_reg_NO_SHIFT_REG;
assign lvb_bb0_memcoalesce_img_test_out_or_byte_en_2 = lvb_bb0_memcoalesce_img_test_out_or_byte_en_2_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb0_cmp5_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_memcoalesce_img_test_out_or_byte_en_2_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb0_cmp5_reg_NO_SHIFT_REG <= local_bb0_cmp5_NO_SHIFT_REG;
			lvb_bb0_memcoalesce_img_test_out_or_byte_en_2_reg_NO_SHIFT_REG <= local_bb0_memcoalesce_img_test_out_or_byte_en_2_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module graying_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_iterations,
		input [63:0] 		input_img_test_in,
		input [63:0] 		input_img_test_out,
		input 		input_wii_cmp5,
		input [3:0] 		input_wii_memcoalesce_img_test_out_or_byte_en_2,
		input 		valid_in_0,
		output 		stall_out_0,
		input 		input_forked_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input 		input_forked_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output 		valid_out_1,
		input 		stall_in_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input 		feedback_valid_in_4,
		output 		feedback_stall_out_4,
		input [3:0] 		feedback_data_in_4,
		input 		feedback_valid_in_0,
		output 		feedback_stall_out_0,
		input 		feedback_data_in_0,
		input 		feedback_valid_in_1,
		output 		feedback_stall_out_1,
		input 		feedback_data_in_1,
		output 		acl_pipelined_valid,
		input 		acl_pipelined_stall,
		output 		acl_pipelined_exiting_valid,
		output 		acl_pipelined_exiting_stall,
		input 		feedback_valid_in_3,
		output 		feedback_stall_out_3,
		input [3:0] 		feedback_data_in_3,
		input 		feedback_valid_in_2,
		output 		feedback_stall_out_2,
		input [63:0] 		feedback_data_in_2,
		output 		feedback_valid_out_3,
		input 		feedback_stall_in_3,
		output [3:0] 		feedback_data_out_3,
		output 		feedback_valid_out_0,
		input 		feedback_stall_in_0,
		output 		feedback_data_out_0,
		output 		feedback_valid_out_2,
		input 		feedback_stall_in_2,
		output [63:0] 		feedback_data_out_2,
		output 		feedback_valid_out_4,
		input 		feedback_stall_in_4,
		output [3:0] 		feedback_data_out_4,
		input [255:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdata,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdatavalid,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_waitrequest,
		output [29:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_address,
		output 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_read,
		output 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_write,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writeack,
		output [255:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writedata,
		output [31:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_byteenable,
		output [4:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_burstcount,
		output 		local_bb1_ld_memcoalesce_img_test_in_load_0_active,
		input 		clock2x,
		output 		feedback_valid_out_1,
		input 		feedback_stall_in_1,
		output 		feedback_data_out_1,
		input [255:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdata,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdatavalid,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_waitrequest,
		output [29:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_address,
		output 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_read,
		output 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_write,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writeack,
		output [255:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writedata,
		output [31:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_byteenable,
		output [4:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_burstcount,
		output 		local_bb1_st_memcoalesce_img_test_out_insertValue_0_active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg input_forked_0_staging_reg_NO_SHIFT_REG;
 reg local_lvm_forked_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg input_forked_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_forked_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_forked_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_0_staging_reg_NO_SHIFT_REG <= input_forked_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_forked_1_staging_reg_NO_SHIFT_REG <= input_forked_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_forked_NO_SHIFT_REG <= input_forked_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready;
 reg local_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
wire local_bb1_cleanups_pop4_acl_pop_i4_7_stall_in;
wire local_bb1_cleanups_pop4_acl_pop_i4_7_output_regs_ready;
wire [3:0] local_bb1_cleanups_pop4_acl_pop_i4_7_result;
wire local_bb1_cleanups_pop4_acl_pop_i4_7_fu_valid_out;
wire local_bb1_cleanups_pop4_acl_pop_i4_7_fu_stall_out;
 reg [3:0] local_bb1_cleanups_pop4_acl_pop_i4_7_NO_SHIFT_REG;
wire local_bb1_cleanups_pop4_acl_pop_i4_7_causedstall;

acl_pop local_bb1_cleanups_pop4_acl_pop_i4_7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_lvm_forked_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(4'h7),
	.stall_out(local_bb1_cleanups_pop4_acl_pop_i4_7_fu_stall_out),
	.valid_in(local_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready),
	.valid_out(local_bb1_cleanups_pop4_acl_pop_i4_7_fu_valid_out),
	.stall_in(~(local_bb1_cleanups_pop4_acl_pop_i4_7_output_regs_ready)),
	.data_out(local_bb1_cleanups_pop4_acl_pop_i4_7_result),
	.feedback_in(feedback_data_in_4),
	.feedback_valid_in(feedback_valid_in_4),
	.feedback_stall_out(feedback_stall_out_4)
);

defparam local_bb1_cleanups_pop4_acl_pop_i4_7_feedback.DATA_WIDTH = 4;
defparam local_bb1_cleanups_pop4_acl_pop_i4_7_feedback.STYLE = "REGULAR";

assign local_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cleanups_pop4_acl_pop_i4_7_output_regs_ready = (&(~(local_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_NO_SHIFT_REG) | ~(local_bb1_cleanups_pop4_acl_pop_i4_7_stall_in)));
assign merge_node_stall_in_0 = (local_bb1_cleanups_pop4_acl_pop_i4_7_fu_stall_out | ~(local_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready));
assign local_bb1_cleanups_pop4_acl_pop_i4_7_causedstall = (local_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready && (local_bb1_cleanups_pop4_acl_pop_i4_7_fu_stall_out && !(~(local_bb1_cleanups_pop4_acl_pop_i4_7_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cleanups_pop4_acl_pop_i4_7_NO_SHIFT_REG <= 'x;
		local_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_cleanups_pop4_acl_pop_i4_7_output_regs_ready)
		begin
			local_bb1_cleanups_pop4_acl_pop_i4_7_NO_SHIFT_REG <= local_bb1_cleanups_pop4_acl_pop_i4_7_result;
			local_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= local_bb1_cleanups_pop4_acl_pop_i4_7_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_cleanups_pop4_acl_pop_i4_7_stall_in))
			begin
				local_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_keep_going_forked_inputs_ready;
 reg local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG;
wire local_bb1_keep_going_forked_stall_in;
wire local_bb1_keep_going_forked_output_regs_ready;
wire local_bb1_keep_going_forked_keep_going;
wire local_bb1_keep_going_forked_fu_valid_out;
wire local_bb1_keep_going_forked_fu_stall_out;
 reg local_bb1_keep_going_forked_NO_SHIFT_REG;
wire local_bb1_keep_going_forked_feedback_pipelined;
wire local_bb1_keep_going_forked_causedstall;

acl_pipeline local_bb1_keep_going_forked_pipelined (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_lvm_forked_NO_SHIFT_REG),
	.stall_out(local_bb1_keep_going_forked_fu_stall_out),
	.valid_in(local_bb1_keep_going_forked_inputs_ready),
	.valid_out(local_bb1_keep_going_forked_fu_valid_out),
	.stall_in(~(local_bb1_keep_going_forked_output_regs_ready)),
	.data_out(local_bb1_keep_going_forked_keep_going),
	.initeration_in(feedback_data_in_0),
	.initeration_valid_in(feedback_valid_in_0),
	.initeration_stall_out(feedback_stall_out_0),
	.not_exitcond_in(feedback_data_in_1),
	.not_exitcond_valid_in(feedback_valid_in_1),
	.not_exitcond_stall_out(feedback_stall_out_1),
	.pipeline_valid_out(acl_pipelined_valid),
	.pipeline_stall_in(acl_pipelined_stall),
	.exiting_valid_out(acl_pipelined_exiting_valid)
);

defparam local_bb1_keep_going_forked_pipelined.FIFO_DEPTH = 2;
defparam local_bb1_keep_going_forked_pipelined.STYLE = "SPECULATIVE";

assign local_bb1_keep_going_forked_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb1_keep_going_forked_output_regs_ready = (&(~(local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG) | ~(local_bb1_keep_going_forked_stall_in)));
assign acl_pipelined_exiting_stall = acl_pipelined_stall;
assign merge_node_stall_in_1 = (local_bb1_keep_going_forked_fu_stall_out | ~(local_bb1_keep_going_forked_inputs_ready));
assign local_bb1_keep_going_forked_causedstall = (local_bb1_keep_going_forked_inputs_ready && (local_bb1_keep_going_forked_fu_stall_out && !(~(local_bb1_keep_going_forked_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_keep_going_forked_NO_SHIFT_REG <= 'x;
		local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_keep_going_forked_output_regs_ready)
		begin
			local_bb1_keep_going_forked_NO_SHIFT_REG <= local_bb1_keep_going_forked_keep_going;
			local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG <= local_bb1_keep_going_forked_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_keep_going_forked_stall_in))
			begin
				local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_initerations_pop3_acl_pop_i4_7_inputs_ready;
 reg local_bb1_initerations_pop3_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
wire local_bb1_initerations_pop3_acl_pop_i4_7_stall_in;
wire local_bb1_initerations_pop3_acl_pop_i4_7_output_regs_ready;
wire [3:0] local_bb1_initerations_pop3_acl_pop_i4_7_result;
wire local_bb1_initerations_pop3_acl_pop_i4_7_fu_valid_out;
wire local_bb1_initerations_pop3_acl_pop_i4_7_fu_stall_out;
 reg [3:0] local_bb1_initerations_pop3_acl_pop_i4_7_NO_SHIFT_REG;
wire local_bb1_initerations_pop3_acl_pop_i4_7_causedstall;

acl_pop local_bb1_initerations_pop3_acl_pop_i4_7_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_lvm_forked_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(4'h7),
	.stall_out(local_bb1_initerations_pop3_acl_pop_i4_7_fu_stall_out),
	.valid_in(local_bb1_initerations_pop3_acl_pop_i4_7_inputs_ready),
	.valid_out(local_bb1_initerations_pop3_acl_pop_i4_7_fu_valid_out),
	.stall_in(~(local_bb1_initerations_pop3_acl_pop_i4_7_output_regs_ready)),
	.data_out(local_bb1_initerations_pop3_acl_pop_i4_7_result),
	.feedback_in(feedback_data_in_3),
	.feedback_valid_in(feedback_valid_in_3),
	.feedback_stall_out(feedback_stall_out_3)
);

defparam local_bb1_initerations_pop3_acl_pop_i4_7_feedback.DATA_WIDTH = 4;
defparam local_bb1_initerations_pop3_acl_pop_i4_7_feedback.STYLE = "REGULAR";

assign local_bb1_initerations_pop3_acl_pop_i4_7_inputs_ready = merge_node_valid_out_2_NO_SHIFT_REG;
assign local_bb1_initerations_pop3_acl_pop_i4_7_output_regs_ready = (&(~(local_bb1_initerations_pop3_acl_pop_i4_7_valid_out_NO_SHIFT_REG) | ~(local_bb1_initerations_pop3_acl_pop_i4_7_stall_in)));
assign merge_node_stall_in_2 = (local_bb1_initerations_pop3_acl_pop_i4_7_fu_stall_out | ~(local_bb1_initerations_pop3_acl_pop_i4_7_inputs_ready));
assign local_bb1_initerations_pop3_acl_pop_i4_7_causedstall = (local_bb1_initerations_pop3_acl_pop_i4_7_inputs_ready && (local_bb1_initerations_pop3_acl_pop_i4_7_fu_stall_out && !(~(local_bb1_initerations_pop3_acl_pop_i4_7_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_initerations_pop3_acl_pop_i4_7_NO_SHIFT_REG <= 'x;
		local_bb1_initerations_pop3_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_initerations_pop3_acl_pop_i4_7_output_regs_ready)
		begin
			local_bb1_initerations_pop3_acl_pop_i4_7_NO_SHIFT_REG <= local_bb1_initerations_pop3_acl_pop_i4_7_result;
			local_bb1_initerations_pop3_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= local_bb1_initerations_pop3_acl_pop_i4_7_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_initerations_pop3_acl_pop_i4_7_stall_in))
			begin
				local_bb1_initerations_pop3_acl_pop_i4_7_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready;
 reg local_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_NO_SHIFT_REG;
wire local_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in;
wire local_bb1_indvars_iv15_pop2_acl_pop_i64_0_output_regs_ready;
wire [63:0] local_bb1_indvars_iv15_pop2_acl_pop_i64_0_result;
wire local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_valid_out;
wire local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_stall_out;
 reg [63:0] local_bb1_indvars_iv15_pop2_acl_pop_i64_0_NO_SHIFT_REG;
wire local_bb1_indvars_iv15_pop2_acl_pop_i64_0_causedstall;

acl_pop local_bb1_indvars_iv15_pop2_acl_pop_i64_0_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_lvm_forked_NO_SHIFT_REG),
	.predicate(1'b0),
	.data_in(64'h0),
	.stall_out(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_stall_out),
	.valid_in(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready),
	.valid_out(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_valid_out),
	.stall_in(~(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_output_regs_ready)),
	.data_out(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_result),
	.feedback_in(feedback_data_in_2),
	.feedback_valid_in(feedback_valid_in_2),
	.feedback_stall_out(feedback_stall_out_2)
);

defparam local_bb1_indvars_iv15_pop2_acl_pop_i64_0_feedback.DATA_WIDTH = 64;
defparam local_bb1_indvars_iv15_pop2_acl_pop_i64_0_feedback.STYLE = "REGULAR";

assign local_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready = merge_node_valid_out_3_NO_SHIFT_REG;
assign local_bb1_indvars_iv15_pop2_acl_pop_i64_0_output_regs_ready = (&(~(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_NO_SHIFT_REG) | ~(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in)));
assign merge_node_stall_in_3 = (local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_stall_out | ~(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready));
assign local_bb1_indvars_iv15_pop2_acl_pop_i64_0_causedstall = (local_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready && (local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_stall_out && !(~(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_indvars_iv15_pop2_acl_pop_i64_0_NO_SHIFT_REG <= 'x;
		local_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_indvars_iv15_pop2_acl_pop_i64_0_output_regs_ready)
		begin
			local_bb1_indvars_iv15_pop2_acl_pop_i64_0_NO_SHIFT_REG <= local_bb1_indvars_iv15_pop2_acl_pop_i64_0_result;
			local_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_NO_SHIFT_REG <= local_bb1_indvars_iv15_pop2_acl_pop_i64_0_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in))
			begin
				local_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 164
//  * capacity = 164
 logic rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_fifo.DEPTH = 165;
defparam rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_fifo.DATA_WIDTH = 0;
defparam rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_fifo.IMPL = "ram";

assign rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_reg_165_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_reg_165_NO_SHIFT_REG = rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_NO_SHIFT_REG;
assign rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_NO_SHIFT_REG = rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_0;
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_0;
 reg rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_1;
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_1;
 reg rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready;
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_local;
 reg rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_combined_valid;
 reg [3:0] rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_reg_NO_SHIFT_REG;
wire [3:0] rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7;

assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready = local_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7 = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_reg_NO_SHIFT_REG : local_bb1_cleanups_pop4_acl_pop_i4_7_NO_SHIFT_REG);
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_combined_valid = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready);
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_local = ((rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_0 & ~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_1 & ~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_0 = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_combined_valid & ~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_1 = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_combined_valid & ~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_1_NO_SHIFT_REG));
assign local_bb1_cleanups_pop4_acl_pop_i4_7_stall_in = (|rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_local)
		begin
			if (~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_staging_reg_NO_SHIFT_REG <= local_bb1_cleanups_pop4_acl_pop_i4_7_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_combined_valid & (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_0)) & rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_local);
		rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_combined_valid & (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_1)) & rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_local);
	end
end


// This section implements a staging register.
// 
wire rstag_2to2_bb1_keep_going_forked_valid_out_0;
wire rstag_2to2_bb1_keep_going_forked_stall_in_0;
 reg rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_1;
wire rstag_2to2_bb1_keep_going_forked_stall_in_1;
 reg rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_2;
wire rstag_2to2_bb1_keep_going_forked_stall_in_2;
 reg rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_valid_out_3;
wire rstag_2to2_bb1_keep_going_forked_stall_in_3;
 reg rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_inputs_ready;
wire rstag_2to2_bb1_keep_going_forked_stall_local;
 reg rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked_combined_valid;
 reg rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_keep_going_forked;

assign rstag_2to2_bb1_keep_going_forked_inputs_ready = local_bb1_keep_going_forked_valid_out_NO_SHIFT_REG;
assign rstag_2to2_bb1_keep_going_forked = (rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG : local_bb1_keep_going_forked_NO_SHIFT_REG);
assign rstag_2to2_bb1_keep_going_forked_combined_valid = (rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_keep_going_forked_inputs_ready);
assign rstag_2to2_bb1_keep_going_forked_stall_local = ((rstag_2to2_bb1_keep_going_forked_stall_in_0 & ~(rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_1 & ~(rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_2 & ~(rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG)) | (rstag_2to2_bb1_keep_going_forked_stall_in_3 & ~(rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG)));
assign rstag_2to2_bb1_keep_going_forked_valid_out_0 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_1 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_2 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG));
assign rstag_2to2_bb1_keep_going_forked_valid_out_3 = (rstag_2to2_bb1_keep_going_forked_combined_valid & ~(rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG));
assign local_bb1_keep_going_forked_stall_in = (|rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_keep_going_forked_stall_local)
		begin
			if (~(rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_keep_going_forked_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_keep_going_forked_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_keep_going_forked_staging_reg_NO_SHIFT_REG <= local_bb1_keep_going_forked_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_0)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_1)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_2_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_2)) & rstag_2to2_bb1_keep_going_forked_stall_local);
		rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG <= (rstag_2to2_bb1_keep_going_forked_combined_valid & (rstag_2to2_bb1_keep_going_forked_consumed_3_NO_SHIFT_REG | ~(rstag_2to2_bb1_keep_going_forked_stall_in_3)) & rstag_2to2_bb1_keep_going_forked_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_next_initerations_stall_local;
wire [3:0] local_bb1_next_initerations;

assign local_bb1_next_initerations = (local_bb1_initerations_pop3_acl_pop_i4_7_NO_SHIFT_REG >> 4'h1);

// This section implements a staging register.
// 
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_0;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_0;
 reg rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_1;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_1;
 reg rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_2;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_2;
 reg rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_2_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_local;
 reg rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid;
 reg [63:0] rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0;

assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready = local_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_NO_SHIFT_REG;
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0 = (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_reg_NO_SHIFT_REG : local_bb1_indvars_iv15_pop2_acl_pop_i64_0_NO_SHIFT_REG);
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid = (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready);
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_local = ((rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_0 & ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_1 & ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_1_NO_SHIFT_REG)) | (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_2 & ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_2_NO_SHIFT_REG)));
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_0 = (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid & ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_1 = (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid & ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_1_NO_SHIFT_REG));
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_2 = (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid & ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_2_NO_SHIFT_REG));
assign local_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in = (|rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_local)
		begin
			if (~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_staging_reg_NO_SHIFT_REG <= local_bb1_indvars_iv15_pop2_acl_pop_i64_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid & (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_0)) & rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_local);
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid & (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_1)) & rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_local);
		rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_2_NO_SHIFT_REG <= (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_combined_valid & (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_consumed_2_NO_SHIFT_REG | ~(rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_2)) & rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_fifo.DEPTH = 2;
defparam rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_fifo.DATA_WIDTH = 0;
defparam rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_fifo.IMPL = "ll_reg";

assign rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_reg_166_inputs_ready_NO_SHIFT_REG = rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_NO_SHIFT_REG;
assign rnode_1to165_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_NO_SHIFT_REG = rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_out_reg_166_NO_SHIFT_REG;
assign rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_reg_166_NO_SHIFT_REG = rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_NO_SHIFT_REG;
assign rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_NO_SHIFT_REG = rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_reg_166_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_var__stall_local;
wire [3:0] local_bb1_var_;

assign local_bb1_var_ = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7 & 4'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u2_stall_local;
wire [3:0] local_bb1_var__u2;

assign local_bb1_var__u2 = (local_bb1_next_initerations & 4'h1);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx41_valid_out;
wire local_bb1_arrayidx41_stall_in;
wire local_bb1_arrayidx41_inputs_ready;
wire local_bb1_arrayidx41_stall_local;
wire [63:0] local_bb1_arrayidx41;

assign local_bb1_arrayidx41_inputs_ready = rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_0;
assign local_bb1_arrayidx41 = (input_img_test_out + rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0);
assign local_bb1_arrayidx41_valid_out = local_bb1_arrayidx41_inputs_ready;
assign local_bb1_arrayidx41_stall_local = local_bb1_arrayidx41_stall_in;
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_0 = (|local_bb1_arrayidx41_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_arrayidx8_stall_local;
wire [63:0] local_bb1_arrayidx8;

assign local_bb1_arrayidx8 = (input_img_test_in + rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0);

// This section implements an unregistered operation.
// 
wire local_bb1_indvars_iv_next16_stall_local;
wire [63:0] local_bb1_indvars_iv_next16;

assign local_bb1_indvars_iv_next16 = (rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0 + 64'h3);

// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_stall_local;
wire local_bb1_first_cleanup;

assign local_bb1_first_cleanup = (local_bb1_var_ != 4'h0);

// This section implements an unregistered operation.
// 
wire local_bb1_next_initerations_valid_out_0;
wire local_bb1_next_initerations_stall_in_0;
 reg local_bb1_next_initerations_consumed_0_NO_SHIFT_REG;
wire local_bb1_last_initeration_valid_out;
wire local_bb1_last_initeration_stall_in;
 reg local_bb1_last_initeration_consumed_0_NO_SHIFT_REG;
wire local_bb1_last_initeration_inputs_ready;
wire local_bb1_last_initeration_stall_local;
wire local_bb1_last_initeration;

assign local_bb1_last_initeration_inputs_ready = local_bb1_initerations_pop3_acl_pop_i4_7_valid_out_NO_SHIFT_REG;
assign local_bb1_last_initeration = (local_bb1_var__u2 != 4'h0);
assign local_bb1_last_initeration_stall_local = ((local_bb1_next_initerations_stall_in_0 & ~(local_bb1_next_initerations_consumed_0_NO_SHIFT_REG)) | (local_bb1_last_initeration_stall_in & ~(local_bb1_last_initeration_consumed_0_NO_SHIFT_REG)));
assign local_bb1_next_initerations_valid_out_0 = (local_bb1_last_initeration_inputs_ready & ~(local_bb1_next_initerations_consumed_0_NO_SHIFT_REG));
assign local_bb1_last_initeration_valid_out = (local_bb1_last_initeration_inputs_ready & ~(local_bb1_last_initeration_consumed_0_NO_SHIFT_REG));
assign local_bb1_initerations_pop3_acl_pop_i4_7_stall_in = (|local_bb1_last_initeration_stall_local);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_next_initerations_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_last_initeration_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_next_initerations_consumed_0_NO_SHIFT_REG <= (local_bb1_last_initeration_inputs_ready & (local_bb1_next_initerations_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_initerations_stall_in_0)) & local_bb1_last_initeration_stall_local);
		local_bb1_last_initeration_consumed_0_NO_SHIFT_REG <= (local_bb1_last_initeration_inputs_ready & (local_bb1_last_initeration_consumed_0_NO_SHIFT_REG | ~(local_bb1_last_initeration_stall_in)) & local_bb1_last_initeration_stall_local);
	end
end


// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_2to165_bb1_arrayidx41_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to165_bb1_arrayidx41_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to165_bb1_arrayidx41_0_NO_SHIFT_REG;
 logic rnode_2to165_bb1_arrayidx41_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to165_bb1_arrayidx41_0_reg_165_NO_SHIFT_REG;
 logic rnode_2to165_bb1_arrayidx41_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_2to165_bb1_arrayidx41_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_2to165_bb1_arrayidx41_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_2to165_bb1_arrayidx41_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to165_bb1_arrayidx41_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to165_bb1_arrayidx41_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_2to165_bb1_arrayidx41_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_2to165_bb1_arrayidx41_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_arrayidx41),
	.data_out(rnode_2to165_bb1_arrayidx41_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_2to165_bb1_arrayidx41_0_reg_165_fifo.DEPTH = 164;
defparam rnode_2to165_bb1_arrayidx41_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_2to165_bb1_arrayidx41_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to165_bb1_arrayidx41_0_reg_165_fifo.IMPL = "ram";

assign rnode_2to165_bb1_arrayidx41_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb1_arrayidx41_valid_out;
assign local_bb1_arrayidx41_stall_in = rnode_2to165_bb1_arrayidx41_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_2to165_bb1_arrayidx41_0_NO_SHIFT_REG = rnode_2to165_bb1_arrayidx41_0_reg_165_NO_SHIFT_REG;
assign rnode_2to165_bb1_arrayidx41_0_stall_in_reg_165_NO_SHIFT_REG = rnode_2to165_bb1_arrayidx41_0_stall_in_NO_SHIFT_REG;
assign rnode_2to165_bb1_arrayidx41_0_valid_out_NO_SHIFT_REG = rnode_2to165_bb1_arrayidx41_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_in_bitcast_0_valid_out;
wire local_bb1_memcoalesce_img_test_in_bitcast_0_stall_in;
wire local_bb1_memcoalesce_img_test_in_bitcast_0_inputs_ready;
wire local_bb1_memcoalesce_img_test_in_bitcast_0_stall_local;
wire [63:0] local_bb1_memcoalesce_img_test_in_bitcast_0;

assign local_bb1_memcoalesce_img_test_in_bitcast_0_inputs_ready = rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_1;
assign local_bb1_memcoalesce_img_test_in_bitcast_0 = local_bb1_arrayidx8;
assign local_bb1_memcoalesce_img_test_in_bitcast_0_valid_out = local_bb1_memcoalesce_img_test_in_bitcast_0_inputs_ready;
assign local_bb1_memcoalesce_img_test_in_bitcast_0_stall_local = local_bb1_memcoalesce_img_test_in_bitcast_0_stall_in;
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_1 = (|local_bb1_memcoalesce_img_test_in_bitcast_0_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u3_stall_local;
wire [31:0] local_bb1_var__u3;

assign local_bb1_var__u3 = local_bb1_indvars_iv_next16[31:0];

// This section implements an unregistered operation.
// 
wire local_bb1_xor_stall_local;
wire local_bb1_xor;

assign local_bb1_xor = (local_bb1_first_cleanup ^ 1'b1);

// This section implements a registered operation.
// 
wire local_bb1_initerations_push3_next_initerations_inputs_ready;
 reg local_bb1_initerations_push3_next_initerations_valid_out_NO_SHIFT_REG;
wire local_bb1_initerations_push3_next_initerations_stall_in;
wire local_bb1_initerations_push3_next_initerations_output_regs_ready;
wire [3:0] local_bb1_initerations_push3_next_initerations_result;
wire local_bb1_initerations_push3_next_initerations_fu_valid_out;
wire local_bb1_initerations_push3_next_initerations_fu_stall_out;
 reg [3:0] local_bb1_initerations_push3_next_initerations_NO_SHIFT_REG;
wire local_bb1_initerations_push3_next_initerations_causedstall;

acl_push local_bb1_initerations_push3_next_initerations_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(local_bb1_next_initerations),
	.stall_out(local_bb1_initerations_push3_next_initerations_fu_stall_out),
	.valid_in(local_bb1_initerations_push3_next_initerations_inputs_ready),
	.valid_out(local_bb1_initerations_push3_next_initerations_fu_valid_out),
	.stall_in(~(local_bb1_initerations_push3_next_initerations_output_regs_ready)),
	.data_out(local_bb1_initerations_push3_next_initerations_result),
	.feedback_out(feedback_data_out_3),
	.feedback_valid_out(feedback_valid_out_3),
	.feedback_stall_in(feedback_stall_in_3)
);

defparam local_bb1_initerations_push3_next_initerations_feedback.STALLFREE = 0;
defparam local_bb1_initerations_push3_next_initerations_feedback.DATA_WIDTH = 4;
defparam local_bb1_initerations_push3_next_initerations_feedback.FIFO_DEPTH = 2;
defparam local_bb1_initerations_push3_next_initerations_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_initerations_push3_next_initerations_feedback.STYLE = "REGULAR";

assign local_bb1_initerations_push3_next_initerations_inputs_ready = (local_bb1_next_initerations_valid_out_0 & rstag_2to2_bb1_keep_going_forked_valid_out_3);
assign local_bb1_initerations_push3_next_initerations_output_regs_ready = (&(~(local_bb1_initerations_push3_next_initerations_valid_out_NO_SHIFT_REG) | ~(local_bb1_initerations_push3_next_initerations_stall_in)));
assign local_bb1_next_initerations_stall_in_0 = (local_bb1_initerations_push3_next_initerations_fu_stall_out | ~(local_bb1_initerations_push3_next_initerations_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_3 = (local_bb1_initerations_push3_next_initerations_fu_stall_out | ~(local_bb1_initerations_push3_next_initerations_inputs_ready));
assign local_bb1_initerations_push3_next_initerations_causedstall = (local_bb1_initerations_push3_next_initerations_inputs_ready && (local_bb1_initerations_push3_next_initerations_fu_stall_out && !(~(local_bb1_initerations_push3_next_initerations_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_initerations_push3_next_initerations_NO_SHIFT_REG <= 'x;
		local_bb1_initerations_push3_next_initerations_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_initerations_push3_next_initerations_output_regs_ready)
		begin
			local_bb1_initerations_push3_next_initerations_NO_SHIFT_REG <= local_bb1_initerations_push3_next_initerations_result;
			local_bb1_initerations_push3_next_initerations_valid_out_NO_SHIFT_REG <= local_bb1_initerations_push3_next_initerations_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_initerations_push3_next_initerations_stall_in))
			begin
				local_bb1_initerations_push3_next_initerations_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_lastiniteration_last_initeration_inputs_ready;
 reg local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG;
wire local_bb1_lastiniteration_last_initeration_stall_in;
wire local_bb1_lastiniteration_last_initeration_output_regs_ready;
wire local_bb1_lastiniteration_last_initeration_result;
wire local_bb1_lastiniteration_last_initeration_fu_valid_out;
wire local_bb1_lastiniteration_last_initeration_fu_stall_out;
 reg local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG;
wire local_bb1_lastiniteration_last_initeration_causedstall;

acl_push local_bb1_lastiniteration_last_initeration_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(local_bb1_last_initeration),
	.stall_out(local_bb1_lastiniteration_last_initeration_fu_stall_out),
	.valid_in(local_bb1_lastiniteration_last_initeration_inputs_ready),
	.valid_out(local_bb1_lastiniteration_last_initeration_fu_valid_out),
	.stall_in(~(local_bb1_lastiniteration_last_initeration_output_regs_ready)),
	.data_out(local_bb1_lastiniteration_last_initeration_result),
	.feedback_out(feedback_data_out_0),
	.feedback_valid_out(feedback_valid_out_0),
	.feedback_stall_in(feedback_stall_in_0)
);

defparam local_bb1_lastiniteration_last_initeration_feedback.STALLFREE = 0;
defparam local_bb1_lastiniteration_last_initeration_feedback.DATA_WIDTH = 1;
defparam local_bb1_lastiniteration_last_initeration_feedback.FIFO_DEPTH = 2;
defparam local_bb1_lastiniteration_last_initeration_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_lastiniteration_last_initeration_feedback.STYLE = "REGULAR";

assign local_bb1_lastiniteration_last_initeration_inputs_ready = (local_bb1_last_initeration_valid_out & rstag_2to2_bb1_keep_going_forked_valid_out_2);
assign local_bb1_lastiniteration_last_initeration_output_regs_ready = (&(~(local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG) | ~(local_bb1_lastiniteration_last_initeration_stall_in)));
assign local_bb1_last_initeration_stall_in = (local_bb1_lastiniteration_last_initeration_fu_stall_out | ~(local_bb1_lastiniteration_last_initeration_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_2 = (local_bb1_lastiniteration_last_initeration_fu_stall_out | ~(local_bb1_lastiniteration_last_initeration_inputs_ready));
assign local_bb1_lastiniteration_last_initeration_causedstall = (local_bb1_lastiniteration_last_initeration_inputs_ready && (local_bb1_lastiniteration_last_initeration_fu_stall_out && !(~(local_bb1_lastiniteration_last_initeration_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG <= 'x;
		local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_lastiniteration_last_initeration_output_regs_ready)
		begin
			local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG <= local_bb1_lastiniteration_last_initeration_result;
			local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= local_bb1_lastiniteration_last_initeration_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_lastiniteration_last_initeration_stall_in))
			begin
				local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_arrayidx41_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_arrayidx41_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_165to166_bb1_arrayidx41_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_arrayidx41_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_165to166_bb1_arrayidx41_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_arrayidx41_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_arrayidx41_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_arrayidx41_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_arrayidx41_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_arrayidx41_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_arrayidx41_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_arrayidx41_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_arrayidx41_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_2to165_bb1_arrayidx41_0_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_arrayidx41_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_arrayidx41_0_reg_166_fifo.DEPTH = 2;
defparam rnode_165to166_bb1_arrayidx41_0_reg_166_fifo.DATA_WIDTH = 64;
defparam rnode_165to166_bb1_arrayidx41_0_reg_166_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to166_bb1_arrayidx41_0_reg_166_fifo.IMPL = "ll_reg";

assign rnode_165to166_bb1_arrayidx41_0_reg_166_inputs_ready_NO_SHIFT_REG = rnode_2to165_bb1_arrayidx41_0_valid_out_NO_SHIFT_REG;
assign rnode_2to165_bb1_arrayidx41_0_stall_in_NO_SHIFT_REG = rnode_165to166_bb1_arrayidx41_0_stall_out_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_arrayidx41_0_NO_SHIFT_REG = rnode_165to166_bb1_arrayidx41_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_arrayidx41_0_stall_in_reg_166_NO_SHIFT_REG = rnode_165to166_bb1_arrayidx41_0_stall_in_NO_SHIFT_REG;
assign rnode_165to166_bb1_arrayidx41_0_valid_out_NO_SHIFT_REG = rnode_165to166_bb1_arrayidx41_0_valid_out_reg_166_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_stall_local;
wire local_bb1_cmp;

assign local_bb1_cmp = (local_bb1_var__u3 == input_iterations);

// This section implements an unregistered operation.
// 
wire local_bb1_first_cleanup_xor_or_stall_local;
wire local_bb1_first_cleanup_xor_or;

assign local_bb1_first_cleanup_xor_or = (input_wii_cmp5 | local_bb1_xor);

// Register node:
//  * latency = 166
//  * capacity = 166
 logic rnode_3to169_bb1_initerations_push3_next_initerations_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_3to169_bb1_initerations_push3_next_initerations_0_NO_SHIFT_REG;
 logic rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_initerations_push3_next_initerations_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_3to169_bb1_initerations_push3_next_initerations_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_initerations_push3_next_initerations_NO_SHIFT_REG),
	.data_out(rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_fifo.DEPTH = 167;
defparam rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_fifo.DATA_WIDTH = 4;
defparam rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_fifo.IMPL = "ram";

assign rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_initerations_push3_next_initerations_valid_out_NO_SHIFT_REG;
assign local_bb1_initerations_push3_next_initerations_stall_in = rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_initerations_push3_next_initerations_0_NO_SHIFT_REG = rnode_3to169_bb1_initerations_push3_next_initerations_0_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_in_reg_169_NO_SHIFT_REG = rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_in_NO_SHIFT_REG;
assign rnode_3to169_bb1_initerations_push3_next_initerations_0_valid_out_NO_SHIFT_REG = rnode_3to169_bb1_initerations_push3_next_initerations_0_valid_out_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 166
//  * capacity = 166
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_3to169_bb1_lastiniteration_last_initeration_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_lastiniteration_last_initeration_NO_SHIFT_REG),
	.data_out(rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_fifo.DEPTH = 167;
defparam rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_fifo.IMPL = "ram";

assign rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_lastiniteration_last_initeration_valid_out_NO_SHIFT_REG;
assign local_bb1_lastiniteration_last_initeration_stall_in = rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG = rnode_3to169_bb1_lastiniteration_last_initeration_0_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_in_reg_169_NO_SHIFT_REG = rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
assign rnode_3to169_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG = rnode_3to169_bb1_lastiniteration_last_initeration_0_valid_out_reg_169_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_out_bitcast_0_valid_out;
wire local_bb1_memcoalesce_img_test_out_bitcast_0_stall_in;
wire local_bb1_memcoalesce_img_test_out_bitcast_0_inputs_ready;
wire local_bb1_memcoalesce_img_test_out_bitcast_0_stall_local;
wire [63:0] local_bb1_memcoalesce_img_test_out_bitcast_0;

assign local_bb1_memcoalesce_img_test_out_bitcast_0_inputs_ready = rnode_165to166_bb1_arrayidx41_0_valid_out_NO_SHIFT_REG;
assign local_bb1_memcoalesce_img_test_out_bitcast_0 = rnode_165to166_bb1_arrayidx41_0_NO_SHIFT_REG;
assign local_bb1_memcoalesce_img_test_out_bitcast_0_valid_out = local_bb1_memcoalesce_img_test_out_bitcast_0_inputs_ready;
assign local_bb1_memcoalesce_img_test_out_bitcast_0_stall_local = local_bb1_memcoalesce_img_test_out_bitcast_0_stall_in;
assign rnode_165to166_bb1_arrayidx41_0_stall_in_NO_SHIFT_REG = (|local_bb1_memcoalesce_img_test_out_bitcast_0_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_var__u4_stall_local;
wire local_bb1_var__u4;

assign local_bb1_var__u4 = (input_wii_cmp5 | local_bb1_cmp);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_initerations_push3_next_initerations_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_169to170_bb1_initerations_push3_next_initerations_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_initerations_push3_next_initerations_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_initerations_push3_next_initerations_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_3to169_bb1_initerations_push3_next_initerations_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_fifo.DATA_WIDTH = 4;
defparam rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_3to169_bb1_initerations_push3_next_initerations_0_valid_out_NO_SHIFT_REG;
assign rnode_3to169_bb1_initerations_push3_next_initerations_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_initerations_push3_next_initerations_0_NO_SHIFT_REG = rnode_169to170_bb1_initerations_push3_next_initerations_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_initerations_push3_next_initerations_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_initerations_push3_next_initerations_0_valid_out_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_lastiniteration_last_initeration_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_3to169_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_3to169_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG;
assign rnode_3to169_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_lastiniteration_last_initeration_0_NO_SHIFT_REG = rnode_169to170_bb1_lastiniteration_last_initeration_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_lastiniteration_last_initeration_0_valid_out_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_notexit_stall_local;
wire local_bb1_notexit;

assign local_bb1_notexit = (local_bb1_var__u4 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_or_stall_local;
wire local_bb1_or;

assign local_bb1_or = (local_bb1_var__u4 | local_bb1_xor);

// This section implements an unregistered operation.
// 
wire local_bb1_masked_stall_local;
wire local_bb1_masked;

assign local_bb1_masked = (local_bb1_var__u4 & local_bb1_first_cleanup);

// This section implements an unregistered operation.
// 
wire local_bb1_cleanups_shl_stall_local;
wire [3:0] local_bb1_cleanups_shl;

assign local_bb1_cleanups_shl[3:1] = 3'h0;
assign local_bb1_cleanups_shl[0] = local_bb1_or;

// This section implements an unregistered operation.
// 
wire local_bb1_next_cleanups_valid_out;
wire local_bb1_next_cleanups_stall_in;
 reg local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG;
wire local_bb1_first_cleanup_valid_out_1;
wire local_bb1_first_cleanup_stall_in_1;
 reg local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG;
wire local_bb1_masked_valid_out;
wire local_bb1_masked_stall_in;
 reg local_bb1_masked_consumed_0_NO_SHIFT_REG;
wire local_bb1_first_cleanup_xor_or_valid_out;
wire local_bb1_first_cleanup_xor_or_stall_in;
 reg local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG;
wire local_bb1_indvars_iv_next16_valid_out_0;
wire local_bb1_indvars_iv_next16_stall_in_0;
 reg local_bb1_indvars_iv_next16_consumed_0_NO_SHIFT_REG;
wire local_bb1_notexit_valid_out;
wire local_bb1_notexit_stall_in;
 reg local_bb1_notexit_consumed_0_NO_SHIFT_REG;
wire local_bb1_next_cleanups_inputs_ready;
wire local_bb1_next_cleanups_stall_local;
wire [3:0] local_bb1_next_cleanups;

assign local_bb1_next_cleanups_inputs_ready = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_0 & rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_valid_out_1 & rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_valid_out_2);
assign local_bb1_next_cleanups = (rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7 << local_bb1_cleanups_shl);
assign local_bb1_next_cleanups_stall_local = ((local_bb1_next_cleanups_stall_in & ~(local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG)) | (local_bb1_first_cleanup_stall_in_1 & ~(local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG)) | (local_bb1_masked_stall_in & ~(local_bb1_masked_consumed_0_NO_SHIFT_REG)) | (local_bb1_first_cleanup_xor_or_stall_in & ~(local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG)) | (local_bb1_indvars_iv_next16_stall_in_0 & ~(local_bb1_indvars_iv_next16_consumed_0_NO_SHIFT_REG)) | (local_bb1_notexit_stall_in & ~(local_bb1_notexit_consumed_0_NO_SHIFT_REG)));
assign local_bb1_next_cleanups_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG));
assign local_bb1_first_cleanup_valid_out_1 = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG));
assign local_bb1_masked_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_masked_consumed_0_NO_SHIFT_REG));
assign local_bb1_first_cleanup_xor_or_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG));
assign local_bb1_indvars_iv_next16_valid_out_0 = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_indvars_iv_next16_consumed_0_NO_SHIFT_REG));
assign local_bb1_notexit_valid_out = (local_bb1_next_cleanups_inputs_ready & ~(local_bb1_notexit_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_0 = (local_bb1_next_cleanups_stall_local | ~(local_bb1_next_cleanups_inputs_ready));
assign rstag_2to2_bb1_cleanups_pop4_acl_pop_i4_7_stall_in_1 = (local_bb1_next_cleanups_stall_local | ~(local_bb1_next_cleanups_inputs_ready));
assign rstag_2to2_bb1_indvars_iv15_pop2_acl_pop_i64_0_stall_in_2 = (local_bb1_next_cleanups_stall_local | ~(local_bb1_next_cleanups_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_masked_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_indvars_iv_next16_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_notexit_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_next_cleanups_consumed_0_NO_SHIFT_REG | ~(local_bb1_next_cleanups_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_first_cleanup_consumed_1_NO_SHIFT_REG | ~(local_bb1_first_cleanup_stall_in_1)) & local_bb1_next_cleanups_stall_local);
		local_bb1_masked_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_masked_consumed_0_NO_SHIFT_REG | ~(local_bb1_masked_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG | ~(local_bb1_first_cleanup_xor_or_stall_in)) & local_bb1_next_cleanups_stall_local);
		local_bb1_indvars_iv_next16_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_indvars_iv_next16_consumed_0_NO_SHIFT_REG | ~(local_bb1_indvars_iv_next16_stall_in_0)) & local_bb1_next_cleanups_stall_local);
		local_bb1_notexit_consumed_0_NO_SHIFT_REG <= (local_bb1_next_cleanups_inputs_ready & (local_bb1_notexit_consumed_0_NO_SHIFT_REG | ~(local_bb1_notexit_stall_in)) & local_bb1_next_cleanups_stall_local);
	end
end


// This section implements a staging register.
// 
wire rstag_2to2_bb1_next_cleanups_valid_out;
wire rstag_2to2_bb1_next_cleanups_stall_in;
wire rstag_2to2_bb1_next_cleanups_inputs_ready;
wire rstag_2to2_bb1_next_cleanups_stall_local;
 reg rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_next_cleanups_combined_valid;
 reg [3:0] rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG;
wire [3:0] rstag_2to2_bb1_next_cleanups;

assign rstag_2to2_bb1_next_cleanups_inputs_ready = local_bb1_next_cleanups_valid_out;
assign rstag_2to2_bb1_next_cleanups = (rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG : local_bb1_next_cleanups);
assign rstag_2to2_bb1_next_cleanups_combined_valid = (rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_next_cleanups_inputs_ready);
assign rstag_2to2_bb1_next_cleanups_valid_out = rstag_2to2_bb1_next_cleanups_combined_valid;
assign rstag_2to2_bb1_next_cleanups_stall_local = rstag_2to2_bb1_next_cleanups_stall_in;
assign local_bb1_next_cleanups_stall_in = (|rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_next_cleanups_stall_local)
		begin
			if (~(rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_next_cleanups_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_next_cleanups_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_next_cleanups_staging_reg_NO_SHIFT_REG <= local_bb1_next_cleanups;
		end
	end
end


// Register node:
//  * latency = 167
//  * capacity = 167
 logic rnode_2to169_bb1_masked_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_reg_169_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_2to169_bb1_masked_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_2to169_bb1_masked_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to169_bb1_masked_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to169_bb1_masked_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_2to169_bb1_masked_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_2to169_bb1_masked_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_masked),
	.data_out(rnode_2to169_bb1_masked_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_2to169_bb1_masked_0_reg_169_fifo.DEPTH = 168;
defparam rnode_2to169_bb1_masked_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_2to169_bb1_masked_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to169_bb1_masked_0_reg_169_fifo.IMPL = "ram";

assign rnode_2to169_bb1_masked_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_masked_valid_out;
assign local_bb1_masked_stall_in = rnode_2to169_bb1_masked_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_2to169_bb1_masked_0_NO_SHIFT_REG = rnode_2to169_bb1_masked_0_reg_169_NO_SHIFT_REG;
assign rnode_2to169_bb1_masked_0_stall_in_reg_169_NO_SHIFT_REG = rnode_2to169_bb1_masked_0_stall_in_NO_SHIFT_REG;
assign rnode_2to169_bb1_masked_0_valid_out_NO_SHIFT_REG = rnode_2to169_bb1_masked_0_valid_out_reg_169_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb1_first_cleanup_xor_or_valid_out_0;
wire rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0;
 reg rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or_valid_out_1;
wire rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1;
 reg rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready;
wire rstag_2to2_bb1_first_cleanup_xor_or_stall_local;
 reg rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or_combined_valid;
 reg rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_first_cleanup_xor_or;

assign rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready = local_bb1_first_cleanup_xor_or_valid_out;
assign rstag_2to2_bb1_first_cleanup_xor_or = (rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG : local_bb1_first_cleanup_xor_or);
assign rstag_2to2_bb1_first_cleanup_xor_or_combined_valid = (rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready);
assign rstag_2to2_bb1_first_cleanup_xor_or_stall_local = ((rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0 & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1 & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb1_first_cleanup_xor_or_valid_out_0 = (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb1_first_cleanup_xor_or_valid_out_1 = (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & ~(rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG));
assign local_bb1_first_cleanup_xor_or_stall_in = (|rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_first_cleanup_xor_or_stall_local)
		begin
			if (~(rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_first_cleanup_xor_or_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_first_cleanup_xor_or_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_first_cleanup_xor_or_staging_reg_NO_SHIFT_REG <= local_bb1_first_cleanup_xor_or;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & (rstag_2to2_bb1_first_cleanup_xor_or_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0)) & rstag_2to2_bb1_first_cleanup_xor_or_stall_local);
		rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb1_first_cleanup_xor_or_combined_valid & (rstag_2to2_bb1_first_cleanup_xor_or_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1)) & rstag_2to2_bb1_first_cleanup_xor_or_stall_local);
	end
end


// This section implements a registered operation.
// 
wire local_bb1_indvars_iv15_push2_indvars_iv_next16_inputs_ready;
 reg local_bb1_indvars_iv15_push2_indvars_iv_next16_valid_out_NO_SHIFT_REG;
wire local_bb1_indvars_iv15_push2_indvars_iv_next16_stall_in;
wire local_bb1_indvars_iv15_push2_indvars_iv_next16_output_regs_ready;
wire [63:0] local_bb1_indvars_iv15_push2_indvars_iv_next16_result;
wire local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_valid_out;
wire local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_stall_out;
 reg [63:0] local_bb1_indvars_iv15_push2_indvars_iv_next16_NO_SHIFT_REG;
wire local_bb1_indvars_iv15_push2_indvars_iv_next16_causedstall;

acl_push local_bb1_indvars_iv15_push2_indvars_iv_next16_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(local_bb1_indvars_iv_next16),
	.stall_out(local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_stall_out),
	.valid_in(local_bb1_indvars_iv15_push2_indvars_iv_next16_inputs_ready),
	.valid_out(local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_valid_out),
	.stall_in(~(local_bb1_indvars_iv15_push2_indvars_iv_next16_output_regs_ready)),
	.data_out(local_bb1_indvars_iv15_push2_indvars_iv_next16_result),
	.feedback_out(feedback_data_out_2),
	.feedback_valid_out(feedback_valid_out_2),
	.feedback_stall_in(feedback_stall_in_2)
);

defparam local_bb1_indvars_iv15_push2_indvars_iv_next16_feedback.STALLFREE = 0;
defparam local_bb1_indvars_iv15_push2_indvars_iv_next16_feedback.DATA_WIDTH = 64;
defparam local_bb1_indvars_iv15_push2_indvars_iv_next16_feedback.FIFO_DEPTH = 2;
defparam local_bb1_indvars_iv15_push2_indvars_iv_next16_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_indvars_iv15_push2_indvars_iv_next16_feedback.STYLE = "REGULAR";

assign local_bb1_indvars_iv15_push2_indvars_iv_next16_inputs_ready = (local_bb1_indvars_iv_next16_valid_out_0 & rstag_2to2_bb1_keep_going_forked_valid_out_1);
assign local_bb1_indvars_iv15_push2_indvars_iv_next16_output_regs_ready = (&(~(local_bb1_indvars_iv15_push2_indvars_iv_next16_valid_out_NO_SHIFT_REG) | ~(local_bb1_indvars_iv15_push2_indvars_iv_next16_stall_in)));
assign local_bb1_indvars_iv_next16_stall_in_0 = (local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_stall_out | ~(local_bb1_indvars_iv15_push2_indvars_iv_next16_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_1 = (local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_stall_out | ~(local_bb1_indvars_iv15_push2_indvars_iv_next16_inputs_ready));
assign local_bb1_indvars_iv15_push2_indvars_iv_next16_causedstall = (local_bb1_indvars_iv15_push2_indvars_iv_next16_inputs_ready && (local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_stall_out && !(~(local_bb1_indvars_iv15_push2_indvars_iv_next16_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_indvars_iv15_push2_indvars_iv_next16_NO_SHIFT_REG <= 'x;
		local_bb1_indvars_iv15_push2_indvars_iv_next16_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_indvars_iv15_push2_indvars_iv_next16_output_regs_ready)
		begin
			local_bb1_indvars_iv15_push2_indvars_iv_next16_NO_SHIFT_REG <= local_bb1_indvars_iv15_push2_indvars_iv_next16_result;
			local_bb1_indvars_iv15_push2_indvars_iv_next16_valid_out_NO_SHIFT_REG <= local_bb1_indvars_iv15_push2_indvars_iv_next16_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_indvars_iv15_push2_indvars_iv_next16_stall_in))
			begin
				local_bb1_indvars_iv15_push2_indvars_iv_next16_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_2to2_bb1_notexit_valid_out;
wire rstag_2to2_bb1_notexit_stall_in;
wire rstag_2to2_bb1_notexit_inputs_ready;
wire rstag_2to2_bb1_notexit_stall_local;
 reg rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb1_notexit_combined_valid;
 reg rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb1_notexit;

assign rstag_2to2_bb1_notexit_inputs_ready = local_bb1_notexit_valid_out;
assign rstag_2to2_bb1_notexit = (rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG : local_bb1_notexit);
assign rstag_2to2_bb1_notexit_combined_valid = (rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG | rstag_2to2_bb1_notexit_inputs_ready);
assign rstag_2to2_bb1_notexit_valid_out = rstag_2to2_bb1_notexit_combined_valid;
assign rstag_2to2_bb1_notexit_stall_local = rstag_2to2_bb1_notexit_stall_in;
assign local_bb1_notexit_stall_in = (|rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb1_notexit_stall_local)
		begin
			if (~(rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb1_notexit_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb1_notexit_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb1_notexit_staging_reg_NO_SHIFT_REG <= local_bb1_notexit;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_cleanups_push4_next_cleanups_inputs_ready;
 reg local_bb1_cleanups_push4_next_cleanups_valid_out_NO_SHIFT_REG;
wire local_bb1_cleanups_push4_next_cleanups_stall_in;
wire local_bb1_cleanups_push4_next_cleanups_output_regs_ready;
wire [3:0] local_bb1_cleanups_push4_next_cleanups_result;
wire local_bb1_cleanups_push4_next_cleanups_fu_valid_out;
wire local_bb1_cleanups_push4_next_cleanups_fu_stall_out;
 reg [3:0] local_bb1_cleanups_push4_next_cleanups_NO_SHIFT_REG;
wire local_bb1_cleanups_push4_next_cleanups_causedstall;

acl_push local_bb1_cleanups_push4_next_cleanups_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(rstag_2to2_bb1_keep_going_forked),
	.predicate(1'b0),
	.data_in(rstag_2to2_bb1_next_cleanups),
	.stall_out(local_bb1_cleanups_push4_next_cleanups_fu_stall_out),
	.valid_in(local_bb1_cleanups_push4_next_cleanups_inputs_ready),
	.valid_out(local_bb1_cleanups_push4_next_cleanups_fu_valid_out),
	.stall_in(~(local_bb1_cleanups_push4_next_cleanups_output_regs_ready)),
	.data_out(local_bb1_cleanups_push4_next_cleanups_result),
	.feedback_out(feedback_data_out_4),
	.feedback_valid_out(feedback_valid_out_4),
	.feedback_stall_in(feedback_stall_in_4)
);

defparam local_bb1_cleanups_push4_next_cleanups_feedback.STALLFREE = 0;
defparam local_bb1_cleanups_push4_next_cleanups_feedback.DATA_WIDTH = 4;
defparam local_bb1_cleanups_push4_next_cleanups_feedback.FIFO_DEPTH = 2;
defparam local_bb1_cleanups_push4_next_cleanups_feedback.MIN_FIFO_LATENCY = 0;
defparam local_bb1_cleanups_push4_next_cleanups_feedback.STYLE = "REGULAR";

assign local_bb1_cleanups_push4_next_cleanups_inputs_ready = (rstag_2to2_bb1_next_cleanups_valid_out & rstag_2to2_bb1_keep_going_forked_valid_out_0);
assign local_bb1_cleanups_push4_next_cleanups_output_regs_ready = (&(~(local_bb1_cleanups_push4_next_cleanups_valid_out_NO_SHIFT_REG) | ~(local_bb1_cleanups_push4_next_cleanups_stall_in)));
assign rstag_2to2_bb1_next_cleanups_stall_in = (local_bb1_cleanups_push4_next_cleanups_fu_stall_out | ~(local_bb1_cleanups_push4_next_cleanups_inputs_ready));
assign rstag_2to2_bb1_keep_going_forked_stall_in_0 = (local_bb1_cleanups_push4_next_cleanups_fu_stall_out | ~(local_bb1_cleanups_push4_next_cleanups_inputs_ready));
assign local_bb1_cleanups_push4_next_cleanups_causedstall = (local_bb1_cleanups_push4_next_cleanups_inputs_ready && (local_bb1_cleanups_push4_next_cleanups_fu_stall_out && !(~(local_bb1_cleanups_push4_next_cleanups_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_cleanups_push4_next_cleanups_NO_SHIFT_REG <= 'x;
		local_bb1_cleanups_push4_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_cleanups_push4_next_cleanups_output_regs_ready)
		begin
			local_bb1_cleanups_push4_next_cleanups_NO_SHIFT_REG <= local_bb1_cleanups_push4_next_cleanups_result;
			local_bb1_cleanups_push4_next_cleanups_valid_out_NO_SHIFT_REG <= local_bb1_cleanups_push4_next_cleanups_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_cleanups_push4_next_cleanups_stall_in))
			begin
				local_bb1_cleanups_push4_next_cleanups_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_masked_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_masked_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_masked_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_masked_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_masked_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_masked_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_masked_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_2to169_bb1_masked_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_masked_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_masked_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_masked_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_masked_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_masked_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_masked_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_2to169_bb1_masked_0_valid_out_NO_SHIFT_REG;
assign rnode_2to169_bb1_masked_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_masked_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_masked_0_NO_SHIFT_REG = rnode_169to170_bb1_masked_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_masked_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_masked_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_masked_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_masked_0_valid_out_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_2to165_bb1_first_cleanup_xor_or_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to165_bb1_first_cleanup_xor_or_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_2to165_bb1_first_cleanup_xor_or_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_2to165_bb1_first_cleanup_xor_or_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb1_first_cleanup_xor_or),
	.data_out(rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_fifo.DEPTH = 164;
defparam rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_fifo.IMPL = "ram";

assign rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb1_first_cleanup_xor_or_valid_out_0;
assign rstag_2to2_bb1_first_cleanup_xor_or_stall_in_0 = rnode_2to165_bb1_first_cleanup_xor_or_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_2to165_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG = rnode_2to165_bb1_first_cleanup_xor_or_0_reg_165_NO_SHIFT_REG;
assign rnode_2to165_bb1_first_cleanup_xor_or_0_stall_in_reg_165_NO_SHIFT_REG = rnode_2to165_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_2to165_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG = rnode_2to165_bb1_first_cleanup_xor_or_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_ld_memcoalesce_img_test_in_load_0_inputs_ready;
 reg local_bb1_ld_memcoalesce_img_test_in_load_0_valid_out_NO_SHIFT_REG;
wire local_bb1_ld_memcoalesce_img_test_in_load_0_stall_in;
wire local_bb1_ld_memcoalesce_img_test_in_load_0_output_regs_ready;
wire local_bb1_ld_memcoalesce_img_test_in_load_0_fu_stall_out;
wire local_bb1_ld_memcoalesce_img_test_in_load_0_fu_valid_out;
wire [31:0] local_bb1_ld_memcoalesce_img_test_in_load_0_lsu_dataout;
 reg [31:0] local_bb1_ld_memcoalesce_img_test_in_load_0_NO_SHIFT_REG;
wire local_bb1_ld_memcoalesce_img_test_in_load_0_causedstall;

lsu_top lsu_local_bb1_ld_memcoalesce_img_test_in_load_0 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_ld_memcoalesce_img_test_in_load_0_fu_stall_out),
	.i_valid(local_bb1_ld_memcoalesce_img_test_in_load_0_inputs_ready),
	.i_address(local_bb1_memcoalesce_img_test_in_bitcast_0),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb1_first_cleanup_xor_or),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb1_ld_memcoalesce_img_test_in_load_0_output_regs_ready)),
	.o_valid(local_bb1_ld_memcoalesce_img_test_in_load_0_fu_valid_out),
	.o_readdata(local_bb1_ld_memcoalesce_img_test_in_load_0_lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_ld_memcoalesce_img_test_in_load_0_active),
	.avm_address(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_address),
	.avm_read(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_read),
	.avm_readdata(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdata),
	.avm_write(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_write),
	.avm_writeack(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writeack),
	.avm_burstcount(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_burstcount),
	.avm_writedata(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writedata),
	.avm_byteenable(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_byteenable),
	.avm_waitrequest(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_waitrequest),
	.avm_readdatavalid(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.AWIDTH = 30;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.WIDTH_BYTES = 4;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.ALIGNMENT_BYTES = 1;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.READ = 1;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.ATOMIC = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.WIDTH = 32;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.MWIDTH = 256;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.MEMORY_SIDE_MEM_LATENCY = 73;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.NUMBER_BANKS = 1;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.USEINPUTFIFO = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.USECACHING = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.HIGH_FMAX = 1;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.ADDRSPACE = 1;
defparam lsu_local_bb1_ld_memcoalesce_img_test_in_load_0.STYLE = "BURST-NON-ALIGNED";

assign local_bb1_ld_memcoalesce_img_test_in_load_0_inputs_ready = (local_bb1_memcoalesce_img_test_in_bitcast_0_valid_out & rstag_2to2_bb1_first_cleanup_xor_or_valid_out_1);
assign local_bb1_ld_memcoalesce_img_test_in_load_0_output_regs_ready = (&(~(local_bb1_ld_memcoalesce_img_test_in_load_0_valid_out_NO_SHIFT_REG) | ~(local_bb1_ld_memcoalesce_img_test_in_load_0_stall_in)));
assign local_bb1_memcoalesce_img_test_in_bitcast_0_stall_in = (local_bb1_ld_memcoalesce_img_test_in_load_0_fu_stall_out | ~(local_bb1_ld_memcoalesce_img_test_in_load_0_inputs_ready));
assign rstag_2to2_bb1_first_cleanup_xor_or_stall_in_1 = (local_bb1_ld_memcoalesce_img_test_in_load_0_fu_stall_out | ~(local_bb1_ld_memcoalesce_img_test_in_load_0_inputs_ready));
assign local_bb1_ld_memcoalesce_img_test_in_load_0_causedstall = (local_bb1_ld_memcoalesce_img_test_in_load_0_inputs_ready && (local_bb1_ld_memcoalesce_img_test_in_load_0_fu_stall_out && !(~(local_bb1_ld_memcoalesce_img_test_in_load_0_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_ld_memcoalesce_img_test_in_load_0_NO_SHIFT_REG <= 'x;
		local_bb1_ld_memcoalesce_img_test_in_load_0_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_ld_memcoalesce_img_test_in_load_0_output_regs_ready)
		begin
			local_bb1_ld_memcoalesce_img_test_in_load_0_NO_SHIFT_REG <= local_bb1_ld_memcoalesce_img_test_in_load_0_lsu_dataout;
			local_bb1_ld_memcoalesce_img_test_in_load_0_valid_out_NO_SHIFT_REG <= local_bb1_ld_memcoalesce_img_test_in_load_0_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_ld_memcoalesce_img_test_in_load_0_stall_in))
			begin
				local_bb1_ld_memcoalesce_img_test_in_load_0_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 166
//  * capacity = 166
 logic rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_NO_SHIFT_REG;
 logic rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_indvars_iv15_push2_indvars_iv_next16_NO_SHIFT_REG),
	.data_out(rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_fifo.DEPTH = 167;
defparam rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_fifo.DATA_WIDTH = 64;
defparam rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_fifo.IMPL = "ram";

assign rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_indvars_iv15_push2_indvars_iv_next16_valid_out_NO_SHIFT_REG;
assign local_bb1_indvars_iv15_push2_indvars_iv_next16_stall_in = rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_NO_SHIFT_REG = rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_reg_169_NO_SHIFT_REG = rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_NO_SHIFT_REG;
assign rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_NO_SHIFT_REG = rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_reg_169_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_notexitcond_notexit_inputs_ready;
 reg local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG;
wire local_bb1_notexitcond_notexit_stall_in;
wire local_bb1_notexitcond_notexit_output_regs_ready;
wire local_bb1_notexitcond_notexit_result;
wire local_bb1_notexitcond_notexit_fu_valid_out;
wire local_bb1_notexitcond_notexit_fu_stall_out;
 reg local_bb1_notexitcond_notexit_NO_SHIFT_REG;
wire local_bb1_notexitcond_notexit_causedstall;

acl_push local_bb1_notexitcond_notexit_feedback (
	.clock(clock),
	.resetn(resetn),
	.dir(local_bb1_first_cleanup),
	.predicate(1'b0),
	.data_in(rstag_2to2_bb1_notexit),
	.stall_out(local_bb1_notexitcond_notexit_fu_stall_out),
	.valid_in(local_bb1_notexitcond_notexit_inputs_ready),
	.valid_out(local_bb1_notexitcond_notexit_fu_valid_out),
	.stall_in(~(local_bb1_notexitcond_notexit_output_regs_ready)),
	.data_out(local_bb1_notexitcond_notexit_result),
	.feedback_out(feedback_data_out_1),
	.feedback_valid_out(feedback_valid_out_1),
	.feedback_stall_in(feedback_stall_in_1)
);

defparam local_bb1_notexitcond_notexit_feedback.STALLFREE = 0;
defparam local_bb1_notexitcond_notexit_feedback.DATA_WIDTH = 1;
defparam local_bb1_notexitcond_notexit_feedback.FIFO_DEPTH = 4;
defparam local_bb1_notexitcond_notexit_feedback.MIN_FIFO_LATENCY = 2;
defparam local_bb1_notexitcond_notexit_feedback.STYLE = "REGULAR";

assign local_bb1_notexitcond_notexit_inputs_ready = (local_bb1_first_cleanup_valid_out_1 & rstag_2to2_bb1_notexit_valid_out);
assign local_bb1_notexitcond_notexit_output_regs_ready = (&(~(local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG) | ~(local_bb1_notexitcond_notexit_stall_in)));
assign local_bb1_first_cleanup_stall_in_1 = (local_bb1_notexitcond_notexit_fu_stall_out | ~(local_bb1_notexitcond_notexit_inputs_ready));
assign rstag_2to2_bb1_notexit_stall_in = (local_bb1_notexitcond_notexit_fu_stall_out | ~(local_bb1_notexitcond_notexit_inputs_ready));
assign local_bb1_notexitcond_notexit_causedstall = (local_bb1_notexitcond_notexit_inputs_ready && (local_bb1_notexitcond_notexit_fu_stall_out && !(~(local_bb1_notexitcond_notexit_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_notexitcond_notexit_NO_SHIFT_REG <= 'x;
		local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_notexitcond_notexit_output_regs_ready)
		begin
			local_bb1_notexitcond_notexit_NO_SHIFT_REG <= local_bb1_notexitcond_notexit_result;
			local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= local_bb1_notexitcond_notexit_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_notexitcond_notexit_stall_in))
			begin
				local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 166
//  * capacity = 166
 logic rnode_3to169_bb1_cleanups_push4_next_cleanups_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_3to169_bb1_cleanups_push4_next_cleanups_0_NO_SHIFT_REG;
 logic rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_cleanups_push4_next_cleanups_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_3to169_bb1_cleanups_push4_next_cleanups_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_cleanups_push4_next_cleanups_NO_SHIFT_REG),
	.data_out(rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_fifo.DEPTH = 167;
defparam rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_fifo.DATA_WIDTH = 4;
defparam rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_fifo.IMPL = "ram";

assign rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_cleanups_push4_next_cleanups_valid_out_NO_SHIFT_REG;
assign local_bb1_cleanups_push4_next_cleanups_stall_in = rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_cleanups_push4_next_cleanups_0_NO_SHIFT_REG = rnode_3to169_bb1_cleanups_push4_next_cleanups_0_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_in_reg_169_NO_SHIFT_REG = rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_in_NO_SHIFT_REG;
assign rnode_3to169_bb1_cleanups_push4_next_cleanups_0_valid_out_NO_SHIFT_REG = rnode_3to169_bb1_cleanups_push4_next_cleanups_0_valid_out_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_first_cleanup_xor_or_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_first_cleanup_xor_or_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_first_cleanup_xor_or_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_first_cleanup_xor_or_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(rnode_2to165_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG),
	.data_out(rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_fifo.DEPTH = 2;
defparam rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_fifo.DATA_WIDTH = 1;
defparam rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_fifo.IMPL = "ll_reg";

assign rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_inputs_ready_NO_SHIFT_REG = rnode_2to165_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG;
assign rnode_2to165_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG = rnode_165to166_bb1_first_cleanup_xor_or_0_stall_out_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG = rnode_165to166_bb1_first_cleanup_xor_or_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_first_cleanup_xor_or_0_stall_in_reg_166_NO_SHIFT_REG = rnode_165to166_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_165to166_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG = rnode_165to166_bb1_first_cleanup_xor_or_0_valid_out_reg_166_NO_SHIFT_REG;

// Register node:
//  * latency = 0
//  * capacity = 80
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_1_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_2_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_0_reg_162_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_0_reg_162_NO_SHIFT_REG;
 logic rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_out_reg_162_NO_SHIFT_REG;
 logic [31:0] rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG),
	.valid_in(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.data_out(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG_fa),
	.valid_out({rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_0_NO_SHIFT_REG, rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_1_NO_SHIFT_REG, rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_2_NO_SHIFT_REG}),
	.stall_in({rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_0_NO_SHIFT_REG, rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_1_NO_SHIFT_REG, rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_2_NO_SHIFT_REG})
);

defparam rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fanout_adaptor.NUM_FANOUTS = 3;

acl_data_fifo rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(local_bb1_ld_memcoalesce_img_test_in_load_0_NO_SHIFT_REG),
	.data_out(rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fifo.DEPTH = 81;
defparam rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_fifo.IMPL = "zl_ram";

assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_inputs_ready_NO_SHIFT_REG = local_bb1_ld_memcoalesce_img_test_in_load_0_valid_out_NO_SHIFT_REG;
assign local_bb1_ld_memcoalesce_img_test_in_load_0_stall_in = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_NO_SHIFT_REG = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG_fa;
assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_1_NO_SHIFT_REG = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG_fa;
assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_2_NO_SHIFT_REG = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_reg_162_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_fifo.DATA_WIDTH = 64;
defparam rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_NO_SHIFT_REG;
assign rnode_3to169_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_NO_SHIFT_REG = rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_reg_170_NO_SHIFT_REG;

// Register node:
//  * latency = 166
//  * capacity = 166
 logic rnode_3to169_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_reg_169_inputs_ready_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_valid_out_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_stall_in_reg_169_NO_SHIFT_REG;
 logic rnode_3to169_bb1_notexitcond_notexit_0_stall_out_reg_169_NO_SHIFT_REG;

acl_data_fifo rnode_3to169_bb1_notexitcond_notexit_0_reg_169_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_3to169_bb1_notexitcond_notexit_0_reg_169_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_3to169_bb1_notexitcond_notexit_0_stall_in_reg_169_NO_SHIFT_REG),
	.valid_out(rnode_3to169_bb1_notexitcond_notexit_0_valid_out_reg_169_NO_SHIFT_REG),
	.stall_out(rnode_3to169_bb1_notexitcond_notexit_0_stall_out_reg_169_NO_SHIFT_REG),
	.data_in(local_bb1_notexitcond_notexit_NO_SHIFT_REG),
	.data_out(rnode_3to169_bb1_notexitcond_notexit_0_reg_169_NO_SHIFT_REG)
);

defparam rnode_3to169_bb1_notexitcond_notexit_0_reg_169_fifo.DEPTH = 167;
defparam rnode_3to169_bb1_notexitcond_notexit_0_reg_169_fifo.DATA_WIDTH = 1;
defparam rnode_3to169_bb1_notexitcond_notexit_0_reg_169_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_3to169_bb1_notexitcond_notexit_0_reg_169_fifo.IMPL = "ram";

assign rnode_3to169_bb1_notexitcond_notexit_0_reg_169_inputs_ready_NO_SHIFT_REG = local_bb1_notexitcond_notexit_valid_out_NO_SHIFT_REG;
assign local_bb1_notexitcond_notexit_stall_in = rnode_3to169_bb1_notexitcond_notexit_0_stall_out_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_notexitcond_notexit_0_NO_SHIFT_REG = rnode_3to169_bb1_notexitcond_notexit_0_reg_169_NO_SHIFT_REG;
assign rnode_3to169_bb1_notexitcond_notexit_0_stall_in_reg_169_NO_SHIFT_REG = rnode_3to169_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
assign rnode_3to169_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = rnode_3to169_bb1_notexitcond_notexit_0_valid_out_reg_169_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_cleanups_push4_next_cleanups_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_in_NO_SHIFT_REG;
 logic [3:0] rnode_169to170_bb1_cleanups_push4_next_cleanups_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic [3:0] rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cleanups_push4_next_cleanups_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_cleanups_push4_next_cleanups_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_3to169_bb1_cleanups_push4_next_cleanups_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_fifo.DATA_WIDTH = 4;
defparam rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_3to169_bb1_cleanups_push4_next_cleanups_0_valid_out_NO_SHIFT_REG;
assign rnode_3to169_bb1_cleanups_push4_next_cleanups_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cleanups_push4_next_cleanups_0_NO_SHIFT_REG = rnode_169to170_bb1_cleanups_push4_next_cleanups_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_cleanups_push4_next_cleanups_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_cleanups_push4_next_cleanups_0_valid_out_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_in_extrValue_2_stall_local;
wire [7:0] local_bb1_memcoalesce_img_test_in_extrValue_2;

assign local_bb1_memcoalesce_img_test_in_extrValue_2 = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_NO_SHIFT_REG[23:16];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_in_extrValue_1_stall_local;
wire [7:0] local_bb1_memcoalesce_img_test_in_extrValue_1;

assign local_bb1_memcoalesce_img_test_in_extrValue_1 = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_1_NO_SHIFT_REG[15:8];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_in_extrValue_0_stall_local;
wire [7:0] local_bb1_memcoalesce_img_test_in_extrValue_0;

assign local_bb1_memcoalesce_img_test_in_extrValue_0 = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_2_NO_SHIFT_REG[7:0];

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_169to170_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_169to170_bb1_notexitcond_notexit_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_169to170_bb1_notexitcond_notexit_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_169to170_bb1_notexitcond_notexit_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_169to170_bb1_notexitcond_notexit_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_169to170_bb1_notexitcond_notexit_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_169to170_bb1_notexitcond_notexit_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(rnode_3to169_bb1_notexitcond_notexit_0_NO_SHIFT_REG),
	.data_out(rnode_169to170_bb1_notexitcond_notexit_0_reg_170_NO_SHIFT_REG)
);

defparam rnode_169to170_bb1_notexitcond_notexit_0_reg_170_fifo.DEPTH = 2;
defparam rnode_169to170_bb1_notexitcond_notexit_0_reg_170_fifo.DATA_WIDTH = 1;
defparam rnode_169to170_bb1_notexitcond_notexit_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_169to170_bb1_notexitcond_notexit_0_reg_170_fifo.IMPL = "ll_reg";

assign rnode_169to170_bb1_notexitcond_notexit_0_reg_170_inputs_ready_NO_SHIFT_REG = rnode_3to169_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG;
assign rnode_3to169_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = rnode_169to170_bb1_notexitcond_notexit_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_notexitcond_notexit_0_NO_SHIFT_REG = rnode_169to170_bb1_notexitcond_notexit_0_reg_170_NO_SHIFT_REG;
assign rnode_169to170_bb1_notexitcond_notexit_0_stall_in_reg_170_NO_SHIFT_REG = rnode_169to170_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG;
assign rnode_169to170_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG = rnode_169to170_bb1_notexitcond_notexit_0_valid_out_reg_170_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_conv_valid_out;
wire local_bb1_conv_stall_in;
wire local_bb1_conv_inputs_ready;
wire local_bb1_conv_stall_local;
wire [31:0] local_bb1_conv;

assign local_bb1_conv_inputs_ready = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_conv[31:8] = 24'h0;
assign local_bb1_conv[7:0] = local_bb1_memcoalesce_img_test_in_extrValue_2;
assign local_bb1_conv_valid_out = local_bb1_conv_inputs_ready;
assign local_bb1_conv_stall_local = local_bb1_conv_stall_in;
assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_0_NO_SHIFT_REG = (|local_bb1_conv_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_conv32_valid_out;
wire local_bb1_conv32_stall_in;
wire local_bb1_conv32_inputs_ready;
wire local_bb1_conv32_stall_local;
wire [31:0] local_bb1_conv32;

assign local_bb1_conv32_inputs_ready = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_1_NO_SHIFT_REG;
assign local_bb1_conv32[31:8] = 24'h0;
assign local_bb1_conv32[7:0] = local_bb1_memcoalesce_img_test_in_extrValue_1;
assign local_bb1_conv32_valid_out = local_bb1_conv32_inputs_ready;
assign local_bb1_conv32_stall_local = local_bb1_conv32_stall_in;
assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_1_NO_SHIFT_REG = (|local_bb1_conv32_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb1_conv36_valid_out;
wire local_bb1_conv36_stall_in;
wire local_bb1_conv36_inputs_ready;
wire local_bb1_conv36_stall_local;
wire [31:0] local_bb1_conv36;

assign local_bb1_conv36_inputs_ready = rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_valid_out_2_NO_SHIFT_REG;
assign local_bb1_conv36[31:8] = 24'h0;
assign local_bb1_conv36[7:0] = local_bb1_memcoalesce_img_test_in_extrValue_0;
assign local_bb1_conv36_valid_out = local_bb1_conv36_inputs_ready;
assign local_bb1_conv36_stall_local = local_bb1_conv36_stall_in;
assign rnode_162to162_bb1_ld_memcoalesce_img_test_in_load_0_0_stall_in_2_NO_SHIFT_REG = (|local_bb1_conv36_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_mul_inputs_ready;
 reg local_bb1_mul_valid_out_NO_SHIFT_REG;
wire local_bb1_mul_stall_in;
wire local_bb1_mul_output_regs_ready;
wire [31:0] local_bb1_mul;
 reg local_bb1_mul_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul_causedstall;

acl_int_mult32s_s5 int_module_local_bb1_mul (
	.clock(clock),
	.dataa(local_bb1_conv),
	.datab(32'h4C),
	.enable(local_bb1_mul_output_regs_ready),
	.result(local_bb1_mul)
);

defparam int_module_local_bb1_mul.INPUT1_WIDTH = 8;
defparam int_module_local_bb1_mul.INPUT2_WIDTH = 7;

assign local_bb1_mul_inputs_ready = local_bb1_conv_valid_out;
assign local_bb1_mul_output_regs_ready = (&(~(local_bb1_mul_valid_out_NO_SHIFT_REG) | ~(local_bb1_mul_stall_in)));
assign local_bb1_conv_stall_in = (~(local_bb1_mul_output_regs_ready) | ~(local_bb1_mul_inputs_ready));
assign local_bb1_mul_causedstall = (local_bb1_mul_inputs_ready && (~(local_bb1_mul_output_regs_ready) && !(~(local_bb1_mul_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_output_regs_ready)
		begin
			local_bb1_mul_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul_inputs_ready;
			local_bb1_mul_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_output_regs_ready)
		begin
			local_bb1_mul_valid_out_NO_SHIFT_REG <= local_bb1_mul_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_mul_stall_in))
			begin
				local_bb1_mul_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_mul33_inputs_ready;
 reg local_bb1_mul33_valid_out_NO_SHIFT_REG;
wire local_bb1_mul33_stall_in;
wire local_bb1_mul33_output_regs_ready;
wire [31:0] local_bb1_mul33;
 reg local_bb1_mul33_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul33_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul33_causedstall;

acl_int_mult32s_s5 int_module_local_bb1_mul33 (
	.clock(clock),
	.dataa(local_bb1_conv32),
	.datab(32'h96),
	.enable(local_bb1_mul33_output_regs_ready),
	.result(local_bb1_mul33)
);

defparam int_module_local_bb1_mul33.INPUT1_WIDTH = 8;
defparam int_module_local_bb1_mul33.INPUT2_WIDTH = 8;

assign local_bb1_mul33_inputs_ready = local_bb1_conv32_valid_out;
assign local_bb1_mul33_output_regs_ready = (&(~(local_bb1_mul33_valid_out_NO_SHIFT_REG) | ~(local_bb1_mul33_stall_in)));
assign local_bb1_conv32_stall_in = (~(local_bb1_mul33_output_regs_ready) | ~(local_bb1_mul33_inputs_ready));
assign local_bb1_mul33_causedstall = (local_bb1_mul33_inputs_ready && (~(local_bb1_mul33_output_regs_ready) && !(~(local_bb1_mul33_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul33_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul33_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul33_output_regs_ready)
		begin
			local_bb1_mul33_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul33_inputs_ready;
			local_bb1_mul33_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul33_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul33_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul33_output_regs_ready)
		begin
			local_bb1_mul33_valid_out_NO_SHIFT_REG <= local_bb1_mul33_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_mul33_stall_in))
			begin
				local_bb1_mul33_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb1_mul37_inputs_ready;
 reg local_bb1_mul37_valid_out_NO_SHIFT_REG;
wire local_bb1_mul37_stall_in;
wire local_bb1_mul37_output_regs_ready;
wire [31:0] local_bb1_mul37;
 reg local_bb1_mul37_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul37_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul37_causedstall;

acl_int_mult32s_s5 int_module_local_bb1_mul37 (
	.clock(clock),
	.dataa(local_bb1_conv36),
	.datab(32'h1E),
	.enable(local_bb1_mul37_output_regs_ready),
	.result(local_bb1_mul37)
);

defparam int_module_local_bb1_mul37.INPUT1_WIDTH = 8;
defparam int_module_local_bb1_mul37.INPUT2_WIDTH = 5;

assign local_bb1_mul37_inputs_ready = local_bb1_conv36_valid_out;
assign local_bb1_mul37_output_regs_ready = (&(~(local_bb1_mul37_valid_out_NO_SHIFT_REG) | ~(local_bb1_mul37_stall_in)));
assign local_bb1_conv36_stall_in = (~(local_bb1_mul37_output_regs_ready) | ~(local_bb1_mul37_inputs_ready));
assign local_bb1_mul37_causedstall = (local_bb1_mul37_inputs_ready && (~(local_bb1_mul37_output_regs_ready) && !(~(local_bb1_mul37_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul37_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul37_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul37_output_regs_ready)
		begin
			local_bb1_mul37_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul37_inputs_ready;
			local_bb1_mul37_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul37_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul37_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul37_output_regs_ready)
		begin
			local_bb1_mul37_valid_out_NO_SHIFT_REG <= local_bb1_mul37_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb1_mul37_stall_in))
			begin
				local_bb1_mul37_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb1_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_165to165_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_165to165_bb1_mul_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_165to165_bb1_mul_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb1_mul_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb1_mul_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb1_mul_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb1_mul_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_mul),
	.data_out(rnode_165to165_bb1_mul_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb1_mul_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb1_mul_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_165to165_bb1_mul_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb1_mul_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb1_mul_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb1_mul_valid_out_NO_SHIFT_REG;
assign local_bb1_mul_stall_in = rnode_165to165_bb1_mul_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul_0_NO_SHIFT_REG = rnode_165to165_bb1_mul_0_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul_0_stall_in_reg_165_NO_SHIFT_REG = rnode_165to165_bb1_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul_0_valid_out_NO_SHIFT_REG = rnode_165to165_bb1_mul_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb1_mul33_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul33_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_165to165_bb1_mul33_0_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul33_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_165to165_bb1_mul33_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul33_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul33_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul33_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_165to165_bb1_mul33_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb1_mul33_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb1_mul33_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb1_mul33_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb1_mul33_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_mul33),
	.data_out(rnode_165to165_bb1_mul33_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb1_mul33_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb1_mul33_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_165to165_bb1_mul33_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb1_mul33_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb1_mul33_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb1_mul33_valid_out_NO_SHIFT_REG;
assign local_bb1_mul33_stall_in = rnode_165to165_bb1_mul33_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul33_0_NO_SHIFT_REG = rnode_165to165_bb1_mul33_0_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul33_0_stall_in_reg_165_NO_SHIFT_REG = rnode_165to165_bb1_mul33_0_stall_in_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul33_0_valid_out_NO_SHIFT_REG = rnode_165to165_bb1_mul33_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb1_mul37_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul37_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_165to165_bb1_mul37_0_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul37_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_165to165_bb1_mul37_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul37_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul37_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb1_mul37_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_165to165_bb1_mul37_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb1_mul37_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb1_mul37_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb1_mul37_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb1_mul37_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb1_mul37),
	.data_out(rnode_165to165_bb1_mul37_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb1_mul37_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb1_mul37_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_165to165_bb1_mul37_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb1_mul37_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb1_mul37_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb1_mul37_valid_out_NO_SHIFT_REG;
assign local_bb1_mul37_stall_in = rnode_165to165_bb1_mul37_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul37_0_NO_SHIFT_REG = rnode_165to165_bb1_mul37_0_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul37_0_stall_in_reg_165_NO_SHIFT_REG = rnode_165to165_bb1_mul37_0_stall_in_NO_SHIFT_REG;
assign rnode_165to165_bb1_mul37_0_valid_out_NO_SHIFT_REG = rnode_165to165_bb1_mul37_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_add34_stall_local;
wire [31:0] local_bb1_add34;

assign local_bb1_add34 = (rnode_165to165_bb1_mul33_0_NO_SHIFT_REG + rnode_165to165_bb1_mul_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_add38_stall_local;
wire [31:0] local_bb1_add38;

assign local_bb1_add38 = (local_bb1_add34 + rnode_165to165_bb1_mul37_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb1_shr_valid_out;
wire local_bb1_shr_stall_in;
wire local_bb1_shr_inputs_ready;
wire local_bb1_shr_stall_local;
wire [31:0] local_bb1_shr;

assign local_bb1_shr_inputs_ready = (rnode_165to165_bb1_mul33_0_valid_out_NO_SHIFT_REG & rnode_165to165_bb1_mul_0_valid_out_NO_SHIFT_REG & rnode_165to165_bb1_mul37_0_valid_out_NO_SHIFT_REG);
assign local_bb1_shr = (local_bb1_add38 >> 32'h8);
assign local_bb1_shr_valid_out = local_bb1_shr_inputs_ready;
assign local_bb1_shr_stall_local = local_bb1_shr_stall_in;
assign rnode_165to165_bb1_mul33_0_stall_in_NO_SHIFT_REG = (local_bb1_shr_stall_local | ~(local_bb1_shr_inputs_ready));
assign rnode_165to165_bb1_mul_0_stall_in_NO_SHIFT_REG = (local_bb1_shr_stall_local | ~(local_bb1_shr_inputs_ready));
assign rnode_165to165_bb1_mul37_0_stall_in_NO_SHIFT_REG = (local_bb1_shr_stall_local | ~(local_bb1_shr_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_165to166_bb1_shr_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to166_bb1_shr_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_165to166_bb1_shr_0_NO_SHIFT_REG;
 logic rnode_165to166_bb1_shr_0_reg_166_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_165to166_bb1_shr_0_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_shr_0_valid_out_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_shr_0_stall_in_reg_166_NO_SHIFT_REG;
 logic rnode_165to166_bb1_shr_0_stall_out_reg_166_NO_SHIFT_REG;

acl_data_fifo rnode_165to166_bb1_shr_0_reg_166_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to166_bb1_shr_0_reg_166_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to166_bb1_shr_0_stall_in_reg_166_NO_SHIFT_REG),
	.valid_out(rnode_165to166_bb1_shr_0_valid_out_reg_166_NO_SHIFT_REG),
	.stall_out(rnode_165to166_bb1_shr_0_stall_out_reg_166_NO_SHIFT_REG),
	.data_in(local_bb1_shr),
	.data_out(rnode_165to166_bb1_shr_0_reg_166_NO_SHIFT_REG)
);

defparam rnode_165to166_bb1_shr_0_reg_166_fifo.DEPTH = 2;
defparam rnode_165to166_bb1_shr_0_reg_166_fifo.DATA_WIDTH = 32;
defparam rnode_165to166_bb1_shr_0_reg_166_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to166_bb1_shr_0_reg_166_fifo.IMPL = "ll_reg";

assign rnode_165to166_bb1_shr_0_reg_166_inputs_ready_NO_SHIFT_REG = local_bb1_shr_valid_out;
assign local_bb1_shr_stall_in = rnode_165to166_bb1_shr_0_stall_out_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_shr_0_NO_SHIFT_REG = rnode_165to166_bb1_shr_0_reg_166_NO_SHIFT_REG;
assign rnode_165to166_bb1_shr_0_stall_in_reg_166_NO_SHIFT_REG = rnode_165to166_bb1_shr_0_stall_in_NO_SHIFT_REG;
assign rnode_165to166_bb1_shr_0_valid_out_NO_SHIFT_REG = rnode_165to166_bb1_shr_0_valid_out_reg_166_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_conv39_stall_local;
wire [7:0] local_bb1_conv39;

assign local_bb1_conv39 = rnode_165to166_bb1_shr_0_NO_SHIFT_REG[7:0];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_out_insertValue_2_stall_local;
wire [31:0] local_bb1_memcoalesce_img_test_out_insertValue_2;

assign local_bb1_memcoalesce_img_test_out_insertValue_2[15:0] = 16'bxxxxxxxxxxxxxxxx;
assign local_bb1_memcoalesce_img_test_out_insertValue_2[23:16] = local_bb1_conv39;
assign local_bb1_memcoalesce_img_test_out_insertValue_2[31:24] = 8'bxxxxxxxx;

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_out_insertValue_1_stall_local;
wire [31:0] local_bb1_memcoalesce_img_test_out_insertValue_1;

assign local_bb1_memcoalesce_img_test_out_insertValue_1[7:0] = local_bb1_memcoalesce_img_test_out_insertValue_2[7:0];
assign local_bb1_memcoalesce_img_test_out_insertValue_1[15:8] = local_bb1_conv39;
assign local_bb1_memcoalesce_img_test_out_insertValue_1[31:16] = local_bb1_memcoalesce_img_test_out_insertValue_2[31:16];

// This section implements an unregistered operation.
// 
wire local_bb1_memcoalesce_img_test_out_insertValue_0_valid_out;
wire local_bb1_memcoalesce_img_test_out_insertValue_0_stall_in;
wire local_bb1_memcoalesce_img_test_out_insertValue_0_inputs_ready;
wire local_bb1_memcoalesce_img_test_out_insertValue_0_stall_local;
wire [31:0] local_bb1_memcoalesce_img_test_out_insertValue_0;

assign local_bb1_memcoalesce_img_test_out_insertValue_0_inputs_ready = rnode_165to166_bb1_shr_0_valid_out_NO_SHIFT_REG;
assign local_bb1_memcoalesce_img_test_out_insertValue_0[7:0] = local_bb1_conv39;
assign local_bb1_memcoalesce_img_test_out_insertValue_0[31:8] = local_bb1_memcoalesce_img_test_out_insertValue_1[31:8];
assign local_bb1_memcoalesce_img_test_out_insertValue_0_valid_out = local_bb1_memcoalesce_img_test_out_insertValue_0_inputs_ready;
assign local_bb1_memcoalesce_img_test_out_insertValue_0_stall_local = local_bb1_memcoalesce_img_test_out_insertValue_0_stall_in;
assign rnode_165to166_bb1_shr_0_stall_in_NO_SHIFT_REG = (|local_bb1_memcoalesce_img_test_out_insertValue_0_stall_local);

// This section implements a registered operation.
// 
wire local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready;
 reg local_bb1_st_memcoalesce_img_test_out_insertValue_0_valid_out_NO_SHIFT_REG;
wire local_bb1_st_memcoalesce_img_test_out_insertValue_0_stall_in;
wire local_bb1_st_memcoalesce_img_test_out_insertValue_0_output_regs_ready;
wire local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out;
wire local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_valid_out;
wire local_bb1_st_memcoalesce_img_test_out_insertValue_0_causedstall;

lsu_top lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out),
	.i_valid(local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready),
	.i_address(local_bb1_memcoalesce_img_test_out_bitcast_0),
	.i_writedata(local_bb1_memcoalesce_img_test_out_insertValue_0),
	.i_cmpdata(),
	.i_predicate(rnode_165to166_bb1_first_cleanup_xor_or_0_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(input_wii_memcoalesce_img_test_out_or_byte_en_2),
	.i_stall(~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_output_regs_ready)),
	.o_valid(local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb1_st_memcoalesce_img_test_out_insertValue_0_active),
	.avm_address(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_address),
	.avm_read(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_read),
	.avm_readdata(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdata),
	.avm_write(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_write),
	.avm_writeack(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writeack),
	.avm_burstcount(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_burstcount),
	.avm_writedata(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writedata),
	.avm_byteenable(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_byteenable),
	.avm_waitrequest(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_waitrequest),
	.avm_readdatavalid(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.AWIDTH = 30;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.WIDTH_BYTES = 4;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.MWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.ALIGNMENT_BYTES = 1;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.READ = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.ATOMIC = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.WIDTH = 32;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.MWIDTH = 256;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.ATOMIC_WIDTH = 3;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.MEMORY_SIDE_MEM_LATENCY = 8;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.USE_WRITE_ACK = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.NUMBER_BANKS = 1;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.USEINPUTFIFO = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.USECACHING = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.USEOUTPUTFIFO = 1;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.HIGH_FMAX = 1;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.ADDRSPACE = 1;
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.STYLE = "BURST-NON-ALIGNED";
defparam lsu_local_bb1_st_memcoalesce_img_test_out_insertValue_0.USE_BYTE_EN = 1;

assign local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready = (local_bb1_memcoalesce_img_test_out_insertValue_0_valid_out & local_bb1_memcoalesce_img_test_out_bitcast_0_valid_out & rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_valid_out_NO_SHIFT_REG & rnode_165to166_bb1_first_cleanup_xor_or_0_valid_out_NO_SHIFT_REG);
assign local_bb1_st_memcoalesce_img_test_out_insertValue_0_output_regs_ready = (&(~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_valid_out_NO_SHIFT_REG) | ~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_stall_in)));
assign local_bb1_memcoalesce_img_test_out_insertValue_0_stall_in = (local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out | ~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready));
assign local_bb1_memcoalesce_img_test_out_bitcast_0_stall_in = (local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out | ~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready));
assign rnode_165to166_memcoalesce_img_test_out_or_byte_en_2_0_stall_in_NO_SHIFT_REG = (local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out | ~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready));
assign rnode_165to166_bb1_first_cleanup_xor_or_0_stall_in_NO_SHIFT_REG = (local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out | ~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready));
assign local_bb1_st_memcoalesce_img_test_out_insertValue_0_causedstall = (local_bb1_st_memcoalesce_img_test_out_insertValue_0_inputs_ready && (local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_stall_out && !(~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_st_memcoalesce_img_test_out_insertValue_0_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_st_memcoalesce_img_test_out_insertValue_0_output_regs_ready)
		begin
			local_bb1_st_memcoalesce_img_test_out_insertValue_0_valid_out_NO_SHIFT_REG <= local_bb1_st_memcoalesce_img_test_out_insertValue_0_fu_valid_out;
		end
		else
		begin
			if (~(local_bb1_st_memcoalesce_img_test_out_insertValue_0_stall_in))
			begin
				local_bb1_st_memcoalesce_img_test_out_insertValue_0_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_valid_out_NO_SHIFT_REG;
 logic rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_in_NO_SHIFT_REG;
 logic rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_inputs_ready_NO_SHIFT_REG;
 logic rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_valid_out_reg_170_NO_SHIFT_REG;
 logic rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_in_reg_170_NO_SHIFT_REG;
 logic rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_out_reg_170_NO_SHIFT_REG;

acl_data_fifo rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_in_reg_170_NO_SHIFT_REG),
	.valid_out(rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_valid_out_reg_170_NO_SHIFT_REG),
	.stall_out(rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_out_reg_170_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_fifo.DEPTH = 3;
defparam rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_fifo.DATA_WIDTH = 0;
defparam rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_fifo.IMPL = "zl_reg";

assign rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_reg_170_inputs_ready_NO_SHIFT_REG = local_bb1_st_memcoalesce_img_test_out_insertValue_0_valid_out_NO_SHIFT_REG;
assign local_bb1_st_memcoalesce_img_test_out_insertValue_0_stall_in = rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_out_reg_170_NO_SHIFT_REG;
assign rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_in_reg_170_NO_SHIFT_REG = rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_in_NO_SHIFT_REG;
assign rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_valid_out_NO_SHIFT_REG = rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_valid_out_reg_170_NO_SHIFT_REG;

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;

assign branch_var__inputs_ready = (rnode_169to170_bb1_initerations_push3_next_initerations_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_lastiniteration_last_initeration_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_cleanups_push4_next_cleanups_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_notexitcond_notexit_0_valid_out_NO_SHIFT_REG & rnode_169to170_bb1_masked_0_valid_out_NO_SHIFT_REG & rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign rnode_169to170_bb1_initerations_push3_next_initerations_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_169to170_bb1_lastiniteration_last_initeration_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_169to170_bb1_indvars_iv15_push2_indvars_iv_next16_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_169to170_bb1_cleanups_push4_next_cleanups_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_169to170_bb1_notexitcond_notexit_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_169to170_bb1_masked_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_170to170_bb1_st_memcoalesce_img_test_out_insertValue_0_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			branch_compare_result_NO_SHIFT_REG <= rnode_169to170_bb1_masked_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module graying_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = ~(stall_in);
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module graying_function
	(
		input 		clock,
		input 		resetn,
		output 		stall_out,
		input 		valid_in,
		output 		valid_out,
		input 		stall_in,
		input [255:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdata,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdatavalid,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_waitrequest,
		output [29:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_address,
		output 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_read,
		output 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_write,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writeack,
		output [255:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writedata,
		output [31:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_byteenable,
		output [4:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_burstcount,
		input [255:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdata,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdatavalid,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_waitrequest,
		output [29:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_address,
		output 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_read,
		output 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_write,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writeack,
		output [255:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writedata,
		output [31:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_byteenable,
		output [4:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_burstcount,
		input 		start,
		input [31:0] 		input_iterations,
		input 		clock2x,
		input [63:0] 		input_img_test_in,
		input [63:0] 		input_img_test_out,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] workgroup_size;
wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire bb_0_lvb_bb0_cmp5;
wire [3:0] bb_0_lvb_bb0_memcoalesce_img_test_out_or_byte_en_2;
wire bb_1_stall_out_0;
wire bb_1_stall_out_1;
wire bb_1_valid_out_0;
wire bb_1_valid_out_1;
wire bb_1_feedback_stall_out_4;
wire bb_1_feedback_stall_out_0;
wire bb_1_feedback_stall_out_1;
wire bb_1_acl_pipelined_valid;
wire bb_1_acl_pipelined_exiting_valid;
wire bb_1_acl_pipelined_exiting_stall;
wire bb_1_feedback_stall_out_3;
wire bb_1_feedback_stall_out_2;
wire bb_1_feedback_valid_out_3;
wire [3:0] bb_1_feedback_data_out_3;
wire bb_1_feedback_valid_out_0;
wire bb_1_feedback_data_out_0;
wire bb_1_feedback_valid_out_2;
wire [63:0] bb_1_feedback_data_out_2;
wire bb_1_feedback_valid_out_4;
wire [3:0] bb_1_feedback_data_out_4;
wire bb_1_local_bb1_ld_memcoalesce_img_test_in_load_0_active;
wire bb_1_feedback_valid_out_1;
wire bb_1_feedback_data_out_1;
wire bb_1_local_bb1_st_memcoalesce_img_test_out_insertValue_0_active;
wire bb_2_stall_out;
wire bb_2_valid_out;
wire feedback_stall_3;
wire feedback_valid_3;
wire [3:0] feedback_data_3;
wire feedback_stall_0;
wire feedback_valid_0;
wire feedback_data_0;
wire feedback_stall_2;
wire feedback_valid_2;
wire [63:0] feedback_data_2;
wire feedback_stall_1;
wire feedback_valid_1;
wire feedback_data_1;
wire feedback_stall_4;
wire feedback_valid_4;
wire [3:0] feedback_data_4;
wire writes_pending;
wire [1:0] lsus_active;

graying_basic_block_0 graying_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.input_iterations(input_iterations),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out_1),
	.lvb_bb0_cmp5(bb_0_lvb_bb0_cmp5),
	.lvb_bb0_memcoalesce_img_test_out_or_byte_en_2(bb_0_lvb_bb0_memcoalesce_img_test_out_or_byte_en_2),
	.workgroup_size(workgroup_size)
);


graying_basic_block_1 graying_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_iterations(input_iterations),
	.input_img_test_in(input_img_test_in),
	.input_img_test_out(input_img_test_out),
	.input_wii_cmp5(bb_0_lvb_bb0_cmp5),
	.input_wii_memcoalesce_img_test_out_or_byte_en_2(bb_0_lvb_bb0_memcoalesce_img_test_out_or_byte_en_2),
	.valid_in_0(bb_1_acl_pipelined_valid),
	.stall_out_0(bb_1_stall_out_0),
	.input_forked_0(1'b0),
	.valid_in_1(bb_0_valid_out),
	.stall_out_1(bb_1_stall_out_1),
	.input_forked_1(1'b1),
	.valid_out_0(bb_1_valid_out_0),
	.stall_in_0(bb_2_stall_out),
	.valid_out_1(bb_1_valid_out_1),
	.stall_in_1(1'b0),
	.workgroup_size(workgroup_size),
	.start(start),
	.feedback_valid_in_4(feedback_valid_4),
	.feedback_stall_out_4(feedback_stall_4),
	.feedback_data_in_4(feedback_data_4),
	.feedback_valid_in_0(feedback_valid_0),
	.feedback_stall_out_0(feedback_stall_0),
	.feedback_data_in_0(feedback_data_0),
	.feedback_valid_in_1(feedback_valid_1),
	.feedback_stall_out_1(feedback_stall_1),
	.feedback_data_in_1(feedback_data_1),
	.acl_pipelined_valid(bb_1_acl_pipelined_valid),
	.acl_pipelined_stall(bb_1_stall_out_0),
	.acl_pipelined_exiting_valid(bb_1_acl_pipelined_exiting_valid),
	.acl_pipelined_exiting_stall(bb_1_acl_pipelined_exiting_stall),
	.feedback_valid_in_3(feedback_valid_3),
	.feedback_stall_out_3(feedback_stall_3),
	.feedback_data_in_3(feedback_data_3),
	.feedback_valid_in_2(feedback_valid_2),
	.feedback_stall_out_2(feedback_stall_2),
	.feedback_data_in_2(feedback_data_2),
	.feedback_valid_out_3(feedback_valid_3),
	.feedback_stall_in_3(feedback_stall_3),
	.feedback_data_out_3(feedback_data_3),
	.feedback_valid_out_0(feedback_valid_0),
	.feedback_stall_in_0(feedback_stall_0),
	.feedback_data_out_0(feedback_data_0),
	.feedback_valid_out_2(feedback_valid_2),
	.feedback_stall_in_2(feedback_stall_2),
	.feedback_data_out_2(feedback_data_2),
	.feedback_valid_out_4(feedback_valid_4),
	.feedback_stall_in_4(feedback_stall_4),
	.feedback_data_out_4(feedback_data_4),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdata(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdata),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdatavalid(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdatavalid),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_waitrequest(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_waitrequest),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_address(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_address),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_read(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_read),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_write(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_write),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writeack(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writeack),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writedata(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writedata),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_byteenable(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_byteenable),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_burstcount(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_burstcount),
	.local_bb1_ld_memcoalesce_img_test_in_load_0_active(bb_1_local_bb1_ld_memcoalesce_img_test_in_load_0_active),
	.clock2x(clock2x),
	.feedback_valid_out_1(feedback_valid_1),
	.feedback_stall_in_1(feedback_stall_1),
	.feedback_data_out_1(feedback_data_1),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdata(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdata),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdatavalid(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdatavalid),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_waitrequest(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_waitrequest),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_address(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_address),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_read(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_read),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_write(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_write),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writeack(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writeack),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writedata(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writedata),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_byteenable(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_byteenable),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_burstcount(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_burstcount),
	.local_bb1_st_memcoalesce_img_test_out_insertValue_0_active(bb_1_local_bb1_st_memcoalesce_img_test_out_insertValue_0_active)
);


graying_basic_block_2 graying_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_1_valid_out_0),
	.stall_out(bb_2_stall_out),
	.valid_out(bb_2_valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size),
	.start(start)
);


graying_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign workgroup_size = 32'h1;
assign valid_out = bb_2_valid_out;
assign stall_out = bb_0_stall_out;
assign writes_pending = bb_1_local_bb1_st_memcoalesce_img_test_out_insertValue_0_active;
assign lsus_active[0] = bb_1_local_bb1_ld_memcoalesce_img_test_in_load_0_active;
assign lsus_active[1] = bb_1_local_bb1_st_memcoalesce_img_test_out_insertValue_0_active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module graying_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output 		avs_cra_waitrequest,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [255:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_readdata,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_readdatavalid,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_address,
		output 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_read,
		output 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_write,
		input 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_writeack,
		output [255:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_writedata,
		output [31:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_byteenable,
		output [4:0] 		avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_burstcount,
		input [255:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_readdata,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_readdatavalid,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_waitrequest,
		output [29:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_address,
		output 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_read,
		output 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_write,
		input 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_writeack,
		output [255:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_writedata,
		output [31:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_byteenable,
		output [4:0] 		avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world. It comprises a
// slave interface to specify the kernel arguments and retain kernel status. 

// This section of the wrapper implements the slave interface.
// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg start_NO_SHIFT_REG;
 reg started_NO_SHIFT_REG;
wire finish;
 reg [31:0] status_NO_SHIFT_REG;
wire has_a_write_pending;
wire has_a_lsu_active;
 reg [159:0] kernel_arguments_NO_SHIFT_REG;
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
 reg [31:0] workgroup_size_NO_SHIFT_REG;
 reg [31:0] global_size_NO_SHIFT_REG[2:0];
 reg [31:0] num_groups_NO_SHIFT_REG[2:0];
 reg [31:0] local_size_NO_SHIFT_REG[2:0];
 reg [31:0] work_dim_NO_SHIFT_REG;
 reg [31:0] global_offset_NO_SHIFT_REG[2:0];
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
wire dispatched_all_groups;
wire [31:0] group_id_tmp[2:0];
wire [31:0] global_id_base_out[2:0];
wire start_out;
wire [31:0] local_id[0:0][2:0];
wire [31:0] global_id[0:0][2:0];
wire [31:0] group_id[0:0][2:0];
wire iter_valid_in;
wire iter_stall_out;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end



// Work group dispatcher is responsible for issuing work-groups to id iterator(s)
acl_work_group_dispatcher group_dispatcher (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.num_groups(num_groups_NO_SHIFT_REG),
	.local_size(local_size_NO_SHIFT_REG),
	.stall_in(iter_stall_out),
	.valid_out(iter_valid_in),
	.group_id_out(group_id_tmp),
	.global_id_base_out(global_id_base_out),
	.start_out(start_out),
	.dispatched_all_groups(dispatched_all_groups)
);

defparam group_dispatcher.NUM_COPIES = 1;
defparam group_dispatcher.RUN_FOREVER = 0;


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
wire [63:0] bitenable;

assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign avs_cra_waitrequest = 1'b0;
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start_NO_SHIFT_REG <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments_NO_SHIFT_REG <= 160'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim_NO_SHIFT_REG <= 32'h0;
		workgroup_size_NO_SHIFT_REG <= 32'h0;
		global_size_NO_SHIFT_REG[0] <= 32'h0;
		global_size_NO_SHIFT_REG[1] <= 32'h0;
		global_size_NO_SHIFT_REG[2] <= 32'h0;
		num_groups_NO_SHIFT_REG[0] <= 32'h0;
		num_groups_NO_SHIFT_REG[1] <= 32'h0;
		num_groups_NO_SHIFT_REG[2] <= 32'h0;
		local_size_NO_SHIFT_REG[0] <= 32'h0;
		local_size_NO_SHIFT_REG[1] <= 32'h0;
		local_size_NO_SHIFT_REG[2] <= 32'h0;
		global_offset_NO_SHIFT_REG[0] <= 32'h0;
		global_offset_NO_SHIFT_REG[1] <= 32'h0;
		global_offset_NO_SHIFT_REG[2] <= 32'h0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (status_NO_SHIFT_REG[0])
			begin
				start_NO_SHIFT_REG <= 1'b1;
			end
			if (start_NO_SHIFT_REG)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start_NO_SHIFT_REG <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= local_router_hang;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		case (avs_cra_address)
			4'h0:
			begin
				avs_cra_readdata[31:0] <= status_NO_SHIFT_REG;
				avs_cra_readdata[63:32] <= 32'h0;
			end

			4'h1:
			begin
				avs_cra_readdata[31:0] <= 'x;
				avs_cra_readdata[63:32] <= 32'h0;
			end

			4'h2:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h3:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h4:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h5:
			begin
				avs_cra_readdata[31:0] <= work_dim_NO_SHIFT_REG;
				avs_cra_readdata[63:32] <= workgroup_size_NO_SHIFT_REG;
			end

			4'h6:
			begin
				avs_cra_readdata[31:0] <= global_size_NO_SHIFT_REG[0];
				avs_cra_readdata[63:32] <= global_size_NO_SHIFT_REG[1];
			end

			4'h7:
			begin
				avs_cra_readdata[31:0] <= global_size_NO_SHIFT_REG[2];
				avs_cra_readdata[63:32] <= num_groups_NO_SHIFT_REG[0];
			end

			4'h8:
			begin
				avs_cra_readdata[31:0] <= num_groups_NO_SHIFT_REG[1];
				avs_cra_readdata[63:32] <= num_groups_NO_SHIFT_REG[2];
			end

			4'h9:
			begin
				avs_cra_readdata[31:0] <= local_size_NO_SHIFT_REG[0];
				avs_cra_readdata[63:32] <= local_size_NO_SHIFT_REG[1];
			end

			4'hA:
			begin
				avs_cra_readdata[31:0] <= local_size_NO_SHIFT_REG[2];
				avs_cra_readdata[63:32] <= global_offset_NO_SHIFT_REG[0];
			end

			4'hB:
			begin
				avs_cra_readdata[31:0] <= global_offset_NO_SHIFT_REG[1];
				avs_cra_readdata[63:32] <= global_offset_NO_SHIFT_REG[2];
			end

			4'hC:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[31:0];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[63:32];
			end

			4'hD:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[95:64];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[127:96];
			end

			4'hE:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[159:128];
				avs_cra_readdata[63:32] <= 32'h0;
			end

			default:
			begin
				avs_cra_readdata <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
	end
	else
	begin
		avs_cra_readdatavalid <= (avs_cra_read & ~(avs_cra_waitrequest));
	end
end


// Handshaking signals used to control data through the pipeline

// Determine when the kernel is finished.
acl_kernel_finish_detector kernel_finish_detector (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.wg_size(workgroup_size_NO_SHIFT_REG),
	.wg_dispatch_valid_out(iter_valid_in),
	.wg_dispatch_stall_in(iter_stall_out),
	.dispatched_all_groups(dispatched_all_groups),
	.kernel_copy_valid_out(valid_out),
	.kernel_copy_stall_in(stall_in),
	.pending_writes(has_a_write_pending),
	.finish(finish)
);

defparam kernel_finish_detector.NUM_COPIES = 1;
defparam kernel_finish_detector.WG_SIZE_W = 32;

assign stall_in = 1'b0;

// Creating ID iterator and kernel instance for every requested kernel copy

// ID iterator is responsible for iterating over all local ids for given work-groups
acl_id_iterator id_iter_inst0 (
	.clock(clock),
	.resetn(resetn),
	.start(start_out),
	.valid_in(iter_valid_in),
	.stall_out(iter_stall_out),
	.stall_in(stall_out),
	.valid_out(valid_in),
	.group_id_in(group_id_tmp),
	.global_id_base_in(global_id_base_out),
	.local_size(local_size_NO_SHIFT_REG),
	.global_size(global_size_NO_SHIFT_REG),
	.local_id(local_id[0]),
	.global_id(global_id[0]),
	.group_id(group_id[0])
);



// This section instantiates a kernel function block
graying_function graying_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdata(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_readdata),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_readdatavalid(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_readdatavalid),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_waitrequest(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_waitrequest),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_address(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_address),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_read(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_read),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_write(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_write),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writeack(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_writeack),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_writedata(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_writedata),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_byteenable(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_byteenable),
	.avm_local_bb1_ld_memcoalesce_img_test_in_load_0_burstcount(avm_local_bb1_ld_memcoalesce_img_test_in_load_0_inst0_burstcount),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdata(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_readdata),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_readdatavalid(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_readdatavalid),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_waitrequest(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_waitrequest),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_address(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_address),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_read(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_read),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_write(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_write),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writeack(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_writeack),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_writedata(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_writedata),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_byteenable(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_byteenable),
	.avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_burstcount(avm_local_bb1_st_memcoalesce_img_test_out_insertValue_0_inst0_burstcount),
	.start(start_out),
	.input_iterations(kernel_arguments_NO_SHIFT_REG[159:128]),
	.clock2x(clock2x),
	.input_img_test_in(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_img_test_out(kernel_arguments_NO_SHIFT_REG[127:64]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module graying_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

