clear all;
close all;
 
s = serial('COM1'); %assigns the object s to serial port
 
set(s, 'InputBufferSize', 256); %number of bytes in inout buffer
set(s, 'FlowControl', 'hardware');
set(s, 'BaudRate', 9600);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBit', 1);
set(s, 'Timeout',10);
%clc;
 
disp(get(s,'Name'));
prop(1)=(get(s,'BaudRate'));
prop(2)=(get(s,'DataBits'));
prop(3)=(get(s, 'StopBit'));
prop(4)=(get(s, 'InputBufferSize'));
 
disp(['Port Setup Done!!',num2str(prop)]);
xx=[];
%   [num str] = xlsread('database.xlsx');  
  
      for t=1:2
         
fopen(s);           %opens the serial port
 a =fscanf(s);
 fclose(s);
%   a=    str2num(a); 
       xx=[xx a];
      %[x y]=find(cell2mat(str)==cell2mat(word))
%      
%       amount=num(x,2);
     
      end
%       [x y]= find(strcmp(str, xx));
%        k=num(xx,1);
%       
%       pos=['C',num2str(x)];
%           xlswrite('database.xlsx',  upamount,'Sheet1',pos)