object viewNovo: TviewNovo
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Nova Tarefa'
  ClientHeight = 187
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblDescricao: TLabel
    Left = 7
    Top = 69
    Width = 55
    Height = 15
    Caption = 'Descri'#231#227'o'
  end
  object lblStatus: TLabel
    Left = 7
    Top = 117
    Width = 34
    Height = 15
    Caption = 'Status'
  end
  object lblPrioridade: TLabel
    Left = 175
    Top = 117
    Width = 59
    Height = 15
    Caption = 'Prioridade'
  end
  object edtDescricao: TEdit
    Left = 7
    Top = 86
    Width = 328
    Height = 23
    MaxLength = 100
    TabOrder = 0
  end
  object cbbStatus: TComboBox
    Left = 7
    Top = 134
    Width = 162
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 1
    Text = 'Aberta'
    Items.Strings = (
      'Aberta'
      'Conclu'#237'da')
  end
  object cbbPrioridade: TComboBox
    Left = 175
    Top = 134
    Width = 160
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 2
    Text = '1'
    Items.Strings = (
      '1'
      '2'
      '3')
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 343
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      343
      57)
    object btnSalvar: TButton
      Left = 7
      Top = 8
      Width = 97
      Height = 44
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      Left = 238
      Top = 8
      Width = 97
      Height = 44
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end