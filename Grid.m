classdef Grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here
    
    % ==================================PROPERTIES=============================================
    properties
        eds_src = ones(3, 1)
        z_src = ones(3, 3)
        src_id = '1'
        obj_node_src = {}
        nodes = {}
        lines = {}
    end
    
    % ==================================METHODS================================================
    methods

        % conctuctor 
        function obj = Grid()

        end


        % SET source parameters
        function setSource(this, src_id, src_EMF, src_Z0, src_Zn)
            % ===================================================
            % src_id  -- str, source node id 
            % src_EMF -- complex float, emf source
            % src_Z0   -- complex float, source impedance 
            % src_Zn -- complex float, ground impedance 
            % ===================================================

            % 
            this.eds_src = ones(3, 1) * src_EMF;
            this.z_src = src_Zn*ones(3) + src_Z0*eye(3);

            % find source node 
            this.src_id = src_id;
            this.obj_node_src = this.find_node(src_id);
            this.nodes{end+1} = this.obj_node_src;
        end
        
        
        % adding node
        function addNode(this, node_id, varargin)
            % ===================================================
            % node_name -- str, unique node name 
            % 
            % ===================================================
            
            % check uniq node_id 
            temp_node = find_node(this, node_id);
            if ~isempty(temp_node)
                error('Your node_id not unique')
            end
            
            this.nodes{end+1} = node(node_id, varargin);
        end
        
        
        % adding line
        function addLine(this, line_id, node_in_id, node_out_id, varargin) 
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
            temp_line = line(line_id, in_node, out_node);
            this.lines{end+1} = temp_line;
            
            % add line in grid 
            in_node.line_c{end+1} = temp_line;
            if isempty(out_node.line_p)
                out_node.line_p = temp_line;
            else
                error('out node alraedy have line in')
            end
        end
        
        
        % find node by node_id
        function p_node = find_node(this, node_id)
            mask = cellfun(@(x) strcmp(x.id, node_id), this.nodes);
            need_idx = find(mask == 1);
            if isempty(need_idx)
                p_node = [];
            else
                p_node = this.nodes{need_idx};
            end
        end


        % find line by line_id
        function temp_line = find_line(this, line_id)
            mask = cellfun(@(x) strcmp(x.id, line_id), this.lines);
            need_idx = find(mask == 1);
            if isempty(need_idx)
                temp_line = [];
            else
                temp_line = this.lines{need_idx};
            end
        end


        % calculate phasors along the grid
        function calcPhasors(this)
            srcNode = this.obj_node_src;
            
            % call cumalitive sigma
            srcNode.calcSigma()

            % get phasors in source
            sigma0 = srcNode.sigma;
            U0 = inv(eye(3,3) + this.z_src*sigma0) * this.eds_src;
            I0 = sigma0*U0;
            srcNode.I = I0;
            srcNode.U = U0;

            % propaget phasors
            srcNode.calcPhasors()
        end

        
    end
    
end

