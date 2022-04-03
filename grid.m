classdef grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        eds_src
        z_src
        src_id
        node_list
        line_list
    end
    
    methods
        % конструктор
        function obj = grid(eds_src, z_src, src_id)
            % ===================================================
            % eds_src -- float array (3, 1)
            % z_src   -- complex array (3, 3)
            % src_id  -- str, source node id 
            % ===================================================
            
            % задаем параметры источника
            obj.eds_src = eds_src;
            obj.z_src = z_src;
            
            % созадем узел, который соответсвует источнику
            add_node(obj, obj.src_id)
            
            obj.src_id = src_id;
        end
        
        
        % добавление узла
        function add_node(this, node_name)
            % ===================================================
            % node_name -- str, unique node name 
            % ===================================================
            
        end
        
        
        % добавление линии
        function add_line(this, line_name, node_in, node_out) 
            % ===================================================
            % line_name -- str, unique line name 
            % node_in   -- str, unique node name in 
            % node_out  -- str, unique node name out
            % ===================================================
            
        end
        
        
        
    end
    
end

