classdef line < handle
   
    %==================================PROPERTIES==============================================
    
    properties 
        %Defining properties of the line class
        
        node_in; %Parent node
        node_out; %Child node
        W; %Matrix W 6*6
        L; %Line length
        I_in; %Current at the input node
        U_in; %Voltage at the input node
        sigma_in; %Matrix of input conductivities
        ID; %Node ID
        
     
    end
    
   %==================================METHODS=================================================
     
    methods 
        %Defining methods of the line class
         
        function obj = Line(ID,node_in,node_out,varargin)
            
   %============================================================================================
            % id -- integer 
            % node_in, node_out -- 
            % I_in, U_in -- Vector (3,1)
            % sigma_in -- Matrix (3,3)
            % load -- Matrix (3,3)
            % W--Matrix W 6*6
  %==============================================================================
            
        %Class constructor
        if (nargin>0)
            obj.ID = ID;
            obj.node_in = node_in;
            obj.node_out = node_out;
            obj.L = L;
            obj.W = W;
            
            if (obj(varargin) <= 1) && ~isempty(varargin{1})
                obj.U_in = varargin{1}; 
            end
            
            if (obj(varargin) <= 1) && ~isempty(varargin{1})
                obj.I_in = varargin{1}; 
            end
            
             if (obj(varargin) <= 1) && ~isempty(varargin{1})
                obj.sigma_in = varargin{1}; 
            end

        end
        
        end
    end
    
end

