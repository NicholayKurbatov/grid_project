classdef node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
        line_in % родительская линия
        line_out % дочерняя линия
        I
        U
        sigma
        load
        
    end
    
    methods
        % конструктор
        function obj = node(id, line_in, line_out, I, U, sigma, load)
            %==============================================================
            % id -- integer 
            % line_in --
            % I, U
            %==============================================================
            obj.id = id;
            obj.line_in = line_in; 
            obj.line_out = line_out; 
            obj.I = I;
            obj.U = U;
            obj.sigma = sigma;
            obj.load = load;

        end

    end
end

