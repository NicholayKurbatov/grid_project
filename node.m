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
            if (obj(varargin) <= 1) && ~isempty(varargin{1})
                obj.line_in = varargin{1}; 
            end

            if (obj(varargin) <= 1) && ~isempty(varargin{2})
                obj.line_out = varargin{2}; 
            end

<<<<<<< HEAD
            if (obj(varargin) <= 1) && ~isempty(varargin{3})
                if class(varargin{3}) ~= 'double'
                    error('')
                end
                if size(varargin{3}) ~= [3, 1]
                    error('')
                end
                obj.I = varargin{3}; 
            end

            if (obj(varargin) <= 1) && ~isempty(varargin{4})
                obj.U = varargin{4}; 
            end
            
            if (obj(varargin) <= 1) && ~isempty(varargin{5})
                obj.sigma = varargin{5}; 
=======
            if (obj(varargin) <= 1) && ~isempty(varargin{4})
                obj.I = varargin{4}; 
            end

            if (obj(varargin) <= 1) && ~isempty(varargin{5})
                obj.I = varargin{5}; 
            end

            if (obj(varargin) <= 1) && ~isempty(varargin{6})
                obj.U = varargin{6}; 
            end
            
            if (obj(varargin) <= 1) && ~isempty(varargin{7})
                obj.sigma = varargin{7}; 
>>>>>>> 119f6a68979df7e4d5c6dd1b7fd56097671917e2
            end
 
<<<<<<< HEAD
            if (obj(varargin) <= 1) && ~isempty(varargin{6})
                obj.load = varargin{6}; 
=======
            if (obj(varargin) <= 1) && ~isempty(obj(varargin{8}))
                obj.load = varargin{8}; 
>>>>>>> 119f6a68979df7e4d5c6dd1b7fd56097671917e2
            end


        end

    end
end

