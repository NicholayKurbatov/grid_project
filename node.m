classdef node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id 
        line_in = [] % Parent's line (указатели)
        line_out = {} % Children's line
        I = zeros(3, 1) % Vectot current
        U = zeros(3, 1) % Vectot voltage
        sigma = zeros(3, 3) % Matrix conductive 
        load = zeros(3, 3)  % Matrix load
        
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
%             if (numel(varargin) >= 1) 
%                 if ~isempty(varargin{1})
%                     obj.line_in = varargin{1}; 
%                 el
%             end
% 
%             if (numel(varargin) >= 1) && ~isempty(varargin{2})
%                 obj.line_out = varargin{2}; 
%             end
% 
%             if (numel(varargin) >= 1) && ~isempty(varargin{3})
% %                 if class(varargin{3}) ~= 'double'
% %                     % all(strcmp(cellfun(@class, b, 'UniformOutput', false), 'double'))
% %                     error('')
% %                 end
% %                 if size(varargin{3}) ~= [3, 1]
% %                     error('')
% %                 end
%                 obj.I = varargin{3}; 
%             end
% 
%             if (numel(varargin) >= 1) && ~isempty(varargin{4})
%                 obj.U = varargin{4}; 
%             end
%             
%             if (numel(varargin) >= 1) && ~isempty(varargin{5})
%                 obj.sigma = varargin{5}; 
%             end
%             
%             if (numel(varargin) >= 1) && ~isempty(varargin{6})
%                 obj.load = varargin{6}; 
%             end

        end

    end
end

