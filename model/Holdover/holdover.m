% Find a VISA-USB object.
scope = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1AB1::0x04CE::DS1ZA171913011::0::INSTR', 'Tag', '');
% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(scope)
    scope = visa('NI', 'USB0::0x1AB1::0x04CE::DS1ZA171913011::0::INSTR');
else
    fclose(scope);
    scope = scope(1);
end
% Connect to instrument object, scope.
fopen(scope);

% Setup Scope Parameters
fprintf(scope, ':CHANnel1:DISPlay ON');
fprintf(scope, ':CHANnel2:DISPlay ON');
fprintf(scope, ':CHANnel1:OFFSet 0');
fprintf(scope, ':CHANnel2:OFFSet 0');
fprintf(scope, ':CHANnel1:PROBe 1');
fprintf(scope, ':CHANnel2:PROBe 10');
fprintf(scope, ':CHANnel1:SCALe 1');
fprintf(scope, ':CHANnel2:SCALe 1');
data1 = query(scope, ':TIMebase:MAIN:SCALe?');
fprintf(scope, ':TIMebase:MAIN:SCALe 0.00000005');
fprintf(scope, ':TRIGger:MODE EDGE');
fprintf(scope, ':TRIGger:EDGe:SOURce CHANnel1');
fprintf(scope, ':TRIGger:EDGe:LEVel 1.65');
fprintf(scope, ':TRIGger:SWEep NORMal');
fprintf(scope, ':MEASure:SETup:DSA CHANnel1');
fprintf(scope, ':MEASure:SETup:DSB CHANnel2');
fprintf(scope, ':MEASure:ITEM RDELay');
fprintf(scope, ':RUN');

log = fopen('no_lock3.txt','w');

while(true)

    % Get PPS Skew
    delay = query(scope, ':MEASure:ITEM? RDELay');
    
    % Print to File
    fprintf(log, '%s', datestr(now,'HH:MM:SS'));
    fprintf(log,', %s\r\n', delay);
    
    % Print to Terminal
    fprintf('%s, %s', datestr(now,'HH:MM:SS'), delay);
    
    pause(1);

end

% Close Log & Disconnect
fclose(log);
fclose(scope);