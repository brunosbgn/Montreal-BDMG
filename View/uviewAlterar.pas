unit uviewAlterar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, RESTRequest4D,
  System.JSON, System.StrUtils;

type
  TviewAlterar = class(TForm)
    pnlBotoes: TPanel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    lblStatus: TLabel;
    cbbStatus: TComboBox;
    edtCodigo: TEdit;
    lblCodigo: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure Alterar;
  public
    { Public declarations }
  end;

var
  viewAlterar: TviewAlterar;

implementation

{$R *.dfm}

procedure TviewAlterar.Alterar;
var
  LResponse: IResponse;
  lObj: TJSONObject;
begin
  try
    lObj := TJSONObject.Create;
    try
      {Par do status para altera��o}
      lObj.AddPair('status', ifThen(cbbStatus.ItemIndex = 0, 'A', 'C'));

      {Requisi��o de altera��o}
      LResponse := TRequest.New.BaseURL('http://localhost:9000/task/' + edtCodigo.Text)
        .BasicAuthentication('bruno', 'montreal')
        .Accept('application/json')
        .AddBody(lObj)
        .Put;

      {Verifica��o da reposta para mensagem}
      if LResponse.StatusCode = 200 then
        ShowMessage('O status da tarefa foi alterado!')
      else
        raise Exception.Create('Falha na edi��o do status da tarefa!');
    finally
      {Libera��o da mem�ria e encerramento do form}
      lObj := nil;
      lObj.Free;
      Self.Close;
    end;
  except
    on E: Exception do
      ShowMessage('Falha ao alterar o status da tarefa: ' + E.Message);
  end;
end;

procedure TviewAlterar.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TviewAlterar.btnSalvarClick(Sender: TObject);
begin
  Alterar;
end;

end.
