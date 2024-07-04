unit uviewPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, RESTRequest4D,
  System.JSON, System.StrUtils, System.Generics.Collections;

type
  TviewPrincipal = class(TForm)
    pnlBotoes: TPanel;
    btnNovo: TButton;
    btnEditar: TButton;
    btnBuscar: TButton;
    grdConsulta: TDBGrid;
    dtsConsulta: TDataSource;
    mmtConsulta: TFDMemTable;
    mmtConsultacodigo: TIntegerField;
    mmtConsultadescricao: TStringField;
    mmtConsultastatus: TStringField;
    mmtConsultaprioridade: TIntegerField;
    mmtConsultadata: TDateField;
    btnExcluir: TButton;
    btnEstatisticas: TButton;
    btnSair: TButton;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnEstatisticasClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    procedure Buscar;
    procedure Excluir;
  public
    { Public declarations }
  end;

var
  viewPrincipal: TviewPrincipal;

implementation

{$R *.dfm}

uses uviewNovo, uviewAlterar, uviewEstatisticas;

procedure TviewPrincipal.Buscar;
var
  LResponse: IResponse;
  lArr: TJSONArray;
  i: Integer;
  lData: TDateTime;
begin
  {Limpando a tabela para n�o acumular registros}
  mmtConsulta.EmptyDataSet;

  try
    {Requisi��o com o servi�o, utilizando Rest4Request}
    LResponse := TRequest.New.BaseURL('http://localhost:9000/task')
      .BasicAuthentication('bruno', 'montreal')
      .Accept('application/json')
      .Get;

    {Verificando a resposta para alimentar o grid}
    if LResponse.StatusCode = 200 then
    begin
      lArr := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONArray;

      try
        if lArr.Count = 0 then
        begin
          ShowMessage('A pesquisa n�o retornou nenhuma tarefa!');
          Exit;
        end;

        {Percorrendo o array de tarefas}
        for i := 0 to Pred(lArr.Count) do
        begin
          {Abre a tabela e alimenta os campos com os JSON, de acordo com a tipagem}
          mmtConsulta.Append;
          mmtConsulta.FieldByName('codigo').AsInteger     := StrToInt(TJSONObject(lArr.Items[i]).GetValue('codigo').Value);
          mmtConsulta.FieldByName('descricao').AsString   := TJSONObject(lArr.Items[i]).GetValue('descricao').Value;
          mmtConsulta.FieldByName('status').AsString      := TJSONObject(lArr.Items[i]).GetValue('status').Value;

          {Aqui precisei converter, j� que nesse novo Delphi, a data fica como float}
          lData := FloatToDateTime(StrToFloat(TJSONObject(lArr.Items[i]).GetValue('data').Value));
          mmtConsulta.FieldByName('data').AsDateTime      := lData;
          mmtConsulta.FieldByName('prioridade').AsInteger := StrToInt(TJSONObject(lArr.Items[i]).GetValue('prioridade').Value);
          mmtConsulta.Post;
        end;
      finally
        {Limpando da mem�ria}
        FreeAndNil(lArr);
      end;
    end
    else
      raise Exception.Create('Registros n�o encontrados!');
  except
    on E: Exception do
      ShowMessage('Falha na consulta de tarefas: ' + E.Message);
  end;
end;

procedure TviewPrincipal.btnNovoClick(Sender: TObject);
var
  lForm: TviewNovo;
begin
  {Cria��o do form como modal}
  lForm := TviewNovo.Create(Self);
  try
    lForm.ShowModal;
    Buscar;
  finally
    FreeAndNil(lForm);
  end;
end;

procedure TviewPrincipal.btnSairClick(Sender: TObject);
begin
  {Finalizando a aplica��o}
  Application.Terminate;
end;

procedure TviewPrincipal.btnEditarClick(Sender: TObject);
var
  lForm: TviewAlterar;
begin
  {Verificando se o grid est� preenchido}
  if mmtConsulta.IsEmpty then
  begin
    ShowMessage('Busque as tarefas antes!');
    Exit;
  end;

  lForm := TviewAlterar.Create(Self);
  try
    {J� atribuindo os valores no formul�rio em mem�ria para facilitar}
    lForm.edtCodigo.Text := mmtConsulta.FieldByName('codigo').AsString;

    if mmtConsulta.FieldByName('status').AsString = 'A' then
      lForm.cbbStatus.ItemIndex := 0
    else lForm.cbbStatus.ItemIndex := 1;

    lForm.ShowModal;
    Buscar;
  finally
    FreeAndNil(lForm);
  end;
end;

procedure TviewPrincipal.btnExcluirClick(Sender: TObject);
begin
    if mmtConsulta.IsEmpty then
  begin
    ShowMessage('Busque as tarefas antes!');
    Exit;
  end;

  Excluir;
end;

procedure TviewPrincipal.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TviewPrincipal.btnEstatisticasClick(Sender: TObject);
var
  lForm: TviewEstatisticas;
begin
  lForm := TviewEstatisticas.Create(Self);
  try
    lForm.ShowModal;
    Buscar;
  finally
    FreeAndNil(lForm);
  end;
end;

procedure TviewPrincipal.Excluir;
var
  lCodigo: String;
  LResponse: IResponse;
begin
  {Recebendo o c�digo, caso queira alterar o da linha}
  lCodigo := InputBox('Tarefa','Confirmar o c�digo da tarefa', mmtConsulta.FieldByName('codigo').AsString);

  {Valida��o do c�digo}
  if StrToIntDef(lCodigo, 0) = 0 then
  begin
    ShowMessage('C�digo inv�lido!');
    Exit;
  end;

  try
    {Requisi��o de exclus�o do registro}
    LResponse := TRequest.New.BaseURL('http://localhost:9000/task/' + lCodigo)
      .BasicAuthentication('bruno', 'montreal')
      .Accept('application/json')
      .Delete;

    {Valida��o para a mensagem}
    if LResponse.StatusCode = 200 then
    begin
      ShowMessage('Registro deletado!');
      Buscar;
    end
    else
      raise Exception.Create('Falha na exclus�o da tarefa!');
  except
    on E: Exception do
      ShowMessage('Falha ao excluir a tarefa: ' + E.Message);
  end;
end;

procedure TviewPrincipal.FormCreate(Sender: TObject);
begin
  {Cria��o da tabela de mem�ria}
  mmtConsulta.CreateDataSet;
end;

end.
