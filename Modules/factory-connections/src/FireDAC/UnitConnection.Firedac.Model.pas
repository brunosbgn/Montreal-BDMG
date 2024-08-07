unit UnitConnection.Firedac.Model;

interface

uses UnitConnection.Model.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Comp.UI, System.Generics.Collections;

type
  TConnectionFiredac = class(TInterfacedObject, iConnection)
  private
    FServer   : String;
    FCaminhoBD: string;
    FUsuario  : string;
    FSenha    : string;
		FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  public
    constructor Create(Server, Database: string; Usuario: string = 'SYSDBA'; Senha: string = 'masterkey');
    destructor Destroy; override;
		class var Instancia: iConnection;
    class function New(Server, Database: string; Usuario: string = 'SYSDBA'; Senha: string = 'masterkey'; Singleton: Boolean = true): iConnection;
		function Connected: Integer;
		procedure Disconnected(Index: Integer);
		function GetListaConexoes: TObjectList<TObject>;
  end;

var
	FDriver : TFDPhysFBDriverLink;
	FConnList : TObjectList<TFDConnection>;

implementation

uses System.SysUtils;

{ TConexaoFireDAC }

constructor TConnectionFiredac.Create(Server, Database: string; Usuario: string = 'SYSDBA'; Senha: string = 'masterkey');
begin
  FServer    := Server;
  FCaminhoBD := Database;
  FUsuario   := Usuario;
  FSenha     := Senha;
  FDGUIxWaitCursor1 := TFDGUIxWaitCursor.Create(nil);
end;

destructor TConnectionFiredac.Destroy;
begin
	FConnList.DisposeOf;
  FDGUIxWaitCursor1.DisposeOf;
  inherited;
end;

function TConnectionFiredac.Connected: Integer;
begin
  if not Assigned(FConnList) then
		FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);
	FConnList.Items[Result].Params.DriverID := 'MSSQL';
 {FConnList.Items[Result].Params.DriverID := 'FB';}
  FConnList.Items[Result].Params.Add('Database=' + FCaminhoBD);
  FConnList.Items[Result].Params.Add('User_Name=' + FUsuario);
  FConnList.Items[Result].Params.Add('Password=' + FSenha);
  FConnList.Items[Result].Params.Add('Server=' + FServer);
  FConnList.Items[Result].Params.Add('CharacterSet=utf8');

	FConnList.Items[Result].Connected;
end;

procedure TConnectionFiredac.Disconnected(Index: Integer);
begin
	FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
end;

function TConnectionFiredac.GetListaConexoes: TObjectList<TObject>;
begin
	Result := TObjectList<TObject>(FConnList);
end;

class function TConnectionFiredac.New(Server, Database, Usuario, Senha: string;
  Singleton: Boolean): iConnection;
begin
  if Singleton then
  begin
    if not Assigned(Instancia) then
    begin
      Instancia := Self.Create(Server, Database, Usuario, Senha);
    end;
    Result := Instancia;
  end
  else
    Result := Self.Create(Server, Database, Usuario, Senha);
end;

end.

