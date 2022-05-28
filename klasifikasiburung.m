function varargout = klasifikasiburung(varargin)
% KLASIFIKASIBURUNG MATLAB code for klasifikasiburung.fig
%      KLASIFIKASIBURUNG, by itself, creates a new KLASIFIKASIBURUNG or raises the existing
%      singleton*.
%
%      H = KLASIFIKASIBURUNG returns the handle to a new KLASIFIKASIBURUNG or the handle to
%      the existing singleton*.
%
%      KLASIFIKASIBURUNG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KLASIFIKASIBURUNG.M with the given input arguments.
%
%      KLASIFIKASIBURUNG('Property','Value',...) creates a new KLASIFIKASIBURUNG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before klasifikasiburung_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to klasifikasiburung_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help klasifikasiburung

% Last Modified by GUIDE v2.5 28-May-2022 16:28:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @klasifikasiburung_OpeningFcn, ...
                   'gui_OutputFcn',  @klasifikasiburung_OutputFcn, ...
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


% --- Executes just before klasifikasiburung is made visible.
function klasifikasiburung_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to klasifikasiburung (see VARARGIN)

% Choose default command line output for klasifikasiburung
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes klasifikasiburung wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = klasifikasiburung_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_input.
function btn_input_Callback(hObject, eventdata, handles)
[nama_file,nama_folder]=uigetfile('*.jpg');

if ~isequal(nama_file,0)
    citra=imread(fullfile(nama_folder,nama_file));
    %menampikan citra di axes
    axes(handles.axes1)
    imshow(citra)
    title('Citra yang akan diproses')
    handles.citra=citra;
    guidata(hObject,handles)
else
    return    
end

% --- Executes on button press in btn_eks.
function btn_eks_Callback(hObject, eventdata, handles)

eks=handles.citra;
ekstraksi=rgb2gray(eks);
hold=graythresh(ekstraksi);
biner=im2bw(ekstraksi,hold);
biner=bwareaopen(biner,30);
se=strel('disk',2);
biner=imclose(biner,se);
biner=imfill(biner,'holes');
[b,l]=bwboundaries(biner,'noholes');
stats=regionprops(l,'ALL')
area=cat(1,stats.Area);
perimeter=cat(1,stats.Perimeter);


set(handles.t_area,'string',num2str(area,'%0.2f'));
set(handles.t_perim,'string',perimeter);

% --- Executes during object creation, after setting all properties.
function t_area_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function t_perim_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
