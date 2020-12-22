function varargout = Lateral_design_of_coiledtube_irrigation(varargin)
% LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION MATLAB code for Lateral_design_of_coiledtube_irrigation.fig
%      LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION, by itself, creates a new LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION or raises the existing
%      singleton*.
%
%      H = LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION returns the handle to a new LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION or the handle to
%      the existing singleton*.
%
%      LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION.M with the given input arguments.
%
%      LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION('Property','Value',...) creates a new LATERAL_DESIGN_OF_COILEDTUBE_IRRIGATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Lateral_design_of_coiledtube_irrigation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Lateral_design_of_coiledtube_irrigation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Lateral_design_of_coiledtube_irrigation

% Last Modified by GUIDE v2.5 13-Aug-2017 15:41:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lateral_design_of_coiledtube_irrigation_OpeningFcn, ...
                   'gui_OutputFcn',  @Lateral_design_of_coiledtube_irrigation_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Lateral_design_of_coiledtube_irrigation is made visible.
function Lateral_design_of_coiledtube_irrigation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Lateral_design_of_coiledtube_irrigation (see VARARGIN)

% Choose default command line output for Lateral_design_of_coiledtube_irrigation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
[x,map]=imread('ASma.jpg');
axes(handles.axes2);
imshow(x,map);

set(handles.axes,'visible','off');

% UIWAIT makes Lateral_design_of_coiledtube_irrigation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Lateral_design_of_coiledtube_irrigation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for N=1:300;
DT=str2double(get(handles.dt,'string'));
% lateral diameter
DL=str2double(get(handles.dl,'string'));
%sec_exceed
EL=(0.25*DT*19*(DL.^-1.9));
% Distance between coiltube
SS=str2double(get(handles.S,'string'));
% section length
LI=EL+SS;
%coiltube flow
QQ=str2double(get(handles.Q,'string'));
%lateral flow
QQQ(N)=(QQ*N);
%temperture
tw=str2double(get(handles.TW,'string'));
% Renylode number for lateral
   Rel(N+1)=((198.7*QQQ(N)*(1+(0.03368*tw)+(0.000221*(tw.^2))))/DL);
% Renylode number for coiltube 
Ret=((198.7*QQ*(1+(0.03368*tw)+(0.000221*(tw^2))))/DT);
% Friction losses for lateral
if (Rel<=2000);
    hfl(N+1)=((408.4479*(LI*(QQQ(N).^2)))./((Rel(N+1))*(DL.^5)));
else
    hfl(N+1)=((2.01926*(LI*(QQQ(N).^2)))./((Rel(N+1).^0.25)*(DL.^5)));
end
end
%length of coiledtube
L=str2double(get(handles.LL,'string'));
SLP=str2double(get(handles.slp,'string'));
CCl=str2double(get(handles.CCL,'string'));
Lat(1)=(0.5*SS);
for N=2:301;
    %changed
    L(N)=hfl(N)+L(N-1)+(SS*SLP);
    LL=L+CCl;
    Lat(N)=(SS+Lat(N-1));
    % Friction for coiltube
if Ret<=2000;
  hft=((408.4479*(LL*(QQ.^2)))./((Ret)*(DT.^5)));
else
    hft=((2.01926*(LL*(QQ.^2)))./((Ret.^0.25)*(DT.^5)));
end
end


%Number of coiledtube
DCC=str2double(get(handles.DC,'string'));
Nt=(L*1000)./(3.14*DCC);
%hc coiledtube
hct=0.0083*Nt*(QQ^2)/(DT^4);
het=0.0077*(QQ.^2)./(DT.^4);
hvt=0.0064*(QQ.^2)./(DT.^4);
hfT=hft+hct+het+hvt+hfl;
%%Operation condition
HFF=str2double(get(handles.HF,'string'));
    X=hfT<=HFF;
XX=numel(X(X==1));
%water velocity at lateral
VL=(QQQ*1000*1000*4)/(3600*1000*3.14*(DL.^2));
vvl=str2double(get(handles.VVL,'string'));
Y=VL<vvl;
YY=numel(Y(Y==1))+1;
%water velocity at coiledtube
q=repmat(QQ,1,100);
VT=(q*1000*1000*4)/(3600*1000*3.14*(DT.^2));
vvt=str2double(get(handles.VVt,'string'));
Z=VT>vvt;
ZZ=numel(Z(Z==1));
Max_length_Coiledtube=str2double(get(handles.M_L,'string'));
ZL=LL<=Max_length_Coiledtube;
ZZL=numel(ZL(ZL==1));
ZZZ=[XX ZZ ZZL];
n=min(ZZZ);
%break
if n>0&&n>YY
nn=Nt(YY:n);
M=LL(YY:n);
Nn=n-YY+1;
D=hfT(YY:n);
A=Lat(1:Nn);
B = sort(M,'descend');
C = sort(nn,'descend');
DD= sort(D,'descend');
d = [A;B;C;DD]';
cnames = {'LL','CL','Con','Ch'};
%output
t = uitable('Data',d,'ColumnName',cnames,'ColumnWidth',{66});
set(handles.axes,'visible','on');
axes(handles.axes);
[hAx,hLine1,~]=plotyy(Lat(1:Nn),B,Lat(1:Nn),DD);
xlabel('Lateral length (L_l) (m)');
ylabel(hAx(1),'Coiled tube length (C_l) (m)') % left y-axis
ylabel(hAx(2),'Coiled tube pressure head  (C_h)  (m)') % right y-axis

