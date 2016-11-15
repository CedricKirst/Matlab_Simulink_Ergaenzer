function varargout = GPSplot(varargin)
% GPSPLOT MATLAB code for GPSplot.fig
%      GPSPLOT, by itself, creates a new GPSPLOT or raises the existing
%      singleton*.
%
%      H = GPSPLOT returns the handle to a new GPSPLOT or the handle to
%      the existing singleton*.
%
%      GPSPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GPSPLOT.M with the given input arguments.
%
%      GPSPLOT('Property','Value',...) creates a new GPSPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GPSplot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GPSplot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GPSplot

% Last Modified by GUIDE v2.5 08-Nov-2016 11:31:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GPSplot_OpeningFcn, ...
                   'gui_OutputFcn',  @GPSplot_OutputFcn, ...
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


% --- Executes just before GPSplot is made visible.
function GPSplot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GPSplot (see VARARGIN)

% Choose default command line output for GPSplot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.plt3DPos);
grid on;
axes(handles.plt2DDistance);
grid on;

global path;
path = uigetdir('/home/cedric/Uni/Matlab_Simulink_Ergänzer');
if(path ~= 0)
    cd(path);
    files = dir('*.txt');
else
    cd('/home/cedric/Uni/Matlab_Simulink_Ergänzer');
    files = dir('*.txt');
end

cd('/home/cedric/Uni/Matlab_Simulink_Ergänzer/GUI');
set(handles.lstbxFiles, 'String', {files.name});



% UIWAIT makes GPSplot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GPSplot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lstbxFiles.
function lstbxFiles_Callback(hObject, eventdata, handles)
% hObject    handle to lstbxFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstbxFiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstbxFiles

global txtdat;
contents = cellstr(get(hObject,'String'));
txtdat = contents{get(hObject,'Value')};

% --- Executes during object creation, after setting all properties.
function lstbxFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstbxFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnPlotGPS.
function btnPlotGPS_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlotGPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global path;
global txtdat;

addpath(path);
try
    [X, Y, Z, Distance, Time] = funGPSPlot(txtdat);
    axes(handles.plt3DPos)
    plot3(X,Y,Z);
    title('Flight Trajectory');
    grid minor;
    axes(handles.plt2DDistance);
    plot(Time, Distance);
    title('Distance over Time');
    grid minor;
catch
    h = msgbox('Chosen Data must have GPS standard!');
end


%lstbxFiles('dir', '/home/cedric/Uni/Matlab_Simulink_Ergänzer/Data');

% --- Executes on selection change in ppmnSelectFolder.
function ppmnSelectFolder_Callback(hObject, eventdata, handles)
% hObject    handle to ppmnSelectFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ppmnSelectFolder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ppmnSelectFolder


% --- Executes during object creation, after setting all properties.
function ppmnSelectFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ppmnSelectFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnChangeDirectory.
function btnChangeDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to btnChangeDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global path;
path = uigetdir('/home/cedric/Uni/Matlab_Simulink_Ergänzer');
if(path ~= 0)
    cd(path);
    files = dir('*.txt');
    cd('/home/cedric/Uni/Matlab_Simulink_Ergänzer/GUI');
    set(handles.lstbxFiles, 'String', {files.name});
end
