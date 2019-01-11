unit DataProxy.Order.Details;

interface

uses
  Data.DB,
  Data.DataProxy,
  // FireDAC - TFDQuery ------------------------------
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Param,
  FireDAC.Stan.Async;

type
  TOrderDetailsDAO = class(TDatasetProxy)
  protected
    procedure ConnectFields; override;
  public
    ORDERID: TIntegerField;
    PRODUCTID: TIntegerField;
    UNITPRICE: TBCDField;
    QUANTITY: TSmallintField;
    DISCOUNT: TSingleField;
    procedure Open(OrderID: integer; pMaxQuantity : SmallInt);
    procedure Close;
    // property DataSet: TDataSet read FDataSet;
  end;

implementation

{ TOrder }

uses Database.Connector, System.SysUtils;

const
  SQL_SELECT_Order_Details = 'SELECT OrderID, ProductID, UNITPRICE,QUANTITY,DISCOUNT ' +
    ' FROM "Order Details"' +
    ' WHERE quantity > %d ' +
    ' order by quantity ';

procedure TOrderDetailsDAO.Close;
begin

end;

procedure TOrderDetailsDAO.ConnectFields;
begin

  ORDERID   := fDataSet.FieldByName('ORDERID') as  TIntegerField;
  PRODUCTID := fDataSet.FieldByName('PRODUCTID') as  TIntegerField;
  UNITPRICE := fDataSet.FieldByName('UNITPRICE') as  TBCDField;
  QUANTITY  := fDataSet.FieldByName('QUANTITY') as  TSmallintField;
  DISCOUNT  := fDataSet.FieldByName('DISCOUNT') as  TSingleField;

end;

procedure TOrderDetailsDAO.Open(OrderID: integer;pMaxQuantity : SmallInt);
var
  fdq: TFDQuery;
  id: string;
  prodid : String;
begin
  if not Assigned(FDataSet) then
  begin
    fdq := TFDQuery.Create(nil);
    fdq.SQL.Text :=  Format(SQL_SELECT_Order_Details,[pMaxQuantity]);
    fdq.Connection := GlobalConnector.GetMainConnection;
    FDataSet := fdq;
{$IFDEF CONSOLEAPP}
    WriteLn('Created Order DAO object....');
{$ENDIF}
  end;
  //(FDataSet as TFDQuery).ParamByName('OrderID').AsInteger := OrderID;
  FDataSet.Open;
  ConnectFields;

{$IFDEF CONSOLEAPP}
    WriteLn('Record count = ' + IntToStr(fDataSet.RecordCount));
    Readln;
{$ENDIF}

end;

end.
