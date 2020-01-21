%%
%simulation setting
Stop_time=100e-6;
step_size=10e-9;
%%
%excitation setting
fs=100e3;
Ts=1/fs;
Pulse_width=0.5;
%%
Seq_Input_V=1;
Seq_Output_V=2;
%%
arr_raw={}; %cell array used to store data
%%
%running simulations
for k=1:1:5
    R_series=k*0.1;
    %
    %write to parameters in PSpice
    Text_JSON=fileread('RC_circuit.json'); %Read JSON file
    Struct_JSON=jsondecode(Text_JSON); %Decode JSON-formated text
    Struct_JSON.Params.R_series=num2str(R_series); %Write to an element
    Text_JSON_Post=jsonencode(Struct_JSON); %Create JSON-formatted text from structure
    fileID=fopen('RC_circuit.json','w'); %Open JSON file for write
    fwrite(fileID,Text_JSON_Post,'char'); %Write updated structure to JSON file
    fclose(fileID); %Close JSON file
    %
    sim('RC_circuit');
    arr_raw{k}=ans;
end
%%
%Post processing
%plot rise time of output voltage against series resistance
