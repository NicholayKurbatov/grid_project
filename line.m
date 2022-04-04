classdef line < handle
    %LINE Summary of this class goes here
    %   Detailed explanation goes here

    %==================================PROPERTIES==============================================
    
    properties 
        %Определение свойств класса line
        
        node_in;  % Father узел
        node_out; % Дочерний узел
        W; %Матрица W 6*6
        L; %Длина линии
        I_in; %Ток на входном узле
        U_in; %Напряжение на входном узле
        sigma_in; %Матрица проводимостей на входе
        ID; %ID узла
        
     
    end
    
     %==================================METHODS=================================================
     
    methods 
        %Определение методов класса line
        
        function obj = Line(node_in,node_out,W,L,I_in,U_in,sigma_in,ID)
        %Конструктор класса
        if (nargin>0)
            obj.node_in = node_in;
            obj.node_out = node_out;
            obj.W = W;
            obj.L = L;
            obj.I_in = I_in;
            obj.U_in = U_in;
            obj.ID = ID;
            obj.sigma_in = sigma_in;
        end
        
        end
    end
    
end