program backPropagation;

uses
  Vcl.Forms,
  UfrmMainForm in 'UfrmMainForm.pas' {frmMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Rede Neural - BackPropagation';
  Application.CreateForm(TfrmMainForm, frmMainForm);
  Application.Run;
end.
