classdef Grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here
    
    % ==================================PROPERTIES=============================================
    properties
        eds_src = ones(3, 1)
        z_src = ones(3, 3)
        src_id = ''
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
            this.eds_src = src_EMF * [1; exp(2i*pi/3); exp(4i*pi/3)];
            this.z_src = src_Zn*ones(3) + src_Z0*eye(3);

            % find source node 
            this.src_id = src_id;
            this.obj_node_src = this.find_node(src_id);
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
            temp_line = line(line_id, in_node, out_node, varargin{:});
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
            I0 = sigma0 * U0;
            srcNode.I = I0;
            srcNode.U = U0;

            % propaget phasors
            srcNode.calcPhasors()
        end


        % adding brake to line
        function insertNode(this, line_id, xi, new_node_id, new_node_load)
            
           % init new node
           addNode(this, new_node_id, new_node_load) 
           new_node = find_node(this, new_node_id);
           
           % find line with enter line_id 
           temp_line = find_line(this, line_id);
           
           % delete parent line of node
           old_out_node_id = temp_line.node_out.id;
           temp_line.node_out.line_p = []; 
                      
           % set found line new L and node_out and id
           L = temp_line.L;
           temp_line.L = L * xi;
           temp_line.node_out = new_node;
           temp_line.id = [line_id , '_1'];
           
           new_L = (1-xi)*L;
           new_line_id = [line_id , '_2'];
           addLine(this, new_line_id, new_node_id, old_out_node_id, new_L, temp_line.W);
           
           new_node.line_p = temp_line;

        end


        % adding brake to line
        function insertFold(this, line_id, xi, vec_l)

%            [ab, ac, ag, bc, bg, cg] 
           load = [sum(vec_l([3, 1, 2])), -vec_l(1), -vec_l(2);...
                   -vec_l(1), sum(vec_l([5, 1, 4])), -vec_l(4);...
                   -vec_l(2), -vec_l(4), sum(vec_l([6, 4, 2]))];

           hash_str = sprintf('%d', load);
           hash_str = [hash_str, line_id, num2str(xi)];
           hash = string2hash(hash_str);
            
           % insert new node
           insertNode(this, line_id, xi, hash, load)
           
           % hash func
           function hash = string2hash(string)
               persistent md
               if isempty(md)
                   md = java.security.MessageDigest.getInstance('SHA-256');
               end
               hash = sprintf('%2.2x', typecast(md.digest(uint8(string)), 'uint8')');
           end

        end
        
    end
    
end

