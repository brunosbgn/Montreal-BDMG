unit umodelConnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TmodelConnection = class(TDataModule)
    cnMontreal: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDQuery1: TFDQuery;
  private
    { Private declarations }
  public
    class function CreateQuery(aOwner: TComponent): TFDQuery;
  end;

var
  modelConnection: TmodelConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TmodelConnection }

class function TmodelConnection.CreateQuery(aOwner: TComponent): TFDQuery;
begin
  Result := TFDQuery.Create(aOwner);
  Result.Connection := TmodelConnection.cnMontreal;
end;

end.
