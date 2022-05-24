classdef node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    % ==================================PROPERTIES============================================
    properties
        id 
        line_p = [] % Parent's line (указатели)
        line_c = {} % Children's line
        I = zeros(3, 1) % Vectot current
        U = zeros(3, 1) % Vectot voltage
        sigma = zeros(3, 3) % Matrix conductive 
        load = zeros(3, 3)  % Matrix load
    end
    
    % ==================================METHODS=================================================
    methods

        % Constucter
        function obj = node(id, varargin)
            %==============================================================
            % id -- integer 
            % line_in, line_out -- 
            % I, U -- Vector (3,1)
            % sigma -- Matrix (3,3)
            % load -- Matrix (3,3)
            %==============================================================
            obj.id = id;

            if (numel(varargin) >= 1) && ~isempty(varargin{1})
                obj.load = varargin{1}{1};
            end

            if (numel(varargin) >= 2) && ~isempty(varargin{2})
                    obj.line_p = varargin{2}; 
            end

            if (numel(varargin) >= 3) && ~isempty(varargin{3})
                obj.line_c = varargin{3}; 
            end

            if (numel(varargin) >= 4) && ~isempty(varargin{4})
%                 if class(varargin{3}) ~= 'double'
%                     % all(strcmp(cellfun(@class, b, 'UniformOutput', false), 'double'))
%                     error('')
%                 end
%                 if size(varargin{3}) ~= [3, 1]
%                     error('')
%                 end
                obj.I = varargin{4}; 
            end

            if (numel(varargin) >= 5) && ~isempty(varargin{5})
                obj.U = varargin{5}; 
            end
            
            if (numel(varargin) >= 6) && ~isempty(varargin{6})
                obj.sigma = varargin{6}; 
            end
            

        end


        % calculate cumalative sigma 
        function calcSigma(this)

            % load in local node
            sigma_c = this.load;
            
            % all sigma in cildren lines
            for k = 1:numel(this.line_c)
                c_line = this.line_c{k};
                c_line.calcSigma()
                sigma_c = sigma_c + c_line.sigma_in;

            end
            % get cumalative sigma in node
            this.sigma = sigma_c;

        end


        % calculate phasors along the grid
        function calcPhasors(this)
           
            for k = 1:length(this.line_c)
                
                this.line_c{k}.I_in = this.line_c{k}.sigma_in * this.U;
                this.line_c{k}.U_in = this.U;
                this.line_c{k}.calcPhasors();

            end
            
        end


    end
end

