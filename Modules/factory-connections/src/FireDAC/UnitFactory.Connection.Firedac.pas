unit UnitFactory.Connection.Firedac;

interface

uses UnitConnection.Model.Interfaces,
     UnitConnection.Firedac.Model,
     UnitQuery.FireDAC.Model;

type
  TFactoryConnectionFiredac = class(TInterfacedObject, iFactoryConnection)
    private
      FConexao: iConnection;
    public
      constructor Create(Server, Database: string; Usuario: string = 'SYSDBA'; Senha: string = 'masterkey'; Singleton: Boolean = true);
      destructor Destroy; override;
      class function New(Server, Database: string; Usuario: string = 'SYSDBA'; Senha: string = 'masterkey'; Singleton: Boolean = true) : iFactoryConnection;
      function Query: iQuery;
  end;

implementation



{ TFactoryConexaoFireDAC }

constructor TFactoryConnectionFiredac.Create(Server, Database: string; Usuario: string = 'SYSDBA'; Senha: string = 'masterkey'; Singleton: Boolean = true);
begin
  FConexao := TConnectionFiredac.New(Server, Database, Usuario, Senha, Singleton);
end;

destructor TFactoryConnectionFiredac.Destroy;
begin

  inherited;
end;

class function TFactoryConnectionFiredac.New(Server, Database, Usuario,
  Senha: string; Singleton: Boolean): iFactoryConnection;
begin
  result := Self.Create(Server, Database, Usuario, Senha, Singleton);
end;

function TFactoryConnectionFiredac.Query: iQuery;
begin
  Result := TQueryFiredac.New(FConexao);
end;

end.
