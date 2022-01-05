% % IG_Streaming_API for Matlab
% % https://labs.ig.com/streaming-api-reference
% % Original version by Abdirahman M Kaahin -- 2020 
function out = IG_Streaming_API(server,method,varargin)  %varargout
 names={'LS_polling','LS_polling_millis','LS_idle_millis'};
 values={'true','0','0'};
switch upper(method)
    case 'CREATE' 
uri='lightstreamer/create_session.txt';        
names=cat(2,'LS_op2','LS_cid','LS_user','LS_password','LS_adapter_set',names);
values=cat(2,'create','mgQkwtwdysogQz2BJ4Ji%20kOj2Bg',varargin{1},...
          ("CST-"+varargin{2}+"|XST-"+varargin{3}),'DEFAULT',values);
    case 'SUBSCRIBE'
uri='lightstreamer/control.txt';        
names=cat(2,'LS_session','LS_mode','LS_id','LS_schema','LS_op',...
       'LS_table','LS_snapshot',names); %,
values=cat(2,varargin{1},varargin{2},varargin{3},varargin{4},...
        'add','1','true',values); %
     case 'BIND' 
uri='lightstreamer/bind_session.txt';
names=cat(2,'LS_session',names);
values=cat(2,varargin{1},values);
end
postQueryArray=queryMaker(names,values);
url=[server,'/',uri];
out=webwrite(url,postQueryArray);
end


