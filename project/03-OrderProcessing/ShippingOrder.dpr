program ShippingOrder;

{$APPTYPE CONSOLE}

{$define CONSOLEAPP}

{$R *.res}

uses
  System.SysUtils,
  Order.ShippmentProcesor in 'Order.ShippmentProcesor.pas',
  Order.Validator in 'Order.Validator.pas',
  DataProxy.Order in 'DataProxy.Order.pas',
  Data.DataProxy in 'Data.DataProxy.pas',
  Helper.TDataSet in 'Helper.TDataSet.pas',
  Database.Connector.Interbase in 'Database.Connector.Interbase.pas',
  Database.Connector in 'Database.Connector.pas',
  Main in 'Main.pas',
  Shippment in 'Shippment.pas',
  DataProxy.Order.Details in 'DataProxy.Order.Details.pas';

begin
  try
    MainProc;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
