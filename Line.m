classdef Line < handle
   
    %==================================PROPERTIES==============================================
    
    properties 
        %Defining properties of the line class
        
        node_in = []; %Parent node
        node_out = {}; %Child node
        W = zeros(6, 6); %Matrix W 6*6
        L = 1; %Line length
        I_in = zeros(3, 1); %Current at the input node
        U_in = zeros(3, 1); %Voltage at the input node
        sigma_in = zeros(3, 3); %Matrix of input conductivities
        id; %Node id
        
     
    end
    
   %==================================METHODS=================================================
     
    methods 
        %Defining methods of the line class
         
        function obj = Line(id,node_in,node_out,varargin)
            
   %============================================================================================
            % id -- integer 
            % node_in, node_out -- 
            % I_in, U_in -- Vector (3,1)
            % sigma_in -- Matrix (3,3)
            % load -- Matrix (3,3)
            % W--Matrix W 6*6
  %==============================================================================
            
            %Class constructor
            obj.id = id;
            obj.node_in = node_in;
            obj.node_out = node_out;
    % 
    %       obj.L = L;
    %       obj.W = W;
                
            if (numel(varargin) >= 1) && ~isempty(varargin{1})
                obj.U_in = varargin{1}; 
                
                validateattributes(obj.U_in,{'double'},{'size',[3,1]});
            end
       
            if (numel(varargin) >= 2) && ~isempty(varargin{2})
                obj.I_in = varargin{2}; 
                
                validateattributes(obj.I_in,{'double'},{'size',[3,1]});
            end
            
             if (numel(varargin) >= 3) && ~isempty(varargin{3})
                obj.sigma_in = varargin{3}; 
                
                classes = {'double'};
                attributes = {'size',[3,3]};
                validateattributes(obj.sigma_in ,classes,attributes);
             end

        end

    end
    
end

