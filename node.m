classdef node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id 
        line_in % Parent's line (указатели)
        line_out % Children's line
        I % Vectot current
        U % Vectot voltage
        sigma % Matrix conductive 
        load % Matrix load
        
    end
    
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
            if (obj(varargin) <= 1) && ~isempty(obj(varargin{1}))
                obj.line_in = obj(varargin{1}); 
            end

            if (obj(varargin) <= 1) && ~isempty(obj(varargin{2}))
                obj.line_out = obj(varargin{2}); 
            end

            if (obj(varargin) <= 1) && ~isempty(obj(varargin{4}))
                obj.I = obj(varargin{4}); 
            end

            if (obj(varargin) <= 1) && ~isempty(obj(varargin{5}))
                obj.I = obj(varargin{5}); 
            end

            if (obj(varargin) <= 1) && ~isempty(obj(varargin{6}))
                obj.U = obj(varargin{6}); 
            end
            
            if (obj(varargin) <= 1) && ~isempty(obj(varargin{7}))
                obj.sigma = obj(varargin{7}); 
            end
 
            if (obj(varargin) <= 1) && ~isempty(obj(varargin{8}))
                obj.load = obj(varargin{8}); 
            end


        end

    end
end

