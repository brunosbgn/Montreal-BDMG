object viewAlterar: TviewAlterar
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Alterar Status da Tarefa'
  ClientHeight = 131
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblStatus: TLabel
    Left = 161
    Top = 69
    Width = 34
    Height = 15
    Caption = 'Status'
  end
  object lblCodigo: TLabel
    Left = 7
    Top = 69
    Width = 38
    Height = 15
    Caption = 'C'#243'digo'
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 314
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      314
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
      Left = 212
      Top = 8
      Width = 97
      Height = 44
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object cbbStatus: TComboBox
    Left = 161
    Top = 84
    Width = 148
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 1
    Text = 'Aberta'
    Items.Strings = (
      'Aberta'
      'Conclu'#237'da')
  end
  object edtCodigo: TEdit
    Left = 7
    Top = 84
    Width = 138
    Height = 23
    Enabled = False
    MaxLength = 100
    TabOrder = 2
  end
end
