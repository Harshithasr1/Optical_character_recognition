% word= 'AT'
clc
clear all
close all
s=serial('COM1');%initialize com port as serial & set baud rate for laptop check with
  set(s,'BaudRate',9600); 
  
% open the com port and start sending 
   fopen(s);
   fprintf(s,'%s','AT')
   %fprintf(s,'%s','D')
   fprintf(s, '%c', 13)
   pause(2)
   fprintf(s,'%s','AT+CMGF=1')
   %fprintf(s,'%s','D')
   fprintf(s, '%c', 13)
   pause(2)
%      fprintf(s,'%s','AT+CMGS="9448847874"')
%      number='944884784'
%      fprintf(s,'AT+CMGS= ''''number''''','async')
   %fprintf(s,'%s','D')
   number=9448847874;
   fprintf(s,'%s','AT+CMGS="%d"',number,'async')
    pause(2)
   fprintf(s, '%c', 13)
   pause(2)
%     fprintf(s,'%s','hello123')
     fn=12,PSNR=24,SSIM=0.25;
    fprintf(s,'PSNR = %3.2f  SSIM = %3.2f \n',[PSNR, SSIM],'async')
   %fprintf(s,'%s','D')
    pause(2)
   fprintf(s, '%c', 26)
   pause(2)
 % out = fscanf(s,'%s')
   fclose(s);
   
%     this.serialPort.WriteLine("AT" + (char)(13));
%                     Thread.Sleep(2000);
%                     this.serialPort.WriteLine("AT+CMGF=1" + (char)(13));
%                     Thread.Sleep(3000);
%                     this.serialPort.WriteLine("AT+CMGS=\"" + cellNo + "\"");
%                     Thread.Sleep(5000);
%                     this.serialPort.WriteLine(">" + messages + (char)(26));