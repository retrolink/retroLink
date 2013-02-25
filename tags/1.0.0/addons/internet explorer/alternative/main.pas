unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls, ShellAPI, MSHTML_TLB, SHDocVw;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StaticText1: TStaticText;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Reg : TRegistry;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{
function ExecuteScript(doc: IHTMLDocument2; script: string; language: string): Boolean;
var
  win: IHTMLWindow2;
  Olelanguage: Olevariant;
begin
  if doc <> nil then
  begin
    try
      win := doc.parentWindow;
      if win <> nil then
      begin
        try
          Olelanguage := language;
          win.ExecScript(script, Olelanguage);
        finally
          win := nil;
        end;
      end;
    finally
      doc := nil;
    end;
  end;
end;
}

function LoginGMX_IE(AKennung, APasswort: string): Boolean;
var
  ShellWindow: IShellWindows;
  WB: IWebbrowser2;
  spDisp: IDispatch;
  IDoc1: IHTMLDocument2;
  Document: Variant;
  k: Integer;
begin
  ShellWindow := CoShellWindows.Create;
  // get the running instance of Internet Explorer
  for k := 0 to ShellWindow.Count do
  begin
    spDisp := ShellWindow.Item(k);
    if spDisp = nil then Continue;
    // QueryInterface determines if an interface can be used with an object
    spDisp.QueryInterface(iWebBrowser2, WB);
    if WB <> nil then
    begin
      WB.Document.QueryInterface(IHTMLDocument2, iDoc1);
      if iDoc1 <> nil then
      begin
        WB := ShellWindow.Item(k) as IWebbrowser2;
        Document := WB.Document;
        WB.Navigate('retrolink.com.br/plugins/ie.js', EmptyParam,EmptyParam,EmptyParam,EmptyParam);
      end;  // idoc <> nil
    end; // wb <> nil
  end;  // for k
end;


procedure TForm1.Button1Click(Sender: TObject);
var
 GUID : string;
 Reg : TRegistry;
 Del : string;
begin
{* The GUID was generated using the M$ guidgen.exe. This is my unique ID
 * All the program does is add some new values to the IE reg settings.
 *
 * "Default Visible" :
 *                Yes to have the button on the menu as default and set to No
 *                if you dont want it as default.
 *
 * "ButtonText" :
 *               This is the text in the label when you put your mouse over the button
 *
 * "HotIcon":
 *           This value holds the directory that the .ico's are stored in
 *
 * "Icon":
 *        is the actuall path and file name of the icon
 *
 * "CLSID":
 *          This is to say it is a button and the value for that is:
 *          {1FBA04EE-3024-11D2-8F1F-0000F87ABD16}
{*
 * "Exec"
 *        is the path of the exe you want to execute when the button is clicked
 *
 *
 * If the button doesnt appear on your menu download guidgen.exe from M$ and generate a
 * new GUID.
 *
 * vote ma code}




  Del := Inputbox('Test version', 'Enter 0 to add the button, 1 to delete the button, 2 to launch the script', '2');

  GUID := '{986CDFC3-0AFC-49ac-942D-2E9CAEE079FC}';  // my ID. gotta use guidgen.exe

  Reg := TRegistry.create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('SOFTWARE\Microsoft\Internet Explorer\Extensions\', true);

  case(StrToInt(Del)) of
   0: begin
        if Reg.CreateKey(GUID)then
        begin
          Reg.OpenKey(GUID, true);
          Reg.WriteString('Default Visible', 'Yes');  { make the button default on the toolbar}
          Reg.WriteString('ButtonText', 'IE Button');
          Reg.WriteString('HotIcon', 'C:\menu');
          Reg.WriteString('Icon', 'C:\menu\icon.ico');
          Reg.WriteString('CLSID', '{1FBA04EE-3024-11D2-8F1F-0000F87ABD16}');
          Reg.WriteString('Exec', 'C:\menu\IEToolbarStarter.exe');
          showmessage('Button added to Internet Explorer.');
          ShellExecute(Handle, 'open', 'IEXPLORE.exe', nil, 0, SW_SHOW);
        end; //end if
      end; //end 0:
   1: begin
        Reg.DeleteKey(GUID);
        ShowMessage('Button removed');
        ShellExecute(Handle, 'open', 'IEXPLORE.exe', nil, 0, SW_SHOW);
      end;// end 1:
   2: begin
      if LoginGMX_IE('','') then
        ShowMessage('execute javascript');
        //ShellExecute(Handle, 'open', 'IEXPLORE.exe', nil, 0, SW_SHOW);
   end// end 2:


   else ShowMessage('Dunno that option');
   end;//case


  Reg.CloseKey;
  Reg.Free;
end;

end.
