unit Order.ShippmentProcesor;

interface

uses
  Shippment,
  DataProxy.Order,
  DataProxy.Order.Details,
  Order.Validator;

const
  c_MinQuantity = 50;

type
  TShipmentProcessor = class
  private
    FShippment: TShippment;
    FOrder: TOrderDAO;
    fOrderDetails : TOrderDetailsDAO;
    FOrderValidator: TOrderValidator;
  public
    constructor Create(aShippment: TShippment);
    destructor Destroy; override;
    procedure ShipCurrentOrder;

  end;

implementation

uses Data.DataProxy, System.Sysutils;

constructor TShipmentProcessor.Create(aShippment: TShippment);
begin
  FShippment := aShippment;
  FOrder := TOrderDao.Create(nil);
  fOrderDetails := TOrderDetailsDAO.Create(nil);
  FOrderValidator := TOrderValidator.Create;
end;

destructor TShipmentProcessor.Destroy;
begin
  FOrder.Free;
  fOrderDetails.Free;
  FOrderValidator.Free;
  inherited;
end;

procedure TShipmentProcessor.ShipCurrentOrder;
begin
  FOrder.Open(FShippment.OrderID);

  fOrderDetails.Open(FShippment.OrderID,c_MinQuantity);

  fOrderDetails.ForEach( procedure (proxy : TGenericDataSetProxy)
                         begin
                          {$IFDEF CONSOLEAPP}
                            var orderid := TOrderDetailsDAO(proxy).ORDERID.AsString;
                            var prodid  := TOrderDetailsDAO(proxy).PRODUCTID.AsString;
                            var quant   := TOrderDetailsDAO(proxy).QUANTITY.AsInteger;
                            WriteLn(Format('OrderID: %s productid: %s Quantity: %d', [orderid, prodid, quant]));
                          {$ENDIF}
                         end);

  FOrderValidator.isValid(FOrder);
  // if isValid then
  // FOrder.Post;
{$IFDEF CONSOLEAPP}
  WriteLn('Order has been processed....');
{$ENDIF}
end;

end.
