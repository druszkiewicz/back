program WzorzecTWork;

uses
  Vcl.Forms,
  Form.Main in 'Form.Main.pas' {Form1},
  MVC.Work in 'MVC.Work.pas',
  Work.CommandOne in 'Work.CommandOne.pas',
  Work.Messaging in 'Work.Messaging.pas',
  Module.MessagingWork in 'Module.MessagingWork.pas' {ModuleOrders: TDataModule},
  Messaging.EventBus in 'Messaging.EventBus.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
