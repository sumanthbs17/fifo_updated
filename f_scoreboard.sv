
class f_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(seq_item, f_scoreboard) item_got_export;
  `uvm_component_utils(f_scoreboard)
  
  function new(string name = "f_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_got_export = new("item_got_export", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  bit [127:0] queue[$];
  int count;
  int depth=16;
  bit full_flag;
  bit alm_full_flag;
  bit empty_flag;
  bit alm_empty_flag;
  
  function void write(input seq_item item_got);
    bit [127:0] examdata;
    if(item_got.i_wren == 'b1)begin
      
      queue.push_back(item_got.i_wrdata);
        
        $display("%d",count);
        count++;
        
        if(count == depth)
          begin
            full_flag=1;
          end
      
      if(count >= 13 && count<=15)
          begin
            alm_full_flag=1;
          end
      else
        begin
          alm_full_flag=0;
        end
      
        if((full_flag && item_got.o_full)==1)
          begin
            $display("full flag matched");
          end
      if((alm_full_flag && item_got.o_alm_full)==1)
        begin
          $display("almost full flag is matched");
        end
      
      //empty conditions
      
      if(count==0)
          begin
            empty_flag=1;
          end
      else
        begin
          empty_flag=0;
        end
        
        if(count<=1 && count >=2)
          begin
            alm_empty_flag=1;
          end
        else
          begin
            alm_empty_flag=0;
          end
        
        if((empty_flag && item_got.o_full)==1)
          begin
            $display("empty flag is matched");
          end
        
        if((alm_empty_flag && item_got.o_alm_empty)==1)
          begin
            $display("almost empty flag is matched");
          end
          
      
        `uvm_info("write Data", $sformatf("wr: %0b rd: %0b data_in: %0h full: %0b",item_got.i_wren, item_got.i_rden,item_got.i_wrdata, item_got.o_full), UVM_LOW);
    end
      else if (item_got.i_rden == 'b1)begin
      if(queue.size() >= 'd1)begin
        examdata = queue.pop_front();
        $display("%d",count);
        count--;
        
        if(count==0)
          begin
            empty_flag=1;
          end
        
        if(count<=1 && count >=2)
          begin
            alm_empty_flag=1;
          end
        else
          begin
            alm_empty_flag=0;
          end
        
        if((empty_flag && item_got.o_full)==1)
          begin
            $display("empty flag is matched");
          end
        
        if((alm_empty_flag && item_got.o_alm_empty)==1)
          begin
            $display("almost empty flag is matched");
          end
        
        //full condiotions
        if(count == depth)
          begin
            full_flag=1;
          end
        else
          begin
            full_flag=0;
          end
      
      if(count >= 13 && count<=15)
          begin
            alm_full_flag=1;
          end
      else
        begin
          alm_full_flag=0;
        end
      
        if((full_flag && item_got.o_full)==1)
          begin
            $display("full flag matched");
          end
      if((alm_full_flag && item_got.o_alm_full)==1)
        begin
          $display("almost full flag is matched");
        end
        
            
        `uvm_info("Read Data", $sformatf("examdata: %0h data_out: %0h empty: %0b", examdata, item_got.o_rddata, item_got.o_empty), UVM_LOW);
        if(examdata == item_got.o_rddata)begin
          $display("-------- 		Pass! 		--------");
        end
        else begin
          $display("--------		Fail!		--------");
          $display("--------		Check empty	--------");
        end
      end
    end
  endfunction
endclass
        

    

