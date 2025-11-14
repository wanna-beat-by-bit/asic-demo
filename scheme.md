edit using - asciiflow.com
```
      PIPELINE                ALU                                
┌─────────────────┐   ┌─────────────────┐                        
│                 │   │ WIDTH           │  WIDTH - cpu word width
│                 │   │                 │                        
│ i_a             ├───┤ i_a             │                        
│ i_b             ├───┤ i_b             │                        
│ i_opcode        ├───┤ i_opcode        │                        
│ i_clk           │   │                 │                        
│ i_rst           │   │                 │                        
│ i_valid         │   │        o_result ├─┐                      
│                 │   │        o_zero   ├─┤                      
│                 │   │        o_cf     ├─┤                      
│                 │   └─────────────────┘ │                      
│                 │                       │                      
│        o_result │◄──────────────────────┤                      
│        o_zero   │◄──────────────────────┤                      
│        o_cf     │◄──────────────────────┘                      
│        o_valid  │                                              
└─────────────────┘                                              

PIPELINE - opeation complete in 2 ticks
```