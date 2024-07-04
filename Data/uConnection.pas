unit uConnection;

interface

uses
  UnitConnection.Model.Interfaces, UnitFactory.Connection.Firedac;

type
  TConnection = class
    class function Query: iQuery;
  end;

implementation

{ TConnection }

class function TConnection.Query: iQuery;
begin
  {No caso, deixei fixo. Geralmente, utilizo .ini ou configuração em banco sqlite para o serviço em si}
  Result := TFactoryConnectionFiredac.New('Jhonys-NoteAsus\SQLEXPRESS', 'BDMG', 'bdmg', 'bdmg').Query;
 {Result := TFactoryConnectionFiredac.New('127.0.0.1', 'C:\BrunoGoncalves\Montreal-BDMG\Data\MONTREAL.FDB', 'sysdba', 'masterkey').Query;}
end;

end.
