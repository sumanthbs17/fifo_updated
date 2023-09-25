class f_sequence extends uvm_sequence#(seq_item);
  `uvm_object_utils(f_sequence)
  
  function new(string name = "f_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    
    `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Write REQs ********"), UVM_LOW)
    
 //contineous write condition   
    repeat(20) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_wren == 1;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Read REQs ********"), UVM_LOW)
    
 //contineous read condition   
    repeat(20) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden == 1;});
      finish_item(req);
    end
    
    `uvm_info(get_type_name(), $sformatf("******** Generate 1000 Random REQs ********"), UVM_LOW)
 //random write and read contition   
    repeat(20) begin
      `uvm_do(req)
    end
    
//alretnate write and read condition    
    repeat(20) begin
      
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_wren == 1;});
      finish_item(req);
      
       req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden == 1;});
      finish_item(req);
      
    end
    
    
  endtask
  
  
endclass
  
 