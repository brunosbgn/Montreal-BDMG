unit uviewNovo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXPickers,
  Vcl.ExtCtrls, RESTRequest4D, System.JSON, System.StrUtils;

type
  TviewNovo = class(TForm)
    edtDescricao: TEdit;
    cbbStatus: TComboBox;
    cbbPrioridade: TComboBox;
    lblDescricao: TLabel;
    lblStatus: TLabel;
    lblPrioridade: TLabel;
    pnlBotoes: TPanel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure Salvar;
  public
    { Public declarations }
  end;

var
  viewNovo: TviewNovo;

implementation

{$R *.dfm}

procedure TviewNovo.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TviewNovo.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

procedure TviewNovo.Salvar;
var
  LResponse: IResponse;
  lObj: TJSONObject;
  lData: String;
begin
  {Verifica��o b�sica}
  if edtDescricao.Text = EmptyStr then
  begin
    ShowMessage('Insira a descri��o da tarefa!');
    Exit;
  end;

  try
    lObj := TJSONObject.Create;
    try
      {Adi��o das tags no objeto}
      lObj.AddPair('descricao', edtDescricao.Text);
      lObj.AddPair('status', ifThen(cbbStatus.ItemIndex = 0, 'A', 'C'));

      {Formata��o da data}
      lData := FormatDateTime('yyyy-mm-dd', FloatToDateTime(Date));

      lObj.AddPair('data', lData);
      lObj.AddPair('prioridade', TJSONNumber.Create(StrToInt(cbbPrioridade.Text)));

      {Requisi��o de novo registro}
      LResponse := TRequest.New.BaseURL('http://localhost:9000/task')
        .BasicAuthentication('bruno', 'montreal')
        .Accept('application/json')
        .AddBody(lObj)
        .Post;

      {Verifica��o da reposta para mensagem}
      if LResponse.StatusCode = 200 then
        ShowMessage('Registro enviado!')
      else
        raise Exception.Create('Falha na inclus�o do registro!');
    finally
      {Forma de libera��o da mem�ria}
      lObj := nil;
      lObj.Free;
      Self.Close;
    end;
  except
    on E: Exception do
      ShowMessage('Falha ao incluir a tarefa: ' + E.Message);
  end;
end;

end.
