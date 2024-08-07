unit usvcBruno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, Horse, Horse.Jhonson,
  Horse.Commons, Horse.BasicAuthentication;

type
  TsvcBruno = class(TService)
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  svcBruno: TsvcBruno;

implementation

{$R *.dfm}

uses ucontrollerTask;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  svcBruno.Controller(CtrlCode);
end;

function TsvcBruno.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsvcBruno.ServiceCreate(Sender: TObject);
begin
  {Utiliza��o do necess�rio para os servi�o}
  THorse.Use(Jhonson);
  THorse.Use(HorseBasicAuthentication(
    function(const aUsuario, aSenha: string): Boolean
    begin
      {Utilizei uma BasicAuthentication bem simples nesse caso, geralmente utilizo bearer}
      Result := aUsuario.Equals('bruno') and aSenha.Equals('montreal');
    end));

  {Registro das rotas}
  TcontrollerTask.Registrar;
end;

procedure TsvcBruno.ServiceStart(Sender: TService; var Started: Boolean);
begin
  {Ativa��o do servi�o}
  THorse.Listen;
  Started := True;
end;

procedure TsvcBruno.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  {Desativa��o do servi�o}
  THorse.StopListen;
  Stopped := True;
end;

end.
