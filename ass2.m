function varargout = ass2(varargin)
% ASS2 MATLAB code for ass2.fig
%      ASS2, by itself, creates a new ASS2 or raises the existing
%      singleton*.
%
%      H = ASS2 returns the handle to a new ASS2 or the handle to
%      the existing singleton*.
%
%      ASS2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASS2.M with the given input arguments.
%
%      ASS2('Property','Value',...) creates a new ASS2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ass2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ass2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ass2

% Last Modified by GUIDE v2.5 08-Apr-2017 14:14:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ass2_OpeningFcn, ...
                   'gui_OutputFcn',  @ass2_OutputFcn, ...
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


% --- Executes just before ass2 is made visible.
function ass2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ass2 (see VARARGIN)

% Choose default command line output for ass2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ass2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ass2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m = str2num(get(handles.m,'String'));
n = str2num(get(handles.n,'String'));

a =  str2num(get(handles.as,'String'));
b = str2num(get(handles.bs,'String'));
Ns =str2num(get(handles.simtime,'String'));
sampltime = str2num(get(handles.sampling,'String'));

i=0;y=[];x =[];hamada=0;bb=0;aa=0;ramp=1;buffer_y=[];

option = get(handles.popupmenu2, 'value')
if (m<= n)
   
   for i=1:(m+1)
       if(i==0)
           x=1;
       else
        x=[x 0];
       end
   end
   for i=1:(n+1) 
       y=[y 0]
   end
   
   for i=0:sampltime:Ns
      
       y(1)=b(1)*x(1);
       for hamada=2:1:(m+1)
             y(1)=y(1)+b(hamada)*x(hamada);     
       end
       
       
      for hamada =1:1:n
          y(1)=y(1)-a(hamada)*y(hamada+1);
      end
               
          
          buffer_y=[buffer_y y(1)];
           
           %update 
           for k = (n+1):-1:2
               y(k)=y(k-1);
           end
     
          for k = (m+1) :-1:2
             x(k)=x(k-1); 
          end
         
          
          if(option==1)
              x(1)=0;
          
          elseif(option==2)
              x(1)=1;
          else
             ramp=ramp+1;
             x(1)=ramp;
         
          end   
   end

   cla
axes(handles.axes1)

j = 0:sampltime:Ns;

plot(j,buffer_y);
grid;
end
function as_Callback(hObject, eventdata, handles)
% hObject    handle to as (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of as as text
%        str2double(get(hObject,'String')) returns contents of as as a double


% --- Executes during object creation, after setting all properties.
function as_CreateFcn(hObject, eventdata, handles)
% hObject    handle to as (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bs_Callback(hObject, eventdata, handles)
% hObject    handle to bs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bs as text
%        str2double(get(hObject,'String')) returns contents of bs as a double


% --- Executes during object creation, after setting all properties.
function bs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m_Callback(hObject, eventdata, handles)
% hObject    handle to m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m as text
%        str2double(get(hObject,'String')) returns contents of m as a double


% --- Executes during object
creation, after setting all properties.
function m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sampling_Callback(hObject, eventdata, handles)
% hObject    handle to sampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sampling as text
%        str2double(get(hObject,'String')) returns contents of sampling as a double


% --- Executes during object creation, after setting all properties.
function sampling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function simtime_Callback(hObject, eventdata, handles)
% hObject    handle to simtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simtime as text
%        str2double(get(hObject,'String')) returns contents of simtime as a double



% --- Executes during object creation, after setting all properties.
function simtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
case 'step' % User selects step.
   handles.current_data = val;
case 'delta' % User selects membrane.
   handles.current_data = val;
end
set(handles.popupmenu2, 'UserData', val);
% Save the handles structure.
guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