else
    n=0;
    nn=0;
    M=0;
Nn=0;
D=0;
A=0;
B = 0;
C = 0;
DD= 0;
dd = [A;B;C;DD]';
%output
cnames = {'LL','CL','Con','Ch'};
t = uitable('Data',dd,'ColumnName',cnames,'ColumnWidth',{67});
[x,map]=imread('ASma2.jpg');
axes(handles.axes)
imshow(x,map)

set(handles.axes,'visible','off');
end



function HF_Callback(hObject, eventdata, handles)
% hObject    handle to HF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HF as text
%        str2double(get(hObject,'String')) returns contents of HF as a double


% --- Executes during object creation, after setting all properties.
function HF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VVL_Callback(hObject, eventdata, handles)
% hObject    handle to VVL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VVL as text
%        str2double(get(hObject,'String')) returns contents of VVL as a double


% --- Executes during object creation, after setting all properties.
function VVL_CreateFcn(hObject, ~, handles)
% hObject    handle to VVL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VVt_Callback(~, eventdata, handles)
% hObject    handle to VVt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VVt as text
%        str2double(get(hObject,'String')) returns contents of VVt as a double


% --- Executes during object creation, after setting all properties.
function VVt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VVt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function M_L_Callback(hObject, eventdata, handles)
% hObject    handle to M_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M_L as text
%        str2double(get(hObject,'String')) returns contents of M_L as a double


% --- Executes during object creation, after setting all properties.
function M_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dt_Callback(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dt as text
%        str2double(get(hObject,'String')) returns contents of dt as a double


% --- Executes during object creation, after setting all properties.
function dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dl_Callback(hObject, eventdata, handles)
% hObject    handle to dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dl as text
%        str2double(get(hObject,'String')) returns contents of dl as a double


% --- Executes during object creation, after setting all properties.
function dl_CreateFcn(hObject, eventdata, ~)
% hObject    handle to dl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TW_Callback(hObject, eventdata, handles)
% hObject    handle to TW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TW as text
%        str2double(get(hObject,'String')) returns contents of TW as a double


% --- Executes during object creation, after setting all properties.
function TW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q_Callback(hObject, eventdata, handles)
% hObject    handle to Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q as text
%        str2double(get(hObject,'String')) returns contents of Q as a double


% --- Executes during object creation, after setting all properties.
function Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S_Callback(hObject, eventdata, handles)
% hObject    handle to S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S as text
%        str2double(get(hObject,'String')) returns contents of S as a double


% --- Executes during object creation, after setting all properties.
function S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LL_Callback(hObject, eventdata, ~)
% hObject    handle to LL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LL as text
%        str2double(get(hObject,'String')) returns contents of LL as a double


% --- Executes during object creation, after setting all properties.
function LL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DC_Callback(hObject, ~, handles)
% hObject    handle to DC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DC as text
%        str2double(get(hObject,'String')) returns contents of DC as a double


% --- Executes during object creation, after setting all properties.
function DC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slp_Callback(hObject, eventdata, handles)
% hObject    handle to slp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slp as text
%        str2double(get(hObject,'String')) returns contents of slp as a double


% --- Executes during object creation, after setting all properties.
function slp_CreateFcn(hObject, ~, handles)
% hObject    handle to slp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, ~, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, ~)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(~, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function CCL_Callback(hObject, eventdata, handles)
% hObject    handle to CCL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CCL as text
%        str2double(get(hObject,'String')) returns contents of CCL as a double


% --- Executes during object creation, after setting all properties.
function CCL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CCL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in c.
function c_Callback(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Q,'string',[]);
set(handles.dl,'string',[]);
set(handles.LL,'string',[]);
set(handles.dt,'string',[]);
set(handles.slp,'string',[]);
set(handles.S,'string',[]);
set(handles.DC,'string',[]);
set(handles.TW,'string',[]);
set(handles.CCL,'string',[]);
set(handles.HF,'string',[]);
set(handles.M_L,'string',[]);
set(handles.VVL,'string',[]);
set(handles.VVt,'string',[]);


% --- Executes during object creation, after setting all properties.
function axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes
