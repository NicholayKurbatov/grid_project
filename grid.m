classdef grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        eds_src = ones(3, 1)
        z_src = ones(3, 3)
        src_id = 1
        node_list = []
        line_list = []
    end
    
    methods
        % conctuctor 
        function obj = grid(src_id, varargin)
            % ===================================================
            % src_id  -- str, source node id 
            % eds_src -- float array (3, 1)
            % z_src   -- complex array (3, 3)
            % ===================================================
            
            % init source, if need 
            if (numel(varargin) >= 1) && ~isempty(varargin{1})
               % dim check
               obj.eds_src = varargin{1};
               if ~isempty(varargin{2})
                   % dim check 
                   obj.z_src = varargin{2};
               end
            else
                obj.eds_src = eds_src;
                obj.z_src = z_src;
            end
            
            % create source node 
            obj.src_id = src_id;
            obj.node_list{end+1} = node(obj.src_id);
            
        end
        
        
        % adding node
        function add_node(this, node_id, varargin)
            % ===================================================
            % node_name -- str, unique node name 
            % 
            % ===================================================
            
            % check uniq node_id 
            if any(cellfun(@(x) strcmp(x.node_id, node_id), this.node_list))
                error('Your node_id not unique')
            end
            
            this.node_list{end+1} = node(this.node_id);
            
        end
        
        
        % adding line
        function add_line(this, line_id, node_in_id, node_out_id, varargin) 
            % ===================================================
            % line_name -- str, unique line name 
            % node_in   -- str, unique node name in 
            % node_out  -- str, unique node name out
            % ===================================================
            
            % check uniq line_id 
            if any(cellfun(@(x) strcmp(x.line_id, line_id), this.line_list))
                error('Your node_id not unique')
            end
            
            % check if exist  node_in_id and node_out_id
            if ~any(cellfun(@(x) strcmp(x.node_id, node_in_id), this.node_list))
                error('Your node_in_id, node_out_id not exist')
            
            elseif ~any(cellfun(@(x) strcmp(x.node_id, node_out_id), this.node_list)) 
                error('Your node_in_id, node_out_id not exist')
            end
           
            this.line_list{end+1} = line(this.node_id);

        end
        
        
        % find node by node_id
        function p_node = find_node(this, node_id)
            mask = cellfun(@(x) strcmp(x.node_id, node_id), this.node_list);
            need_idx = find(mask == 1);
            if need_idx
                p_node = this.node_list{need_idx};
            else
                p_node = [];
            end
        end
        
    end
    
end

