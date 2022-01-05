% % IG_Trading_API for Matlab
% % http://labs.ig.com/rest-trading-api-reference
% % Original version by Abdirahman M Kaahin -- 2020
function out=IG_Trading_API(method,action,keyvalue,varargin)
CST_token=varargin{1};        
XST_token=varargin{2};

%METHODS%
url='https://demo-api.ig.com/gateway/deal/';
 switch upper(method)
%Login%   
    case 'LOGIN_UPDATE'
update='session/refresh-token';
V='1';        
Body=struct('refresh_token',varargin{3});
     case 'LOGIN_TOKENS'
update='session?fetchSessionTokens=true';
V='2';         
%Account%        
     case 'ACCOUNT_INFO'
update='accounts';
V='1';
     case 'ACCOUNT_PREFERENCES'
update='accounts/preferences';        
V='1';
       if strcmpi(action,'PUT')
Body=struct('trailingStopsEnabled',varargin{3});
       end 
     case 'ACCOUNT_ACTIVITY'       
update='history/activity?'; 
V='3';
Query=queryMaker(varargin{3},varargin{4}); 
     case 'ACCOUNT_TRANSACTION'
update='history/transactions?';
V='2';
Query=queryMaker(varargin{3},varargin{4});
%Dealing%
     case 'DEALING_CONFIRMATION'
update=['confirms/',varargin{3}];
V='1';
     case 'DEALING_POSITION_ALL'
update='positions';
V='2';
     case 'DEALING_POSITION'
dealId=varargin{3};
update=['positions/',dealId];
V='2';
     case 'DEALING_POSITION_OTC'
update='positions/otc';
V='2';
        if strcmpi(action,'PUT')         
update=[update,'/',varargin{3}];
Body=cell2struct(varargin{4},varargin{5},2);
        elseif strcmpi(action,'DELETE')
V='1'; 
Body=varargin{3};   
        elseif strcmpi(action,'POST')
Body=varargin{3};          
        end 
     case 'DEALING_SPRINTMARKET'
update='positions/sprintmarkets'; 
V='2';
       if strcmpi(action,'POST')
V='1';            
Body=cell2struct(varargin{3},varargin{4},2);
       end       
     case 'DEALING_WORKINGORDERS' 
update='workingorders';
V='2';
     case 'DEALING_WORKINGORDERS_OTC'
update='workingorders/otc'; 
V='2';
       if strcmpi(action,'PUT')||strcmpi(action,'DELETE')       
update=[update,'/',varargin{3}];
       end
       if strcmpi(action,'PUT')
Body=cell2struct(varargin{4},varargin{5},2);
       elseif strcmpi(action,'POST')
Body=cell2struct(varargin{3},varargin{4},2);
       end    
%Markets%
     case 'MARKETS_CATEGORIES'
update='marketnavigation';
V='1';
     case 'MARKETS_CATEGORY' 
update=['marketnavigation/',varargin{3}];
V='1';
     case 'MARKETS'
update='markets?';
V='2';
Query=queryMaker(varargin{3},varargin{4});

     case 'MARKETS_SEARCH'        
update=['markets?searchTerm=',varargin{3}];
V='1';
     case 'MARKETS_PRICE'        
update=['prices/',varargin{3}];
V='2';
       if length(varargin)>3 
Query=queryMaker(varargin{2},varargin{5});
       end     
%Watchlists%
     case 'WATCHLISTS_ALL'
update='watchlists';
V='1';
        if strcmpi(action,'POST')          
Body=struct('name',varargin{3},'epics',varargin{4}); 
        end
     case 'WATCHLISTS_SPECIFIC'
update=['watchlists/',varargin{3}];
V='1';
        if strcmpi(action,'POST') 
Body=struct('watchlist',varargin{4});
        end
     case 'WATCHLISTS_REMOVER'
update=['watchlists/',varargin{3},'/',varargin{4}];
V='1';
%Client Sentiment%
     case 'CLIENTSENTIMENT'
update='clientsentiment'; 
V='1';
       if length(markedId)==1
marketId=varargin{3};           
update=[update,'/',marketId]; 
       else
Query=queryMaker(varargin{3},varargin{4});           
       end 
    case 'CLIENTSENTIMENT_RELATED'       
update=['clientsentiment/related/',varargin{3}]; 
V='1';
%General%
     case 'CLIENT_DATA'
update='operations/application';
V='1';   
        if  strcmpi(action,'PUT') 
Body=cell2struct(varargin{3},varargin{4},2);
        end
 end
 
%HEADERS%


    if strcmpi(action,'PUT')
Header_Input={'Version',V;'X-IG-API-KEY',keyvalue;'CST',CST_token;'X-SECURITY-TOKEN',XST_token};
%action=varargin{end};
    elseif strcmpi(action,'DELETE')
Header_Input={'Content-Type','application/json; charset=UTF-8';'Accept','application/json; charset=UTF-8';...
      'version',V;'X-IG-API-KEY',keyvalue;'CST',CST_token;'X-SECURITY-TOKEN',XST_token;'_method','DELETE'};
    else
Header_Input={'version',V;'X-IG-API-KEY',keyvalue;'CST',CST_token;'X-SECURITY-TOKEN',XST_token};
    end 
Header=weboptions('HeaderFields',Header_Input);

%ACTIONS% 
switch upper(action)
   case 'POST'
out = webwrite([url,update],Body,Header);
   case 'DELETE' 
out = webwrite([url,update],Body,Header);       
   case 'GET' 
      if ~exist('Query','var')
out = webread([url,update],Header);
      else       
out = webread([url,update,Query],Header);
      end
end
end