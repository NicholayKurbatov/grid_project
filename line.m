classdef line < handle
    %LINE Summary of this class goes here
    %   Detailed explanation goes here

    % ==================================PROPERTIES=============================================
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
    
    % ==================================METHODS=================================================
    methods 
        %Defining methods of the line class
        
        % conctuctor 
        function obj = line(id,node_in,node_out,varargin)
            % ===============================
            % id -- integer 
            % node_in, node_out -- 
            % I_in, U_in -- Vector (3,1)
            % sigma_in -- Matrix (3,3)
            % load -- Matrix (3,3)
            % W--Matrix W 6*6
            % ===============================

            obj.id = id;
            obj.node_in = node_in;
            obj.node_out = node_out;
                
            if (numel(varargin) >= 1) && ~isempty(varargin{1})
                obj.L = varargin{1}; 
            end

            if (numel(varargin) >= 2) && ~isempty(varargin{2})
                obj.W = varargin{2}; 
            end

            if (numel(varargin) >= 3) && ~isempty(varargin{3})
                obj.U_in = varargin{3}; 
                
                validateattributes(obj.U_in,{'double'},{'size',[3,1]});
            end
       
            if (numel(varargin) >= 4) && ~isempty(varargin{4})
                obj.I_in = varargin{4}; 
                
                validateattributes(obj.I_in,{'double'},{'size',[3,1]});
            end
            
             if (numel(varargin) >= 5) && ~isempty(varargin{5})
                obj.sigma_in = varargin{5}; 
                
                classes = {'double'};
                attributes = {'size',[3,3]};
                validateattributes(obj.sigma_in ,classes,attributes);
             end
        end
        

        % calculate cumalative sigma 
        function calcSigma(this)
            %get node out sigma
            this.node_out.calcSigma();
            sigma = this.node_out.sigma;
            E = -1*eye(3);
            AB = [sigma, E] * expm(this.W*this.L);
            A = AB(:,1:3);
            B = AB(:,4:end);
            sigma0 = -1 * inv(B)*A;
            %assign sigma value
            this.sigma_in = sigma0;
        end


        % calculate phasors along the grid
        function calcPhasors(this)     
            sigma_end = this.node_out.sigma;
            IU_in = [this.U_in ; sigma_end * this.U_in ];
            IU_end = expm(-this.W*this.L) * IU_in;
            U_end = IU_end(1:3);
            I_end = IU_end(4:end);
            
            %assign U and I value
            this.node_out.U = U_end;
            this.node_out.I = I_end;
            
            this.node_out.calcPhasors();
        end

    end
    
end


