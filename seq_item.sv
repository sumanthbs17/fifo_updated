




class seq_item extends uvm_sequence_item;
  
  //---------------------------------------
  //data and control fields
  //---------------------------------------
  rand bit [127:0]i_wrdata;
  rand bit i_rden;
  rand bit i_wren;
  bit o_alm_full;
  bit o_alm_empty;
  bit o_full;
  bit o_empty;
  bit [127:0]o_rddata;
  
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(i_wrdata, UVM_ALL_ON)
  `uvm_field_int(i_rden, UVM_ALL_ON)
  `uvm_field_int(i_wren, UVM_ALL_ON)
  `uvm_field_int(o_alm_full, UVM_ALL_ON)
  `uvm_field_int(o_alm_empty, UVM_ALL_ON)
  `uvm_field_int(o_full, UVM_ALL_ON)
  `uvm_field_int(o_empty, UVM_ALL_ON)
  `uvm_field_int(o_rddata, UVM_ALL_ON)
  `uvm_object_utils_end
  
  //---------------------------------------
  //Constraint
  //---------------------------------------
  constraint c1{i_wren!=i_rden;};
  
  //---------------------------------------
  //Pre randomize function
  //---------------------------------------
  function void pre_randomize();
    if(i_rden)
      i_wrdata.rand_mode(0);
  endfunction
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name="seq_item");
    super.new(name);
  endfunction
  
  function string convert2string();
    return $psprintf("i_wrdata=%0d,i_rden=%0b,i_wren=%0b,o_alm_full=%0b,o_alm_empty=%0b,o_full=%0b,o_empty=%0b,data_out=%0d",i_wrdata,i_rden,i_wren,o_alm_full,o_alm_empty,o_full,o_empty,o_rddata);
  endfunction
  
endclass