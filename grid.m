classdef grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        eds_src = ones(3, 1)
        z_src = ones(3, 3)
        src_id = 1
        node_list = {}
        line_list = {}
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
            temp_node = find_node(this, node_id);
            if ~isempty(temp_node)
                error('Your node_id not unique')
            end
            
            this.node_list{end+1} = node(node_id, varargin);
            
        end
        
        
        % adding line
        function add_line(this, line_id, node_in_id, node_out_id, varargin) 
            % ===================================================
            % line_name -- str, unique line name 
            % node_in   -- str, unique node name in 
            % node_out  -- str, unique node name out
            % ===================================================
            
            % check uniq line_id
            temp_line = find_line(this, line_id);
            if ~isempty(temp_line)
                error('Your line_id not unique')
            end
            
            % check if exist  node_in_id and node_out_id
            in_node = find_node(this, node_in_id);
            out_node = find_node(this, node_out_id);
            if isempty(in_node)
                error('Your node_in_id not exist')
           
            elseif isempty(out_node)
                error('Your node_out_id not exist')
            end
           
            % create temp line obj
            temp_line = Line(line_id, in_node, out_node);
            this.line_list{end+1} = temp_line;
            
            % add line in grid 
            in_node.line_out{end+1} = temp_line;
            if isempty(out_node.line_in)
                out_node.line_in = temp_line;
            else
                error('out node alraedy have line in')
            end
            
        end
        
        
        % find node by node_id
        function p_node = find_node(this, node_id)
            mask = cellfun(@(x) strcmp(x.id, node_id), this.node_list);
            need_idx = find(mask == 1);
            if isempty(need_idx)
                p_node = [];
            else
                p_node = this.node_list{need_idx};
            end
        end


        % find line by line_id
        function temp_line = find_line(this, line_id)
            mask = cellfun(@(x) strcmp(x.id, line_id), this.line_list);
            need_idx = find(mask == 1);
            if isempty(need_idx)
                temp_line = [];
            else
                temp_line = this.line_list{need_idx};
            end
        end
        
    end
    
end

