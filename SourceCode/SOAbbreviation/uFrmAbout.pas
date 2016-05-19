unit uFrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage;

type
  TfrmAbout = class(TForm)
    pnlDown: TPanel;
    btnOK: TButton;
    Image1: TImage;
    Image2: TImage;
    lblVersion: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

end.
